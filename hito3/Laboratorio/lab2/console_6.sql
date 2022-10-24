create database Hito_3;
use Hito_3;

set @admin = 'admin';
select @admin;
set @admin = 'Gustabo';

create or replace function ejemplo() returns varchar(60)
begin
    declare respuesta varchar(60) default '';
    if @admin = 'admin'
    then
        set respuesta = 'Usuario Admin';
        else
        set respuesta = 'Usuario Invitado';
    end if;
    return respuesta;
end;

select ejemplo();

create or replace function ejemplo2() returns varchar(60)
begin
    declare respuesta varchar(50) default '';
    case
        when @admin = 'Admin' then set respuesta = 'Usuario Admin';
        when @admin = 'Guest' then set respuesta = 'Usuario Invitado';
        else set respuesta = 'Usuario Nuevo';
    end case;
    return respuesta;
end;

select ejemplo2();

-- crear una variable global de nombre precio
-- creae na funcion que maneje case
--  si el precio es mayor a 10 y memor igual a 20 retornar el mensaje basico
--  si el precio es mayor a 20 y memor igual a 30 retornar el mensaje intermedio
--  si el precio es mayor a 30 y memor igual a 50 retornar el mensaje superior
--  si el precio es mayor a 50  retorna el mernsaje carrisimo

set @precio = 15;

create or replace function precio() returns varchar(50)
begin
    declare respuesta varchar(50) default '';
    case
        when @precio >10 and  @precio <=20 then set respuesta = 'Basico';
        when @precio >20 and @precio <=30 then set respuesta = 'Intermedio';
        when @precio >30 and @precio <=50 then set respuesta = 'Superior';
        when @precio >50 then set respuesta = 'Carisimo';
        else set respuesta = 'Precio Nuevo';
    end case;
    return respuesta;
end;

select precio();
-- crear una funcion que reciba un parametro integer
--  la funcion debe retornar un texto TEXT como respuesta
-- el parametro es un valor numerico credit number
-- si es mayor a 50000 es PlATINIUM
-- si es mayor igual a 10000 y menor igual a 50000 es GOLD
-- si es menor a 10000 es SILVER
-- la funvcion debe retornar indicando si ese cliente es PLANTINIUM, GOLD o SILVER en base  al valor del credit_numnber();

set @Credit_Number = 15000;
create or replace function precio2() returns varchar(50)
begin
    declare respuesta varchar(50) default '';
    case
        when @Credit_Number >50000  then set respuesta = 'PLATINIUM';
        when @Credit_Number >=10000 and @Credit_Number <=50000 then set respuesta = 'Gold';
        when @Credit_Number <10000 then set respuesta = 'Silver';
        else set respuesta = 'Precio Nuevo';
    end case;
    return respuesta;
end;

select precio2();

-- bucle para numeros primos

create or replace function numbers(limitWhile integer) returns text
begin
    declare x integer default! 1;
    declare str text default '';

      while x <= limitWhile do
          set str = concat(str, x , ',');
          set x = x + 1;
          end while;
    return str;
end;

select numbers(10);

-- Numeros naturales

create or replace function numeros_naturales(limite integer) returns text
begin
    declare response text default '';
    declare x integer default 1;

    while x <= limite do
        set response = CONCAT(response , x , ',');
        set x = x + 1;
    end while;
    return response;
end;

select numeros_naturales(30);

-- Numeros Naturales Pares
create or replace function numeros_naturales_pares(limite integer) returns text
begin
    declare response text default '';
    declare x integer default 2;

    while x <= limite do
        set response = CONCAT(response , x , ',');
        set x = x + 2;
    end while;
    return response;
end;

select numeros_naturales_pares(60);

-- Crear una funcion que maneje while para el siguiente escenario
-- Esta funcion recibe un parametro (limite -> integer)
-- Si ese numero es par generar los pares hasta ese numero
-- Si ese numero es par, generar los impares hasta ese numero

create or replace function parametro (limite integer) returns text
begin
    declare response text default '';
    declare z integer;

    if limite % 2 = 0
    then
    set z = 2;
    while z <= limite do
        set response = CONCAT(response , z , ',');
        set z = z + 2;
    end while;
    else
    set z = 1;
    while  z <= limite do
        set response = CONCAT(response , z ,',');
        set z = z + 2;
        end while;
    end if;
    return response;
end;

select parametro(15);

-- Crear una funcion que maneje un solo while para el siguiente escenario
-- Esta funcion recibe un parametro (limite -> integer)
-- Si ese numero es par generar los pares hasta ese numero
-- Si ese numero es par, generar los impares hasta ese numero

create or replace function parametrov1 (limite integer) returns text
begin
    declare response text default '';
    declare z integer;

    if limite % 2 = 0
    then
    set z = 2;
    else
    if limite % 2 = 1
    then
    set z = 1;
    end if;
    end if;

    while z <= limite do
        set response = CONCAT(response , z , ',');
        set z = z + 2;

         end while;
    return response;
end;

select parametrov1(15);

-- que sea descendente
create or replace function parametrov2 (limite integer) returns text
begin
    declare response text default '';
    declare z integer;

    if limite % 2 = 0
    then
    set z = 2;
    else
    if limite % 2 = 1
    then
    set z = 1;
    end if;
    end if;

    while z <= limite do
        set response = CONCAT( z ,','  , response);
        set z = z + 2;

    end while;
    return response;
end;

select parametrov2(55);

create or replace function parametrov2 (limite integer) returns text
begin
    declare response text default '';
        while  limite < 0 do
        set response = CONCAT(  response, limite, ',');
        set limite = limite -2;
end while;
    return response;
end;
select parametrov2(10);

-- repeat
create or replace function repetir3 ( x integer) returns text
begin
    declare str text default '';

    repeat
        set  str = concat(str, x, ',');
        set x = x - 1;
    until  x <= 0 end repeat;
    return  str;
end;

select repetir(20);

-- repetoir con letras

create or replace function repetir3 ( limite integer) returns text
begin
    declare str text default '';
    repeat
        if limite % 2 = 0 then
        set  str = concat(str, limite, '-AA-');
        set limite = limite - 1;
        else
        set str = concat(str, limite , '-BB-');
        set limite = limite -1;
        end if;
    until  1 > limite
        end repeat;
    return  str;
end;

select repetir3(20);
