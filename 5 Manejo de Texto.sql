/**************************************** ANALISIS DE TEXTO ****************************************/

/* 5-1 Introduccion */
/* Se utilizaran datos de reseñas de un parque de diversiones. El objetivo es aprender herramientas para limpieza y análisis básico de texto. */

/* 5-2 Qué es el analisis de Texto */
/* Los datos de tipo texto pueden ser: 
	Estructurados: 		Datos de formularios por ejemplo
	No estructurados:	Datos extraídos directamente de libros, revistas, páginas web.
    Semi estructurados:	Tienen parte estructurada y no estructurada como los correos electronicos.*/
/* Hay 2 tipos de análisis de texto:
	Cualitativo:	Leer el texto y hacer un resumen del contenido.
    	Cuantitativo:	Categorización, extracción de información. SQL nos servira para este análisis.*/
/* Metas:
	-Extracción de texto: Extraer el numero de estrellas que dejo una reseña.
    	-Categorización: Categorizar las reseñas.
    	-Análisis de sentimiento: Si al reseña fue positiva, negativa o neutra. Nota: SQL no es la mejor opción para realizar este análisis.*/

/* 5-3 Por que sí usar SQL */
/* Si se cuenta con una gran cantidad de datos y están disponibles directamente en una base relacional. Es una herramienta adecuada para tareas de conteo
o frecuencias, busqueda de palabras clave, limpiar y estructurar datos.*/

/* 5-4 SQL no es bueno para trabajar con texto */
/* Si la base es muy pequeña, si la consultas requieren ser ser ejecutadas en el menor tiempo posible hay alternativas como Elastic Search, 
si el objetivo es leer todo el texto y entregar un resumen. */

/* 5-5 Caracteristicas del Texto */

/* Mostrar las primeras 5 filas de la tabla disneyrew del esquema analisistexto */
select * 
from analisistexto.disneyrew
limit 5;
/*
disneyrew_id	Information
1	Rating: 4, Year_Month: 2019-4, Reviewer_Location: Australia, Review_Text: If you've ever been to Disneyland anywhere you'll find Disneyland Hong Kong very similar in the layout when you walk into main street! It has a very familiar feel. One of the rides  its a Small World  is absolutely fabulous and worth doing. The day we visited was fairly hot and relatively busy but the queues moved fairly well. Branch: Disneyland_HongKong
2	Rating: 4, Year_Month: 2019-5, Reviewer_Location: Philippines, Review_Text: Its been a while since d last time we visit HK Disneyland .. Yet, this time we only stay in Tomorrowland .. AKA Marvel land!Now they have Iron Man Experience n d Newly open Ant Man n d Wasp!!Ironman .. Great feature n so Exciting, especially d whole scenery of HK (HK central area to Kowloon)!Antman .. Changed by previous Buzz lightyear! More or less d same, but I'm expecting to have something most!!However, my boys like it!!Space Mountain .. Turns into Star Wars!! This 1 is Great!!!For cast members (staffs) .. Felt bit MINUS point from before!!! Just dun feel like its a Disney brand!! Seems more local like Ocean Park or even worst!!They got no SMILING face, but just wanna u to enter n attraction n leave!!Hello this is supposed to be Happiest Place on Earth brand!! But, just really Dont feel it!!Bakery in Main Street now have more attractive delicacies n Disney theme sweets .. These are Good Points!!Last, they also have Starbucks now inside the theme park!! Branch: Disneyland_HongKong
3	Rating: 4, Year_Month: 2019-4, Reviewer_Location: United Arab Emirates, Review_Text: Thanks God it wasn   t too hot or too humid when I was visiting the park   otherwise it would be a big issue (there is not a lot of shade).I have arrived around 10:30am and left at 6pm. Unfortunately I didn   t last until evening parade, but 8.5 hours was too much for me.There is plenty to do and everyone will find something interesting for themselves to enjoy.It wasn   t extremely busy and the longest time I had to queue for certain attractions was 45 minutes (which is really not that bad).Although I had an amazing time, I felt a bit underwhelmed with choice of rides and attractions. The park itself is quite small (I was really expecting something grand   even the main castle which was closed by the way was quite small).The food options are good, few coffee shops (including Starbucks) and plenty of gift shops. There was no issue with toilets as they are everywhere.All together it was a great day out and I really enjoyed it. Branch: Disneyland_HongKong
4	Rating: 4, Year_Month: 2019-4, Reviewer_Location: Australia, Review_Text: HK Disneyland is a great compact park. Unfortunately there is quite a bit of maintenance work going on at present so a number of areas are closed off (including the famous castle) If you go midweek, it is not too crowded and certainly no where near as bus as LA Disneyland. We did notice on this visit that prices for food, drinks etc have really gone through the roof so be prepared to pay top dollar for snacks (and avoid the souvenir shops if you can) Regardless, kids will love it. Branch: Disneyland_HongKong
5	Rating: 4, Year_Month: 2019-4, Reviewer_Location: United Kingdom, Review_Text: the location is not in the city, took around 1 hour from Kowlon, my kids like disneyland so much, everything is fine.   but its really crowded and hot in Hong Kong Branch: Disneyland_HongKong
...
*/

