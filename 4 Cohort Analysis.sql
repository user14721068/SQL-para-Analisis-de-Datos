/* 4.- ANALISIS DE COHORTE */

/* 4-1 Introduccion a las Cohortes */

/*
Agrupamiento generacional: Cual es caracteristica para agrupar gente en la cohorte, por ejemplo: fecha de nacimiento, primer compra de un producto, nacionalidad, género, sexo. No debe cambiar a lo largo del estudio.
Temporalidad: Tiempo en que se estará siguiendo al grupo.
Métrica agregada: Cómo mediremos a las personas de la cohorte, pueden ser ventas, ticket promedio, calificaciones, asistencia a clase, tasa de clicks, etc.
*/

/*
Temas:
Análisis de retención: Si cada miembro de una generación está presenta en una fecha en particular de nuestro estudio.
Análisis de superviviencia: Cuanta gente de una generación sobrevive después de cierto tiempo.
Análisis de devolución: Si una acción ha sucedido más de n veces en un periodo de tiempo dado. Por ejemplo, cuantas veces nos compra un cliente en un periodo de tiempo.
Análisis Acumulativos: A lo largo de la vida del cliente, cuento dinero ha gastado con nosotros.
*/

/* 4-2 Introducción a Análisis de Retencion */

/* Qué tanta gente se queda con nosotros. Ver el tamaño de la cohorte a través del tiempo, o bien, que tanto dinero gasta la gente a traves del tiempo */ 
/* Buscamos expresar como un %. Al inicio se tiene un 100%, luego puede aumentar o disminuir. */
/* Se puede considerar el número de personas o gasto de dinero a través del tiempo. */

/* 4-3 SQL para curva basica de Retencion */

SELECT 	* 
FROM 	cohort.supertienda
LIMIT 	10;
/*
id	Categoria	Ciudad	Pais_Region	Nombre_Cliente	Proveedor	Fecha_Orden	ID_Orden	CP	Nombre_Producto	Region	Segmento	Fecha_Envio	Modo_Envio	Estado_Provincia	SubCategoria	Descuento	Ganancia	Cantidad	Ventas
1	Suministros de Oficina	Houston	United States	Darren Powers	Message Book	01/03/2019 12:00:00 a. m.	US-2019-103800	77095	Message Book, Wirebound, Four 5 1/2" X 4" Forms/Pg., 200 Dupl. Sets/Book	Central	Consumidor	01/07/2019 12:00:00 a. m.	Standard Class	Texas	Papel	0.20	5.551200000000000000000000000000	2	16.448000000000000000000000000000
2	Suministros de Oficina	Naperville	United States	Phillina Ober	GBC	01/04/2019 12:00:00 a. m.	US-2019-112326	60540	GBC Standard Plastic Binding Systems Combs	Central	Home Office	01/08/2019 12:00:00 a. m.	Standard Class	Illinois	Portafolio	0.80	-5.487000000000000000000000000000	2	3.540000000000000000000000000000
3	Suministros de Oficina	Naperville	United States	Phillina Ober	Avery	01/04/2019 12:00:00 a. m.	US-2019-112326	60540	Avery 508	Central	Home Office	01/08/2019 12:00:00 a. m.	Standard Class	Illinois	Etiquetas	0.20	4.271700000000000000000000000000	3	11.784000000000000000000000000000
4	Suministros de Oficina	Naperville	United States	Phillina Ober	SAFCO	01/04/2019 12:00:00 a. m.	US-2019-112326	60540	SAFCO Boltless Steel Shelving	Central	Home Office	01/08/2019 12:00:00 a. m.	Standard Class	Illinois	Almacenamiento	0.20	-64.774800000000000000000000000000	3	272.736000000000000000000000000000
5	Suministros de Oficina	Philadelphia	United States	Mick Brown	Avery	01/05/2019 12:00:00 a. m.	US-2019-141817	19143	Avery Hi-Liter EverBold Pen Style Fluorescent Highlighters, 4/Pack	Este	Consumidor	01/12/2019 12:00:00 a. m.	Standard Class	Pennsylvania	Arte	0.20	4.884000000000000000000000000000	3	19.536000000000000000000000000000
6	Muebles	Henderson	United States	Maria Etezadi	Global	01/06/2019 12:00:00 a. m.	US-2019-167199	42420	Global Deluxe High-Back Manager's Chair	Sur	Home Office	01/10/2019 12:00:00 a. m.	Standard Class	Kentucky	Sillas	0.00	746.407800000000000000000000000000	9	2573.820000000000000000000000000000
7	Suministros de Oficina	Henderson	United States	Maria Etezadi	Rogers	01/06/2019 12:00:00 a. m.	US-2019-167199	42420	Rogers Handheld Barrel Pencil Sharpener	Sur	Home Office	01/10/2019 12:00:00 a. m.	Standard Class	Kentucky	Arte	0.00	1.479600000000000000000000000000	2	5.480000000000000000000000000000
8	Suministros de Oficina	Athens	United States	Jack O'Briant	Dixon	01/06/2019 12:00:00 a. m.	US-2019-106054	30605	Dixon Prang Watercolor Pencils, 10-Color Set with Brush	Sur	Corporativo	01/07/2019 12:00:00 a. m.	First Class	Georgia	Arte	0.00	5.239800000000000000000000000000	3	12.780000000000000000000000000000
9	Suministros de Oficina	Henderson	United States	Maria Etezadi	Ibico	01/06/2019 12:00:00 a. m.	US-2019-167199	42420	Ibico Hi-Tech Manual Binding System	Sur	Home Office	01/10/2019 12:00:00 a. m.	Standard Class	Kentucky	Portafolio	0.00	274.491000000000000000000000000000	2	609.980000000000000000000000000000
10	Suministros de Oficina	Henderson	United States	Maria Etezadi	Alliance	01/06/2019 12:00:00 a. m.	US-2019-167199	42420	Alliance Super-Size Bands, Assorted Sizes	Sur	Home Office	01/10/2019 12:00:00 a. m.	Standard Class	Kentucky	Ajustadores	0.00	0.311200000000000000000000000000	4	31.120000000000000000000000000000
*/

