.PHONY: test produtos usuarios carrinhos login

COLLECTION := collection
ENV := local

test:
	cd $(COLLECTION) && bru run --env $(ENV)

produtos:
	cd $(COLLECTION) && bru run Produtos --env $(ENV)

usuarios:
	cd $(COLLECTION) && bru run Usuarios --env $(ENV)

carrinhos:
	cd $(COLLECTION) && bru run carrinhos --env $(ENV)

login:
	cd $(COLLECTION) && bru run login --env $(ENV)
