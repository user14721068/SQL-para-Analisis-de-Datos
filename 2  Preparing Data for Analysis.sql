/* 2-2 Tipos de Datos */

/*
STRING:
	CHAR: Longitud fija 
	VARCHAR: Longitud variables. Hasta 256 caracteres.
	TEXT/BLOB: Grandes longitudes de datos como cartas, mails, reseñas, comentarios.
NUMERICO:
	INT: Guardar numeros enteros
	FLOAT/DOUBLE/DECIMAL: Para guardar numeros decimales.

LOGICOS:
	BOOLEANOS:Guardar valores True o False
	
DATE TIME/ TIME STAMP:
	Guardar fechas en formato YYYY-MM-DD hh:mm:ss

TIME:
	Guardar horas en formato hh:mm:ss

DATE:
	Guardar fechas en formato YYYY-MM-DD
*/


/* 2-7 Perfilacion - HIstogramas y Frecuencias */

select * from preparacion.hotel limit 10;
/*
id	Hotel	Cancelado	Tiempo_entre_Reserva_y_Llegada	Ano_Llegada	Mes_Llegada	Semana_de_Llegada	Dia_de_Llegada	Mes	Fecha	Noches_de_Fin_de_Semana	Noches_Entre_Semana	Adultos	Ninos	Bebes	Comida	Codigo_Pais	Pais	Segmento_de_Mercado	distribution_channel	is_repeated_guest	previous_cancellations	previous_bookings_not_canceled	reserved_room_type	assigned_room_type	booking_changes	deposit_type	agent	company	days_in_waiting_list	customer_type	adr	required_car_parking_spaces	total_of_special_requests	reservation_status	reservation_status_date	name	email	phone_number	credit_card
1	Hotel_del_Monte	0	342	2015	July	27	1	7	01/07/2015	0	0	2	0	0	Desayuno	PRT	Portugal	Directo	Directo	0	0	0	C	C	3	No_Deposit			0	Transient	0	0	0	Check_Out	42186	Ernest_Barnes	Ernest.Barnes31@outlook.com	669_792_1661	************4322
2	Hotel_del_Monte	0	737	2015	July	27	1	7	01/07/2015	0	0	2	0	0	Desayuno	PRT	Portugal	Directo	Directo	0	0	0	C	C	4	No_Deposit			0	Transient	0	0	0	Check_Out	42186	Andrea_Baker	Andrea_Baker94@aol.com	858_637_6955	************9157
3	Hotel_del_Monte	0	7	2015	July	27	1	7	01/07/2015	0	1	1	0	0	Desayuno	GBR	United_Kingdom_of_Great_Britain_and_Northern_Ireland_(the)	Directo	Directo	0	0	0	A	C	0	No_Deposit			0	Transient	75	0	0	Check_Out	42187	Rebecca_Parker	Rebecca_Parker@comcast.net	652_885_2745	************3734
4	Hotel_del_Monte	0	13	2015	July	27	1	7	01/07/2015	0	1	1	0	0	Desayuno	GBR	United_Kingdom_of_Great_Britain_and_Northern_Ireland_(the)	Empresarial	Empresarial	0	0	0	A	A	0	No_Deposit	304		0	Transient	75	0	0	Check_Out	42187	Laura_Murray	Laura_M@gmail.com	364_656_8427	************5677
5	Hotel_del_Monte	0	14	2015	July	27	1	7	01/07/2015	0	2	2	0	0	Desayuno	GBR	United_Kingdom_of_Great_Britain_and_Northern_Ireland_(the)	Agencia_Viajes_Online	TA/TO	0	0	0	A	A	0	No_Deposit	240		0	Transient	98	0	1	Check_Out	42188	Linda_Hines	LHines@verizon.com	713_226_5883	************5498
6	Hotel_del_Monte	0	14	2015	July	27	1	7	01/07/2015	0	2	2	0	0	Desayuno	GBR	United_Kingdom_of_Great_Britain_and_Northern_Ireland_(the)	Agencia_Viajes_Online	TA/TO	0	0	0	A	A	0	No_Deposit	240		0	Transient	98	0	1	Check_Out	42188	Jasmine_Fletcher	JFletcher43@xfinity.com	190_271_6743	************9263
7	Hotel_del_Monte	0	0	2015	July	27	1	7	01/07/2015	0	2	2	0	0	Desayuno	PRT	Portugal	Directo	Directo	0	0	0	C	C	0	No_Deposit			0	Transient	107	0	0	Check_Out	42188	Dylan_Rangel	Rangel.Dylan@comcast.net	420_332_5209	************6994
8	Hotel_del_Monte	0	9	2015	July	27	1	7	01/07/2015	0	2	2	0	0	Todo_Incluido	PRT	Portugal	Directo	Directo	0	0	0	C	C	0	No_Deposit	303		0	Transient	103	0	1	Check_Out	42188	William_Velez	Velez_William@mail.com	286_669_4333	************8729
9	Hotel_del_Monte	1	85	2015	July	27	1	7	01/07/2015	0	3	2	0	0	Desayuno	PRT	Portugal	Agencia_Viajes_Online	TA/TO	0	0	0	A	A	0	No_Deposit	240		0	Transient	82	0	1	Canceled	42130	Steven_Murphy	Steven.Murphy54@aol.com	341_726_5787	************3639
10	Hotel_del_Monte	1	75	2015	July	27	1	7	01/07/2015	0	3	2	0	0	Desayuno_y_Cena	PRT	Portugal	Offline_TA/TO	TA/TO	0	0	0	D	D	0	No_Deposit	15		0	Transient	106	0	0	Canceled	42116	Michael_Moore	MichaelMoore81@outlook.com	316_648_6176	************9190
...
*/