/* Obtener el numero de caracteres de la columna information */
select	length(information) as tamaño
from analisistexto.disneyrew
limit 5;
/*
tamaño
430
1074
1051
587
270
...
*/


/* Agrupar por el numero de caracteres que tienen las reseñas y hacer un conteo */
select	length(information) as tamaño,
		count(disneyrew_id)
from analisistexto.disneyrew
group by 1
order by 1 desc;
/*
tamaño	count(disneyrew_id)
20860	1
18564	1
18443	1
17466	1
17074	1
...
152	1
151	1
150	1
120	1
114	1
*/

/* 5-6 Text Parsing 1 */

/* Formula Left y Right para extraer caracteres de una cadena */
select 	left("Reseñas de Disney",7)  as izquierda,
	right("Reseñas de Disney",6) as derecha; 
/*
izquierda	derecha
Reseñas		Disney
*/

/* Extraer los primeros 6 caracteres de la columna de reseñas y contar cuantas veces se repite cada cadena */
select 	left(information,6) as izquierda,
	count(disneyrew_id)
from   	analisistexto.disneyrew
group by 1;
/*
izquierda	count(disneyrew_id)
Rating		42656
*/

/* Usar la función right y left para obtener la fecha en que se hizo el comentario. Notemos que faltaría limpiar la fecha. */
select right(left(information,30),7) as fecha
from analisistexto.disneyrew
group by 1
order by 1;
/*
fecha
2010-10
2010-11
2010-12
2010-3,
2010-4,
...
*/

/* Función substring_index */
/* Esta funcion busca una cadena especificada por el usuario sobre una columa de tipo string y devuelve la cadena antes de ese string o despues de ese string. */
/* Si la cadena "un ejemplo" se repite varias veces en el string, la funcion tomara en cuenta solo la primera vez que aparezca */
select 	substring_index("Esto es un ejemplo de texto","un ejemplo", 1) as Texto1, 
	substring_index("Esto es un ejemplo de texto","un ejemplo",-1) as Texto2;
/*
Texto1		Texto2
Esto es 	de texto
*/

/* Usar la funcion substring para extraer la fecha de la columna Infomrmation */
select 	substring_index(substring_index(information,"Year_Month: ",-1),",",1) as fecha,
	count(disneyrew_id)
from 	analisistexto.disneyrew
group by 1
order by 1;
/*
fecha		count(disneyrew_id)
2010-10		21
2010-11		27
2010-12		56
2010-3		2
2010-4		1
...
*/

/* 5-7 Text Parsing 2 */

/* Usando la consulta anterior obtener el año */
select 	substring_index(substring_index(substring_index(information,"Year_Month: ",-1),",",1),"-",1) as año,
	count(disneyrew_id) as conteo
from 	analisistexto.disneyrew
group by 1
order by 1;
/* 
año	count(disneyrew_id)
2010	143
2011	1984
2012	4342
2013	4717
2014	5301
...
*/

