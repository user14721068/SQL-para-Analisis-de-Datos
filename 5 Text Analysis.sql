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

/* Formula Left y Right para extraer datos caracteres de una cadena */
select 	left("Reseñas de Disney",7) as izquierda,
		right("Reseñas de Disney",6) as derecha; 
/*
izquierda	derecha
Reseñas	Disney
*/

/* Extraer los primeros 6 caracteres de la columna de reseñas y contar cuantas veces se repite cada cadena */
select 	left(information,6) as izquierda,
		count(disneyrew_id)
from analisistexto.disneyrew
group by 1;
/*
izquierda	count(disneyrew_id)
Rating	42656
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
Texto1	Texto2
Esto es 	 de texto
*/

/* Usar la funcion substring para extraer la fecha de la columna Infomrmation */
select 	substring_index(substring_index(information,"Year_Month: ",-1),",",1) as fecha,
		count(disneyrew_id)
from 	analisistexto.disneyrew
group by 1
order by 1;
/*
fecha	count(disneyrew_id)
2010-10	21
2010-11	27
2010-12	56
2010-3	2
2010-4	1
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
rating	fecha	pais_origen	comentario	parque
4	2019-4	Australia	If you've ever been to Disneyland anywhere you'll find Disneyland Hong Kong very similar in the layout when you walk into main street! It has a very familiar feel. One of the rides  its a Small World  is absolutely fabulous and worth doing. The day we visited was fairly hot and relatively busy but the queues moved fairly well. Branch: Disneyland_HongKong	Rating: 4, Year_Month: 2019-4, Reviewer_Location: Australia, Review_Text: If you've ever been to Disneyland anywhere you'll find Disneyland Hong Kong very similar in the layout when you walk into main street! It has a very familiar feel. One of the rides  its a Small World  is absolutely fabulous and worth doing. The day we visited was fairly hot and relatively busy but the queues moved fairly well. Branch: Disneyland_HongKong
4	2019-5	Philippines	Its been a while since d last time we visit HK Disneyland .. Yet, this time we only stay in Tomorrowland .. AKA Marvel land!Now they have Iron Man Experience n d Newly open Ant Man n d Wasp!!Ironman .. Great feature n so Exciting, especially d whole scenery of HK (HK central area to Kowloon)!Antman .. Changed by previous Buzz lightyear! More or less d same, but I'm expecting to have something most!!However, my boys like it!!Space Mountain .. Turns into Star Wars!! This 1 is Great!!!For cast members (staffs) .. Felt bit MINUS point from before!!! Just dun feel like its a Disney brand!! Seems more local like Ocean Park or even worst!!They got no SMILING face, but just wanna u to enter n attraction n leave!!Hello this is supposed to be Happiest Place on Earth brand!! But, just really Dont feel it!!Bakery in Main Street now have more attractive delicacies n Disney theme sweets .. These are Good Points!!Last, they also have Starbucks now inside the theme park!! Branch: Disneyland_HongKong	Rating: 4, Year_Month: 2019-5, Reviewer_Location: Philippines, Review_Text: Its been a while since d last time we visit HK Disneyland .. Yet, this time we only stay in Tomorrowland .. AKA Marvel land!Now they have Iron Man Experience n d Newly open Ant Man n d Wasp!!Ironman .. Great feature n so Exciting, especially d whole scenery of HK (HK central area to Kowloon)!Antman .. Changed by previous Buzz lightyear! More or less d same, but I'm expecting to have something most!!However, my boys like it!!Space Mountain .. Turns into Star Wars!! This 1 is Great!!!For cast members (staffs) .. Felt bit MINUS point from before!!! Just dun feel like its a Disney brand!! Seems more local like Ocean Park or even worst!!They got no SMILING face, but just wanna u to enter n attraction n leave!!Hello this is supposed to be Happiest Place on Earth brand!! But, just really Dont feel it!!Bakery in Main Street now have more attractive delicacies n Disney theme sweets .. These are Good Points!!Last, they also have Starbucks now inside the theme park!! Branch: Disneyland_HongKong
4	2019-4	United Arab Emirates	Thanks God it wasn   t too hot or too humid when I was visiting the park   otherwise it would be a big issue (there is not a lot of shade).I have arrived around 10:30am and left at 6pm. Unfortunately I didn   t last until evening parade, but 8.5 hours was too much for me.There is plenty to do and everyone will find something interesting for themselves to enjoy.It wasn   t extremely busy and the longest time I had to queue for certain attractions was 45 minutes (which is really not that bad).Although I had an amazing time, I felt a bit underwhelmed with choice of rides and attractions. The park itself is quite small (I was really expecting something grand   even the main castle which was closed by the way was quite small).The food options are good, few coffee shops (including Starbucks) and plenty of gift shops. There was no issue with toilets as they are everywhere.All together it was a great day out and I really enjoyed it. Branch: Disneyland_HongKong	Rating: 4, Year_Month: 2019-4, Reviewer_Location: United Arab Emirates, Review_Text: Thanks God it wasn   t too hot or too humid when I was visiting the park   otherwise it would be a big issue (there is not a lot of shade).I have arrived around 10:30am and left at 6pm. Unfortunately I didn   t last until evening parade, but 8.5 hours was too much for me.There is plenty to do and everyone will find something interesting for themselves to enjoy.It wasn   t extremely busy and the longest time I had to queue for certain attractions was 45 minutes (which is really not that bad).Although I had an amazing time, I felt a bit underwhelmed with choice of rides and attractions. The park itself is quite small (I was really expecting something grand   even the main castle which was closed by the way was quite small).The food options are good, few coffee shops (including Starbucks) and plenty of gift shops. There was no issue with toilets as they are everywhere.All together it was a great day out and I really enjoyed it. Branch: Disneyland_HongKong
4	2019-4	Australia	HK Disneyland is a great compact park. Unfortunately there is quite a bit of maintenance work going on at present so a number of areas are closed off (including the famous castle) If you go midweek, it is not too crowded and certainly no where near as bus as LA Disneyland. We did notice on this visit that prices for food, drinks etc have really gone through the roof so be prepared to pay top dollar for snacks (and avoid the souvenir shops if you can) Regardless, kids will love it. Branch: Disneyland_HongKong	Rating: 4, Year_Month: 2019-4, Reviewer_Location: Australia, Review_Text: HK Disneyland is a great compact park. Unfortunately there is quite a bit of maintenance work going on at present so a number of areas are closed off (including the famous castle) If you go midweek, it is not too crowded and certainly no where near as bus as LA Disneyland. We did notice on this visit that prices for food, drinks etc have really gone through the roof so be prepared to pay top dollar for snacks (and avoid the souvenir shops if you can) Regardless, kids will love it. Branch: Disneyland_HongKong
4	2019-4	United Kingdom	the location is not in the city, took around 1 hour from Kowlon, my kids like disneyland so much, everything is fine.   but its really crowded and hot in Hong Kong Branch: Disneyland_HongKong	Rating: 4, Year_Month: 2019-4, Reviewer_Location: United Kingdom, Review_Text: the location is not in the city, took around 1 hour from Kowlon, my kids like disneyland so much, everything is fine.   but its really crowded and hot in Hong Kong Branch: Disneyland_HongKong
...
*/

/* 5-8 Transformacion de Texto */

/* Funciones Upper, Lower, Trim */
select	upper("Hola amigos") as upper,							/* Convierte una cadena a mayusculas */
		lower("Hola amigos") as lower,							/* Convierte una cadena a minusculas */
		trim("    Hola amigos     ") as trim,					/* Elimina espacios en blanco al inicio y final de una cadena */
        trim(leading "$" from "$$Hola amigos") as trim2, 		/* Elimina un caracter inicial que le especifiquemos de una cadena de texto */
        replace("Hola amigos","Hola","Holi") as reemplazar;		/* Permite sustituir una cadena de texto por otra dentro de una string */
/*
upper	lower	trim	trim2	reemplazar
HOLA AMIGOS	hola amigos	Hola amigos	Hola amigos	Holi amigos
*/


/* 	Usar la funcion trim para eliminar espacios en blanco de la columna comentario.
	Crear una nueva tabla para guardar el resultado de esta consulta.
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







