.PHONY: help test produtos usuarios carrinhos login up down

COLLECTION := collection
ENV := local

help:
	@echo "Comandos disponíveis:"
	@echo ""
	@echo "  make up          - Sobe o ambiente Serverest"
	@echo "  make down        - Para e remove o ambiente Serverest"
	@echo "  make setup       - Instala as dependências do projeto"
	@echo "  make test        - Executa todos os testes"
	@echo "  make produtos    - Executa os testes de Produtos"
	@echo "  make usuarios    - Executa os testes de Usuários"
	@echo "  make carrinhos   - Executa os testes de Carrinhos"
	@echo "  make login       - Executa os testes de Login"
	@echo ""

up:
	docker run -d --name serverest -p 3000:3000 paulogoncalvesbh/serverest:latest

down:
	docker stop serverest && docker rm serverest

setup:
	cd $(COLLECTION) && npm install -g @usebruno/cli

test:
	cd $(COLLECTION) && bru run --env $(ENV) --reporter-junit reports/results.xml

produtos:
	cd $(COLLECTION) && bru run Produtos --env $(ENV)

usuarios:
	cd $(COLLECTION) && bru run Usuarios --env $(ENV)

carrinhos:
	cd $(COLLECTION) && bru run carrinhos --env $(ENV)

login: usuarios
	cd $(COLLECTION) && bru run login --env $(ENV)