/* Obtener el año y el mes */
select 	substring_index(substring_index(substring_index(information,"Year_Month: ",-1),",",1),"-",1) as año,
	substring_index(substring_index(substring_index(information,"Year_Month: ",-1),",",1),"-",-1) as mes,
	count(disneyrew_id) as conteo
from 	analisistexto.disneyrew
group by 1,2
order by 1;
/*
año	mes	conteo
2010	10	21
2010	11	27
2010	12	56
2010	3	2
2010	4	1
...
*/

/* Usar la funcion substring_index para obtener rating, fecha, pais de origen */
select 	substring_index(substring_index(information,", Year_Month: ",1),"Rating: ",-1) as rating,
	substring_index(substring_index(information,", Reviewer_Location: ",1),", Year_Month: ",-1) as fecha,
        substring_index(substring_index(substring_index(information,", Reviewer_Location: ",1),", Year_Month: ",-1),"-",1) as año,
        substring_index(substring_index(substring_index(information,", Reviewer_Location: ",1),", Year_Month: ",-1),"-",-1) as mes,
        substring_index(substring_index(information,", Review_Text: ",1),", Reviewer_Location: ",-1) as pais_origen,
        substring_index(substring_index(information,", Branch: ",1),", Review_Text: ",-1) as comentario,
        substring_index(information,", Branch: ",1) as parque
