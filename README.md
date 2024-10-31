#  API de tarefas (sistema principal)

# Regras de negócio

# Diagramas

# Como executar o projeto

## Requisitos para rodar

- Docker Engine devidamente instalado
- Docker Compose devidamente instalado
- Portas `3000`, `9000` e `3306` da máquina disponíveis

> Sugestão: utilizar [Docker Desktop](https://www.docker.com/products/docker-desktop/), pois traz os requisitos acima além de uma interface gráfica que simplifica o gerenciamento de múltiplos containers.

## Como rodar a primeira vez

Navegue até o diretório onde se encontra o código adquirido através deste repositório e execute o seguinte comando:

```
docker compose up
```

Este comando irá criar a imagem baseado no código fonte e com essa imagem irá criar e iniciar o container docker. Além disso também criará o banco de dados (incluindo o de testes).

Da próxima vez que for rodar basta iniciar o container, não precisará o construir (a menos que tenha acontecido alguma mudança em relação as dependências no projeto, mas isto é apenas para fins de desenvolvimento).

## Para executar a suite de testes basta rodar o seguinte comando no diretório raiz do projeto

```
rspec spec/
```

# Documentação da API

| Verb   | Route                          | Parameters                           |
|--------|--------------------------------|--------------------------------------|
| get    | /tasks/get_all_tasks           | token                                |
| post   | /user_tasks/create             | token,description,state              |
| get    | /user_tasks/get_a_task         | token,user_task_id                   |
| put    | /user_tasks/update             | token,user_task_id,description,state |
| delete | /user_tasks/delete             | token,user_task_id                   |
| post   | /web_scraping_tasks/create     | token,url_for_scraping,state         |
| get    | /web_scraping_tasks/get_a_task | token,web_scraping_task_id           |
| put    | /web_scraping_tasks/update     | token,state                          |
| delete | /web_scraping_tasks/delete     | token,web_scraping_task_id           |