/* Obtener los valores unicos de la columnas hotel */
select distinct(hotel)
from preparacion.hotel;
/*
hotel
Hotel del Monte
Hotel de Ciudad
*/

/* Obtener los valores unicos de la columna comida */
select distinct(comida)
from preparacion.hotel;
/*
comida
Desayuno
Todo Incluido
Desayuno y Cena
No Informacion
Sin Comida
*/

/* Conteo de filas segun el tipo de comida*/
select comida, count(*)
from preparacion.hotel
group by 1
order by 2 desc;
/*
comida	count(*)
Desayuno	92310
Desayuno y Cena	14463
Sin Comida	10650
No Informacion	1169
Todo Incluido	798
*/


/* Conteo de filas segun el pais*/
select pais, count(*)
from preparacion.hotel 
group by 1
order by 2 desc;
/*
pais	count(*)
Portugal	49078
United Kingdom of Great Britain and Northern Ireland (the)	12129
France	10415
Spain	8568
...
Saint Lucia	1
Dominica	1
French Polynesia	1
Cayman Islands (the)	1
Madagascar	1
*/


/* Conteo de filas segun el tipo de consumidor */
select customer_type, count(*)
from preparacion.hotel
group by 1
order by 2 desc;
/*
customer_type	count(*)
Transient	89613
Transient-Party	25124
Contract	4076
Group	577
*/



/* Noches entre semana que se queda la gente */
select Noches_Entre_Semana, count(*)
from preparacion.hotel
group by 1
order by 1 asc;
/*
Noches_Entre_Semana	count(*)
0	7645
1	30310
2	33684
3	22258
4	9563
5	11077
6	1499
7	1029
8	656
9	231
10	1036
11	56
12	42
13	27
14	35
15	85
16	16
17	4
18	6
19	44
20	41
21	15
22	7
24	3
25	6
26	1
30	5
32	1
33	1
34	1
35	1
40	2
41	1
42	1
50	1
*/



/* Numero de visitantes adultos agrupado por nombre del pais */
select pais, sum(adultos) as visitas
from preparacion.hotel
group by 1
order by 2;
/*
pais	visitas
Kiribati	1
Guyana	1
Botswana	2
Nepal	2
Sudan	2
...
Germany	13703
Spain	16615
France	20291
United Kingdom of Great Britain and Northern Ireland (the)	23223
Portugal	86799
*/



/* Cuantos paises mandaron 1 adulto, cuandos 2 adultos, etc */
select visitas, count(*) as Numero_de_paises
from (
	select pais, sum(adultos) as visitas
	from preparacion.hotel
	group by 1
	order by 2) as A
group by visitas
order by Numero_de_paises desc;
/*
visitas	Numero_de_paises
2	29
4	10
6	6
8	6
3	4
...
13703	1
16615	1
20291	1
23223	1
86799	1
*/



