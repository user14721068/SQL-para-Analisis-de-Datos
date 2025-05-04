/* 3.- SERIES DE TIEMPO */

/* 3-3 Zonas Horarias */

/* Horario central del México tiene 6 horas de diferencia respecto al meridiano de greenwich (Londres)(UTC) */

/*
Nota
Cual es la diferencia entre el tipo de datos datetime y timestamp en mysql? 
En MySQL, tanto el tipo de dato DATETIME como TIMESTAMP se utilizan para almacenar fechas y horas, 
pero hay algunas diferencias importantes entre ellos:
DATETIME:
- Almacena fechas y horas en un formato específico (AAAA-MM-DD HH:MM:SS)
- No tiene zona horaria asociada
- No se actualiza automáticamente cuando se inserta o actualiza un registro
- Puede almacenar fechas y horas en cualquier rango (desde 1000-01-01 00:00:00 hasta 9999-12-31 23:59:59)
- Requiere 8 bytes de almacenamiento
TIMESTAMP:
- Almacena fechas y horas en un formato específico (AAAA-MM-DD HH:MM:SS)
- Tiene zona horaria asociada (UTC por defecto, es decir, el meridiano de greenwich)
- Se actualiza automáticamente cuando se inserta o actualiza un registro (si se configura para hacerlo)
- Puede almacenar fechas y horas en un rango más limitado (desde 1970-01-01 00:00:00 hasta 2038-01-19 03:14:07)
- Requiere 4 bytes de almacenamiento
En resumen, la principal diferencia entre DATETIME y TIMESTAMP es que TIMESTAMP tiene zona horaria asociada y se puede configurar para actualizarse 
automáticamente, mientras que DATETIME no tiene zona horaria asociada y no se actualiza automáticamente.
Según la experiencia y las prácticas comunes en la industria, el tipo de dato más utilizado en MySQL es DATETIME.
Hay varias razones por las que DATETIME es más popular:
1. Flexibilidad: DATETIME permite almacenar fechas y horas en cualquier rango, desde 1000-01-01 00:00:00 hasta 9999-12-31 23:59:59.
2. Simplicidad: DATETIME es más fácil de entender y utilizar que TIMESTAMP, especialmente para aquellos que no están familiarizados con la zona horaria UTC.
3. Compatibilidad: DATETIME es compatible con la mayoría de las aplicaciones y frameworks, mientras que TIMESTAMP puede requerir configuraciones adicionales.
Sin embargo, TIMESTAMP es muy útil en ciertas situaciones, como:
1. Almacenamiento de fechas y horas con zona horaria: TIMESTAMP es ideal para almacenar fechas y horas con zona horaria, especialmente cuando se trabaja con aplicaciones globales.
2. Actualización automática: TIMESTAMP se puede configurar para actualizarse automáticamente cuando se inserta o actualiza un registro.
En resumen, aunque DATETIME es el tipo de dato más utilizado en MySQL, TIMESTAMP es muy útil en ciertas situaciones y puede ser la mejor opción dependiendo de las necesidades específicas de tu proyecto.
¿Quieres saber más sobre cómo elegir el tipo de dato adecuado para tus necesidades?
*/


/* Conversion de zona horaria */
/* Cuando en londres era 2004-01-01 12:00:00, en Guadalajara era 2004-01-01 06:00:00, ya que son 6 horas hacia atras */
/* La funcion Convert_TZ requiere los argumentos: date time, zona horaria en que se registro el dato, zona horaria deseada */
SELECT 	CONVERT_TZ("2004-01-01 12:00:00","+00:00","-06:00") as HorarioCST; 
/*
HorarioCST
2004-01-01 06:00:00
*/


/* Conversion de zona horaria */
/* Cuando en londres era 2004-01-01 12:00:00, en San Francisco California era 2004-01-01 06:00:00, ya que son 8 horas hacia atras */
SELECT 	CONVERT_TZ("2004-01-01 12:00:00","+00:00","-08:00") as HorarioCST;
/*
HorarioCST
2004-01-01 04:00:00
*/



/* Conversion de zona horaria de una columna */
SELECT 	ventasgerentes_id,
	fecha,
	convert_tz(fecha,"+00:00","-6:00") as Horario_Guadalajara
from preparacion.ventasgerentes;
/*
ventasgerentes_id	fecha			HorarioCST
1			2012-09-01 00:00:00	2012-08-31 18:00:00
2			2012-09-03 00:00:00	2012-09-02 18:00:00
3			2012-09-03 00:00:00	2012-09-02 18:00:00
4			2012-09-05 00:00:00	2012-09-04 18:00:00
5			2012-09-06 00:00:00	2012-09-05 18:00:00
...
*/


/* 3-4 Fechas y Horas */

/* TimeStamp: Estampa de tiempo */
/* MYSQL maneja las fechas en formato YYYY-MM-DD */
/* Mexico usa las fechas en formato dd-mm-aaaa */
/* EU usa las fechas en formato mm-dd-aaaa */

/* Veremos 3 casos: Cambiar el formato de las fechas, extraer partes de la fecha y armar una fecha a partir de sus partes. */

/* Obtener fecha actual  */
select current_date();
/*
current_date()
2024-12-16
*/

/* Obtener fecha y hora actual */
select now();
/*
now()
2024-12-16 11:41:10
*/


/* Convertir una fecha a formato Año-Mes-Día */
select date_format("2020-12-17","%Y-%m-%d") as fecha;
/*
fecha
2020-12-17
*/



/* Convertir una fecha a formato Año-Mes-Día */
select date_format("2020-12-17","%y-%M-%D");
/*
fecha
20-December-17th
*/



/* Convertir una fecha a formato Año-Mes-Día con Día=01 */
select date_format("2020-12-17","%Y-%m-01");
/*
fecha
2020-12-01
*/


/* Convertir un datetime a date */
select date("2020-12-17 14:00:00") as fecha;
/*
fecha
2020-12-17
*/



