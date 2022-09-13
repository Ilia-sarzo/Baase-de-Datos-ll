create database defensahito2;
use defensahito2;

CREATE TABLE autor
(
    id_autor    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name        VARCHAR(100),
    nacionality VARCHAR(50)
);

CREATE TABLE book
(
    id_book   INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    codigo    VARCHAR(25)                        NOT NULL,
    isbn      VARCHAR(50),
    title     VARCHAR(100),
    editorial VARCHAR(50),
    pages     INTEGER,
    id_autor  INTEGER,
    FOREIGN KEY (id_autor) REFERENCES autor (id_autor)
);

CREATE TABLE category
(
    id_cat  INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    type    VARCHAR(50),
    id_book INTEGER,
    FOREIGN KEY (id_book) REFERENCES book (id_book)
);

CREATE TABLE users
(
    id_user  INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    ci       VARCHAR(15)                        NOT NULL,
    fullname VARCHAR(100),
    lastname VARCHAR(100),
    address  VARCHAR(150),
    phone    INTEGER
);

CREATE TABLE prestamos
(
    id_prestamo    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_book        INTEGER,
    id_user        INTEGER,
    fec_prestamo   DATE,
    fec_devolucion DATE,
    FOREIGN KEY (id_book) REFERENCES book (id_book),
    FOREIGN KEY (id_user) REFERENCES users (id_user)
);

INSERT INTO autor (name, nacionality)
VALUES ('autor_name_1', 'Bolivia'),
       ('autor_name_2', 'Argentina'),
       ('autor_name_3', 'Mexico'),
       ('autor_name_4', 'Paraguay');

INSERT INTO book (codigo, isbn, title, editorial, pages, id_autor)
VALUES ('codigo_book_1', 'isbn_1', 'title_book_1', 'NOVA', 30, 1),
       ('codigo_book_2', 'isbn_2', 'title_book_2', 'NOVA II', 25, 1),
       ('codigo_book_3', 'isbn_3', 'title_book_3', 'NUEVA SENDA', 55, 2),
       ('codigo_book_4', 'isbn_4', 'title_book_4', 'IBRANI', 100, 3),
       ('codigo_book_5', 'isbn_5', 'title_book_5', 'IBRANI', 200, 4),
       ('codigo_book_6', 'isbn_6', 'title_book_6', 'IBRANI', 85, 4);

INSERT INTO category (type, id_book)
VALUES ('HISTORIA', 1),
       ('HISTORIA', 2),
       ('COMEDIA', 3),
       ('MANGA', 4),
       ('MANGA', 5),
       ('MANGA', 6);

INSERT INTO users (ci, fullname, lastname, address, phone)
VALUES ('111 cbba', 'user_1', 'lastanme_1', 'address_1', 111),
       ('222 cbba', 'user_2', 'lastanme_2', 'address_2', 222),
       ('333 cbba', 'user_3', 'lastanme_3', 'address_3', 333),
       ('444 lp', 'user_4', 'lastanme_4', 'address_4', 444),
       ('555 lp', 'user_5', 'lastanme_5', 'address_5', 555),
       ('666 sc', 'user_6', 'lastanme_6', 'address_6', 666),
       ('777 sc', 'user_7', 'lastanme_7', 'address_7', 777),
       ('888 or', 'user_8', 'lastanme_8', 'address_8', 888);

INSERT INTO prestamos (id_book, id_user, fec_prestamo, fec_devolucion)
VALUES (1, 1, '2017-10-20', '2017-10-25'),
       (2, 2, '2017-11-20', '2017-11-22'),
       (3, 3, '2018-10-22', '2018-10-27'),
       (4, 3, '2018-11-15', '2017-11-20'),
       (5, 4, '2018-12-20', '2018-12-25'),
       (6, 5, '2019-10-16', '2019-10-18');


#Mostrar el título del libro, los nombres y apellidos, y la categoría de los usuarios que se prestaron libros donde la categoría sea COMEDIA o MANGA

select Concat(us.fullname ',' us.Lastname)
from users as us

SELECT us.fullname, us.lastname, us.ci, bo.title
from users as us

inner join prestamos p on us.id_user = p.id_user
inner join book bo on p.id_book = bo.id_book
inner join category c on bo.id_book = c.id_book
inner join autor a on bo.id_autor = a.id_autor
where c.type = 'MANGA';

# Se desea saber cuántos usuarios se prestaron libros que correspondan a la editorial IBRANI y que la cantidad de sus páginas sea mayor a 90.
# Deberá de crear una función que retorne esa cantidad.
# La función debe de recibir 2 parámetros.
# Editorial y la cantidad de páginas.

create or replace function users_Ibrain(editorial varchar (50), pages integer)
returns VARCHAR (50)
begin
    return (select count(bo.id_book)
            from book as bo
            inner join prestamos as pr on bo.id_book = pr.id_book
            inner join users as us on pr.id_user = us.id_user
            where bo.pages > 90 and bo.editorial = 'Ibrani'
    );
end;

select users_Ibrain('IBRANI', 90) AS Editorial_Pages;


# Se desea saber qué libros tienen una cantidad de páginas par de la categoría MANGA.
# Deberá de crear una función que verifique si es par o no y retornar un TEXT que indique PAR o IMPAR adicionalmente concatenado el número de páginas.
# Esta función recibe como parámetro la cantidad de páginas.
# La función deberá ser usada en la cláusula SELECT.
# Deberá de crear una función que concatena cadenas.
# Se tiene el siguiente comportamiento esperado. (Debe de usar los mismos alias que de la imagen)

select concat('Editorial' , 'Paginas');

create or replace function get_concat(editorial varchar (50), type varchar (50)) returns varchar (100)
begin
    declare concatenado varchar (100) default '';
        set concatenado = concat('EDITORIAL: ', editorial, ', ', 'CATEGORIA: ', type);

return concatenado;
end;

select get_concat('IBRANI' , 'MANGA');

create or replace function get_par_impar(pages int ) returns varchar (100)
begin
        declare pagess varchar(100);
        set pagess = if(pages  %2 =0 , concat('Par: ', pages) , concat('Impar: ', pages));
        return pagess;
end;

select bo.editorial, cat.type, bo.pages
from book as bo
inner join category cat on bo.id_book = cat.id_book;

select get_concat('IBRANI', 'MANGA') , get_par_impar(23);


# Se desea saber cuántos libros fueron prestados en la gestión 2018.
# Crear una función que permita saber esa cantidad.
# Comportamiento esperado.

create or replace function get_prestados() returns integer
begin
        select COUNT(pres.fec_prestamo)
        from book as bo
        inner join prestamos as pres on bo.id_book = pres.id_book
        where pres.fec_prestamo = year(2018-10-22);
return year();
end;


select count(pr.fec_prestamo)
from prestamos as pr
inner join book bo on pr.id_book = bo.id_book
where year(pr.fec_prestamo) = 2018;

-- Se desea saber cuántos libros fueron prestados entre las gestiones 2017 y 2018.
-- Crear una función que permita saber esa cantidad.
-- SELECT usuariosGestion2017_2018();


create or replace function get_prestamo(editorial VARCHAR(100), id_book integer)  RETURNS varchar(1000)
    BEGIN
       RETURN (select Count( b.id_book)
                      from users AS U
                   inner join prestamos p on U.id_user = p.id_user
                   inner join book b on p.id_book = b.id_book
                 and b.pages > pages);

     END;


select count(*)
from prestamos as p
inner join book b on p.id_book = b.id_book
where year(fec_prestamo) = 2017  or  year(fec_prestamo)= 2018;