/* 2-8 Binning */


/* Conteo de filas agrupado por noches_entre_semana y adr */
select noches_entre_semana, adr, count(*)
from preparacion.hotel
group by 1,2
order by 1,2;
/*
noches_entre_semana	adr	count(*)
0	0.00	838
0	1.00	1
0	3.00	1
0	4.00	2
0	5.00	1
...
40	25.50	1
40	28.79	1
41	8.34	1
42	110.50	1
50	110.00	1
*/



/* Generar buckets para noches_entre_semana */
select 
case 	
	when noches_entre_semana <= 5 then "hasta_5_noches"
	when noches_entre_semana > 5 and noches_entre_semana <= 15 then "hasta_15_noches"
	else "Mas_de_15_noches"
end as cantidad_bin,
adr, 
count(*) as reservaciones
from preparacion.hotel
group by 1,2
order by 1,2;
/*
cantidad_bin	adr	reservaciones
cantidad_bin	adr	reservaciones
hasta_15_noches	-6.38	1
hasta_15_noches	0.00	36
hasta_15_noches	0.50	1
hasta_15_noches	1.56	1
hasta_15_noches	1.80	1
...
Mas_de_15_noches	142.97	1
Mas_de_15_noches	147.90	1
Mas_de_15_noches	170.00	1
Mas_de_15_noches	171.30	1
Mas_de_15_noches	212.00	1
*/



/* Generar buckets para noches_entre_semana y adr */
select 
case
	when noches_entre_semana <= 5 then "Hasta_5_noches"
    when noches_entre_semana <= 15 then "Hasta_15_noches"
    else "Mas_de_15_noches"
end as cantidad_noches,
case
	when adr <= 100 then "Hasta_100_dolares_la_noche"
    when adr <= 250 then "Hasta_250_dolares_la_noche"
    else "Mas_de_250_dolares_la_noche"
end as categoria_adr,
count(*)
from preparacion.hotel
group by 1,2
order by 1,2; 
/*
cantidad_noches	categoria_adr	count(*)
Hasta_15_noches	Hasta_100_dolares_la_noche	2603
Hasta_15_noches	Hasta_250_dolares_la_noche	2022
Hasta_15_noches	Mas_de_250_dolares_la_noche	71
Hasta_5_noches	Hasta_100_dolares_la_noche	64897
Hasta_5_noches	Hasta_250_dolares_la_noche	48467
Hasta_5_noches	Mas_de_250_dolares_la_noche	1173
Mas_de_15_noches	Hasta_100_dolares_la_noche	138
Mas_de_15_noches	Hasta_250_dolares_la_noche	19
*/



/* Función Round */
/* Permite hacer redondeos a decenas, centenas, miles, etc */
/* Decenas:  0-4  baja a la decena  inmediata anterior, 5-9   sube a la siguiente decena */
/* Centenas: 0-49 baja a la centena inmediata anterior, 50-99 sube a la siguiente centena */
/* Miles:    0-499 baja al mil inmediato anterior     , 500-999 sube al siguiente mil */
select 
	distinct
	Tiempo_entre_Reserva_y_Llegada,
	round(Tiempo_entre_Reserva_y_Llegada,-1) as Redondeo_a_decenas
from preparacion.hotel
order by 2 asc;
/*
Tiempo_entre_Reserva_y_Llegada	Redondeo_a_decenas
0	0
1	0
2	0
3	0
4	0
5	10
6	10
7	10
8	10
9	10
10	10
...
*/


/* Redondeo a centenas */
select 
	distinct
	Tiempo_entre_Reserva_y_Llegada,
	round(Tiempo_entre_Reserva_y_Llegada,-2) as Redondeo_a_centenas
