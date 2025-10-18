#!/bin/bash

echo -e "Passo 1: Baixando a imagem 'nginx' mais recente."
docker pull nginx

echo -e "\nPasso 2: Iniciando um containers a partir da imagem nginx com o nome 'meu-servidor."
docker container run -d --name meu-servidor nginx

echo -e "\nPasso 3: Listando todos os containers EM EXECUÇÃO"
docker ps

echo -e "\nPasso 4: Parando e removendo o containers 'meu-servidor'...${NC}"
docker stop meu-servidor
docker rm meu-servidor

echo -e "\nPasso 5: Listando TODOS os containers (incluindo os parados)"
docker container ls -a

echo -e "\nO script executou todos os passos."