/* Truncar la columna fecha_orden y luego convertir a tipo date */
UPDATE cohort.supertienda SET cohort.supertienda.fecha_orden = STR_TO_DATE(SUBSTRING_INDEX(cohort.supertienda.fecha_orden, ' ', 1),'%m/%d/%Y') ;

/* Por el momento se analiza solo la retención no la cohorte */

/* Obtener la fecha en que cada cliente hizo su primera orden */
select 		nombre_cliente,
			min(fecha_orden) as fecha_primera_orden
from 		cohort.supertienda
group by 	1;
/*
nombre_cliente	fecha_primera_orden
Darren Powers	01/03/2019 12:00:00 a. m.
Phillina Ober	01/04/2019 12:00:00 a. m.
Mick Brown	01/05/2019 12:00:00 a. m.
Maria Etezadi	01/06/2019 12:00:00 a. m.
Jack O'Briant	01/06/2019 12:00:00 a. m.
...
*/


/* Obtener cuantos clientes compraron, cuantos compraron 1 mes después de su primera compra, 2 meses después, 3 meses despues, etc */
select 			timestampdiff(MONTH,A.fecha_primera_orden,B.fecha_orden) as periodo,
				count(distinct B.nombre_cliente ) as nro_clientes
from 
(
	select 		nombre_cliente,
				min(fecha_orden) as fecha_primera_orden
	from 		cohort.supertienda
	group by 	1
) AS A 
INNER JOIN cohort.supertienda as B on A.nombre_cliente = B.nombre_cliente
GROUP BY 1;
/*
periodo	nro_clientes
0	800
1	69
2	74
3	71
4	61
5	89
...
*/

/* Con la consulta anterior, obtener el porcentaje de cada periodo respecto al periodo 0 */
select 	periodo,
		nro_clientes,
        first_value(nro_clientes) over (order by periodo) as clientes_iniciales,
        100 * nro_clientes / first_value(nro_clientes) over (order by periodo) as porcentaje_retencion
FROM
(
	select 			timestampdiff(MONTH,A.fecha_primera_orden,B.fecha_orden) as periodo,
					count(distinct B.nombre_cliente ) as nro_clientes
	from 
	(
		select 		nombre_cliente,
					min(fecha_orden) as fecha_primera_orden
		from 		cohort.supertienda
		group by 	1
	) AS A 
	INNER JOIN cohort.supertienda as B on A.nombre_cliente = B.nombre_cliente
	GROUP BY 1
) AS Z;
/*
periodo	nro_clientes	clientes_iniciales	porcentaje_retencion
0	800	800	100.0000
1	69	800	8.6250
2	74	800	9.2500
3	71	800	8.8750
4	61	800	7.6250
5	89	800	11.1250
...
*/


/* 4-4 Analisis de Retencion Legisladores */