from preparacion.hotel
order by 2 asc;
/*
Tiempo_entre_Reserva_y_Llegada	Redondeo_a_centenas
0	0
1	0
2	0
3	0
4	0
5	0
6	0
7	0
8	0
9	0
10	0
11	0
12	0
13	0
14	0
15	0
16	0
17	0
18	0
19	0
20	0
21	0
22	0
23	0
24	0
25	0
26	0
27	0
28	0
29	0
30	0
31	0
32	0
33	0
34	0
35	0
36	0
37	0
38	0
39	0
40	0
41	0
42	0
43	0
44	0
45	0
46	0
47	0
48	0
49	0
50	100
51	100
52	100
53	100
54	100
55	100
56	100
57	100
58	100
59	100
60	100
61	100
62	100
63	100
64	100
65	100
66	100
67	100
68	100
69	100
70	100
71	100
72	100
73	100
74	100
75	100
76	100
77	100
78	100
79	100
80	100
81	100
82	100
83	100
84	100
85	100
86	100
87	100
88	100
89	100
90	100
91	100
92	100
93	100
94	100
95	100
96	100
97	100
98	100
99	100
100	100
...
*/




/* Creación de bins usando redondeo a centenas */
select 
	round(tiempo_entre_reserva_y_llegada,-2) as tiempo_redondeado_centenas,
    count(*) as conteo_filas
from preparacion.hotel
group by 1
order by 1 asc;
/*
tiempo_redondeado_centenas	conteo_filas
0	50281
100	36234
200	19203
300	9748
400	2807
500	851
600	264
700	2
*/


/* FUNCIONES DE VENTANA - OVER - PARTITION */
/* Permite usar funciones de agregacion sin tener que mostrar la tabla de resultados agrupada */
/* Permite aplicar una funcion de agregacion a un bloque de filas y que ese resultado aparezca para todas las filas de la tabla */

/* Total de clientes tipo "adulto" */
select sum(adultos)
from preparacion.hotel;
/*
sum(adultos)
221636
*/



/* Mostrar el Total de clientes de tipo "adulto" en una nueva columna sin usar group by*/
select hotel, cancelado, sum(adultos) over ()
from preparacion.hotel;
/*
hotel	cancelado	sum(adultos) over ()
Hotel del Monte	0	221636
Hotel del Monte	0	221636
Hotel del Monte	0	221636
Hotel del Monte	0	221636
Hotel del Monte	0	221636
...
Hotel de Ciudad	0	221636
Hotel de Ciudad	0	221636
Hotel de Ciudad	0	221636
Hotel de Ciudad	0	221636
Hotel de Ciudad	0	221636
*/


/* Total de clientes adultos por tipo de hotel */
select hotel, sum(adultos)
from preparacion.hotel
group by hotel;
/*
hotel	sum(adultos)
Hotel del Monte	74798
Hotel de Ciudad	146838
*/


/* Mostrar el Total de clientes adultos agrupando por tipo de hotel*/
select hotel, cancelado, sum(adultos) over (partition by hotel)
from preparacion.hotel;
/*
hotel	cancelado	sum(adultos) over (partition by hotel)
Hotel de Ciudad	1	146838
Hotel de Ciudad	1	146838
Hotel de Ciudad	1	146838
Hotel de Ciudad	1	146838
Hotel de Ciudad	1	146838
...
Hotel del Monte	0	74798
Hotel del Monte	0	74798
Hotel del Monte	0	74798
Hotel del Monte	0	74798
Hotel del Monte	0	74798
*/






/*   2-9 Cuantiles */


/* Función ntile */

/*  
Nota: La funcion cuantil Qx(p) de una funcion de probabilidad acumulada Fx(x) se define como el valor mas pequeño de x tal que Fx(x)=p  
Es decir, Qx(p)=min{xER | Fx(x) = p }
Fuente: https://statproofbook.github.io/P/duni-qf.html

Sin embargo la función ntile no realiza la misma tarea, sino que divide las filas de una partición ordenada en un numero n de grupos, 
y para cada fila asigna el grupo al que pertence.
https://www.mysqltutorial.org/mysql-window-functions/mysql-ntile-function/
*/


/* Hacer una partición de 10 grupos de las filas de la tabla, usando la columna "noches_entre_semana" ordenadas por "noches entre semana" */
select 
	pais,
    noches_entre_semana,
    ntile(10) over (order by noches_entre_semana) as decil
from preparacion.hotel
order by 3;
/*
pais	noches_entre_semana	decil
Portugal	1	1
Portugal	1	1
Portugal	1	1
Portugal	1	1
Portugal	1	1
...
Portugal	40	10
United Kingdom of Great Britain and Northern Ireland (the)	40	10
United Kingdom of Great Britain and Northern Ireland (the)	41	10
Portugal	42	10
Portugal	50	10
*/


