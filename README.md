# FIAP Tech Challenge - Fase 3 | GitOps + ArgoCD

**Responsavel:** Renan  
**Branch:** `feature/cd-gitops-argocd`  
**Objetivo:** Deploy automatizado dos microsservicos no cluster EKS via ArgoCD

---

## Estrutura do Repositorio

```
fiap-tech-challenge-fase-3-infra/
+-- gitops/
|   +-- auth/
|   |   +-- deployment.yaml
|   |   +-- service.yaml
|   +-- flag/
|   |   +-- deployment.yaml
|   |   +-- service.yaml
|   +-- targeting/
|   |   +-- deployment.yaml
|   |   +-- service.yaml
|   +-- evaluation/
|   |   +-- deployment.yaml
|   |   +-- service.yaml
|   +-- analytics/
|       +-- deployment.yaml
|       +-- service.yaml
+-- argocd/
    +-- apps/
        +-- auth-app.yaml
        +-- flag-app.yaml
        +-- targeting-app.yaml
        +-- evaluation-app.yaml
        +-- analytics-app.yaml
```

---

## Pre-requisitos

| Integrante | O que precisa estar pronto |
|---|---|
| Edson | Cluster EKS ativo + Repositorios ECR criados na AWS |
| Sandro | Build e push das imagens Docker para o ECR |

---

## Instalacao do ArgoCD no Cluster EKS

### 1. Conectar ao cluster

```bash
aws eks update-kubeconfig --region REGION --name CLUSTER_NAME
```

### 2. Instalar o ArgoCD

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### 3. Aguardar os pods subirem

```bash
kubectl get pods -n argocd
# Aguarde STATUS = Running em todos os pods
```

### 4. Acessar a interface web

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Abra no navegador: **https://localhost:8080**

### 5. Obter a senha inicial

```bash
kubectl get secret argocd-initial-admin-secret -n argocd \
  -o jsonpath="{.data.password}" | base64 -d
```

- **Login:** `admin`
- **Senha:** resultado do comando acima

---

## Registrar os Microsservicos no ArgoCD

Execute os comandos abaixo a partir da **raiz do repositorio clonado**:

```bash
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/auth-app.yaml
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/flag-app.yaml
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/targeting-app.yaml
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/evaluation-app.yaml
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/analytics-app.yaml
```

O ArgoCD vai monitorar este repositorio e fazer o deploy automatico de cada microsservico.

---

## Fluxo de Deploy

```
1. Sandro faz push da imagem Docker para o ECR
           |
           v
2. Pipeline atualiza a tag da imagem no deployment.yaml deste repositorio
           |
           v
3. ArgoCD detecta a mudanca no GitHub
           |
           v
4. ArgoCD aplica o novo deployment no cluster EKS automaticamente
```

---

## Atualizar Imagem Manualmente

Edite o `deployment.yaml` do microsservico desejado e troque a linha `image:`.

```bash
# Arquivo: fiap-tech-challenge-fase-3-infra/gitops/auth/deployment.yaml

# Altere de:
image: ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com/auth:latest

# Para:
image: 123456789012.dkr.ecr.us-east-1.amazonaws.com/auth:v1.0.0-abc123

# Commit e push
git add fiap-tech-challenge-fase-3-infra/gitops/auth/deployment.yaml
git commit -m "chore: atualiza imagem auth v1.0.0-abc123"
git push
```

O ArgoCD detecta o push e faz o deploy automaticamente.

---

## Variaveis para preencher

| Variavel | Onde fica | Quem fornece |
|---|---|---|
| `ACCOUNT_ID` | `gitops/*/deployment.yaml` | Edson |
| `REGION` | `gitops/*/deployment.yaml` | Edson |
| `CLUSTER_NAME` | Comando `aws eks update-kubeconfig` | Edson |

---

## Comportamento do ArgoCD

| Configuracao | O que faz |
|---|---|
| `syncPolicy: automated` | Deploy automatico a cada mudanca no repositorio |
| `prune: true` | Remove do cluster recursos deletados do repositorio |
| `selfHeal: true` | Corrige o cluster se alguem mudar algo diretamente nele |