SELECT 	* 
FROM 	cohort.legisladoresusa
LIMIT 	5;
/**
legisladoresusa_id	IDLegislador	DipSen	InicioPeriodo	FinPeriodo	Estado
1	B000944	rep	1993-01-05 00:00:00	1995-01-03 00:00:00	OH
2	C000127	rep	1993-01-05 00:00:00	1995-01-03 00:00:00	WA
3	C000141	rep	1987-01-06 00:00:00	1989-01-03 00:00:00	MD
4	C000174	rep	1983-01-03 00:00:00	1985-01-03 00:00:00	DE
5	C001070	sen	2007-01-04 00:00:00	2013-01-03 00:00:00	PA
...
*/

SELECT 	* 
FROM 	cohort.tablafechas
LIMIT 	5;
/*
Year	Mes	Dia	Dias_en_Year
1770	12	31	365
1771	12	31	365
1772	12	31	366
1773	12	31	365
1774	12	31	365
...
*/

/*Agregar una columna de fecha*/
ALTER TABLE cohort.tablafechas ADD COLUMN Fecha DATE;
UPDATE cohort.tablafechas SET cohort.tablafechas.Fecha = concat(Year,"-",Mes,"-",Dia);

SELECT 	* 
FROM 	cohort.tablafechas
LIMIT 	5;
/*
Year	Mes	Dia	Dias_en_Year	Fecha
1770	12	31	365	1770-12-31
1771	12	31	365	1771-12-31
1772	12	31	366	1772-12-31
1773	12	31	365	1773-12-31
1774	12	31	365	1774-12-31
...
*/

/* Cuando inicia cada legislador su periodo */
SELECT 	IDLegislador,
		MIN(InicioPeriodo) as Primer_Periodo
FROM cohort.legisladoresusa
GROUP BY 1;
/*
IDLegislador	Primer_Periodo
B000944	1993-01-05 00:00:00
C000127	1993-01-05 00:00:00
C000141	1987-01-06 00:00:00
C000174	1983-01-03 00:00:00
C001070	2007-01-04 00:00:00
...
*/

/* Agregar la fecha de primer periodo a la tabla original */
SELECT *
FROM
(
SELECT 	IDLegislador,
		MIN(InicioPeriodo) as Primer_Periodo
FROM cohort.legisladoresusa
GROUP BY 1
) AS A 
INNER JOIN cohort.legisladoresusa AS B ON A.IDLegislador=B.IDLegislador;
/*
IDLegislador	Primer_Periodo	legisladoresusa_id	IDLegislador	DipSen	InicioPeriodo	FinPeriodo	Estado
B000944	1993-01-05 00:00:00	1	B000944	rep	1993-01-05 00:00:00	1995-01-03 00:00:00	OH
C000127	1993-01-05 00:00:00	2	C000127	rep	1993-01-05 00:00:00	1995-01-03 00:00:00	WA
C000141	1987-01-06 00:00:00	3	C000141	rep	1987-01-06 00:00:00	1989-01-03 00:00:00	MD
C000174	1983-01-03 00:00:00	4	C000174	rep	1983-01-03 00:00:00	1985-01-03 00:00:00	DE
C001070	2007-01-04 00:00:00	5	C001070	sen	2007-01-04 00:00:00	2013-01-03 00:00:00	PA
...
*/

/*Usar la tabla de fechas para agregar las fechas intermedias entre InicioPeriodo y FinPeriodo y calcular el periodo */
SELECT 	A.IDLegislador,
		A.Primer_Periodo,
        B.InicioPeriodo,
        B.FinPeriodo,
        C.Fecha,
		COALESCE(timestampdiff(YEAR,A.primer_periodo,C.fecha),0) as Periodo
FROM
(
SELECT 	IDLegislador,
		MIN(InicioPeriodo) as Primer_Periodo
FROM cohort.legisladoresusa
GROUP BY 1
) AS A 
INNER JOIN cohort.legisladoresusa AS B ON A.IDLegislador=B.IDLegislador
LEFT JOIN cohort.tablafechas AS C ON C.FECHA BETWEEN B.InicioPeriodo AND B.FInPeriodo
ORDER BY A.IDLegislador, B.InicioPeriodo, C.Fecha;
/*
IDLegislador	Primer_Periodo	InicioPeriodo	FinPeriodo	Fecha	Periodo
A000001	1951-01-03 00:00:00	1951-01-03 00:00:00	1953-01-03 00:00:00	1951-12-31	0
A000001	1951-01-03 00:00:00	1951-01-03 00:00:00	1953-01-03 00:00:00	1952-12-31	1
A000002	1947-01-03 00:00:00	1947-01-03 00:00:00	1949-01-03 00:00:00	1947-12-31	0
A000002	1947-01-03 00:00:00	1947-01-03 00:00:00	1949-01-03 00:00:00	1948-12-31	1
A000002	1947-01-03 00:00:00	1949-01-03 00:00:00	1951-01-03 00:00:00	1949-12-31	2
A000002	1947-01-03 00:00:00	1949-01-03 00:00:00	1951-01-03 00:00:00	1950-12-31	3
...
*/