from analisistexto.disneyrew;
/*
rating	fecha	pais_origen		comentario																																																																																																																																																																																																																																																																					parque
4	2019-4	Australia		If you've ever been to Disneyland anywhere you'll find Disneyland Hong Kong very similar in the layout when you walk into main street! It has a very familiar feel. One of the rides  its a Small World  is absolutely fabulous and worth doing. The day we visited was fairly hot and relatively busy but the queues moved fairly well. Branch: Disneyland_HongKong	Rating: 4, Year_Month: 2019-4, Reviewer_Location: Australia, Review_Text: If you've ever been to Disneyland anywhere you'll find Disneyland Hong Kong very similar in the layout when you walk into main street! It has a very familiar feel. One of the rides  its a Small World  is absolutely fabulous and worth doing. The day we visited was fairly hot and relatively busy but the queues moved fairly well. 																																																																																																																																																																							Branch: Disneyland_HongKong
4	2019-5	Philippines		Its been a while since d last time we visit HK Disneyland .. Yet, this time we only stay in Tomorrowland .. AKA Marvel land!Now they have Iron Man Experience n d Newly open Ant Man n d Wasp!!Ironman .. Great feature n so Exciting, especially d whole scenery of HK (HK central area to Kowloon)!Antman .. Changed by previous Buzz lightyear! More or less d same, but I'm expecting to have something most!!However, my boys like it!!Space Mountain .. Turns into Star Wars!! This 1 is Great!!!For cast members (staffs) .. Felt bit MINUS point from before!!! Just dun feel like its a Disney brand!! Seems more local like Ocean Park or even worst!!They got no SMILING face, but just wanna u to enter n attraction n leave!!Hello this is supposed to be Happiest Place on Earth brand!! But, just really Dont feel it!!Bakery in Main Street now have more attractive delicacies n Disney theme sweets .. These are Good Points!!Last, they also have Starbucks now inside the theme park!! Branch: Disneyland_HongKong	Rating: 4, Year_Month: 2019-5, Reviewer_Location: Philippines, Review_Text: Its been a while since d last time we visit HK Disneyland .. Yet, this time we only stay in Tomorrowland .. AKA Marvel land!Now they have Iron Man Experience n d Newly open Ant Man n d Wasp!!Ironman .. Great feature n so Exciting, especially d whole scenery of HK (HK central area to Kowloon)!Antman .. Changed by previous Buzz lightyear! More or less d same, but I'm expecting to have something most!!However, my boys like it!!Space Mountain .. Turns into Star Wars!! This 1 is Great!!!For cast members (staffs) .. Felt bit MINUS point from before!!! Just dun feel like its a Disney brand!! Seems more local like Ocean Park or even worst!!They got no SMILING face, but just wanna u to enter n attraction n leave!!Hello this is supposed to be Happiest Place on Earth brand!! But, just really Dont feel it!!Bakery in Main Street now have more attractive delicacies n Disney theme sweets .. These are Good Points!!Last, they also have Starbucks now inside the theme park!! 							Branch: Disneyland_HongKong
4	2019-4	United Arab Emirates	Thanks God it wasn   t too hot or too humid when I was visiting the park   otherwise it would be a big issue (there is not a lot of shade).I have arrived around 10:30am and left at 6pm. Unfortunately I didn   t last until evening parade, but 8.5 hours was too much for me.There is plenty to do and everyone will find something interesting for themselves to enjoy.It wasn   t extremely busy and the longest time I had to queue for certain attractions was 45 minutes (which is really not that bad).Although I had an amazing time, I felt a bit underwhelmed with choice of rides and attractions. The park itself is quite small (I was really expecting something grand   even the main castle which was closed by the way was quite small).The food options are good, few coffee shops (including Starbucks) and plenty of gift shops. There was no issue with toilets as they are everywhere.All together it was a great day out and I really enjoyed it. Branch: Disneyland_HongKong	Rating: 4, Year_Month: 2019-4, Reviewer_Location: United Arab Emirates, Review_Text: Thanks God it wasn   t too hot or too humid when I was visiting the park   otherwise it would be a big issue (there is not a lot of shade).I have arrived around 10:30am and left at 6pm. Unfortunately I didn   t last until evening parade, but 8.5 hours was too much for me.There is plenty to do and everyone will find something interesting for themselves to enjoy.It wasn   t extremely busy and the longest time I had to queue for certain attractions was 45 minutes (which is really not that bad).Although I had an amazing time, I felt a bit underwhelmed with choice of rides and attractions. The park itself is quite small (I was really expecting something grand   even the main castle which was closed by the way was quite small).The food options are good, few coffee shops (including Starbucks) and plenty of gift shops. There was no issue with toilets as they are everywhere.All together it was a great day out and I really enjoyed it. 													Branch: Disneyland_HongKong
4	2019-4	Australia		HK Disneyland is a great compact park. Unfortunately there is quite a bit of maintenance work going on at present so a number of areas are closed off (including the famous castle) If you go midweek, it is not too crowded and certainly no where near as bus as LA Disneyland. We did notice on this visit that prices for food, drinks etc have really gone through the roof so be prepared to pay top dollar for snacks (and avoid the souvenir shops if you can) Regardless, kids will love it. Branch: Disneyland_HongKong	Rating: 4, Year_Month: 2019-4, Reviewer_Location: Australia, Review_Text: HK Disneyland is a great compact park. Unfortunately there is quite a bit of maintenance work going on at present so a number of areas are closed off (including the famous castle) If you go midweek, it is not too crowded and certainly no where near as bus as LA Disneyland. We did notice on this visit that prices for food, drinks etc have really gone through the roof so be prepared to pay top dollar for snacks (and avoid the souvenir shops if you can) Regardless, kids will love it. 																																																																																																																															Branch: Disneyland_HongKong
4	2019-4	United Kingdom		the location is not in the city, took around 1 hour from Kowlon, my kids like disneyland so much, everything is fine.   but its really crowded and hot in Hong Kong Branch: Disneyland_HongKong	Rating: 4, Year_Month: 2019-4, Reviewer_Location: United Kingdom, Review_Text: the location is not in the city, took around 1 hour from Kowlon, my kids like disneyland so much, everything is fine.   but its really crowded and hot in Hong Kong 																																																																																																																																																																																																																Branch: Disneyland_HongKong
...
*/

/* 5-8 Transformacion de Texto */

/* Funciones Upper, Lower, Trim */
select	upper("Hola amigos") as upper,							/* Convierte una cadena a mayusculas */
	lower("Hola amigos") as lower,							/* Convierte una cadena a minusculas */
	trim("    Hola amigos     ") as trim,						/* Elimina espacios en blanco al inicio y final de una cadena */
        trim(leading "$" from "$$Hola amigos") as trim2, 				/* Elimina un caracter inicial que le especifiquemos de una cadena de texto */
        replace("Hola amigos","Hola","Holi") as reemplazar;				/* Permite sustituir una cadena de texto por otra dentro de una string */