/* Obtener el decil, valor minimo, valor maximo y conteo de filas sobre el numero de noches_entre_semana */
select decil, min(noches_entre_semana), max(noches_entre_semana), count(*)
from
	(select 
		pais,
		noches_entre_semana,
		ntile(10) over (order by noches_entre_semana) as decil
	from preparacion.hotel
	order by noches_entre_semana) as T1
group by decil;
/*
decil	min(noches_entre_semana)	max(noches_entre_semana)	count(*)
1		0		1		11939
3		1		1		11939
2		1		1		11939
4		1		2		11939
6		2		2		11939
5		2		2		11939
7		2		3		11939
8		3		4		11939
9		4		5		11939
10		5		50		11939
*/


/* Función PERCENT_RANK */
/* 	Percent_rank(): Returns the percentage of partition values less than the value in the current row, excluding the highest value. 
	Return values range from 0 to 1 and represent the row relative rank, calculated as the result of this formula, 
    where rank is the row rank and rows is the number of partition rows:
	https://dev.mysql.com/doc/refman/8.4/en/window-function-descriptions.html#function_percent-rank
*/

/* Obtener el percentil de la fila noches_entre_semana ordenando por noches_entre_semana */
/* La columna "percentil" devuelve el porcentaje de valores en la columna "noches_entre_semana" que son <= al valor de la fila actual */
select 
	pais, 
    noches_entre_semana, 
    percent_rank() over (order by noches_entre_semana) as percentil
from preparacion.hotel
order by noches_entre_semana;
/*
pais	noches_entre_semana	percentil
Portugal	0	0
Portugal	0	0
Italy	0	0
Portugal	0	0
China	0	0
...
Portugal	40	0.9999664960758529
United Kingdom of Great Britain and Northern Ireland (the)	40	0.9999664960758529
United Kingdom of Great Britain and Northern Ireland (the)	41	0.9999832480379265
Portugal	42	0.9999916240189632
Portugal	50	1

*/


/* 	Los valores unicos de noches_entre_semana - percentil */
/* 	Se interpreta de la siguiente manera:
	El 0 % de los datos es <= 0
	El 6.403437502617494 % de los datos es <= 1
    El 31.79103602509444 % de los datos es <= 2
	...
    El 99.99916240189632 % de los datos es <= 42
    El 100% de los datos es <= 50
 */
select distinct noches_entre_semana, percentil
from
(select 
	pais, 
    noches_entre_semana, 
    percent_rank() over (order by noches_entre_semana) as percentil
from preparacion.hotel
order by noches_entre_semana) as T;
/*
noches_entre_semana	percentil
0	0
1	0.06403437502617494
2	0.3179103602509444
3	0.600046905493806
4	0.7864794914104315
5	0.8665789980651484
6	0.9593597400095486
7	0.9719153355836803
8	0.9805342200705257
9	0.9860288636306528
10	0.9879637152501487
11	0.9966412316042517
12	0.9971102865423113
13	0.9974620777458559
14	0.997688229233849
15	0.9979813885701363
16	0.9986933469582625
17	0.998827362654851
18	0.9988608665789981
19	0.9989111224652187
20	0.999279665630837
21	0.999623080853345
22	0.9997487205688966
24	0.999807352436154
25	0.9998324803792644
26	0.9998827362654851
30	0.9998911122465218
32	0.9999329921517057
33	0.9999413681327426
34	0.9999497441137793
35	0.9999581200948161
40	0.9999664960758529
41	0.9999832480379265
42	0.9999916240189632
50	1
*/


/* Obtener el minimo, maximo y recuento para cada percentil */
select 
	round(percentil,3), 
    min(noches_entre_semana), 
    max(noches_entre_semana), 
    count(*)
from
(select 
	pais, 
    noches_entre_semana, 
    percent_rank() over (order by noches_entre_semana) as percentil
from preparacion.hotel
order by noches_entre_semana) as T
group by 1;
/*
round(percentil,3)	min(noches_entre_semana)	max(noches_entre_semana)	count(*)
0.000	0	0	7645
0.064	1	1	30310
0.318	2	2	33684
0.600	3	3	22258
0.786	4	4	9563
0.867	5	5	11077
0.959	6	6	1499
0.972	7	7	1029
0.981	8	8	656
0.986	9	9	231
0.988	10	10	1036
0.997	11	13	125
0.998	14	15	120
0.999	16	20	111
1.000	21	50	46
*/