/* Con la columna periodo calculada en el punto anterior, calcular el numero de legisladores en cada uno de los periodos */
SELECT 	Periodo,
		count(distinct IDLegislador) as numero_legisladores
FROM
(
SELECT 	A.IDLegislador,
		A.Primer_Periodo,
        B.InicioPeriodo,
        B.FinPeriodo,
        C.Fecha,
		COALESCE(timestampdiff(YEAR,A.primer_periodo,C.fecha),0) as Periodo
FROM
(
SELECT 	IDLegislador,
		MIN(InicioPeriodo) as Primer_Periodo
FROM cohort.legisladoresusa
GROUP BY 1
) AS A 
INNER JOIN cohort.legisladoresusa AS B ON A.IDLegislador=B.IDLegislador
LEFT JOIN cohort.tablafechas AS C ON C.FECHA BETWEEN B.InicioPeriodo AND B.FInPeriodo
ORDER BY A.IDLegislador, B.InicioPeriodo, C.Fecha
) AS M
GROUP BY 1
ORDER BY 1 ASC;
/* 
Periodo	numero_legisladores
NULL	137
0	12501
1	12328
2	8162
3	8065
...
*/

/* De la tabla anterior, calcular una columna con el porcentaje de retencion respecto del periodo 0 */
SELECT 	periodo,
		numero_legisladores,
        first_value(numero_legisladores) over (order by periodo) as poblacion_inicial,
		100*(numero_legisladores / first_value(numero_legisladores) over (order by periodo)) as porcentaje_retencion
FROM
(
		SELECT 	Periodo,
				count(distinct IDLegislador) as numero_legisladores
		FROM
		(
				SELECT 	A.IDLegislador,
						A.Primer_Periodo,
						B.InicioPeriodo,
						B.FinPeriodo,
						C.Fecha,
						COALESCE(timestampdiff(YEAR,A.primer_periodo,C.fecha),0) as Periodo
				FROM
				(
						SELECT 	IDLegislador,
								MIN(InicioPeriodo) as Primer_Periodo
						FROM cohort.legisladoresusa
						GROUP BY 1
		) AS A 
		INNER JOIN cohort.legisladoresusa AS B ON A.IDLegislador=B.IDLegislador
		LEFT JOIN cohort.tablafechas AS C ON C.FECHA BETWEEN B.InicioPeriodo AND B.FInPeriodo
		ORDER BY A.IDLegislador, B.InicioPeriodo, C.Fecha
) AS M
GROUP BY 1
ORDER BY 1 ASC
) AS N;
/*
periodo	numero_legisladores	poblacion_inicial	porcentaje_retencion
0	12518	12518	100.0000
1	12328	12518	98.4822
2	8162	12518	65.2021
3	8065	12518	64.4272
4	5854	12518	46.7647
5	5787	12518	46.2294
...
*/



/* 4-5 Cohortes derivadas de la serie de tiempo */

/* De la tabla "Supertienda" obtener los clientes y la fecha de su primera orden */
select		nombre_cliente,
			min(fecha_orden) as primera_orden
from cohort.supertienda
group by 1;
/*
nombre_cliente	primera_orden
Darren Powers	2019-01-03
Phillina Ober	2019-01-04
Mick Brown	2019-01-05
Maria Etezadi	2019-01-06
Jack O'Briant	2019-01-06
...
*/

/* Obtener el año de la primera orden y a partir de su primera orden calcular cuantos clientes regresaron 1 mes despues, 2 meses despues, ..., n meses despues */
select	extract(year from primera_orden) as primer_anio,
		timestampdiff(month, a.primera_orden, b.fecha_orden) as periodo,
        count(distinct a.nombre_cliente) as clientes_retenidos
