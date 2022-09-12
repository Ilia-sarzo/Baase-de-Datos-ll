create database function_agregation;

use function_agregation;

create table estudiantes(
    id_est integer auto_increment primary key not null,
    nombres varchar(50),
    apellidos varchar(50),
    edad integer,
    gestion integer,
    fono integer,
    email varchar(100),
    direccion varchar(100),
    sexo varchar(10)
);

select est.*
from estudiantes as est;

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Miguel' ,'Gonzales Veliz', 20, 2832115, 'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino');
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Sandra' ,'Mavir Uria', 25, 2832116, 'sandra@gmail.com', 'Av. 6 de Agosto', 'femenino');
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Joel' ,'Adubiri Mondar', 30, 2832117, 'joel@gmail.com', 'Av. 6 de Agosto', 'masculino');
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Andrea' ,'Arias Ballesteros', 21, 2832118, 'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino');
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Santos' ,'Montes Valenzuela', 24, 2832119, 'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');

# Crear la consulta sql
# que modifique el campo GESTION
# y que asigne a todos el valor 2022

update estudiantes
set gestion = '2022'
where id_est > 0;

CREATE TABLE materias
(
  id_mat INTEGER AUTO_INCREMENT PRIMARY KEY  NOT NULL,
  nombre_mat VARCHAR(100),
  cod_mat VARCHAR(100)
);

CREATE TABLE inscripcion
(
  id_ins INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
  id_est INT NOT NULL,

  id_mat INT NOT NULL,
  semestre VARCHAR(20),
  gestion INTEGER,
  FOREIGN KEY (id_est) REFERENCES estudiantes (id_est),
  FOREIGN KEY (id_mat) REFERENCES materias (id_mat)
);

INSERT INTO materias (nombre_mat, cod_mat) VALUES
    ('Introduccion a la Arquitectura','ARQ-101'),
    ('Urbanismo y Diseno','ARQ-102'),
    ('Dibujo y Pintura Arquitectonico','ARQ-103'),
    ('Matematica discreta','ARQ-104'),
    ('Fisica Basica','ARQ-105');

INSERT INTO inscripcion (id_est, id_mat, semestre, gestion) VALUES
 (1, 1, '1er Semestre', 2015),
 (1, 2, '2do Semestre', 2015),
 (2, 4, '1er Semestre', 2016),
 (2, 3, '2do Semestre', 2016);

INSERT INTO inscripcion (id_est, id_mat, semestre, gestion) VALUES
 (3, 3, '2do Semestre', 2017),
 (3, 1, '3er Semestre', 2017),
 (4, 4, '4to Semestre', 2017),
 (5, 5, '5to Semestre', 2017);


# Mostrar los nombres y apellidos de los estudiantes inscritos en la materia
# ARQ-104, adicionalmente mostrar el nombre de la materia.
# tablas relacionadas:
# estudiantes
# inscrption
# materia

select est.nombres, est.apellidos, mat.nombre_mat
from inscripcion as ins
inner join estudiantes as est on ins.id_est = est.id_est
inner join materias as mat on ins.id_mat = mat.id_mat
where mat.cod_mat = 'ARQ-104';

# Contar cuantos registros tiene la tabla estudiantes

select count(est.id_est) as 'Cantidad de Estudiantes'
from estudiantes as est;

# Mostrar el promedio de edad en la tabla estudiantes.

 select avg(est.edad) as 'Promedio de Edad'
from estudiantes as est;

# Mostrar la máxima edad que se tiene en la tabla estudiantes.

SELECT MAX(est.edad)
FROM estudiantes AS est;


# Mostrar la mínima edad que se tiene en la estudiantes.
SELECT MIN(est.edad)
FROM estudiantes AS est;

# Determinar la maxima edad de los estudiantes cuyo genero sea masculino o femenino

select max(est.edad) as 'Edad Maxima'
from estudiantes as est
where est.sexo = 'Masculino' && est.edad >20;

# Crear una función que devuelve el máximo valor del campo edad en la tabla estudiantes.

create or replace function get_max_edad()
    returns integer

    begin
            return (
                SELECT MAX(est.edad)
                FROM estudiantes AS est
            ) ;
    end;

select get_max_edad() as MaxEdad;



# Crear una función que obtenga la menor edad de los estudiantes.
# Crear una función que obtenga el promedio de las edades.
# Crear una función que obtenga la mayor edad de los estudiantes (cuyo sexo seas masculino o femenino).

create or replace function get_min_edad()
    returns integer

    begin
            return (
                SELECT MIN(est.edad)
                FROM estudiantes AS est
            );
    end;

select get_min_edad() as MinEdad;

create or replace function get_promedio()
    returns integer

    begin
            return (
                select avg(est.edad) as 'Promedio de Edad'
                from estudiantes as est
                );

    end;


select get_promedio() as Promedio;

create or replace  function get_edad_mayor()
    returns integer

    begin
                return (select max(est.edad) as 'Edad Maxima'
                        from estudiantes as est
                        where est.sexo = 'Masculino' && est.edad >20);
    end;

select get_edad_mayor() as Edadmayor;

#  Mostrar el registro de la tabla estudiantes (nombre y apellidos) donde cuyo id_est sea el máximo.

create or replace function get_max_id() returns integer
    begin
            return (
                select max(est.id_est)
                 from estudiantes as est
            );
    end;

select get_max_id();

select est.nombres, est.apellidos
from estudiantes as est
where est.id_est = get_max_id();


# Crear una funcion que obtenga la suma de las edades de los estudiantes Masculino/Femenino