/*
upper		lower		trim		trim2		reemplazar
HOLA AMIGOS	hola amigos	Hola amigos	Hola amigos	Holi amigos
*/


/* Crear una nueva tabla para guardar el resultado de esta consulta.	
   Usar la funcion trim para eliminar espacios en blanco de la columna comentario.
   Convertir la columna rating a entero sin signo.
   Convertir la columna año a entero sin signo.
   Convertir la columna mes a entero sin signo.
   Reemplazar el nombre de país.
*/
create table analisistexto.disneyclean as
select	convert(rating,unsigned int) as rating,
	case
		when año="missing" then null
        	else convert(año,unsigned int)
	end as año,
	case
		when mes="missing" then null
        	else convert(mes,unsigned int)
	end as mes,
        replace(replace(replace(pais_origen,"United States","US"),"United Kingdom","UK"),"United Arab Emirates","UAE") as pais_origen,
        trim(comentario) as comentario,
        parque
from
(
	select 	substring_index(substring_index(information,", Year_Month: ",1),"Rating: ",-1) as rating,
		substring_index(substring_index(information,", Reviewer_Location: ",1),", Year_Month: ",-1) as fecha,
		substring_index(substring_index(substring_index(information,", Reviewer_Location: ",1),", Year_Month: ",-1),"-",1) as año,
		substring_index(substring_index(substring_index(information,", Reviewer_Location: ",1),", Year_Month: ",-1),"-",-1) as mes,
		substring_index(substring_index(information,", Review_Text: ",1),", Reviewer_Location: ",-1) as pais_origen,
		substring_index(substring_index(information,", Branch: ",1),", Review_Text: ",-1) as comentario,
		substring_index(information,", Branch: ",1) as parque
	from analisistexto.disneyrew
) as a;


/* 5-9 Busquedas con Comodin */

/* Funcion LIKE */
select 	"Daniel Perez Gonzalez"	LIKE "Go" 		as e1, 		/* Devuelve 0. Busca coincidencia exacta entre las dos cadenas.*/
	"Daniel Perez Gonzalez"	NOT LIKE "Go" 	    	as e2, 		/* Devuelve 1. Busca la NO coincidencia exacta entre las dos cadenas.*/
	"Daniel Perez Gonzalez"	LIKE "%on%" 		as e3, 		/* Devuelve 1. Busca que la cadena empiece con texto cualquiera seguida de la cadena "on" seguida de texto cualquiera.*/
	"Daniel Perez Gonzalez" LIKE "d%" 		as e4,		/* Devuelve 1. Busca que la cadena empiece con la palabra "d" seguida de texto cualquiera.*/
	"Daniel Perez Gonzalez" LIKE "P%" 		as e5,		/* Devuelve 0. Busca que la cadena empiece con la palabra "P" seguida de texto cualquiera.*/
	"Daniel Perez Gonzalez" LIKE "%Z" 		as e6,		/* Devuelve 1. Busca que la cadena empiece con texto cualquiera y termine con "z".*/
	"Daniel Perez Gonzalez" LIKE "%el" 		as e7,		/* Devuelve 0. Busca que la cadena empiece con texto cualquiera y termine con "el".*/
	"Daniel Perez Gonzalez" LIKE "_a%" 		as e8,		/* Devuelve 1. Busca que la cadena empiece con un caracter cualquiera, seguida de la letra "a" seguido de texto cualquiera.*/
	"Daniel Perez Gonzalez" LIKE "_e%" 		as e9;		/* Devuelve 0. Busca que la cadena empiece con un caracter cualquiera, seguida de la letra "e" seguido de texto cualquiera.*/
/*
e1	e2	e3	e4	e5	e6	e7	e8	e9
0	1	1	1	0	1	0	1	1
*/


/* Contar el número de reseñas que contengan la palabra "grandson" */
select	count(*) 
from 	analisistexto.disneyclean
where 	comentario like "%grandson%";
/*
count(*)
241
*/

