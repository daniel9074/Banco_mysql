
create database loja;
use loja;
create table gerente(
id int not null primary key,
nome varchar(45) not null,
cpf bigint
);
create table cliente(
id int not null primary key,
nome varchar(45) not null,
cpf bigint not null,
endereco varchar(45) not null,
telefone bigint not null
);
create table funcionario(
id int not null primary key,
nome varchar(45) not null,
cpf bigint not null
);
create table cadastro_de_produtos(
id int not null primary key,
produto varchar(45) not null,
marca varchar(45) not null,
valor decimal(6,2) not null,
tamanho varchar(3) not null
);
create table estoque(
id int not null primary key,
produtos_estoque varchar(45) not null,
cadastro_de_produtos_id int not null,
foreign key (cadastro_de_produtos_id) references cadastro_de_produtos(id)
);
create table venda(
id int not null primary key,
produto_vendido varchar(45)not null,
valor decimal(6,2) not null,
data_da_venda date not null,
desconto decimal(6,2) not null,
funcionario_id int not null,
cliente_id int not null,
estoque_id int not null,
gerente_id int not null,
foreign key (funcionario_id) references funcionario(id),
foreign key (cliente_id) references cliente(id),
foreign key (estoque_id) references estoque(id),
foreign key  (gerente_id) references gerente(id)
);
insert into gerente(id,nome,cpf)
values
('1','Carlos Emanuel','881018326499');

insert into funcionario(id,nome,cpf)
values
('1','João Antonio','2452532466'),
('2','Andressa pires','62204631744'),
('3','Ricardo Soares','01831997224'),
('5','Jéssica de Souza','0507339615');

insert into cliente(id,nome,cpf,endereco,telefone)
values
('1','Roberta Fraga','10726658081','Rua Leblon de Itapuã','6422684644'),
('2','Cristian silva','60727924052','Rua Doutor Manoel Estêvão Uzeda Luna Filho','6831659774'),
('3','Andreson Costa','08257718033','Residencial Pontaporã','9624328241'),
('4','Guilherme ferreira','76615204002','Rua Vinte e Um','6534311464'),
('5','Amanda martins','34382121027','Rua Tancredo Neves','9520573715');

insert into cadastro_de_produtos(id,produto,marca,valor,tamanho)
values
('1','tenis','adidas','50.00','36'),
('2','camiseta','nike','70.99','gg'),
('3','bermuda','bila bong','80.00','g'),
('4','tenis','vans','150.00','35'),
('5','camiseta','vans','125.00','m');

insert into estoque(id, produtos_estoque, cadastro_de_produtos_id)
values
('1','tenis','1'),
('2','camiseta','2'),
('3','bermuda','3'),
('4','tenis','4'),
('5','camiseta','5');

insert into venda(id,produto_vendido,valor,data_da_venda,desconto,funcionario_id,cliente_id,estoque_id,gerente_id)
values
('1','camiseta vans','125.00','2018-05-23','20.00','3','1','5','1'),
('2','tenis adidas','50.00','2018-05-25','10.00','5','4','1','1'),
('3','camiseta nike','70.00','2018-06-02','5.00','2','4','2','1'),
('4','tenis vans','150.00','2018-06-16','0.00','1','2','4','1'),
('5','bermuda bila bong','80.00','2018-07-12','30.00','5','3','3','1');






select*from mysql.user;

create user'gerente'@'localhost'identified by'1812';
create user'usuario1'@'localhost'identified by'9783';
create user'usuario2'@'localhost'identified by'9952';
create user'usuario3'@'localhost'identified by'5012';
create user'usuario4'@'localhost' identified by'5402';

grant  all privileges  on *.* to 'gerente'@'localhost';
grant select on *.* to 'usuario1'@'localhost';
grant select on *.* to 'usuario2'@'localhost';
grant select on *.* to 'usuario3'@'localhost';
grant select on *.* to 'usuario4'@'localhost';
flush privileges;

create role 'local de busca';
create role 'gerenciamento';




grant all on gerente.* to 'gerenciamento';

grant 'gerenciamento' to 'gerente'@'localhost';
set default role'gerenciamento' to 'gerente'@'localhost';

grant select on funcionario.* to 'local de busca';

grant 'local de busca' to 'usuario1'@'localhost';
set default role'local de busca' to 'usuario1'@'localhost';
grant 'local de busca' to 'usuario2'@'localhost';
set default role'local de busca' to 'usuario1'@'localhost';
grant 'local de busca' to 'usuario3'@'localhost';
set default role'local de busca' to 'usuario1'@'localhost';
grant 'local de busca' to 'usuario4'@'localhost';
set default role'local de busca' to 'usuario1'@'localhost';

select *from venda;

delimiter //
create procedure relatorio_nome(nomec varchar(45))
begin

select c.nome as nome_cliente, produto_vendido as produto_comprado, valor, desconto, data_da_venda, f.nome as nome_funcionario from venda v 
inner join cliente c on c.id=v.cliente_id 
inner join funcionario f on f.id=v.funcionario_id where c.nome=nomec;

end;

// delimiter 

call relatorio_nome('Roberta Fraga');




explain select c.nome as nome_cliente, produto_vendido as produto_comprado, valor, desconto, data_da_venda, f.nome as nome_funcionario from venda v 
inner join cliente c on c.id=v.cliente_id 
inner join funcionario f on f.id=v.funcionario_id

create index idx_1 on cliente(nome);


/* para fazer bakups eu iria no painel inicial escolher server depois data export,em seguida escolheria em qual local para fazer o backup
para restaurar eu iria em asministration data import/restore escolheria o local que esta e faria o restore,
outra opção de backup que eu usaria seria o sqlbackup que tem opção de fazer backup diariamente */