create or replace  function suma_de_edades() returns integer

begin
        return (
            select sum(est.edad)
            from estudiantes as est
            where est.sexo = 'Femenino'
            );
end;

select suma_de_edades();

select est.nombres, est.apellidos
from estudiantes as est
where suma_de_edades() % 2 =0;


# Crear una funcion que obtenga la suma de las edades de los estudiantes Femeninos.
create or replace  function suma_de_edades() returns integer

begin
        return (
            select sum(est.edad)
            from estudiantes as est
            where est.sexo = 'Femenino'
            );
end;

select suma_de_edades();

select est.nombres, est.apellidos
from estudiantes as est
where suma_de_edades() % 2 =0;


# Volver parametrizable la funcion anterior. v1
create or replace  function suma_de_edades_v1(genero_valor varchar(10)) returns integer

begin
        return (
            select sum(est.edad)
            from estudiantes as est
            where est.sexo = genero_valor
            );
end;

select suma_de_edades_v1('masculino');
select est.nombres, est.apellidos
from estudiantes as est
where suma_de_edades_v1('Masculino') % 2 =0;

# Volver parametrizable la funcion anterior. v2
create or replace  function suma_edadesv2(genero varchar(10)) returns integer
begin
#Esto sirve para declarar una vsariable en una funcion
         declare sumaedad integer default 0;
# default sirve para asignar un valor.
# into sirve para asignarle el resultado de una consulta a la variable
        select sum(est.edad) into sumaedad
        from estudiantes as est
        where est.sexo = genero;

        return sumaedad;
end;

select est.nombres, est.apellidos
from estudiantes as est
where suma_edadesv2('Masculino') % 2 =0;


create or replace function get_promedio_varones(sexo varchar(10)) returns integer
begin
    declare promedio integer default 0;

    select avg(est.edad) into promedio
    from estudiantes as est
    where est.sexo = sexo;

    return promedio;
end;

select get_promedio_varones('Masculino');
select est.nombres, est.apellidos
from estudiantes as est
where suma_edadesv2('Masculino') % 2 =0;

# Crear una función que permita concatenar dos columnas.
# Concatena el nombre y apellidos de la tabla estudiante.
# El nombre de la función deberá ser getNombreCompleto
# La función deberá recibir 2 parámetros (nombre y apellidos)

select concat('Andres' , ' ' , 'Quiroga');

create or replace function getNombreCompleto(part1 varchar(25) , part2 varchar(35)) returns varchar(50)
begin
        declare concatenado varchar(50) default ''; -- concatenado = '';
        set concatenado = concat(part1, '-', part2);
        return concatenado;
end;

select getNombreCompleto('Popeye' , 'Espinaca');

select getNombreCompleto(est.nombres , est.apellidos) as fullname
from estudiantes as est;

# TRIM elimina espacios de izquierda a derecha

Select concat_ws('-' 'DBA II', '2022' , '2do Semestre') as concat;

#Concatenar ; Generar el siguienter formato de salida
# Concatenar nombres y apellidos de la siguiente forma: Nombres: Andres, Apellidos: Quiroga
# Concatenar gestion y edad de la siguiente forma: Gestion: 2022, edad: (10)

create or replace function output_fullname(nombres varchar(20) , apellidos varchar(20)) returns varchar(100)
begin
        declare resultado varchar(100) default '';

        set resultado = concat('Nombres: ' , nombres , ', Apellidos: ' , apellidos);
        return resultado;
end;

select output_fullname('Andres' , 'Quiroga');

# gestion y edad
select output_fullname(est.nombres , est.apellidos)
    from estudiantes as est;
#
create or replace function output_age(gestion int , edad int) returns varchar(100)
begin
        declare resultado varchar(100) default '';

        set resultado = concat('Gestion: ' , gestion , ', Edad:(' , edad , ') ');
        return resultado;
end;

select output_age(2022 , 23);

select output_age(est.gestion , est.edad)
from estudiantes as est;

# las dos funciones anteriores unidas a una sola
create or replace function output_full(nombres varchar(20) , apellidos varchar(20) , gestion int , edad int) returns varchar(100)
begin
        declare resultado varchar(100) default '';
        set resultado = concat('Nombres: ' , nombres , 'Apellidos: ' , apellidos , 'Gestion: ' , gestion , 'Edad:(' , edad  , ') ');
        return resultado;
end;

select output_full('Andres' , 'Quiroga' , 2022 , 23);

select output_full(est.nombres , est.apellidos , est.gestion , est.edad)
from estudiantes as est;

#
create or replace function full_datos(Nombres varchar(30) , Apellidos varchar(30) , Edad int) returns varchar(60)
begin
        declare resultado varchar(60) default '';
        set resultado = concat('Nombres: ' , Nombres , 'Apellidos: ' , Apellidos , 'Edad:(' , Edad , ')');
        return resultado;
end;




# Mostrar el nombre, apellidos y el semestre de todos los estudiantes que esten inscritos.
# en la gestion 2015

select est.nombres , est.apellidos , m.nombre_mat , i.gestion
from estudiantes as est
inner join inscripcion i on est.id_est = i.id_est
inner join materias m on i.id_mat = m.id_mat
where i.gestion = '2015' and m.cod_mat = 'ARQ-101' and i.semestre = '5to Semestre';

select est.nombres , est.apellidos , i.gestion
from estudiantes as est
inner join inscripcion i on est.id_est = i.id_est
where i.gestion =2016 or i.gestion = 2017;