/* 2-10 Limpieza de Datos */


/* Tabla generos */
select * from preparacion.generos;
/*
ID_Cliente	Genero
1	Femenino
2	Femenina
3	F
4	F
5	F
6	F
7	Femenino
8	Femenino
9	Femenina
10	Femenina
*/


/* CASE WHEN para reemplazar texto */
select
	ID_Cliente, 
    genero,
	case 
		when genero = "Femenino" then "Mujer"
        when genero = "F" then "Mujer"
		when genero = "Femenina" then "Mujer"
        else "Desconocido"
	end as genero_limpio
from preparacion.generos;
/*
ID_Cliente	genero	genero_limpio
1	Femenino	Mujer
2	Femenina	Mujer
3	F	Mujer
4	F	Mujer
5	F	Mujer
6	F	Mujer
7	Femenino	Mujer
8	Femenino	Mujer
9	Femenina	Mujer
10	Femenina	Mujer
*/


/* CASE WHEN para crear categorias*/
select 
	pais, 
    num_reservaciones,
    case
		when num_reservaciones <= 100 then "Pocas reservaciones"
        when num_reservaciones <= 10000 and num_reservaciones > 100 then "Medias reservaciones"
        else "Muchas reservaciones"
    end as Tipo_de_pais
from 
	(select 
		pais,
		count(*) as num_reservaciones
	from preparacion.hotel
	group by pais) as T
order by num_reservaciones;
/*
SALIDA DEL SCRIPT
pais	num_reservaciones	Tipo_de_pais
Botswana	1	Pocas reservaciones
Nepal	1	Pocas reservaciones
Sudan (the)	1	Pocas reservaciones
Namibia	1	Pocas reservaciones
Sierra Leone	1	Pocas reservaciones
...
Germany	7287	Medias reservaciones
Spain	8568	Medias reservaciones
France	10415	Muchas reservaciones
United Kingdom of Great Britain and Northern Ireland (the)	12129	Muchas reservaciones
Portugal	49078	Muchas reservaciones
*/


/* CASE WHEN para crear categorias */
select 
	Mes_Llegada,
    mes,
    case
		when mes in (12,1,2) then "Invierno"
        when mes in (3,4,5) then "Primavera"
        when mes in (6,7,8) then "Verano"
        else "Otoño"
	end as estacion
from preparacion.hotel
group by Mes_Llegada, mes, estacion
order by mes;
/*
SALIDA DEL SCRIPT
Mes_Llegada	mes	estacion
January	1	Invierno
February	2	Invierno
March	3	Primavera
April	4	Primavera
May	5	Primavera
June	6	Verano
July	7	Verano
August	8	Verano
September	9	Otoño
October	10	Otoño
November	11	Otoño
December	12	Invierno
*/

/* Clientes que llegaron sin avisar */
select 
	Tiempo_entre_Reserva_y_Llegada,
    case	
		when tiempo_entre_reserva_y_llegada = 0 then 0
        else 1
    end as llego_sin_avisar
from preparacion.hotel
group by tiempo_entre_reserva_y_llegada, llego_sin_avisar
order by tiempo_entre_reserva_y_llegada;
/*
SALIDA DEL SCRIPT
Tiempo_entre_Reserva_y_Llegada	llego_sin_avisar
0	0
1	1
2	1
3	1
4	1
...
615	1
622	1
626	1
629	1
709	1
*/


/* 2-10-1 Imputacion */


/* Ventas donde se desconoce el empleado que las realizo */
select * 
from preparacion.ventas as v left join empleados as e on v.venta_empleado=e.id_empleado
where e.ID_empleado is null;
/*
SALIDA DEL SCRIPT
ventas_id	Fecha	ID_local	clave_producto	venta	venta_empleado	ID_empleado	Nombre	Apellido	Telefono	Edad	Domicilio	ID_Gerente
12	2019-09-03 00:00:00	1	pzz	1362	5728566	NULL	NULL	NULL	NULL	NULL	NULL	NULL
16	2019-07-30 00:00:00	3	brr	1062	5728566	NULL	NULL	NULL	NULL	NULL	NULL	NULL
21	2019-06-08 00:00:00	4	qsd	497	5728566	NULL	NULL	NULL	NULL	NULL	NULL	NULL
*/

