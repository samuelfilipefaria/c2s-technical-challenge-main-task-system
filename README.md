#  API de tarefas (sistema principal)

# Regras de negócio

## Gerenciamento de usuários

O sistema deverá exigir os seguintes dados dos usuários:

- Nome
- E-mail
- Senha

Após o cadastro o usuário deverá ser levado para a página de login. A autenticação será feita por meio de JWT (JSON Web Token) e o usuário não poderá fazer **nenhuma ação** com relação as tarefas ou web scraping se não estiver logado.

O sistema deverá permitir que o usuário saia de sua conta e delete/edite os dados da mesma.

Obs.: se um usuário for deletado, as tarefas criadas e/ou editadas, bem como as notificações relativas as mesmas, NÃO DEVEM ser deletadas também.

## Gerenciamento de tarefas

Existirão 2 tipos de tarefa:

1. Tarefa relativa a uma ação de um usuário
2. Tarefa relativa a uma ação do próprio sistema (nesse caso, o web scraping)

A primeira terá o seguintes campos:

- Descrição
- Estado (pendente, em progresso, concluída, falha)

A segunda terá o seguintes campos:

- Estado (pendente, em progresso, concluída, falha)
- URL para web scraping (campo único, não faz sentido extrair dados duas vezes da mesma URL)

Apenas usuários autenticados podem criar, editar e/ou deletar tarefas.

Diferentemente das tarefas de usuário, as tarefas de web scraping não podem ser editadas diretamente por usuários, uma vez que é uma tarefa de web scraping feita por uma máquina de forma assíncrona, além disso, estas só podem ser deletas ao fim da operação de extração de dados (nos estados "concluída" ou "falha")

Obs.: as tarefas aparecerão para TODOS os usuários logados, e não apenas para o usuário que a criou.

## Envio de notificações

Existirão 2 tipos de notificação:

1. Notificação relativa a uma ação de um usuário
2. Notificação relativa a uma ação do próprio sistema (nesse caso, o web scraping)

A primeira terá o seguintes campos:

- Usuário
- Operação
- Tarefa

Exemplo: O usuário **João** **editou** a tarefa **#15 "limpar a casa"**

A segunda terá o seguintes campos:

- Resultado (falha ou sucesso)
- Dados extraídos (em caso de sucesso)

Exemplo: A tarefa **#6 "pegar dados da BMW"** **teve sucesso** ao extrair os seguintes dados:

- **Marca: BMW**
- **Modelo: ix1**
- **Preço: 500000,00**

O sistema deve enviar notificações para os usuários sempre que:

- Uma tarefa for criada
- Uma tarefa for editada (isto inclui quando é finalizada pelo próprio sistema, no caso do web scraping)
- Uma tarefa de wen scraping for concluída (com falha ou sucesso)

Obs.: as notificações aparecerão para TODOS os usuários **logados**, e não apenas para o usuário que criou a tarefa relacionada à notificação. Além disso, quando uma tarefa for deletada, TODAS as notificações relativas a ela devem ser deletadas também.

## Web scraping

O web scraping deve ser feito em um anúncio do site web motors e deve coletar os seguintes dados:

- Marca
- Modelo
- Preço

# Diagramas (utilizados como apoio visual no vídeo explicativo)

## Representação dos microserviços

![c2s_technical_challenge_diagram](https://github.com/user-attachments/assets/4273a012-fbb1-441f-8702-b886dc6649f6)

## Diagrama de classes (utilizadas como tabelas no banco de dados graças ao ORM)

![class_diagram_c2s_challenge](https://github.com/user-attachments/assets/b5aaad9e-4d79-4a83-b8c1-c32ea770a36d)

## Diagrama de casos de uso

![diagram_use_case_c2s_challenge](https://github.com/user-attachments/assets/40e4aa8f-496d-485e-8d13-b98ca8632ebb)

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
