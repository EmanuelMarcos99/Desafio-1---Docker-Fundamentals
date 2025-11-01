#!/bin/bash

echo "Passo 1: Criando o volume Docker chamado 'nginx_logs'..."
docker volume create nginx_logs

echo "Passo 2: Executando o primeiro container Nginx ('nginx-com-volume')..."
docker container run --name nginx-com-volume -d -p 8080:80 --mount type=volume,source=nginx_logs,target=/var/log/nginx nginx

echo "Passo 3: Gerando logs de acesso com o comando 'curl http://localhost:8080'..."
curl http://localhost:8080

echo "Passo 4: Parando e removendo o container 'nginx-com-volume'..."
docker stop nginx-com-volume
docker rm nginx-com-volume

echo "O container foi removido, mas o volume 'nginx_logs' e seus dados ainda existem!"

echo "Passo 5: Criando um NOVO container para validar a persistencia dos logs..."
docker container run --name nginx-validador -d -p 8080:80 --mount type=volume,source=nginx_logs,target=/var/log/nginx nginx

echo "Aguardando 2 segundos para o novo Nginx iniciar..." 
sleep 2

echo "Passo 6: Verificando o conteudo do 'access.log' dentro do NOVO container..."
docker exec nginx-validador cat /var/log/nginx/access.log

echo "Limpeza: Parando e removendo o container de validacao..."
docker stop nginx-validador
docker rm nginx-validador

echo "Concluído"