/* La tabla de ventasgerentes tiene valores null en la columna producto_principal */
select *
from preparacion.ventasgerentes
order by producto_principal asc;
/*
ventasgerentes_id	GERENTE	ZONA	SEXO	Fecha	Ventas_$	No._Clientes	Producto_Principal	Antigüedad	MES
10	GONZALEZ TOKMAN ALEJANDRO LUIS	4	H	2012-09-11 00:00:00	53835	5	NULL	9	9
12	PALAFOX GONZALEZ ABEL	2	H	2012-09-13 00:00:00	72968	2	NULL	10	9
13	JARAMILLO GIL ARTURO	3	H	2012-09-14 00:00:00	70311	9	NULL	3	9
9	GONZALEZ TOKMAN ALEJANDRO LUIS	4	H	2012-09-10 00:00:00	66571	18	NULL	9	9
14	PALAFOX GONZALEZ ABEL	2	H	2012-09-15 00:00:00	47484	8	NULL	10	9
11	JARAMILLO GIL ARTURO	3	H	2012-09-11 00:00:00	55700	9	NULL	3	9
663	LOPEZ KOLKOVSKA BORYANA CRISTINA	2	M	2013-05-30 00:00:00	48535	18	Azul 10	4	5
402	JARAMILLO GIL ARTURO	3	H	2013-08-29 00:00:00	35994	18	Azul 10	3	8
500	DE LA MORA CONDE MARIA	3	M	2012-11-10 00:00:00	81488	18	Azul 10	6	11
82	PALAFOX GONZALEZ ABEL	2	H	2012-11-05 00:00:00	42857	20	Azul 10	10	11
596	DE LA MORA CONDE MARIA	3	M	2013-02-25 00:00:00	28715	2	Azul 10	6	2
...
*/

/* Se puede rellenar con el producto no nulo que aparezca mas veces */
select producto_principal, count(*)
from preparacion.ventasgerentes
group by producto_principal
order by 2 desc;
/*
producto_principal	count(*)
Verde 13			30
Azul 10				29
Morado 150			28
Azul 140			26
Morado 140			26
...
*/


select 	ventasgerentes_id, 
		producto_principal,
		case
			when producto_principal is null then "Verde 13"
            else producto_principal
        end as producto_imputado
from preparacion.ventasgerentes
order by producto_principal asc;
/*
ventasgerentes_id	producto_principal	producto_imputado
10	NULL	Verde 13
12	NULL	Verde 13
13	NULL	Verde 13
9	NULL	Verde 13
14	NULL	Verde 13
11	NULL	Verde 13
663	Azul 10	Azul 10
402	Azul 10	Azul 10
500	Azul 10	Azul 10
82	Azul 10	Azul 10
596	Azul 10	Azul 10
...
*/



/*   2-11 Darle Forma a los Datos */

/* PIVOTING  */

/* En MYSQL no existen funciones para obtener tablas dinamicas (en SQLSERVER si) pero se puede obtener el mismo resultado usando agrupaciones y agregaciones */

select * from preparacion.ventas;
/*
ventas_id	Fecha	ID_local	clave_producto	venta	venta_empleado
1	2018-11-18 00:00:00	2	pzz	1302	2630867
2	2018-09-17 00:00:00	2	clz	953	2310967
3	2018-10-18 00:00:00	4	brr	1286	6931035
4	2018-10-30 00:00:00	1	brr	889	9922377
5	2018-05-16 00:00:00	1	qsd	495	2520477
6	2018-12-15 00:00:00	3	pzz	544	9611338
7	2018-07-28 00:00:00	4	pzz	1444	6332756
8	2018-10-05 00:00:00	1	pzz	435	2520477
9	2018-04-20 00:00:00	1	qsd	1203	9922377
10	2018-06-08 00:00:00	1	brr	1038	6332756
11	2018-08-22 00:00:00	1	brr	404	3833745
12	2019-09-03 00:00:00	1	pzz	1362	5728566
13	2019-07-16 00:00:00	3	qsd	1054	2310967
14	2019-08-27 00:00:00	3	clz	303	3833745
15	2019-12-15 00:00:00	1	brr	871	2520477
16	2019-07-30 00:00:00	3	brr	1062	5728566
17	2019-10-25 00:00:00	1	pzz	1376	6332756
18	2019-12-14 00:00:00	3	pzz	957	2310967
19	2019-08-14 00:00:00	2	clz	972	2310967
20	2019-12-01 00:00:00	1	pzz	1455	2310967
21	2019-06-08 00:00:00	4	qsd	497	5728566
22	2019-07-25 00:00:00	3	clz	1179	2310967
*/


