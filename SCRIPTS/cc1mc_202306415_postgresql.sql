----------------------------------------------------------------------------------
-- Preparação para criar as tabelas do PSET
----------------------------------------------------------------------------------

--
-- Apagando o BD UVV e o Usuario
----------------------------------------------------------------------------------

DROP DATABASE IF EXISTS uvv;
DROP ROLE IF EXISTS rafael;
DROP USER IF EXISTS rafael;
--
-- Criacao do perfil
----------------------------------------------------------------------------------

-- USER: rafael

CREATE USER rafael WITH
  CREATEDB
  CREATEROLE
  ENCRYPTED PASSWORD '05072004';

--
-- Criacao do Banco de Dados
----------------------------------------------------------------------------------

-- Database: UVV
----------------------------------------------------------------------------------

SET ROLE rafael;
CREATE DATABASE uvv
    WITH
    OWNER = rafael
    TEMPLATE = template0
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
    LC_CTYPE = 'pt_BR.UTF-8'
    ALLOW_CONNECTIONS = true;

--
-- Troca de Conexões
----------------------------------------------------------------------------------

\setenv PGPASSWORD '05072004'
\c uvv rafael

--
-- Criação de esquema
----------------------------------------------------------------------------------

DROP SCHEMA IF EXISTS lojas;
CREATE SCHEMA IF NOT EXISTS lojas
    AUTHORIZATION rafael;
ALTER DATABASE uvv SET search_path TO "lojas", public;
SET search_path TO lojas;

----------------------------------------------------------------------------------
-- Criacao tabela produtos
----------------------------------------------------------------------------------

CREATE TABLE lojas.produtos (
                produto_id                  NUMERIC(38)      NOT NULL,
                nome                        VARCHAR(255)     NOT NULL,
                preco_unitario              NUMERIC(10,2),
                detalhes                    BYTEA,
                imagem                      BYTEA,
                imagem_mime_type            VARCHAR(512),
                imagem_arquivo              VARCHAR(512),
                imagem_charset              VARCHAR(512),
                imagem_ultima_atualizacao   DATE,

--
--  chave primaria
----------------------------------------------------------------------------------

                CONSTRAINT produto_id PRIMARY KEY (produto_id)
);

--
--comentarios da tabela 
----------------------------------------------------------------------------------

COMMENT ON TABLE lojas.produtos IS                               'Armazena informações detalhadas sobre os produtos disponíveis no sistema descrição.';

COMMENT ON COLUMN lojas.produtos.produto_id IS                   'Identificador único para cada registro de produto.';
COMMENT ON COLUMN lojas.produtos.nome IS                         'Armazena o nome do produto, identificando-o de forma clara e concisa.';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS               'Armazena o preço unitário de um produto.';
COMMENT ON COLUMN lojas.produtos.detalhes IS                     'Essa coluna destina-se a armazenar informações complementares ou descritivas sobre o produto.';
COMMENT ON COLUMN lojas.produtos.imagem IS                       'Armazena o caminho ou o nome do arquivo da imagem associada ao produto.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS             'Essa coluna contém o tipo MIME da imagem relacionada ao produto.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS               'A coluna "imagem_arquivo" armazena o nome do arquivo ou o caminho da imagem associada ao produto.';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS               'Armazena o conjunto de caracteres associado à imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS    'Registra a data e hora da última atualização da imagem do produto.';

--
--criacao tabela lojas 
----------------------------------------------------------------------------------

CREATE TABLE lojas.lojas (
                loja_id                 NUMERIC(38)   NOT NULL,
                nome                    VARCHAR(255)  NOT NULL,
                endereco_web            VARCHAR(100),
                endereco_fisico         VARCHAR(512),
                latitude                NUMERIC,
                longitude               NUMERIC,
                logo                    BYTEA,
                logo_mime_type          VARCHAR(512),
                logo_arquivo            VARCHAR(512),
                logo_charset            VARCHAR(512),
                logo_ultima_atualizacao DATE,

--
--  chave primaria
----------------------------------------------------------------------------------

                CONSTRAINT loja_id PRIMARY KEY (loja_id)
);

--
--comentarios da tabela 
----------------------------------------------------------------------------------

COMMENT ON TABLE lojas.lojas IS                              'Tabela referente a todas informações referentes à loja.';

COMMENT ON COLUMN lojas.lojas.loja_id IS                     'Coluna referente ao Identificador único da loja.';
COMMENT ON COLUMN lojas.lojas.nome IS                        'Coluna referente ao nome completo da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_web IS                'Armazena o endereço web associado ao recurso relacionado.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS             'Guarda informações sobre o endereço físico da loja.';
COMMENT ON COLUMN lojas.lojas.latitude IS                    'Armazena a latitude geográfica da localização.';
COMMENT ON COLUMN lojas.lojas.longitude IS                   'Armazena a longitude geográfica da localização.';
COMMENT ON COLUMN lojas.lojas.logo IS                        'Armazena o caminho ou o nome do arquivo do logo associado ao registro.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS              'Armazena o tipo MIME do arquivo do logo associado ao registro.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS                'Armazena o arquivo de imagem do logo associado ao registro.';
COMMENT ON COLUMN lojas.lojas.logo_charset IS                'Armazena o conjunto de caracteres (charset) associado ao logo.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS     'Registra a data e hora mais recentes em que o logo foi atualizado no registro.';

