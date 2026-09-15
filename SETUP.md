# Como subir esta base no MySQL e usar no PopSQL

Guia para Windows. Do zero até rodar a primeira query: uns 5 minutos.

---

## Etapa 1 — Criar a base no MySQL

O jeito mais confiável no Windows é usar o cliente de linha de comando do MySQL e o comando `SOURCE`. Evita problema de redirecionamento (`<`), que o PowerShell não aceita.

**1.** Salve a pasta do projeto num caminho sem espaços e sem acento. Exemplo:

```
C:\projetos\sql-portfolio-saas
```

**2.** Abra o **MySQL 8.0 Command Line Client** (procure no menu Iniciar) e digite sua senha do root.

Se preferir usar o terminal normal, abra o `cmd` e rode:

```
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p
```

**3.** Já dentro do prompt `mysql>`, rode os dois arquivos na ordem. Atenção: use **barra normal** (`/`) no caminho, não barra invertida.

```sql
SOURCE C:/projetos/sql-portfolio-saas/schema.sql;
SOURCE C:/projetos/sql-portfolio-saas/seed.sql;
```

O `schema.sql` já cria o banco `saas_demo` e as 5 tabelas. O `seed.sql` insere os dados.

**4.** Confira se entrou tudo:

```sql
USE saas_demo;

SELECT 'clientes' AS tabela, COUNT(*) AS registros FROM clientes
UNION ALL SELECT 'assinaturas', COUNT(*) FROM assinaturas
UNION ALL SELECT 'cobrancas',   COUNT(*) FROM cobrancas
UNION ALL SELECT 'tickets',     COUNT(*) FROM tickets_suporte;
```

Resultado esperado:

| tabela | registros |
|---|---|
| clientes | 60 |
| assinaturas | 60 |
| cobrancas | 655 |
| tickets | 177 |

Se os quatro números baterem, a base está pronta. Pode fechar o cliente de linha de comando — o resto é no PopSQL.

---

## Etapa 2 — Conectar o PopSQL

No PopSQL: **New connection** → **MySQL**, e preencha:

| Campo | Valor |
|---|---|
| Name | `MySQL local — saas_demo` |
| Host | `localhost` |
| Port | `3306` |
| Database | `saas_demo` |
| Username | `root` |
| Password | sua senha do MySQL |
| Connection type | Direct connection (sem SSH tunnel) |

Clique em **Test connection** antes de salvar. Preencher o campo **Database** com `saas_demo` é o que faz as queries rodarem sem precisar de `USE saas_demo;` em cada arquivo.

Se o teste falhar, quase sempre é uma destas três coisas:

- **Can't connect / connection refused** → o serviço do MySQL não está rodando. Abra o menu Iniciar, digite `services.msc`, procure `MySQL80` e clique em Iniciar.
- **Access denied for user 'root'** → senha errada.
- **Unknown database 'saas_demo'** → a Etapa 1 não completou. Volte e rode o `schema.sql`.

---

## Etapa 3 — Ver as tabelas e rodar as queries

Com a conexão ativa, o painel esquerdo do PopSQL mostra o schema `saas_demo` e, dentro dele, as 5 tabelas. Clicar em cada uma abre a lista de colunas — é a forma rápida de conferir o modelo enquanto escreve a query.

Para rodar as perguntas:

1. **New query** (ou `Ctrl + T`)
2. Cole o conteúdo de um arquivo da pasta `queries/`
3. `Ctrl + Enter` executa

Atalhos que valem decorar:

| Atalho | O que faz |
|---|---|
| `Ctrl + Enter` | Roda a query (ou só o trecho selecionado) |
| `Ctrl + T` | Nova aba de query |
| `Ctrl + S` | Salva a query na sua biblioteca |
| `Ctrl + /` | Comenta/descomenta a linha |

Salvar cada uma das 10 com `Ctrl + S` usando o nome da pergunta deixa sua biblioteca no PopSQL espelhando o repositório. Ajuda quando você estiver revisando para a entrevista.

---

## Alternativa — fazer tudo dentro do PopSQL

Se preferir não abrir o terminal:

1. Crie a conexão da Etapa 2, mas deixe o campo **Database** em branco (ou coloque `mysql`)
2. Abra uma query nova, cole **todo** o conteúdo do `schema.sql` e rode
3. Abra outra query, cole **todo** o conteúdo do `seed.sql` e rode
4. Edite a conexão e coloque `saas_demo` no campo Database
5. Reconecte

Funciona, mas o `seed.sql` tem mais de 600 linhas e o `INSERT` de `cobrancas` é grande — o editor fica pesado. Por isso a via do `SOURCE` é a recomendada.

---

## Recomeçar do zero

Se quiser limpar tudo e refazer, rode no prompt `mysql>`:

```sql
DROP DATABASE saas_demo;
```

Depois repita a Etapa 1. O `schema.sql` é idempotente: pode rodar quantas vezes quiser, ele derruba e recria as tabelas.
