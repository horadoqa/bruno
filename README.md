# Bruno API ServeRest

 [BRUNO](<https://www.usebruno.com/>)

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

 Após iniciar o container, a API estará disponível em:

```
http://localhost:3000
```

### 2\. Instalar o Bruno CLI

```bash
npm install -g @usebruno/cli
```

### 3\. Executar a suíte

```bash
bru run --env local
```

### 4\. Gerar relatório JUnit

```bash
bru run --env local --reporter-junit results.xml
```

## Ambientes

O ambiente utilizado nos testes locais é o `local`, definido em:

```
environments/local.yml
```

Esse arquivo contém a URL base da API e as variáveis necessárias para autenticação e gerenciamento de sessão.

Para executar os testes utilizando esse ambiente:

```bash
bru run --env local
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
[Bruno Collection]
        │
        ├── Login
        │   ├── Login Admin
        │   └── Login Cliente
        │
        ├── Usuarios
        │   ├── Criar Usuario
        │   ├── Listar Usuarios
        │   ├── Alterar Usuario
        │   └── Excluir Usuario
        │
        ├── Produtos
        │   ├── Cadastrar Produtos
        │   ├── Buscar Produto Por Nome
        │   └── Listar Produtos
        │
        ├── Carrinhos
        │   ├── Criar Carrinho
        │   ├── Concluir Compra
        │   └── Listar Carrinhos
        │
        └── environments/
            └── local.yml
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

 Durante a execução dos testes podem ser gerados relatórios nos formatos:

- HTML
- JSON
- XML/JUnit

 Os arquivos de resultado, como:

```
results.html
results.json
results.xml
```

 são considerados artefatos de execução e devem permanecer ignorados pelo Git para evitar ruído no versionamento.

## Estrutura do repositório

```
.
├── .github/
│   └── workflows/
│       └── api-tests.yml
├── App/
├── Carrinhos/
├── environments/
├── Login/
├── Produtos/
├── Usuarios/
├── .gitignore
├── opencollection.yml
├── README.md
└── ...
```

## Troubleshooting

### A API não responde

 Verifique se o container do ServeRest foi iniciado corretamente e se a porta `3000` está disponível:

```bash
docker ps
```

 Também é possível testar diretamente um endpoint:

```bash
curl http://localhost:3000/produtos
```

 ### Bruno não encontra o ambiente

 Confirme se o arquivo abaixo existe:

```
environments/local.yml
```

 E execute a coleção utilizando o ambiente correto:

```bash
bru run --env local
```

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

 A principal mudança foi deixar **Quick start como o único lugar que ensina a executar o projeto**. A seção **Ambientes** agora apenas explica o propósito do `local.yml`, sem repetir todo o processo de configuração.