/* Extraer el dia, mes, año, hora, minuto, segundo de un datetime */
select 	"2020-12-17 14:15:20" as fecha,
	extract(day from "2020-12-17 14:15:20" ) 	as dia,
	extract(month from "2020-12-17 14:15:20" ) 	as mes,
        extract(year from "2020-12-17 14:15:20") 	as año,
        extract(hour from "2020-12-17 14:15:20" ) 	as hora,
        extract(minute from "2020-12-17 14:15:20" ) 	as minutos,
        extract(second from "2020-12-17 14:15:20" ) 	as segundos;
/*
fecha			dia	mes	año	hora	minutos		segundos
2020-12-17 14:15:20	17	12	2020	14	15		20
*/



/* Crear una fecha y hora a partir de cadenas de texto */
/* Esto ya devuelve una columa de tipo datetime */
select date_format(concat("2020-12-17"," ","14:15:16"),"%Y-%m-%d %h:%m:%s") as fecha_hora; 
/*
fecha_hora
2020-12-17 02:12:16
*/


/* Crear una fecha a partir de cadenas de texto */
/* Esto ya devuelve una columa de tipo date */
select date_format(concat("2020-12-17"),"%Y-%m-%d") as fecha; 
/*
fecha
2020-12-17
*/



/* Crear fecha a partir del año y cuantos días han transcurrido */
select makedate(2020,352) as fecha;
/*
fecha
2020-12-17
*/


/* Crear una hora a partir de hora, minuto y segundos */
select maketime(14,15,20);
/*
hora
14:15:20
*/


/* 3-5-Date Math */


/* Diferencia entre 2 fechas*/
select 	timestampdiff(DAY, "2020-01-01","2020-02-01") 	as diferencia_en_dias,
	timestampdiff(MONTH, "2020-01-01","2020-02-01") as diferencia_en_meses,
        timestampdiff(YEAR, "2020-01-01","2020-02-01") 	as diferencia_en_años,
        timestampdiff(HOUR, "2020-01-01","2020-02-01") 	as diferencia_en_horas,
        timestampdiff(MINUTE, "2020-01-01","2020-02-01") as diferencia_en_minutos,
        timestampdiff(SECOND, "2020-01-01","2020-02-01") as diferencia_en_segundos;
/*
diferencia_en_dias	diferencia_en_meses	diferencia_en_años	diferencia_en_horas	diferencia_en_minutos	diferencia_en_segundos
31			1			0			744			44640			2678400
*/



/* Obtener una fecha a partir de una fecha dada y un intervalo */
SELECT DATE_ADD("2017-12-01", interval 15 day ) as nueva_fecha;
/*
nueva_fecha
2017-12-16
*/

/* Obtener una fecha a partir de una fecha dada y un intervalo */
SELECT DATE_ADD("2017-12-01", interval 1 month ) as nueva_fecha;
/*
nueva_fecha
2018-01-01
*/

/* Obtener una fecha a partir de una fecha dada y un intervalo */
SELECT DATE_ADD("2017-12-01", interval 5 second ) as nueva_fecha;
/*
nueva_fecha
2017-12-01 00:00:05
*/

/* Obtener una fecha a partir de una fecha dada y un intervalo */
SELECT DATE_ADD("2017-12-01", interval -1 day ) as nueva_fecha;
/*
nueva_fecha
'2017-11-30'
*/


/* Es posible sumar fechas y multiples intervalos sin usar la funcion date_add */
select date("2020-01-01") + interval 1 day + interval 1 hour - interval 10 minute + interval 15 second as nueva_fecha;
/*
nueva_fecha
2020-01-02 00:50:15
*/


/* Uso de funciones de fecha al filtrar datos */

select fecha, sexo 
from preparacion.ventasgerentes
where fecha > date("2013-01-01") + interval 30 day
order by fecha asc;
/*
fecha			sexo
2013-02-01 00:00:00	M
2013-02-02 00:00:00	H
2013-02-02 00:00:00	H
2013-02-02 00:00:00	H
2013-02-03 00:00:00	M
...

2013-09-28 00:00:00	M
2013-09-29 00:00:00	H
2013-09-30 00:00:00	H
2013-09-30 00:00:00	H
2013-10-01 00:00:00	H
*/



/* 3-6-Time Math */


/* Sumar horas, minutos y segundos a un tiempo determinado */
select time("05:00:00") + interval 1 hour + interval 5 minute + interval 15 second as nueva_hora;
/*
nueva_hora
'06:05:15'
*/


/* Diferencia entre 2 tiempos */
select timediff("10:00:00","05:00:00") as diferencia;
/*
diferencia
'05:00:00'
*/



/* 3-7-Tendencias Básicas */

/* Todos los registros de la tabla "retail_sales" */
select *
from serie_de_tiempo.retail_sales
order by sales_month asc;
/*
sales_id	sales_month		naics_code	kind_of_business				reason_for_null		sales
1		1992-01-01 00:00:00	441		Motor vehicle and parts dealers			NULL			29811
2		1992-01-01 00:00:00	4411		Automobile dealers				NULL			25800
3		1992-01-01 00:00:00	4411, 4412	Automobile and other motor vehicle dealers	NULL			26788
4		1992-01-01 00:00:00	44111		New car dealers					NULL			24056
5		1992-01-01 00:00:00	44112		Used car dealers				NULL			1744
...
*/



/* Todos los registros de la tabla "tamaños" */
select *
from serie_de_tiempo.tamaños;
/*
tamaños_id	Tamaño	Descripcion	Tamaño_en_CMS
1		P	Pequeño		20
2		M	Mediano		30
3		G	Grande		40
4		EG	Extra Grande	50
*/


/* Ventas totales por mes */
select	sales_month,
	sales
from serie_de_tiempo.retail_sales
where kind_of_business IN ("Retail and food services sales, total")
order by sales_month asc;
/*
sales_month		sales
1992-01-01 00:00:00	146376
1992-02-01 00:00:00	147079
1992-03-01 00:00:00	159336
1992-04-01 00:00:00	163669
1992-05-01 00:00:00	170068
...
*/


/* Ventas totales por año */
select 	extract(year from sales_month) as ventas_anuales,
	sum(sales)
