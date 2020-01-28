# UpChallenge

API Rest "recriando" a API do Twitter, utilizando a linguagem **Elixir** e o framework **Phoenix**

## Instalação

É necessário instalar a máquina virtual Erlang (versão 18+)\*; a linguagem Elixir (1.5+); o gerenciador de pacotes Hex; e o Phoenix.

\* Ao instalar o Elixir segundo as instruções em https://elixir-lang.org/install.html, o Erland também é instalado

mais detalhes: https://hexdocs.pm/phoenix/installation.html

## Configuração

Todos os comandos devem ser feitos na raiz da pasta api.

- Ajustar as configurações de acesso ao banco de dados (preferencialmente PostgreSQL) no arquivo api/config/dev.exs

- Instalar as dependências do projeto:

```bash
mix deps.get
```

- Criar o banco e executar as migrations:

```bash
mix ecto.setup
```

\* Para ver a lista de comandos possíveis para o ecto:

```bash
mix ecto
```

- Iniciar o servidor ( em localhost:4000 ):

```bash
mix phx.server
```

## Docs

Pasta docs contém uma coleção e arquivo de ambiente do Postman com os endpoints implementados
