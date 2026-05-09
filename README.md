Para o seu FIAP Tech Challenge - Fase 3, o README precisa ser profissional, técnico e fácil de seguir para os avaliadores. Como você já definiu que o nome da branch será feature/cd-gitops-argocd, o documento abaixo reflete essa estrutura organizada.Aqui está a proposta de README estruturada:🚀 FIAP Tech Challenge - Fase 3 | GitOps & ArgoCDResponsável: RenanFoco: Deploy Automatizado de Microsserviços no Cluster EKS utilizando a metodologia GitOps.Este repositório contém a inteligência de entrega contínua (CD) do projeto. Através do ArgoCD, garantimos que o estado do cluster Kubernetes na AWS (EKS) esteja sempre sincronizado com os manifestos definidos neste repositório.📂 Estrutura do Repositório (GitOps)A organização segue o padrão de separação por microsserviços e definições de aplicações do ArgoCD:Plaintextfiap-tech-challenge-fase-3-infra/
├── gitops/                 # Manifestos K8s por serviço
│   ├── auth/               # Deployment e Service do serviço Auth
│   ├── flag/               # Configurações do serviço Flag
│   ├── targeting/          # Configurações do serviço Targeting
│   ├── evaluation/         # Configurações do serviço Evaluation
│   └── analytics/          # Configurações do serviço Analytics
├── argocd/
│   └── apps/               # Application Manifests (ArgoCD Objects)
│       ├── auth-app.yaml
│       ├── flag-app.yaml
│       └── ...
└── README.md
🛠️ Pré-requisitos TécnicosPara o funcionamento pleno deste fluxo, as seguintes etapas devem estar concluídas:Infraestrutura (Edson): Cluster EKS ativo e Repositórios ECR criados.CI/Build (Sandro): Imagens Docker geradas e armazenadas no ECR.🚀 Guia de Instalação e Configuração1. Conexão com o ClusterConfigure seu contexto local para apontar para o EKS da AWS:Bashaws eks update-kubeconfig --region <REGION> --name <CLUSTER_NAME>
2. Instalação do ArgoCDInstalamos o ArgoCD em um namespace isolado dentro do cluster:Bashkubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
Aguarde até que todos os pods estejam com o status Running:Bashkubectl get pods -n argocd
3. Acesso à Interface (UI)Realize o port-forward para acessar o painel administrativo localmente:Bashkubectl port-forward svc/argocd-server -n argocd 8080:443
URL: https://localhost:8080Usuário: adminSenha: Obtenha via comando abaixo:Bashkubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
⚙️ Registro das Aplicações (GitOps Flow)Para que o ArgoCD comece a monitorar este repositório e gerenciar os microsserviços, aplique os arquivos de declaração de App:Bashkubectl apply -f argocd/apps/
O que o ArgoCD fará automaticamente?Self-Heal: Se alguém alterar o cluster manualmente, o ArgoCD sobrescreve para manter o estado do Git.Prune: Se um recurso for removido do Git, ele será deletado do cluster.Auto-Sync: Qualquer git push na branch principal dispara o deploy.🔄 Fluxo de Atualização de ImagemO ciclo de vida de uma atualização segue o fluxo:Dev/Sandro: Faz o push da nova imagem para o ECR.GitOps: O manifesto em gitops/<servico>/deployment.yaml é atualizado com a nova TAG da imagem.ArgoCD: Detecta a diferença de versão entre o Git e o Cluster e realiza o Rolling Update.Exemplo de atualização manual:YAML# gitops/auth/deployment.yaml
spec:
  containers:
  - name: auth
    image: <ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/auth:v1.0.0
📌 Observações de ConfiguraçãoCampoDescriçãoACCOUNT_IDID da conta AWS onde o ECR reside.REGIONRegião AWS (ex: us-east-1).repoURLDeve apontar para a URL deste repositório Git.targetRevisionDefinido como main ou a branch de entrega.