from serie_de_tiempo.retail_sales
where kind_of_business IN ("Retail and food services sales, total")
group by ventas_anuales
order by ventas_anuales asc;
/*
ventas_anuales	sum(sales)
1992		2014102
1993		2153095
1994		2330235
1995		2450628
1996		2603794
1997		2726131
1998		2852956
1999		3086990
2000		3287537
2001		3378906
2002		3459077
2003		3612457
2004		3846605
2005		4085746
2006		4294359
2007		4439733
2008		4391580
2009		4064476
2010		4284968
2011		4598302
2012		4826390
2013		5001763
2014		5215656
2015		5349487
2016		5510186
2017		5744810
2018		6001623
2019		6218002
2020		6224399
...
*/




/* 3-8-Tendencias Compuestas */

select	extract(year from sales_month) as año,
	kind_of_business,
	sum(sales)
from serie_de_tiempo.retail_sales
where kind_of_business IN ('Book stores','Sporting goods stores', 'Hobby, toy, and game stores')
group by año, kind_of_business;
/*
año	kind_of_business		sum(sales)
1992	Sporting goods stores		15583
1992	Hobby, toy, and game stores	11251
1992	Book stores			8327
1993	Sporting goods stores		16791
1993	Hobby, toy, and game stores	11651
1993	Book stores			9108
1994	Sporting goods stores		18825
1994	Hobby, toy, and game stores	12850
1994	Book stores			10107
1995	Sporting goods stores		19869
1995	Hobby, toy, and game stores	13714
1995	Book stores			11196
1996	Sporting goods stores		20810
1996	Hobby, toy, and game stores	14502
1996	Book stores			11905
1997	Sporting goods stores		21167
1997	Hobby, toy, and game stores	15021
1997	Book stores			12742
1998	Sporting goods stores		22284
1998	Hobby, toy, and game stores	15833
1998	Book stores			13282
1999	Sporting goods stores		23699
1999	Hobby, toy, and game stores	16651
1999	Book stores			14172
2000	Sporting goods stores		25308
2000	Hobby, toy, and game stores	16947
2000	Book stores			14879
2001	Sporting goods stores		26158
2001	Hobby, toy, and game stores	16820
2001	Book stores			15098
2002	Sporting goods stores		26219
2002	Hobby, toy, and game stores	16909
2002	Book stores			15437
2003	Sporting goods stores		27000
2003	Hobby, toy, and game stores	16582
2003	Book stores			16219
2004	Sporting goods stores		28640
2004	Hobby, toy, and game stores	16314
2004	Book stores			16881
2005	Sporting goods stores		30713
2005	Hobby, toy, and game stores	16255
2005	Book stores			16992
2006	Sporting goods stores		33869
2006	Hobby, toy, and game stores	16020
2006	Book stores			16978
2007	Sporting goods stores		35804
2007	Hobby, toy, and game stores	16344
2007	Book stores			17171
2008	Sporting goods stores		36777
2008	Hobby, toy, and game stores	16107
2008	Book stores			16801
2009	Sporting goods stores		36574
2009	Hobby, toy, and game stores	15530
2009	Book stores			15802
2010	Sporting goods stores		37407
2010	Hobby, toy, and game stores	15805
2010	Book stores			15238
2011	Sporting goods stores		38995
2011	Hobby, toy, and game stores	16119
2011	Book stores			13716
2012	Sporting goods stores		42142
2012	Hobby, toy, and game stores	16620
2012	Book stores			12269
2013	Sporting goods stores		44401
2013	Hobby, toy, and game stores	16907
2013	Book stores			11489
2014	Sporting goods stores		44723
2014	Hobby, toy, and game stores	17409
2014	Book stores			11325
2015	Sporting goods stores		46326
2015	Hobby, toy, and game stores	18009
2015	Book stores			10998
2016	Sporting goods stores		47290
2016	Hobby, toy, and game stores	18297
2016	Book stores			10741
2017	Sporting goods stores		45111
2017	Hobby, toy, and game stores	18075
2017	Book stores			10375
2018	Sporting goods stores		43857
2018	Hobby, toy, and game stores	16832
2018	Book stores			9617
2019	Sporting goods stores		43808
2019	Hobby, toy, and game stores	16261
2019	Book stores			8844
2020	Sporting goods stores		53344
2020	Hobby, toy, and game stores	17287
2020	Book stores			6425
*/



/* 3-9-Tendencias Complejas con porcentajes */



/* Ventas totales agrupado por fecha y tipo de negocio */
select 	date(sales_month) as mes_venta,
	kind_of_business,
        sales
from serie_de_tiempo.retail_sales
where kind_of_business IN ('Men\'s clothing stores','Women\'s clothing stores');
/*
mes_venta	kind_of_business	sales
1992-01-01	Men's clothing stores	701
1992-01-01	Women's clothing stores	1873
1992-02-01	Men's clothing stores	658
1992-02-01	Women's clothing stores	1991
1992-03-01	Men's clothing stores	731
...
2020-10-01	Women's clothing stores	2634
2020-11-01	Men's clothing stores	0
2020-11-01	Women's clothing stores	2726
2020-12-01	Men's clothing stores	604
2020-12-01	Women's clothing stores	3399
*/





/* Venta totales agrupado por año y tipo de negocio */
select 	extract(year from sales_month) as año,
	kind_of_business,
        sum(sales)
from serie_de_tiempo.retail_sales
where kind_of_business IN ('Men\'s clothing stores','Women\'s clothing stores')
group by año,kind_of_business;
/*
año	kind_of_business	sum(sales)
1992	Men's clothing stores	10179
1992	Women's clothing stores	31815
1993	Men's clothing stores	9962
1993	Women's clothing stores	32350
1994	Men's clothing stores	10032
...
*/


/* Diferencia de ventas totales entre hombres y mujeres agrupado por año */
WITH T as (
	select	extract(year from sales_month) as año,
		sum(case when kind_of_business = 'Women\'s clothing stores' then sales else 0 end) as venta_mujeres,
		sum(case when kind_of_business = 'Men\'s clothing stores'   then sales else 0 end) as venta_hombres
	from serie_de_tiempo.retail_sales
	where kind_of_business IN ('Men\'s clothing stores','Women\'s clothing stores')
	group by año
	)