/* Contar el número de reseñas que no contengan la palabra "grandson" */
select	count(*) 
from 	analisistexto.disneyclean
where 	comentario not like "%grandson%";
/*
count(*)
42415
*/

/* Conteo de comentarios qu contegan la palabra son o daughter */
select count(*)
from analisistexto.disneyclean
where comentario like "%daughter%" or comentario like "%son%";
/*
count(*)
9922
*/

/* Contar los comentarios que contienen la palabra wife y contienen las palabras son o daugther */
select count(*)
from analisistexto.disneyclean
where comentario like "%wife%" and (comentario like "%son%" or comentario like "%daughter%" );
/*
count(*)
540
*/

/* Contar los comentarios de acuerdo a si contienen alguna de las siguientes palabras */
select 	case 	
		when comentario like "%love%" 		then "aman"
		when comentario like "%fabulous%" 	then "fabuloso"
                when comentario like "%like%" 		then "gusta"
                when comentario like "%good%" 		then "bien"
		when comentario like "%bad%" 		then "malo"
                when comentario like "%expensive%" 	then "caro"
                when comentario like "%boring%" 	then "aburrido"
                else "ninguno"
	end as sentimiento,
	count(*)
from analisistexto.disneyclean
group by 1
order by 1 desc;
/*
sentimiento	count(*)
ninguno		16622
malo		947
gusta		6907
fabuloso	413
caro		1853
bien		4958
aman		10863
aburrido	93
*/

/* Obtener la tabla considerando que puede haber comentarios que contenga una o mas palabras */
select 	comentario like "%love%" as "aman",
		comentario like "%like%" as "gusta",
		comentario like "%bad%"  as "malo",
        count(*)
from analisistexto.disneyclean
group by 1,2,3
order by 1,2,3;
/*
aman	gusta	malo	count(*)
0	0	0	23431
0	0	1	1370
0	1	0	6366
0	1	1	626
1	0	0	7398
1	0	1	460
1	1	0	2591
1	1	1	414
*/

/* 5-10 Busqueda Exacta */

/* Extraer la primera palabra del comentario y verificar si coincide con una lista de palabras dada */

select *
from
(
	select 	substring_index(comentario," ",1) as primera_palabra,
			comentario
	from analisistexto.disneyclean
) as Z
where primera_palabra in ("Amazing","Great","Fun","Small","Disgusting");
/*
primera_palabra	comentario
Great	Great place! Your day will go by and you won't even know it. Obviously went there for my daughter and she absolutely loved it! Too bad the parade got canceled though. Branch: Disneyland_HongKong
Small	Small disneyland catering to kids, but they have some nice rides including the new Ant Man ride. Pricey food and somewhat long queues but that is part of the theme park. Try to go in the morning and then again in the evening, best is to stay one day at the hotel to maximize the park. Branch: Disneyland_HongKong
Great	Great fun for the family.  The fact that it is a smaller park than other Disney   s is a plus.  Facilities seem new and loads of different games. Branch: Disneyland_HongKong
great	great way to spend a day in Hong kong as a tourist, easy to wander through the park and lots of fun, overall good value, found some good souvenirs along the way..food a little expensive as is with most parks a should do if your over that way Branch: Disneyland_HongKong
Amazing	Amazing  The shows  Everything was amazing  If u are a Disney fan you should visit   Is in fact a must and if u didnt do it then ur missing out Branch: Disneyland_HongKong
...
*/


/* 5-11 Expresiones Regulares */

/* Busqueda de una palabra dentro de texto */
select 	"Los datos son de disney" regexp "Disney" as busqueda,
		"Los datos son de disney" regexp "e" as busqueda;
/*
busqueda1 busqueda2
1 	1
*/

/* Negación de busqueda de una palabra dentro de texto */
select "Los datos son de disney" not regexp "Disney" as busqueda;
/*
busqueda
0
*/

/* Busqueda de una palabra que esté contenida en el texto pero no al inicio del texto */
select 	"Los datos son de disney" regexp ".disney" as busqueda1,
		"Los datos son de disney" regexp ".los" as busqueda2;
/*
busqueda1 busqueda2
1 0
*/