--
-- criacao da tabela estoques
----------------------------------------------------------------------------------

CREATE TABLE lojas.estoques (
                estoque_id          NUMERIC(38)   NOT NULL,
                loja_id             NUMERIC(38)   NOT NULL,
                produto_id          NUMERIC(38)   NOT NULL,
                quantidade          NUMERIC(38)   NOT NULL,

--
--  chave primaria
----------------------------------------------------------------------------------

                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);

--
--comentarios da tabela 
----------------------------------------------------------------------------------

COMMENT ON TABLE lojas.estoques IS               'Registra a quantidade atual de produtos em estoque para uma determinada loja.';
COMMENT ON COLUMN lojas.estoques.estoque_id IS   'Identificador único para cada registro de estoque.';
COMMENT ON COLUMN lojas.estoques.loja_id IS      'Coluna referente ao Identificador único da loja.';
COMMENT ON COLUMN lojas.estoques.produto_id IS   'Identificador único para cada registro de produto.';
COMMENT ON COLUMN lojas.estoques.quantidade IS   'Armazena o número atual de unidades disponíveis desse produto em estoque.';

--
-- criacao da tabela clientes
----------------------------------------------------------------------------------

CREATE TABLE lojas.clientes (
                cliente_id          NUMERIC(38)     NOT NULL,
                email               VARCHAR(255)    NOT NULL,
                nome                VARCHAR(255)    NOT NULL,
                telefone1           VARCHAR(20),
                telefone2           VARCHAR(20),
                telefone3           VARCHAR(20),

--
--  chave primaria
----------------------------------------------------------------------------------

                CONSTRAINT cliente_id PRIMARY KEY (cliente_id)
);

--
--comentarios da tabela 
----------------------------------------------------------------------------------

COMMENT ON TABLE lojas.clientes IS                   'Tabela relacionada com os clientes, contendo seu nome, email, telefones e ID';
COMMENT ON COLUMN lojas.clientes.cliente_id IS       'Colocar aqui o Identificador unico referente ao cliente citado';
COMMENT ON COLUMN lojas.clientes.email IS            'Colocar aqui o Email completo referente ao cliente citado.';
COMMENT ON COLUMN lojas.clientes.nome IS             'Colocar aqui o nome completo do cliente';
COMMENT ON COLUMN lojas.clientes.telefone1 IS        'Coluna referente ao telefone do cliente';
COMMENT ON COLUMN lojas.clientes.telefone2 IS        'Coluna referente ao segundo telefone do cliente';
COMMENT ON COLUMN lojas.clientes.telefone3 IS        'Coluna referente ao terceiro telefone do cliente';

--
-- criacao da tabela pedidos
----------------------------------------------------------------------------------

CREATE TABLE lojas.pedidos (
                pedido_id               NUMERIC(38)         NOT NULL,
                data_hora               TIMESTAMP           NOT NULL,
                cliente_id              NUMERIC(38)         NOT NULL,
                "status"                VARCHAR(15)         NOT NULL,
                loja_id                 NUMERIC(38)         NOT NULL,

--
--  chave primaria
----------------------------------------------------------------------------------

                CONSTRAINT pedido_id PRIMARY KEY (pedido_id)
);

--
--comentarios da tabela 
----------------------------------------------------------------------------------

COMMENT ON TABLE lojas.pedidos IS                        'Tabela Referente a todas informações dos pedidos, como data, status e o ID';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS             'Coluna referente ao Identificador único dos pedidos';
COMMENT ON COLUMN lojas.pedidos.data_hora IS             'Armazena a data e hora em que o pedido foi realizado.';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS            'Colocar aqui o Identificador único referente ao cliente citado';
COMMENT ON COLUMN lojas.pedidos.status IS                'Coluna referente ao status atual da entrega';
COMMENT ON COLUMN lojas.pedidos.loja_id IS                'Coluna referente ao Identificador único da loja';

--
-- criacao da tabela envios
----------------------------------------------------------------------------------

CREATE TABLE lojas.envios (
                envio_id              NUMERIC(38)   NOT NULL,
                loja_id               NUMERIC(38)   NOT NULL,
                cliente_id            NUMERIC(38)   NOT NULL,
                endereco_entrega      VARCHAR(512)  NOT NULL,
                "status"              VARCHAR(15)   NOT NULL,

--
--  chave primaria
----------------------------------------------------------------------------------
                CONSTRAINT envio_id PRIMARY KEY (envio_id)
);

--
--comentarios da tabela 
----------------------------------------------------------------------------------