select año, venta_mujeres, venta_hombres, venta_mujeres - venta_hombres as mujeres_menos_hombres
from T;
/*
SALIDA DE SCRIPT
año	venta_mujeres	venta_hombres	mujeres_menos_hombres
1992	31815		10179		21636
1993	32350		9962		22388
1994	30585		10032		20553
1995	28696		9315		19381
1996	28238		9546		18692
1997	27822		10069		17753
1998	28332		10196		18136
1999	29549		9667		19882
2000	31447		9507		21940
2001	31453		8625		22828
2002	31246		8112		23134
2003	32565		8249		24316
2004	34954		8566		26388
2005	37075		8737		28338
2006	38809		8844		29965
2007	40294		8772		31522
2008	38402		8351		30051
2009	36055		7353		28702
2010	37690		7285		30405
2011	40048		7860		32188
2012	41794		8272		33522
2013	41787		8670		33117
2014	41575		8870		32705
2015	41065		8810		32255
2016	40845		8494		32351
2017	40660		8298		32362
2018	41173		8208		32965
2019	40861		7981		32880
2020	26526		3681		22845
*/


/* Tasa de ventas totales de mujeres respecto de ventas de hombres agrupado por año */
WITH T as (
select	extract(year from sales_month) as año,
	sum(case when kind_of_business = 'Women\'s clothing stores' then sales else 0 end) as venta_mujeres,
        sum(case when kind_of_business = 'Men\'s clothing stores'   then sales else 0 end) as venta_hombres
from serie_de_tiempo.retail_sales
where kind_of_business IN ('Men\'s clothing stores','Women\'s clothing stores')
group by año)
select año, venta_mujeres, venta_hombres, venta_mujeres / venta_hombres as mujeres_entre_hombres
from T;
/*
año	venta_mujeres	venta_hombres	mujeres_entre_hombres
1992	31815		10179		3.1256
1993	32350		9962		3.2473
1994	30585		10032		3.0487
1995	28696		9315		3.0806
1996	28238		9546		2.9581
1997	27822		10069		2.7631
1998	28332		10196		2.7787
1999	29549		9667		3.0567
2000	31447		9507		3.3078
2001	31453		8625		3.6467
2002	31246		8112		3.8518
2003	32565		8249		3.9478
2004	34954		8566		4.0806
2005	37075		8737		4.2434
2006	38809		8844		4.3882
2007	40294		8772		4.5935
2008	38402		8351		4.5985
2009	36055		7353		4.9034
2010	37690		7285		5.1736
2011	40048		7860		5.0952
2012	41794		8272		5.0525
2013	41787		8670		4.8197
2014	41575		8870		4.6871
2015	41065		8810		4.6612
2016	40845		8494		4.8087
2017	40660		8298		4.9000
2018	41173		8208		5.0162
2019	40861		7981		5.1198
2020	26526		3681		7.2062
*/



/* 3-10-Porcentaje del total */

/* Usaremos 2 metodos distintos: Self Join (unir una tabla consigo misma) y con Funciones de Ventana (Over) */

/* SELF JOIN */
/* Obtener el porcentaje de ventas de hombres y mujeres respecto del total de ventas mensuales de ambos sexos */
select 	a.sales_month, 
	a.kind_of_business, 
	a.sales, 
	b.ventas_totales_mes, 
	100 * a.sales / b.ventas_totales_mes as pct_ventas_totales
from (	select 	sales_month, kind_of_business, sales
		from serie_de_tiempo.retail_sales as a
		where kind_of_business IN ('Men\'s clothing stores','Women\'s clothing stores')) as a
        JOIN
	(	select sales_month, sum(sales) as ventas_totales_mes
		from serie_de_tiempo.retail_sales 
		where kind_of_business IN ('Men\'s clothing stores','Women\'s clothing stores')
		group by sales_month) as b
        ON a.sales_month=b.sales_month;
/*
SALIDA DEL SCRIPT
sales_month		kind_of_business	sales	ventas_totales_mes	pct_ventas_totales
1992-01-01 00:00:00	Men's clothing stores	701	2574			27.2339
1992-01-01 00:00:00	Women's clothing stores	1873	2574			72.7661
1992-02-01 00:00:00	Men's clothing stores	658	2649			24.8396
1992-02-01 00:00:00	Women's clothing stores	1991	2649			75.1604
1992-03-01 00:00:00	Men's clothing stores	731	3134			23.3248
1992-03-01 00:00:00	Women's clothing stores	2403	3134			76.6752
1992-04-01 00:00:00	Men's clothing stores	816	3481			23.4415
1992-04-01 00:00:00	Women's clothing stores	2665	3481			76.5585
1992-05-01 00:00:00	Men's clothing stores	856	3608			23.7251
1992-05-01 00:00:00	Women's clothing stores	2752	3608			76.2749

*/


/* FUNCION VENTANA (OVER) */
/* Obtener el porcentaje de ventas de hombres y mujeres respecto del total de ventas mensuales de ambos sexos */
select 	sales_month,
	kind_of_business,
        sales,
        sum(sales) over (partition by sales_month) as ventas_totales_mes,
        100*sales/sum(sales) over (partition by sales_month) as pct_ventas_totales
from serie_de_tiempo.retail_sales
where kind_of_business IN ('Men\'s clothing stores','Women\'s clothing stores');
/*
SALIDA DEL SCRIPT
sales_month		kind_of_business	sales	ventas_totales_mes	pct_ventas_totales
1992-01-01 00:00:00	Men's clothing stores	701	2574			27.2339
1992-01-01 00:00:00	Women's clothing stores	1873	2574			72.7661
1992-02-01 00:00:00	Men's clothing stores	658	2649			24.8396
1992-02-01 00:00:00	Women's clothing stores	1991	2649			75.1604
1992-03-01 00:00:00	Men's clothing stores	731	3134			23.3248
1992-03-01 00:00:00	Women's clothing stores	2403	3134			76.6752
1992-04-01 00:00:00	Men's clothing stores	816	3481			23.4415
1992-04-01 00:00:00	Women's clothing stores	2665	3481			76.5585
1992-05-01 00:00:00	Men's clothing stores	856	3608			23.7251
1992-05-01 00:00:00	Women's clothing stores	2752	3608			76.2749
*/



