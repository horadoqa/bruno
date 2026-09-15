# Bruno API ServeRest

Este repositório reúne uma suíte de testes automatizados de API para a aplicação ServeRest, desenvolvida com [Bruno](<https://www.usebruno.com/>).

O objetivo é validar os principais fluxos da API, incluindo autenticação, usuários, produtos, carrinhos e conclusão de compras, além de garantir a qualidade das regras de negócio por meio de testes automatizados e execução contínua em CI/CD.

 ## Visão geral

 A estrutura do projeto organiza as requisições por domínio funcional:

- Login
- Produtos
- Usuários
- Carrinhos
- App

Cada arquivo `.yml` representa uma requisição HTTP, cenário de teste ou fluxo de API, com validações de status, payload e respostas esperadas.

## Stack

- **Bruno** — execução e organização dos testes de API
- **YAML** — definição das coleções e ambientes
- **GitHub Actions** — execução automatizada em CI
- **ServeRest** — API utilizada como referência para os testes
- **Node.js** — suporte para execução do Bruno CLI

 ## Pré-requisitos

 Antes de executar os testes localmente, certifique-se de ter instalado:

- Node.js 18+
- npm
- Docker
- Bruno CLI

 ## Quick start

 > Projeto de automação de testes de API com Bruno + ServeRest.

### 1\. Subir a API

 A API ServeRest pode ser executada localmente utilizando Docker.

Docker Hub:

https://hub.docker.com/r/paulogoncalvesbh/serverest/tags

```bash
docker run -d --name serverest -p 3000:3000 paulogoncalvesbh/serverest:latest
```

```bash
docker ps
CONTAINER ID   IMAGE                               COMMAND          CREATED       STATUS       PORTS                                         NAMES
7ccd11825680   paulogoncalvesbh/serverest:latest   "npm start --"   5 minutes ago   Up 5 minutes   0.0.0.0:3000->3000/tcp, [::]:3000->3000/tcp   serverest
```

Após iniciar o container, a API estará disponível em:

```
http://localhost:3000
```

Também é possível testar diretamente um endpoint:

```bash
curl -I http://localhost:3000
HTTP/1.1 200 OK
```

### 2\. Instalar o Bruno CLI

```bash
npm install -g @usebruno/cli
```

### 3\. Executar a suíte (collection)

Acessar a pasta da collectio

```bash
cd collection
```

Depois

```bash
bru run --env local
```

OBS.: O `bru run` não aceita o caminho da coleção como argumento. Ele precisa ser executado estando fisicamente no diretório onde está o `opencollection.yml`

### 4\. Gerar relatório JUnit

```bash
bru run --env local --reporter-junit results.xml
```

### 5\. Executar somente a pasta Usuarios

```bash
bru run Usuarios --env local
```

Salvandoo resultado

```bash
bru run Usuarios --env local --reporter-junit results.xml
```

Parando o serviço do Serverest

```bash
docker stop serverest && docker rm serverest 
```

## Ambientes

O ambiente utilizado nos testes locais é o `local`, definido em:

```
environments/local.yml
```

Esse arquivo contém a URL base da API e as variáveis necessárias para autenticação e gerenciamento de sessão.

Para executar os testes utilizando esse ambiente:

```bash
cd collectio
bru run --env local
```

OU 

Usando o `Makefile`

```bash
make test 
```

## Endpoints principais

| Módulo | Método | Endpoint | Objetivo |
| --- | --- | --- | --- |
| Login | POST | `/login` | Autenticação do usuário |
| Usuários | GET | `/usuarios` | Listagem de usuários |
| Usuários | POST | `/usuarios` | Cadastro de usuário |
| Usuários | PUT | `/usuarios/:id` | Atualização de usuário |
| Usuários | DELETE | `/usuarios/:id` | Exclusão de usuário |
| Produtos | GET | `/produtos` | Listagem de produtos |
| Produtos | POST | `/produtos` | Cadastro de produto |
| Produtos | PUT | `/produtos/:id` | Atualização de produto |
| Produtos | DELETE | `/produtos/:id` | Exclusão de produto |
| Carrinhos | POST | `/carrinhos` | Criação do carrinho |
| Carrinhos | GET | `/carrinhos/:id` | Consulta de carrinho |
| Carrinhos | DELETE | `/carrinhos/:id` | Exclusão do carrinho |
| Compras | POST | `/concluir-compra` | Finalização da compra |

## Regras de negócio avaliadas

 A suíte valida, entre outros cenários:

- criação de usuários com dados válidos
- autenticação e geração de token
- validação de preços e dados de produtos
- criação de carrinhos com produtos e quantidades válidas
- autenticação para operações restritas
- respostas de sucesso e erro
- códigos HTTP esperados
- estrutura e conteúdo dos payloads retornados pela API

 ## Arquitetura

 A arquitetura do projeto é orientada por coleções e cenários de teste, organizados por contexto funcional:

```
bruno/
│
├── .github/
│   └── workflows/
│       └── api-tests.yml
│
├── collection/
│   ├── App
│   │   ├── README.md
│   │   └── folder.yml
│   ├── Produtos
│   │   ├── Alterar Produto.yml
│   │   ├── Buscar Produto Por ID.yml
│   │   ├── Buscar Produto Por Nome.yml
│   │   ├── Cadastrar Produto sem Admin.yml
│   │   ├── Cadastrar Produto sem Token.yml
│   │   ├── Cadastrar Produtos.yml
│   │   ├── Listar produtos.yml
│   │   └── folder.yml
│   ├── Usuarios
│   │   ├── Alterar Usuario.yml
│   │   ├── Buscar usuario por ID.yml
│   │   ├── Cadastrar Cliente.yml
│   │   ├── Criar Usuario.yml
│   │   ├── Listar Usuarios.yml
│   │   └── folder.yml
│   ├── carrinhos
│   │   ├── Buscar Carrinho Por ID.yml
│   │   ├── Cancelar Compra.yml
│   │   ├── Concluir Compra.yml
│   │   ├── Criar carrinho.yml
│   │   ├── Excluir Cliente.yml
│   │   ├── Excluir Produto.yml
│   │   ├── Excluir Usuario.yml
│   │   ├── Listar Carrinhos.yml
│   │   ├── Recriar Carrinho.yml
│   │   └── folder.yml
│   ├── environments
│   │   └── local.yml
│   ├── login
│   │   ├── Login Admin.yml
│   │   ├── Login Cliente.yml
│   │   └── folder.yml
│   ├── opencollection.yml
│   └── reports
│       └── results.html
├── .gitignore
├── README.md
└── Makefile
```

## Fluxos cobertos

 A suíte contempla os principais fluxos funcionais da API:

- autenticação
- cadastro e consulta de usuários
- atualização e exclusão de usuários
- cadastro e listagem de produtos
- filtros e buscas por produto
- criação e manipulação de carrinhos
- fluxo de compra e conclusão da compra

## CI/CD

 O projeto possui uma pipeline no GitHub Actions definida em:

```
.github/workflows/api-tests.yml
```

A pipeline:

- inicia a API ServeRest em um container
- aguarda a aplicação ficar disponível
- instala o Bruno CLI
- executa a coleção de testes
- gera o relatório de execução
- publica o resultado como artefato JUnit

 ## Relatórios

 Durante a execução dos testes podem ser gerados relatórios no formato:

- XML/JUnit

 Os arquivos de resultado, como:

```
collection/report/results.xml
```

São considerados artefatos de execução e devem permanecer ignorados pelo Git para evitar ruído no versionamento.

## Troubleshooting

### Token ausente ou inválido

Revise a etapa de login e verifique se o token de autorização está sendo capturado corretamente no script `after-response`.

### Erros de status 400 ou 401

 Verifique:

- payload enviado
- token de autenticação
- permissões do usuário
- regras de negócio do endpoint
- variáveis definidas no ambiente `local`

 ## Contribuição

Para contribuir com melhorias na suíte:

1. Clone o repositório.
2. Crie uma branch para sua alteração.
3. Adicione ou ajuste os cenários de teste.
4. Execute a suíte localmente.
5. Verifique os resultados.
6. Abra um pull request com uma descrição clara das alterações.

 ## Autor

- Ricardo Fahham

 ## Observações

 Este repositório é focado em testes automatizados de API e validação de comportamento funcional.

 A suíte pode ser utilizada como base para:

- automação de regressão
- validação de regras de negócio
- garantia de qualidade
- testes de integração
- execução contínua em CI/CD

 