from
(	select		nombre_cliente,
				min(fecha_orden) as primera_orden
	from cohort.supertienda
	group by 1
) as a
inner join cohort.supertienda as b on a.nombre_cliente = b.Nombre_Cliente
group by 1,2;
/*
primer_anio	periodo	clientes_retenidos
2019	0	605
2019	1	51
2019	2	51
2019	3	51
2019	4	37
2019	5	68
...
*/

/* Usando la consulta anterior, calcular el porcentaje de retención respecto del periodo 0 */
select 	primer_anio,
		periodo, 
        clientes_retenidos,
        first_value(clientes_retenidos) over (partition by primer_anio order by periodo) as tamanio_cohorte,
        100 * clientes_retenidos / first_value(clientes_retenidos) over (partition by primer_anio order by periodo) as porcentaje_retencion
from
(
select	extract(year from primera_orden) as primer_anio,
		timestampdiff(month, a.primera_orden, b.fecha_orden) as periodo,
        count(distinct a.nombre_cliente) as clientes_retenidos
from
(	select		nombre_cliente,
				min(fecha_orden) as primera_orden
	from cohort.supertienda
	group by 1
) as a
inner join cohort.supertienda as b on a.nombre_cliente = b.Nombre_Cliente
group by 1,2
) as b;
/*
primer_anio	periodo	clientes_retenidos	tamanio_cohorte	porcentaje_retencion
2019	0	605	605	100.0000
2019	1	51	605	8.4298
2019	2	51	605	8.4298
2019	3	51	605	8.4298
2019	4	37	605	6.1157
...
*/

/* Generar una cohorte con la categoria de la primera compra de los clientes */

/* Obtener la categoria de la primera compra que hizo cada cliente */
select 	nombre_cliente,
		min(fecha_orden) as primera_orden,
        first_value(categoria) over (partition by nombre_cliente order by fecha_orden) as categoria_primera_compra
from 	cohort.supertienda
group by 1;
/*
nombre_cliente	primera_orden	categoria_primera_compra
Aaron Bergman	2019-02-18	Suministros de Oficina
Aaron Hawkins	2019-04-22	Suministros de Oficina
Aaron Smayling	2019-07-27	Suministros de Oficina
Adam Bellavance	2020-09-18	Suministros de Oficina
Adam Hart	2019-11-16	Suministros de Oficina
...
*/

/* Con la consulta anterior, agrupar por categoria_primera_compra y periodo de compra, y obtener el total de clientes retenidos */
select 	categoria_primera_compra,
		timestampdiff(month, a.primera_orden, b.fecha_orden) as periodo,
        count(distinct a.nombre_cliente) as clientes_retenidos
from
(
	select 	nombre_cliente,
			min(fecha_orden) as primera_orden,
			first_value(categoria) over (partition by nombre_cliente order by fecha_orden) as categoria_primera_compra
	from 	cohort.supertienda
	group by 1
) as a
inner join cohort.supertienda as b on a.nombre_cliente=b.nombre_cliente
group by 1,2;
/*
categoria_primera_compra	periodo	clientes_retenidos
Muebles	0	285
Muebles	1	23
Muebles	2	22
Muebles	3	25
Muebles	4	22
Muebles	5	27
...
*/

/* Con la consulta anterior obtener el porcentaj de retencion respecto del periodo 0 */
select 	categoria_primera_compra,
		periodo,
		clientes_retenidos,
        first_value(clientes_retenidos) over (partition by categoria_primera_compra order by periodo) as tamanio_cohorte,
        100 * clientes_retenidos / first_value(clientes_retenidos) over (partition by categoria_primera_compra order by periodo) as porcentaje_retencion
from
(
	select 	categoria_primera_compra,
			timestampdiff(month, a.primera_orden, b.fecha_orden) as periodo,
			count(distinct a.nombre_cliente) as clientes_retenidos
	from
	(
		select 	nombre_cliente,
				min(fecha_orden) as primera_orden,
				first_value(categoria) over (partition by nombre_cliente order by fecha_orden) as categoria_primera_compra
		from 	cohort.supertienda
		group by 1
	) as a
	inner join cohort.supertienda as b on a.nombre_cliente=b.nombre_cliente
	group by 1,2
) as c
group by 1,2;
/*
categoria_primera_compra	periodo	clientes_retenidos	tamanio_cohorte	porcentaje_retencion
Muebles	0	285	285	100.0000
Muebles	1	23	285	8.0702
Muebles	2	22	285	7.7193
Muebles	3	25	285	8.7719
Muebles	4	22	285	7.7193
...
*/

/* 4-6 Calculo en Fechas Diferentes */