/*Obtener el porcentaje que cada mes representa de las ventas anuales*/

/*SELF JOIN*/
select 	a.anio, 
	a.sales_month, 
	a.kind_of_business, 
	a.sales,  
	b.ventas_anuales, 
	100 * a.sales / b.ventas_anuales as pct_ventas
from
	(select extract(year from sales_month) as anio,sales_month, kind_of_business, sales
	from	serie_de_tiempo.retail_sales
	where kind_of_business IN ('Men\'s clothing stores','Women\'s clothing stores')
	) as a 
    JOIN
	(select extract(year from sales_month) as anio,kind_of_business,sum(sales) as ventas_anuales
	from serie_de_tiempo.retail_sales
	where kind_of_business IN ('Men\'s clothing stores','Women\'s clothing stores')
	group by anio,kind_of_business) as b
    ON a.anio = b.anio AND a.kind_of_business=b.kind_of_business;
/*
anio	sales_month		kind_of_business	sales	ventas_anuales	pct_ventas
1992	1992-01-01 00:00:00	Men's clothing stores"	701	10179		6.8867
1992	1992-02-01 00:00:00	Men's clothing stores"	658	10179		6.4643
1992	1992-03-01 00:00:00	Men's clothing stores"	731	10179		7.1815
1992	1992-04-01 00:00:00	Men's clothing stores"	816	10179		8.0165
1992	1992-05-01 00:00:00	Men's clothing stores"	856	10179		8.4095
1992	1992-06-01 00:00:00	Men's clothing stores"	853	10179		8.3800
1992	1992-07-01 00:00:00	Men's clothing stores"	714	10179		7.0144
1992	1992-08-01 00:00:00	Men's clothing stores"	777	10179		7.6334
1992	1992-09-01 00:00:00	Men's clothing stores"	762	10179		7.4860
1992	1992-10-01 00:00:00	Men's clothing stores"	841	10179		8.2621
*/
    
/*FUNCION VENTANA*/
select 	extract(year from sales_month) as year_extract,
	sales_month,
	kind_of_business,
	sales,
	sum(sales) over (partition by extract(year from sales_month),kind_of_business) as venta_anual,
        100 * sales / sum(sales) over (partition by extract(year from sales_month),kind_of_business) as pct_ventas
from serie_de_tiempo.retail_sales
where kind_of_business IN ('Men\'s clothing stores','Women\'s clothing stores');
/*
SALIDA DEL SCRIPT
year_extract	sales_month		kind_of_business	sales	venta_anual	pct_ventas
1992		1992-01-01 00:00:00	Men's clothing stores	701	10179		6.8867
1992		1992-02-01 00:00:00	Men's clothing stores	658	10179		6.4643
1992		1992-03-01 00:00:00	Men's clothing stores	731	10179		7.1815
1992		1992-04-01 00:00:00	Men's clothing stores	816	10179		8.0165
1992		1992-05-01 00:00:00	Men's clothing stores	856	10179		8.4095
1992		1992-06-01 00:00:00	Men's clothing stores	853	10179		8.3800
1992		1992-07-01 00:00:00	Men's clothing stores	714	10179		7.0144
1992		1992-08-01 00:00:00	Men's clothing stores	777	10179		7.6334
1992		1992-09-01 00:00:00	Men's clothing stores	762	10179		7.4860
1992		1992-10-01 00:00:00	Men's clothing stores	841	10179		8.2621
*/



/*3-11-Cambio Porcentual a lo largo del tiempo*/
select 	anio_venta,
	kind_of_business,
	ventas,
	first_value(ventas) over (partition by kind_of_business order by anio_venta) as primer_venta,
        ((ventas / first_value(ventas) over (partition by kind_of_business order by anio_venta)) - 1) * 100 as indice_ventas
from 
	(
	select 	extract(year from sales_month) as anio_venta, 
		kind_of_business,
		sum(sales) as ventas
	from serie_de_tiempo.retail_sales
	where kind_of_business IN ('Men\'s clothing stores','Women\'s clothing stores')
	group by anio_venta,kind_of_business
	) as A;
