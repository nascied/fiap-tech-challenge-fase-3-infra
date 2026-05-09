# ?? FIAP Tech Challenge - Fase 3 | Parte do Renan (GitOps + ArgoCD)

Esta parte do projeto é responsável pelo **deploy automatizado** dos microsserviços no cluster EKS usando **ArgoCD** (GitOps).

---

## ?? Estrutura do Repositório

```
fiap-tech-challenge-fase-3-infra/
??? gitops/
?   ??? auth/
?   ?   ??? deployment.yaml   ? Define como o microsserviço auth roda no Kubernetes
?   ?   ??? service.yaml      ? Expõe o microsserviço auth dentro do cluster
?   ??? flag/
?   ?   ??? deployment.yaml
?   ?   ??? service.yaml
?   ??? targeting/
?   ?   ??? deployment.yaml
?   ?   ??? service.yaml
?   ??? evaluation/
?   ?   ??? deployment.yaml
?   ?   ??? service.yaml
?   ??? analytics/
?       ??? deployment.yaml
?       ??? service.yaml
??? argocd/
    ??? apps/
        ??? auth-app.yaml       ? Diz para o ArgoCD monitorar e deployar o auth
        ??? flag-app.yaml
        ??? targeting-app.yaml
        ??? evaluation-app.yaml
        ??? analytics-app.yaml
```

---

## ? Pré-requisitos

Antes de começar, o **Edson** precisa ter criado:
- ? Cluster EKS rodando na AWS
- ? Repositórios ECR criados (um por microsserviço)

E o **Sandro** precisa ter feito:
- ? Build e push das imagens Docker para o ECR

---

## ??? Passo a Passo: Instalação do ArgoCD no cluster EKS

### 1. Conectar ao cluster EKS

```bash
# Substitua REGION e CLUSTER_NAME pelos valores que o Edson passar
aws eks update-kubeconfig --region REGION --name CLUSTER_NAME
```

### 2. Instalar o ArgoCD no cluster

```bash
kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### 3. Aguardar o ArgoCD subir

```bash
kubectl get pods -n argocd
# Espere todos os pods estarem com STATUS "Running"
```

### 4. Acessar a interface web do ArgoCD

```bash
# Expõe temporariamente a interface no seu computador
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Acesse no navegador: `https://localhost:8080`

### 5. Pegar a senha inicial do ArgoCD

```bash
kubectl get secret argocd-initial-admin-secret -n argocd \
  -o jsonpath="{.data.password}" | base64 -d
```

- **Login:** `admin`
- **Senha:** resultado do comando acima

---

## ?? Passo a Passo: Registrar os Apps no ArgoCD

Após instalar o ArgoCD, aplique os arquivos da pasta `argocd/apps/`.  
Eles dizem ao ArgoCD **o que monitorar e deployar** neste repositório.

```bash
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/auth-app.yaml
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/flag-app.yaml
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/targeting-app.yaml
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/evaluation-app.yaml
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/analytics-app.yaml
```

> ?? Execute esses comandos a partir da raiz do repositório clonado.

Após isso, o ArgoCD vai automaticamente fazer o deploy de cada microsserviço no cluster.

---

## ?? Como funciona o fluxo completo

```
Sandro faz push da imagem ? ECR
           ?
Pipeline (Sandro) atualiza a tag da imagem no deployment.yaml deste repositório
(ex: auth:v1.0.0-abc123)
           ?
ArgoCD detecta a mudança neste repositório (GitHub)
           ?
ArgoCD faz o deploy automático no cluster EKS
```

---

## ?? Como atualizar a imagem de um microsserviço (manualmente)

Se precisar atualizar a imagem na mão, edite o `deployment.yaml` do microsserviço desejado e troque a linha `image:`.

Exemplo para o `auth`:

```bash
# Edite o arquivo:
# fiap-tech-challenge-fase-3-infra/gitops/auth/deployment.yaml
# Troque a linha image: por:
image: 123456789012.dkr.ecr.us-east-1.amazonaws.com/auth:v1.0.0-abc123

# Depois faça commit e push
git add fiap-tech-challenge-fase-3-infra/gitops/auth/deployment.yaml
git commit -m "chore: atualiza imagem auth para v1.0.0-abc123"
git push
```

O ArgoCD detecta o push e faz o deploy automaticamente. **Não precisa rodar mais nenhum comando.**

---

## ?? Observações Importantes

| Campo | O que colocar |
|---|---|
| `ACCOUNT_ID` nos deployments | ID da conta AWS (pegar com o Edson) |
| `REGION` nos deployments | Região usada (ex: `us-east-1`) |
| `repoURL` nos apps ArgoCD | Já está apontando para este repositório |

- O `syncPolicy: automated` nos arquivos de app garante que qualquer mudança no repositório seja aplicada **automaticamente** no cluster, sem precisar fazer nada manualmente.
- `prune: true` ? remove recursos que foram deletados do repositório
- `selfHeal: true` ? se alguém mudar algo direto no cluster, o ArgoCD corrige de volta para o que está no repositório