COMMENT ON COLUMN lojas.envios.envio_id IS               'Coluna referente ao Identificador único de envio';
COMMENT ON COLUMN lojas.envios.loja_id IS                'Coluna referente ao Identificador único da loja';
COMMENT ON COLUMN lojas.envios.cliente_id IS             'Colocar aqui o Identificador único referente ao cliente citado';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS       'Coluna referente ao endereço completo no qual o envio será feito';
COMMENT ON COLUMN lojas.envios.status IS                 'Coluna referente ao status atual da entrega';

--
-- criacao da tabela pedido_items
----------------------------------------------------------------------------------
CREATE TABLE lojas.pedidos_items (
                pedido_id       NUMERIC(38)     NOT NULL,
                produto_id      NUMERIC(38)     NOT NULL,
                numero_da_linha NUMERIC(38)     NOT NULL,
                preco_unitario  NUMERIC(10,2)   NOT NULL,
                quantidade      NUMERIC(38)     NOT NULL,
                envio_id        NUMERIC(38)     NOT NULL,

--
--  chave primaria
----------------------------------------------------------------------------------

                CONSTRAINT pedido_id_produto_id PRIMARY KEY (pedido_id, produto_id)
);

--
--comentarios da tabela 
----------------------------------------------------------------------------------

COMMENT ON TABLE lojas.pedidos_items IS                      'A tabela "pedidos_items" armazena informações sobre os itens individuais de um pedido.';
COMMENT ON COLUMN lojas.pedidos_items.pedido_id IS           'Coluna referente ao Identificador único dos pedidos';
COMMENT ON COLUMN lojas.pedidos_items.produto_id IS          'Identificador único para cada registro de produto.';
COMMENT ON COLUMN lojas.pedidos_items.numero_da_linha IS     'Representa o número de sequência ou ordem atribuído a cada item de pedido.';
COMMENT ON COLUMN lojas.pedidos_items.preco_unitario IS      'Armazena o preço unitário de um produto, representando o valor monetário atribuído a cada unidade do produto.';
COMMENT ON COLUMN lojas.pedidos_items.quantidade IS          'Armazena o número atual de unidades disponíveis desse produto em estoque.';
COMMENT ON COLUMN lojas.pedidos_items.envio_id IS            'Coluna referente ao Identificador único de envio';

----------------------------------------------------------------------------------
-- Criacao das relacoes da tabela
----------------------------------------------------------------------------------


ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_items ADD CONSTRAINT pedidos_pedidos_items_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

----------------------------------------------------------------------------------
-- Criação das Restrições "CHECK"
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
-- PEDIDOS
----------------------------------------------------------------------------------
-- COLUNA STATUS PEDIDOS

ALTER TABLE lojas.pedidos
ADD CONSTRAINT status_check
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

----------------------------------------------------------------------------------
-- PRODUTOS
----------------------------------------------------------------------------------
-- COLUNA PRECO UNITARIO
ALTER TABLE lojas.produtos
ADD CONSTRAINT preco_unitario_check
CHECK (preco_unitario >= 0);
 -- COLUNA NOME PRODUTOS
ALTER TABLE lojas.produtos
ADD CONSTRAINT nome_produtos_check
UNIQUE (nome);

----------------------------------------------------------------------------------
-- ENVIOS
----------------------------------------------------------------------------------
-- COLUNA STATUS ENVIO
ALTER TABLE lojas.envios 
ADD CONSTRAINT status_envios_check 
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'))

----------------------------------------------------------------------------------
-- LOJAS
----------------------------------------------------------------------------------
-- COLUNA LONGITUDE
ALTER TABLE lojas.lojas
ADD CONSTRAINT lojas_longitude_check
CHECK (longitude >= -180 AND longitude <= 180);
-- COLUNA LATITUDE
ALTER TABLE lojas.lojas
ADD CONSTRAINT lojas_latitude_check
CHECK (latitude >= -90 AND latitude <= 90);
-- COLUNA NOME
ALTER TABLE lojas.lojas
ADD CONSTRAINT nome_lojas_check 
UNIQUE (nome);

----------------------------------------------------------------------------------
-- CLIENTES
----------------------------------------------------------------------------------
-- COLUNA EMAIL
ALTER TABLE lojas.clientes
ADD CONSTRAINT email_check
CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
-- COLUNA TELEFONE
ALTER TABLE lojas.clientes
ADD CONSTRAINT telefone_clientes_check
CHECK (LENGTH(telefone1) >= 5 AND LENGTH(telefone1) <= 20);

----------------------------------------------------------------------------------
-- ESTOQUES
----------------------------------------------------------------------------------
-- COLUNA ESTOQUES
ALTER TABLE lojas.estoques 
ADD CONSTRAINT estoques.armazem_check 
CHECK (quantidade >= 0);

----------------------------------------------------------------------------------
-- PEDIDOS ITENS
----------------------------------------------------------------------------------
-- COLUNA QUANTIDADE
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT quantidade_itens_check
CHECK (quantidade >= 0);
-- COLUNA PRECO UNITARIO
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT preco_unitario_pedidos_itens_check
CHECK (preco_unitario >= 0);