/*
anio_venta	kind_of_business	ventas	primer_venta	indice_ventas
1992		Men's clothing stores	10179	10179		0.0000
1993		Men's clothing stores	9962	10179		-2.1318
1994		Men's clothing stores	10032	10179		-1.4441
1995		Men's clothing stores	9315	10179		-8.4881
1996		Men's clothing stores	9546	10179		-6.2187
1997		Men's clothing stores	10069	10179		-1.0807
1998		Men's clothing stores	10196	10179		0.1670
1999		Men's clothing stores	9667	10179		-5.0300
2000		Men's clothing stores	9507	10179		-6.6018
2001		Men's clothing stores	8625	10179		-15.2667
2002		Men's clothing stores	8112	10179		-20.3065
2003		Men's clothing stores	8249	10179		-18.9606
2004		Men's clothing stores	8566	10179		-15.8464
2005		Men's clothing stores	8737	10179		-14.1664
2006		Men's clothing stores	8844	10179		-13.1152
2007		Men's clothing stores	8772	10179		-13.8226
2008		Men's clothing stores	8351	10179		-17.9585
2009		Men's clothing stores	7353	10179		-27.7630
2010		Men's clothing stores	7285	10179		-28.4311
2011		Men's clothing stores	7860	10179		-22.7822
2012		Men's clothing stores	8272	10179		-18.7346
2013		Men's clothing stores	8670	10179		-14.8246
2014		Men's clothing stores	8870	10179		-12.8598
2015		Men's clothing stores	8810	10179		-13.4493
2016		Men's clothing stores	8494	10179		-16.5537
2017		Men's clothing stores	8298	10179		-18.4792
2018		Men's clothing stores	8208	10179		-19.3634
2019		Men's clothing stores	7981	10179		-21.5935
2020		Men's clothing stores	3681	10179		-63.8373
1992		Women's clothing stores	31815	31815		0.0000
1993		Women's clothing stores	32350	31815		1.6816
1994		Women's clothing stores	30585	31815		-3.8661
1995		Women's clothing stores	28696	31815		-9.8036
1996		Women's clothing stores	28238	31815		-11.2431
1997		Women's clothing stores	27822	31815		-12.5507
1998		Women's clothing stores	28332	31815		-10.9477
1999		Women's clothing stores	29549	31815		-7.1224
2000		Women's clothing stores	31447	31815		-1.1567
2001		Women's clothing stores	31453	31815		-1.1378
2002		Women's clothing stores	31246	31815		-1.7885
2003		Women's clothing stores	32565	31815		2.3574
2004		Women's clothing stores	34954	31815		9.8664
2005		Women's clothing stores	37075	31815		16.5331
2006		Women's clothing stores	38809	31815		21.9833
2007		Women's clothing stores	40294	31815		26.6510
2008		Women's clothing stores	38402	31815		20.7041
2009		Women's clothing stores	36055	31815		13.3270
2010		Women's clothing stores	37690	31815		18.4661
2011		Women's clothing stores	40048	31815		25.8777
2012		Women's clothing stores	41794	31815		31.3657
2013		Women's clothing stores	41787	31815		31.3437
2014		Women's clothing stores	41575	31815		30.6774
2015		Women's clothing stores	41065	31815		29.0743
2016		Women's clothing stores	40845	31815		28.3828
2017		Women's clothing stores	40660	31815		27.8014
2018		Women's clothing stores	41173	31815		29.4138
2019		Women's clothing stores	40861	31815		28.4331
2020		Women's clothing stores	26526	31815		-16.6242
*/


/*  3-12-Introduccion a Ventanas Moviles */
/* 3-13- Ventanas Moviles */
/* Hay 2 maneras de hacerlo, usando self join y usando las funciones de ventana over */

/*Método con self join*/
select 	a.sales_month, 
	a.sales, 
	/*b.sales_month as ventana_movil,*/ 
        AVG(b.sales) as promedio_de_ventas_ventana_movil,
        count(*)
from 	serie_de_tiempo.retail_sales as a 
	join
        serie_de_tiempo.retail_sales as b
        on a.kind_of_business = b.kind_of_business
	and b.sales_month between a.sales_month - interval 11 month and a.sales_month
where a.kind_of_business IN ('Women\'s clothing stores')
group by 1
order by 1;
/*
salida del script
sales_month		sales	promedio_de_ventas_ventana_movil	count(*)
1992-01-01 00:00:00	1873	1873.0000				1
1992-02-01 00:00:00	1991	1932.0000				2
1992-03-01 00:00:00	2403	2089.0000				3
1992-04-01 00:00:00	2665	2233.0000				4
1992-05-01 00:00:00	2752	2336.8000				5
1992-06-01 00:00:00	2424	2351.3333				6
1992-07-01 00:00:00	2373	2354.4286				7
1992-08-01 00:00:00	2657	2392.2500				8
1992-09-01 00:00:00	2560	2410.8889				9
1992-10-01 00:00:00	2755	2445.3000				10
1992-11-01 00:00:00	2946	2490.8182				11
1992-12-01 00:00:00	4416	2651.2500				12
1993-01-01 00:00:00	2123	2672.0833				12
...
2020-05-01 00:00:00	1099	2763.4167				12
2020-06-01 00:00:00	2027	2659.6667				12
2020-07-01 00:00:00	2373	2585.6667				12
2020-08-01 00:00:00	2386	2507.4167				12
2020-09-01 00:00:00	2494	2458.5833				12
2020-10-01 00:00:00	2634	2395.5833				12
2020-11-01 00:00:00	2726	2301.9167				12
2020-12-01 00:00:00	3399	2210.5000				12
*/

/* Metodo con funciones de ventana OVER PARTITION */
select 	sales_month,
	avg(sales) 	over (order by sales_month rows between  11 preceding and current row) 	as promedio_movil,
        count(sales) 	over (order by sales_month rows between  11 preceding and current row)	as conteo_de_filas
from serie_de_tiempo.retail_sales
where kind_of_business IN ('Women\'s clothing stores');
/*
sales_month		promedio_movil	conteo_de_filas
1992-01-01 00:00:00	1873.0000	1
1992-02-01 00:00:00	1932.0000	2
1992-03-01 00:00:00	2089.0000	3
1992-04-01 00:00:00	2233.0000	4
1992-05-01 00:00:00	2336.8000	5
1992-06-01 00:00:00	2351.3333	6
1992-07-01 00:00:00	2354.4286	7
1992-08-01 00:00:00	2392.2500	8
1992-09-01 00:00:00	2410.8889	9
1992-10-01 00:00:00	2445.3000	10
1992-11-01 00:00:00	2490.8182	11
1992-12-01 00:00:00	2651.2500	12
1993-01-01 00:00:00	2672.0833	12
1993-02-01 00:00:00	2673.2500	12
1993-03-01 00:00:00	2676.5000	12
1993-04-01 00:00:00	2684.5833	12
1993-05-01 00:00:00	2694.6667	12
...
2019-09-01 00:00:00	3445.8333	12
2019-10-01 00:00:00	3434.9167	12
2019-11-01 00:00:00	3409.3333	12
2019-12-01 00:00:00	3405.0833	12
2020-01-01 00:00:00	3406.8333	12
2020-02-01 00:00:00	3416.5833	12
2020-03-01 00:00:00	3248.1667	12
2020-04-01 00:00:00	2989.0833	12
2020-05-01 00:00:00	2763.4167	12
2020-06-01 00:00:00	2659.6667	12
2020-07-01 00:00:00	2585.6667	12
2020-08-01 00:00:00	2507.4167	12
2020-09-01 00:00:00	2458.5833	12
2020-10-01 00:00:00	2395.5833	12
2020-11-01 00:00:00	2301.9167	12
2020-12-01 00:00:00	2210.5000	12
*/



