# FIAP Tech Challenge - Fase 3 | Parte do Renan (GitOps + ArgoCD)

Esta parte do projeto e responsavel pelo **deploy automatizado** dos microsservicos no cluster EKS usando **ArgoCD** (GitOps).

---

## Estrutura do Repositorio

`"
fiap-tech-challenge-fase-3-infra/
+-- gitops/
|   +-- auth/
|   |   +-- deployment.yaml   -> Define como o microsservico auth roda no Kubernetes
|   |   +-- service.yaml      -> Expoe o microsservico auth dentro do cluster
|   +-- flag/
|   +-- targeting/
|   +-- evaluation/
|   +-- analytics/
+-- argocd/
    +-- apps/
        +-- auth-app.yaml
        +-- flag-app.yaml
        +-- targeting-app.yaml
        +-- evaluation-app.yaml
        +-- analytics-app.yaml
`"

---

## Pre-requisitos

- **Edson**: Cluster EKS + Repositorios ECR criados na AWS
- **Sandro**: Build e push das imagens Docker para o ECR

---

## Passo a Passo: Instalacao do ArgoCD no cluster EKS

### 1. Conectar ao cluster EKS

`ash
aws eks update-kubeconfig --region REGION --name CLUSTER_NAME
`"

### 2. Instalar o ArgoCD no cluster

`ash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
`"

### 3. Aguardar o ArgoCD subir

`ash
kubectl get pods -n argocd
# Espere todos os pods estarem com STATUS Running
`"

### 4. Acessar a interface web do ArgoCD

`ash
kubectl port-forward svc/argocd-server -n argocd 8080:443
`"

Acesse no navegador: https://localhost:8080

### 5. Pegar a senha inicial

`ash
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
`"

- **Login:** admin
- **Senha:** resultado do comando acima

---

## Passo a Passo: Registrar os Apps no ArgoCD

Apos instalar o ArgoCD, aplique os arquivos da pasta argocd/apps/:

`ash
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/auth-app.yaml
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/flag-app.yaml
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/targeting-app.yaml
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/evaluation-app.yaml
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/analytics-app.yaml
`"

> Execute esses comandos a partir da raiz do repositorio clonado.

---

## Fluxo Completo

`"
Sandro push imagem -> ECR
         |
         v
Pipeline atualiza deployment.yaml (nova tag da imagem)
         |
         v
ArgoCD detecta mudanca no repositorio
         |
         v
ArgoCD faz deploy automatico no cluster EKS
`"

---

## Como atualizar a imagem manualmente

`ash
# Edite fiap-tech-challenge-fase-3-infra/gitops/auth/deployment.yaml
# Troque a linha image: por:
image: 123456789012.dkr.ecr.us-east-1.amazonaws.com/auth:v1.0.0-abc123

git add fiap-tech-challenge-fase-3-infra/gitops/auth/deployment.yaml
git commit -m "chore: atualiza imagem auth para v1.0.0-abc123"
git push
`"

O ArgoCD detecta o push e faz o deploy automaticamente.

---

## Observacoes Importantes

| Campo | O que colocar |
|---|---|
| ACCOUNT_ID nos deployments | ID da conta AWS (pegar com o Edson) |
| REGION nos deployments | Regiao usada (ex: us-east-1) |
| repoURL nos apps ArgoCD | Ja esta apontando para este repositorio |

- **syncPolicy automated**: deploy automatico a cada mudanca no repositorio
- **prune: true**: remove recursos deletados do repositorio
- **selfHeal: true**: se alguem mudar algo direto no cluster, o ArgoCD corrige de volta
