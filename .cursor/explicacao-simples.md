# ?? Explicação como se você tivesse 10 anos

---

## O que é esse projeto?

Imagina que você tem 5 robôs funcionários (os microsserviços):
- **auth** ? cuida de login/senha
- **flag** ? controla "ligar/desligar" funcionalidades
- **targeting** ? decide quem vê o quê
- **evaluation** ? avalia regras
- **analytics** ? conta e mede coisas

Esses robôs precisam rodar em algum lugar. Esse lugar é a **AWS** (uma nuvem gigante de computadores da Amazon).

---

## O que é o Kubernetes (EKS)?

Pensa no EKS como um **gerente de robôs**.  
Você fala para ele: *"quero 1 robô auth rodando, com essa imagem, nessa porta"*.  
Ele garante que o robô vai ficar de pé. Se cair, ele levanta de novo sozinho.

Os arquivos `deployment.yaml` são como a **ficha de cada robô**: nome, foto (imagem Docker), quantos quero, qual porta usa.

Os arquivos `service.yaml` são como o **endereço do robô** dentro do cluster, para outros robôs saberem onde encontrá-lo.

---

## O que é o ArgoCD?

ArgoCD é um **fiscal** que fica olhando este repositório no GitHub.

Toda vez que alguém muda um arquivo aqui (ex: troca a imagem do robô auth), o ArgoCD percebe e manda o Kubernetes atualizar o robô automaticamente.

Ou seja: **você só muda o arquivo aqui no GitHub ? o robô no cluster já é atualizado. Mágica!** ?

---

## O que é GitOps?

É o nome dessa ideia:
> "Tudo o que está no repositório Git é a verdade. O cluster deve ser igual ao repositório."

Se o repositório diz "quero 1 robô auth com imagem v1.0.0", o cluster vai ter exatamente isso.  
Se você tentar mudar direto no cluster sem mudar aqui, o ArgoCD corrige e volta para o que está no repositório.

---

## Quem faz o quê nesse projeto?

```
EDSON  ? Cria a estrutura na AWS (os computadores, a rede, o EKS)
  ?
SANDRO ? Pega o código, compila, testa, empacota em imagem Docker e envia para ECR
  ?
RENAN  ? Os arquivos deste repositório dizem COMO e ONDE rodar cada microsserviço
         O ArgoCD usa esses arquivos para fazer o deploy automático
```

---

## O que é o ECR?

ECR é o **armário de imagens Docker** da AWS.  
Uma imagem Docker é como uma "foto" do microsserviço pronto para rodar.  
O Sandro coloca a foto lá. O deployment.yaml aponta para essa foto.

---

## O que é cada arquivo?

### `gitops/auth/deployment.yaml`
Diz para o Kubernetes:
- "Quero rodar 1 cópia do microsserviço auth"
- "A imagem está aqui: `123456.dkr.ecr.us-east-1.amazonaws.com/auth:v1.0.0`"
- "Ele escuta na porta 8080"

### `gitops/auth/service.yaml`
Diz para o Kubernetes:
- "Cria um endereço interno para o auth"
- "Quem quiser falar com o auth, manda para a porta 80, e eu redireciono para 8080"

### `argocd/apps/auth-app.yaml`
Diz para o ArgoCD:
- "Fica de olho neste repositório do GitHub"
- "Quando mudar alguma coisa na pasta `gitops/auth`, atualiza o cluster automaticamente"

---

## Fluxo resumido em 4 passos

```
1. Sandro termina o build ? imagem nova no ECR (ex: auth:v1.0.0-abc123)
2. Pipeline atualiza o deployment.yaml aqui neste repositório com a nova tag
3. ArgoCD percebe a mudança no repositório
4. ArgoCD manda o Kubernetes trocar a versão antiga pela nova ? Deploy feito! ?
```

---

## Comandos que o Renan precisa rodar (uma única vez)

```bash
# 1. Conectar ao cluster do Edson
aws eks update-kubeconfig --region us-east-1 --name NOME_DO_CLUSTER

# 2. Instalar o ArgoCD no cluster
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# 3. Registrar os microsserviços no ArgoCD
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/auth-app.yaml
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/flag-app.yaml
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/targeting-app.yaml
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/evaluation-app.yaml
kubectl apply -f fiap-tech-challenge-fase-3-infra/argocd/apps/analytics-app.yaml
```

**Pronto. Depois disso é tudo automático.** ??