/* 3-14-Acumulado YTD */

/* Funciones acumulativas */
/*Obtener las ventas acumulada por trimestre*/
select 	sales_month,
	sales as ventas_del_mes,
	sum(sales) over (partition by extract(year from sales_month),extract(quarter from sales_month) order by sales_month) as ventas_acumuladas
from serie_de_tiempo.retail_sales
where kind_of_business IN ('Women\'s clothing stores');
/*
salida del script
sales_month		ventas_del_mes	ventas_acumuladas
1992-01-01 00:00:00	1873		1873
1992-02-01 00:00:00	1991		3864
1992-03-01 00:00:00	2403		6267
1992-04-01 00:00:00	2665		2665
1992-05-01 00:00:00	2752		5417
1992-06-01 00:00:00	2424		7841
1992-07-01 00:00:00	2373		2373
1992-08-01 00:00:00	2657		5030
1992-09-01 00:00:00	2560		7590
1992-10-01 00:00:00	2755		2755
...
2020-03-01 00:00:00	1564		6893
2020-04-01 00:00:00	495		495
2020-05-01 00:00:00	1099		1594
2020-06-01 00:00:00	2027		3621
2020-07-01 00:00:00	2373		2373
2020-08-01 00:00:00	2386		4759
2020-09-01 00:00:00	2494		7253
2020-10-01 00:00:00	2634		2634
2020-11-01 00:00:00	2726		5360
2020-12-01 00:00:00	3399		8759
*/

/* 3-15-Estacionalidad */

/* 3-16-Periodo vs Periodo */
/* Año Actual vs Año Pasado, Mes Actual vs Mes Pasado, Día Actual vs Día Anterior, etc*/
/* Se puede utilizar la función LAG con valores enteros postivos para obtener valores anteriores, y con valores negativos se obtienen valores posteriores */

/* Se puede hacer de 2 maneras distintas: Self Join y función Ventana */

/* Comparar ventas de mes actual vs mes anterior */
/* Nota: Para esta operacion no esta realmente calculando el mes previo en terminos de fechas, sino que dada la particion y el orden elegido en la
clausula over, toma el valor de la fila inmediata anterior */
select 	kind_of_business,
	sales_month,
        sales as ventas,
        lag(sales_month) 	over (partition by kind_of_business order by sales_month) as mes_previo,
        lag(sales) 		over (partition by kind_of_business order by sales_month) as ventas_mes_previo,
        ((sales/lag(sales) over (partition by kind_of_business order by sales_month))-1)*100 as porcentaje_crecimiento
from serie_de_tiempo.retail_sales
where kind_of_business = "Book Stores";
/*
salida del script
kind_of_business	sales_month		ventas	mes_previo		ventas_mes_previo	porcentaje_crecimiento
Book stores		1992-01-01 00:00:00	790	NULL			NULL			NULL
Book stores		1992-02-01 00:00:00	539	1992-01-01 00:00:00	790			-31.7722
Book stores		1992-03-01 00:00:00	535	1992-02-01 00:00:00	539			-0.7421
Book stores		1992-04-01 00:00:00	523	1992-03-01 00:00:00	535			-2.2430
Book stores		1992-05-01 00:00:00	552	1992-04-01 00:00:00	523			5.5449
Book stores		1992-06-01 00:00:00	589	1992-05-01 00:00:00	552			6.7029
Book stores		1992-07-01 00:00:00	592	1992-06-01 00:00:00	589			0.5093
Book stores		1992-08-01 00:00:00	894	1992-07-01 00:00:00	592			51.0135
Book stores		1992-09-01 00:00:00	861	1992-08-01 00:00:00	894			-3.6913
Book stores		1992-10-01 00:00:00	645	1992-09-01 00:00:00	861			-25.0871
Book stores		1992-11-01 00:00:00	642	1992-10-01 00:00:00	645			-0.4651
...
Book stores		2020-03-01 00:00:00	392	2020-02-01 00:00:00	573			-31.5881
Book stores		2020-04-01 00:00:00	163	2020-03-01 00:00:00	392			-58.4184
Book stores		2020-05-01 00:00:00	275	2020-04-01 00:00:00	163			68.7117
Book stores		2020-06-01 00:00:00	388	2020-05-01 00:00:00	275			41.0909
Book stores		2020-07-01 00:00:00	437	2020-06-01 00:00:00	388			12.6289
Book stores		2020-08-01 00:00:00	770	2020-07-01 00:00:00	437			76.2014
Book stores		2020-09-01 00:00:00	620	2020-08-01 00:00:00	770			-19.4805
Book stores		2020-10-01 00:00:00	455	2020-09-01 00:00:00	620			-26.6129
Book stores		2020-11-01 00:00:00	496	2020-10-01 00:00:00	455			9.0110
Book stores		2020-12-01 00:00:00	900	2020-11-01 00:00:00	496			81.4516
*/



/* Comparar ventas de año actual vs año anterior */
select 	anio,
	ventas_anuales,
        lag(anio) 		over (order by anio) as anio_anterior,
        lag(ventas_anuales) 	over (order by anio) as ventas_anio_anterior,
        ((ventas_anuales/lag(ventas_anuales) over (order by anio))-1)*100 as porcentaje_crecimiento
from 
		(select 	extract(year from sales_month) as anio,
				sum(sales) as ventas_anuales 
		from		serie_de_tiempo.retail_sales
		where 		kind_of_business = "Book Stores"
		group by 1) as a;
/*
salida del script

anio	ventas_anuales	anio_anterior	ventas_anio_anterior	porcentaje_crecimiento
1992	8327		NULL		NULL			NULL
1993	9108		1992		8327			9.3791
1994	10107		1993		9108			10.9684
1995	11196		1994		10107			10.7747
1996	11905		1995		11196			6.3326
...
2016	10741		2015		10998			-2.3368
2017	10375		2016		10741			-3.4075
2018	9617		2017		10375			-7.3060
2019	8844		2018		9617			-8.0378
2020	6425		2019		8844			-27.3519
*/