/* Busqueda de palabras con distintas iniciales */
select 	"Los datos son de disney" regexp "[abcdef]isney" 	as busqueda1,  /*Buscar aisney o disney  ... o fisney */
		"Los datos son de disney" regexp "[abcdef]" 		as busqueda2;  /*Buscar a o b o c o d o e o f*/
/*
busqueda1 busqueda2
1	1
*/

/* Buscar cualquier letra del entre la a y la z */
select "Los datos son de disney" regexp "[a-z]" as busqueda;
/*
busqueda1 
1
*/

/* Buscar cualquier numero entre un rango de numeros */
select 	"5 minutos en el parque" regexp "[1-5]" as busqueda1,
		"5 minutos en el parque" regexp "[1-3]" as busqueda2,
        "5 minutos en el parque" regexp "[12345]" as busqueda3;   /* Buscar 1 o 2 o 3 o 4 o 5 */
/*
busqueda1 	busqueda2 	busqueda3
1	0	1
*/

/* Buscar un cadena de 3 digitos cualesquiera entre 0 y 9 en el texto */
select "El tiempo es de 120 minutos" regexp "[0-9][0-9][0-9]" as busqueda;
/*
busqueda1 
1
*/

/* Buscar una cadena que empiece con un numero del 0 al 9*/
select "El tiempo es de 120 minutos" regexp "[0-9]+" as busqueda; 		/* El simbolo + indica que buscaremos el patron [0-9] m veces después */
/*
busqueda
1
*/

/* Verificar si la frase empieza o termina con una cadena especifica */
select 	"Los datos son de Disney" regexp "^los" as busqueda1,			/*Si la palabra empieza con "los"    */
		"Los datos son de Disney" regexp "disney$" as busqueda2;		/*Si la palabra termina con "disney" */
/*
busqueda1	busqueda2
1	1
*/


/* Busqueda de espacios en blanco en el texto */
select 	"Los datos son de Disney" regexp "[:space:]" as busqueda1,
		"Los_datos_son_de_Disney" regexp "[:space:]" as busqueda2;
/*
/*
busqueda1	busqueda2
1	0
*/

/* Busqueda de palabras solas */
select "Si puede ser no se tal vez a lo mejor" regexp "\\bsi\\b" as busqueda;
/*
busqueda
1
*/


/* Busqueda de patrones repetidos n veces */
select "La contraseña debe ser de tipo 00a" regexp "[0-9]{2}[a-z]" as busqueda;
/*
busqueda
1
*/ 


/* 5-12 Expresiones Regulares 2 */

/* Busqueda de comentarios con la cadena "5 estrellas" o "4 estrellas" o ... o "1 estrella" */
select 	regexp_substr(comentario,"[0-5] star[s ]") as calificacion
from analisistexto.disneyclean
where comentario regexp "[0-5] star[s ]";

/* Con tabla anterior realizar un conteo de acuerdo al numero de estrellas */
select 	regexp_substr(comentario,"[0-5] star[s]") as calificacion,
		count(*)
from
(
	select 	regexp_replace(comentario,"star[s ,.]","stars") as comentario
	from analisistexto.disneyclean
	where comentario regexp "[0-5] star[s ,.]"
) as A
group by 1
order by 2 desc;
/*
calificacion	count(*)
5 stars	169
4 stars	58
3 stars	31
2 stars	21
1 stars	10
0 stars	4
*/

/* 5-13 Construccion de Texto */

/* Concatenación de texto */
select 	concat(rating," Rating") as rating_2
from analisistexto.disneyclean;
/*
rating_2
4 Rating
4 Rating
4 Rating
4 Rating
4 Rating
...
*/


/* Concatenacion de n cadenas de texto indicando un separados */
select concat_ws("-",año,mes,pais_origen) as texto
from	analisistexto.disneyclean;
/*
texto
2019-4-Australia
2019-5-Philippines
2019-4-UAE
2019-4-Australia
2019-4-UK
...
*/

/* Para cada parque obtener el pais de origen de los visitantes */
select	parque,
		group_concat(distinct pais_origen) as pais_visitantes
from 	analisistexto.disneyclean
group by 1;