/* venta total desglosada por empleado */
select 	venta_empleado,
		sum(venta)
from preparacion.ventas
group by venta_empleado
order by 2 desc;
/*
venta_empleado	sum(venta)
2310967			6570
6332756			3858
5728566			2921
9922377			2092
2520477			1801
2630867			1302
6931035			1286
3833745			707
9611338			544
*/



/* Obtener las ventas desglosadas por empleado y por tipo de producto */
select 	venta_empleado,
		sum(case when clave_producto="pzz" then venta else 0 end) as suma_venta_pizza,
        sum(case when clave_producto="clz" then venta else 0 end) as suma_venta_calzone,
        sum(case when clave_producto="brr" then venta else 0 end) as suma_venta_burrito,
        sum(case when clave_producto="qsd" then venta else 0 end) as suma_venta_quesadilla
from preparacion.ventas
group by venta_empleado;
/*
venta_empleado	suma_venta_pizza	suma_venta_calzone	suma_venta_burrito	suma_venta_quesadilla
2630867	1302	0	0	0
2310967	2412	3104	0	1054
6931035	0	0	1286	0
9922377	0	0	889	1203
2520477	435	0	871	495
9611338	544	0	0	0
6332756	2820	0	1038	0
3833745	0	303	404	0
5728566	1362	0	1062	497
*/

/* Obtener las ventas totales por tipo de producto */
select 	sum(case when clave_producto="pzz" then venta else 0 end) as suma_venta_pizza,
        sum(case when clave_producto="clz" then venta else 0 end) as suma_venta_calzone,
        sum(case when clave_producto="brr" then venta else 0 end) as suma_venta_burrito,
        sum(case when clave_producto="qsd" then venta else 0 end) as suma_venta_quesadilla
from preparacion.ventas;
/*
suma_venta_pizza	suma_venta_calzone	suma_venta_burrito	suma_venta_quesadilla
8875	3407	5550	3249
*/


/* Lo mismo usando group by */
select clave_producto, sum(venta)
from preparacion.ventas
group by 1;
/*
clave_producto	sum(venta)
pzz	8875
clz	3407
brr	5550
qsd	3249
*/


/* UNPIVOTING */


/* Datos ya dinamizados */
select * from preparacion.poblacion;
/*
Country_	year_1980	year_1990	year_2000	year_2010
Canada 	24593	27791	31100	34207
México	68347	84634	99775	114061
United States	227225	249623	282162	309326
*/


/* Desdinamizacion de la columna 1980*/
select country_,
		"1980" as "Year",
		year_1980 as poblacion
from preparacion.poblacion;
/*
country_	Year	poblacion
Canada 	1980	24593
México	1980	68347
United States	1980	227225
*/

/* Desdinamizacion de todas las columnas */
select country_,
		"1980" as "Year",
		year_1980 as poblacion
from preparacion.poblacion
	union all
select country_,
		"1990" as "Year",
		year_1990 as poblacion
from preparacion.poblacion
	union all
select country_,
		"2000" as "Year",
		year_2000 as poblacion
from preparacion.poblacion
	union all
select country_,
		"2010" as "Year",
		year_2010 as poblacion
from preparacion.poblacion;
/* 
country_	Year	poblacion
Canada 		1980	24593
México		1980	68347
United States	1980	227225
Canada 		1990	27791
México		1990	84634
United States	1990	249623
Canada 		2000	31100
México		2000	99775
United States	2000	282162
Canada 		2010	34207
México		2010	114061
United States	2010	309326
*/