/* 3-17-Mismo Mes Año Pasado */
/* Comparar cada mes con el mismo mes 1 año hacia atrás */
select 	sales_month,
	sales,
        extract(month from sales_month) as mes,
        lag(sales_month) 	over (partition by extract(month from sales_month) order by sales_month) as mes_año_previo,
        lag(sales) 		over (partition by extract(month from sales_month) order by sales_month) as ventas_mes_año_previo,
        (sales - lag(sales)	over (partition by extract(month from sales_month) order by sales_month)) as diferencia_absoluta,
        ((sales / lag(sales) 	over (partition by extract(month from sales_month) order by sales_month)) -1)*100 as porcentaje_crecimiento
from serie_de_tiempo.retail_sales
where kind_of_business = "Book Stores";
/*
salida del script
sales_month		sales	mes	mes_año_previo		ventas_mes_año_previo	diferencia_absoluta	porcentaje_crecimiento
1992-01-01 00:00:00	790	1	NULL			NULL			NULL			NULL
1993-01-01 00:00:00	998	1	1992-01-01 00:00:00	790			208			26.3291
1994-01-01 00:00:00	1053	1	1993-01-01 00:00:00	998			55			5.5110
1995-01-01 00:00:00	1308	1	1994-01-01 00:00:00	1053			255			24.2165
1996-01-01 00:00:00	1373	1	1995-01-01 00:00:00	1308			65			4.9694
...
2016-12-01 00:00:00	1249	12	2015-12-01 00:00:00	1321			-72			-5.4504
2017-12-01 00:00:00	1114	12	2016-12-01 00:00:00	1249			-135			-10.8086
2018-12-01 00:00:00	1122	12	2017-12-01 00:00:00	1114			8			0.7181
2019-12-01 00:00:00	1037	12	2018-12-01 00:00:00	1122			-85			-7.5758
2020-12-01 00:00:00	900	12	2019-12-01 00:00:00	1037			-137			-13.2112
*/


/* 3-18-Varios Periodos Previos y Conclusion */
/* Es posible obtener los datos con 1,2,3,...,n periodos de retraso. */

select 	sales_month,
	sales,
        lag(sales,1) over (partition by extract(month from sales_month) order by sales_month) as ventas_lag_1_año,
        lag(sales,2) over (partition by extract(month from sales_month) order by sales_month) as ventas_lag_2_año,
        lag(sales,3) over (partition by extract(month from sales_month) order by sales_month) as ventas_lag_3_año
from serie_de_tiempo.retail_sales
where kind_of_business = "Book Stores";
/*
salida del script
sales_month		sales	ventas_lag_1_año	ventas_lag_2_año	ventas_lag_3_año
1992-01-01 00:00:00	790	NULL			NULL			NULL
1993-01-01 00:00:00	998	790			NULL			NULL
1994-01-01 00:00:00	1053	998			790			NULL
1995-01-01 00:00:00	1308	1053			998			790
1996-01-01 00:00:00	1373	1308			1053			998
1997-01-01 00:00:00	1558	1373			1308			1053
1998-01-01 00:00:00	1463	1558			1373			1308
1999-01-01 00:00:00	1514	1463			1558			1373
2000-01-01 00:00:00	1505	1514			1463			1558
2001-01-01 00:00:00	1585	1505			1514			1463
...
2011-12-01 00:00:00	1400	1879			1911			2008
2012-12-01 00:00:00	1318	1400			1879			1911
2013-12-01 00:00:00	1327	1318			1400			1879
2014-12-01 00:00:00	1332	1327			1318			1400
2015-12-01 00:00:00	1321	1332			1327			1318
2016-12-01 00:00:00	1249	1321			1332			1327
2017-12-01 00:00:00	1114	1249			1321			1332
2018-12-01 00:00:00	1122	1114			1249			1321
2019-12-01 00:00:00	1037	1122			1114			1249
2020-12-01 00:00:00	900	1037			1122			1114
*/

/* Obtener el % de crecimiento del mes con respecto al promedio de venta del mismo mes pero de hace 1 año, 2 años y 3 años */
select 	sales_month,
	sales,
        avg(sales) over (partition by extract(month from sales_month) order by sales_month rows between 3 preceding and 1 preceding) as promedio_venta_3_periodos_antes,
        (sales / avg(sales) over (partition by extract(month from sales_month) order by sales_month rows between 3 preceding and 1 preceding)) as procentaje_crecimiento
from serie_de_tiempo.retail_sales
where kind_of_business = "Book Stores"
/*
salida del script
sales_month		sales	promedio_venta_3_periodos_antes	procentaje_crecimiento
1992-01-01 00:00:00	790	NULL				NULL
1993-01-01 00:00:00	998	790.0000			1.2633
1994-01-01 00:00:00	1053	894.0000			1.1779
1995-01-01 00:00:00	1308	947.0000			1.3812
1996-01-01 00:00:00	1373	1119.6667			1.2263
1997-01-01 00:00:00	1558	1244.6667			1.2517
1998-01-01 00:00:00	1463	1413.0000			1.0354
1999-01-01 00:00:00	1514	1464.6667			1.0337
2000-01-01 00:00:00	1505	1511.6667			0.9956
2001-01-01 00:00:00	1585	1494.0000			1.0609
...
2011-12-01 00:00:00	1400	1932.6667			0.7244
2012-12-01 00:00:00	1318	1730.0000			0.7618
2013-12-01 00:00:00	1327	1532.3333			0.8660
2014-12-01 00:00:00	1332	1348.3333			0.9879
2015-12-01 00:00:00	1321	1325.6667			0.9965
2016-12-01 00:00:00	1249	1326.6667			0.9415
2017-12-01 00:00:00	1114	1300.6667			0.8565
2018-12-01 00:00:00	1122	1228.0000			0.9137
2019-12-01 00:00:00	1037	1161.6667			0.8927
2020-12-01 00:00:00	900	1091.0000			0.8249
*/



















