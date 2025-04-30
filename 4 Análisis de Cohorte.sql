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
Análisis de retorno: Si una acción ha sucedido más de n veces en un periodo de tiempo dado. Por ejemplo, cuantas veces nos compra un cliente en un periodo de tiempo.
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

/* En el capitulo anterior se vio el caso de una cohorte definida por la fecha de compra del primer producto. 
Ahora se definirá la cohorte a partir de una fecha fija que sea de interés para un estudio */

/* Vista previa de la tabla legisladoresusa */
select 	*
from cohort.legisladoresusa 
limit 5;
/*
legisladoresusa_id	IDLegislador	DipSen	InicioPeriodo	FinPeriodo	Estado
1	B000944	rep	1993-01-05 00:00:00	1995-01-03 00:00:00	OH
2	C000127	rep	1993-01-05 00:00:00	1995-01-03 00:00:00	WA
3	C000141	rep	1987-01-06 00:00:00	1989-01-03 00:00:00	MD
4	C000174	rep	1983-01-03 00:00:00	1985-01-03 00:00:00	DE
5	C001070	sen	2007-01-04 00:00:00	2013-01-03 00:00:00	PA
...
*/

/* Obtener los diputados o senadores que estuvieron activos en algún momento del año 2000 */
select 	IDLegislador,
		DipSen,
		date("2000-01-01") as inicio_cohorte,
        min(InicioPeriodo) as inicio_periodo
from 	cohort.legisladoresusa
where 	InicioPeriodo<="2000-12-31" and FinPeriodo>="2000-01-01"
group by 1,2,3;
/*
IDLegislador	DipSen	inicio_cohorte	inicio_periodo
C001035	sen	2000-01-01	1997-01-07 00:00:00
E000285	sen	2000-01-01	1997-01-07 00:00:00
U000039	rep	2000-01-01	1999-01-06 00:00:00
B001230	rep	2000-01-01	1999-01-06 00:00:00
L000557	rep	2000-01-01	1999-01-06 00:00:00
...
*/

/* Agregar los datos de la consulta anterior a la tabla legisladoresusa */
SELECT 	*
FROM
(
	select IDLegislador,
			DipSen,
			date("2000-01-01") as inicio_cohorte,
			min(InicioPeriodo) as inicio_periodo
	from 	cohort.legisladoresusa
	where 	InicioPeriodo<="2000-12-31" and FinPeriodo>="2000-01-01"
	group by 1,2,3
) as a
inner join cohort.legisladoresusa as b on a.IDLegislador=b.IDLegislador 
	and b.InicioPeriodo >= a.inicio_periodo;
/*
IDLegislador	DipSen	inicio_cohorte	inicio_periodo	legisladoresusa_id	IDLegislador	DipSen	InicioPeriodo	FinPeriodo	Estado
C001035	sen	2000-01-01	1997-01-07 00:00:00	18	C001035	sen	1997-01-07 00:00:00	2003-01-03 00:00:00	ME
E000285	sen	2000-01-01	1997-01-07 00:00:00	22	E000285	sen	1997-01-07 00:00:00	2003-01-03 00:00:00	WY
U000039	rep	2000-01-01	1999-01-06 00:00:00	32	U000039	rep	1999-01-06 00:00:00	2001-01-03 00:00:00	NM
B001230	rep	2000-01-01	1999-01-06 00:00:00	40	B001230	rep	1999-01-06 00:00:00	2001-01-03 00:00:00	WI
L000557	rep	2000-01-01	1999-01-06 00:00:00	153	L000557	rep	1999-01-06 00:00:00	2001-01-03 00:00:00	CT
...
*/



/* Con la consulta anterior rellenar las fechas intermedias entre inicio periodo y fin periodo usando la tabla auxiliar "tablafechas" */
SELECT 	*,
		timestampdiff(year,a.inicio_cohorte,c.fecha) as periodo
FROM
(
	select IDLegislador,
			DipSen,
			date("2000-01-01") as inicio_cohorte,
			min(InicioPeriodo) as inicio_periodo
	from 	cohort.legisladoresusa
	where 	InicioPeriodo<="2000-12-31" and FinPeriodo>="2000-01-01"
	group by 1,2,3
) as a
inner join cohort.legisladoresusa as b on a.IDLegislador=b.IDLegislador and b.InicioPeriodo >= a.inicio_periodo
left join cohort.tablafechas as c on c.fecha between b.InicioPeriodo and b.FinPeriodo and c.year >= 2000   /*Crear una fila para cada fecha en la tabla fechas si la fecha esta entre el inicio_periodo y fin_periodo del legislador, conservar solo del 2000 en adelante.*/
where timestampdiff(year,a.inicio_cohorte,c.fecha) IS NOT NULL;
/*
IDLegislador	DipSen	inicio_cohorte	inicio_periodo	legisladoresusa_id	IDLegislador	DipSen	InicioPeriodo	FinPeriodo	Estado	Year	Mes	Dia	Dias_en_Year	Fecha
C001035	sen	2000-01-01	1997-01-07 00:00:00	18	C001035	sen	1997-01-07 00:00:00	2003-01-03 00:00:00	ME	2000	12	31	366	2000-12-31
C001035	sen	2000-01-01	1997-01-07 00:00:00	18	C001035	sen	1997-01-07 00:00:00	2003-01-03 00:00:00	ME	2001	12	31	365	2001-12-31
C001035	sen	2000-01-01	1997-01-07 00:00:00	18	C001035	sen	1997-01-07 00:00:00	2003-01-03 00:00:00	ME	2002	12	31	365	2002-12-31
E000285	sen	2000-01-01	1997-01-07 00:00:00	22	E000285	sen	1997-01-07 00:00:00	2003-01-03 00:00:00	WY	2000	12	31	366	2000-12-31
E000285	sen	2000-01-01	1997-01-07 00:00:00	22	E000285	sen	1997-01-07 00:00:00	2003-01-03 00:00:00	WY	2001	12	31	365	2001-12-31
...
*/


/* Con la consulta anterior calcular el periodo en años a partir del año 2000 y el numero de legisladores en cada periodo */
select 	a.dipsen,
		timestampdiff(year,a.inicio_cohorte,c.fecha) as periodo,
        count(distinct a.IDLegislador) as cohorte_retenida
from
(
	select IDLegislador,
			DipSen,
			date("2000-01-01") as inicio_cohorte,
			min(InicioPeriodo) as inicio_periodo
	from 	cohort.legisladoresusa
	where 	InicioPeriodo<="2000-12-31" and FinPeriodo>="2000-01-01"
	group by 1,2,3
) as a
inner join cohort.legisladoresusa as b on a.IDLegislador=b.IDLegislador and b.InicioPeriodo >= a.inicio_periodo
left join cohort.tablafechas as c on c.fecha between b.InicioPeriodo and b.FinPeriodo and c.year >= 2000
where timestampdiff(year,a.inicio_cohorte,c.fecha) IS NOT NULL
group by 1,2;
/*
dipsen	periodo	cohorte_retenida
rep	0	439
rep	1	392
rep	2	389
rep	3	340
rep	4	338
rep	5	308
...
*/



/* Con la consulta anterior calcular el porcentaje respecto del año de inicio de la cohorte */
select 	dipsen,
		periodo,
        cohorte_retenida,
        first_value(cohorte_retenida) over (partition by dipsen order by periodo) as cohorte_inicial,
        100 * cohorte_retenida / first_value(cohorte_retenida) over (partition by dipsen order by periodo) as porcentaje_retencion
from
(
		select 	a.dipsen,
				coalesce(timestampdiff(year,a.inicio_cohorte,c.fecha),0) as periodo,
				count(distinct a.IDLegislador) as cohorte_retenida
		from
		(
			select IDLegislador,
					DipSen,
					date("2000-01-01") as inicio_cohorte,
					min(InicioPeriodo) as inicio_periodo
			from 	cohort.legisladoresusa
			where 	InicioPeriodo<="2000-12-31" and FinPeriodo>="2000-01-01"
			group by 1,2,3
		) as a
		inner join cohort.legisladoresusa as b on a.IDLegislador=b.IDLegislador and b.InicioPeriodo >= a.inicio_periodo
		left join cohort.tablafechas as c on c.fecha between b.InicioPeriodo and b.FinPeriodo and c.year >= 2000
		group by 1,2
) as b;
/*
dipsen	periodo	cohorte_retenida	cohorte_inicial	porcentaje_retencion
rep	0	440	440	100.0000
rep	1	392	440	89.0909
rep	2	389	440	88.4091
rep	3	340	440	77.2727
rep	4	338	440	76.8182
rep	5	308	440	70.0000
...
*/


/* 4-7 Analisis de Supervivencia */

/* Por legislador, obtener el siglo en que inicio su periodo, la fecha de inicio de su primer periodo, la fecha de inicio de su ultimo periodo y años de permanencia */
SELECT 	idlegislador,
		FLOOR((year(min(inicioperiodo))+99)/100) as siglo,
		min(inicioperiodo) as primer_periodo,
		max(inicioperiodo) as ultimo_periodo,
        timestampdiff(year,min(inicioperiodo),max(inicioperiodo)) as permanencia
FROM	cohort.legisladoresusa
GROUP BY 1
ORDER BY permanencia;
/*
idlegislador	siglo	primer_periodo	ultimo_periodo	permanencia
H000293	20	1945-02-15 00:00:00	1945-02-15 00:00:00	0
H000426	20	1945-01-03 00:00:00	1945-01-03 00:00:00	0
H000515	20	1945-01-03 00:00:00	1945-01-03 00:00:00	0
H000682	20	1945-01-03 00:00:00	1945-01-03 00:00:00	0
H000913	20	1945-10-08 00:00:00	1945-10-08 00:00:00	0
...
*/


/* Con la consulta anterior, agrupar por siglo y obtener el numero y porcentaje de legisladores que estuvieron 10 o más años */
SELECT 	siglo,
		COUNT(distinct idlegislador) AS cohorte_inicial,
        COUNT(distinct case when permanencia>=10 then idlegislador end) AS mas_de_10_anios,
        COUNT(distinct case when permanencia>=10 then idlegislador end) / COUNT(distinct idlegislador) AS porcentaje
FROM
(
		SELECT 	idlegislador,
				FLOOR((year(min(inicioperiodo))+99)/100) as siglo,
				min(inicioperiodo) as primer_periodo,
				max(inicioperiodo) as ultimo_periodo,
				timestampdiff(year,min(inicioperiodo),max(inicioperiodo)) as permanencia
		FROM	cohort.legisladoresusa
		GROUP BY 1
		ORDER BY permanencia
) AS A
GROUP BY 1;
/*
siglo	cohorte_inicial	mas_de_10_anios	porcentaje
18	368	83	0.2255
19	6299	892	0.1416
20	5091	1853	0.3640
21	760	119	0.1566
...
*/

/* Analisis de retorno de clientes */

/* Desglosado por año, obtener cuantos de mis clientes hicieron su primera compra en articulos de oficina */
SELECT 	YEAR(primer_orden) as cohort_anual,
		count(distinct nombre_cliente) as oficina
FROM
(
	SELECT 	nombre_cliente,
			min(fecha_orden) as primer_orden
	FROM 	cohort.supertienda
	where 	categoria = "Suministros de oficina"
	group by 1
) as A
GROUP BY 1;
/*
cohort_anual	oficina
2019	518
2020	169
2021	83
2022	23
...
*/

/* Con la consulta anterior, obtener desglosado por año, el numero de clientes cuya primera compra fue en articulos de oficina y posteriormente vuelven para comprar articulos de tecnologia */
SELECT 	year(a.primer_orden) as anio_cohorte,
		count(distinct b.nombre_cliente) as oficina_tecnologia
FROM
(
	SELECT 	nombre_cliente,
			min(fecha_orden) as primer_orden
	FROM 	cohort.supertienda
	where 	categoria = "Suministros de oficina"
	group by 1
) as a
INNER JOIN cohort.supertienda as b on a.nombre_cliente = b.nombre_cliente
WHERE b.Categoria="Tecnología" AND b.Fecha_Orden > a.primer_orden
GROUP BY 1;
/*
year(a.primer_orden)	oficina_tecnologia
2019	424
2020	128
2021	53
2022	8
*/

/* Con la consulta anterior obtener el porcentaje de clientes que compraron primero articulos de oficina y regresan en un tiempo futuro por articulos de tecnologia */
SELECT 	AA.anio_cohorte,
		AA.oficina,
		BB.oficina_tecnologia,
        BB.oficina_tecnologia / AA.oficina AS porcentaje
		
FROM
	(SELECT 	year(a.primer_orden) as anio_cohorte,
			count(distinct a.nombre_cliente) as oficina
	FROM
	(
		SELECT 	nombre_cliente,
				min(fecha_orden) as primer_orden
		FROM 	cohort.supertienda
		where 	categoria = "Suministros de oficina"
		group by 1
	) as a
	GROUP BY 1
) AS AA
LEFT JOIN
(
	SELECT 	year(a.primer_orden) as anio_cohorte,
			count(distinct b.nombre_cliente) as oficina_tecnologia
	FROM
	(
		SELECT 	nombre_cliente,
				min(fecha_orden) as primer_orden
		FROM 	cohort.supertienda
		where 	categoria = "Suministros de oficina"
		group by 1
) as a
INNER JOIN cohort.supertienda as b on a.nombre_cliente = b.nombre_cliente
WHERE b.Categoria="Tecnología" AND b.Fecha_Orden > a.primer_orden
GROUP BY 1
) AS BB 
ON AA.anio_cohorte = BB.anio_cohorte;
/*
anio_cohorte	oficina	oficina_tecnologia	porcentaje
2019	518	424	0.8185
2020	169	128	0.7574
2021	83	53	0.6386
2022	23	8	0.3478
*/

/* En los ejemplos anteriores solo se pidio que el cliente regresara pero no se especifica en cuantos periodos deberia de regresar */

/* Con la consulta anterior obtener el porcentaje de clientes que compraron primero articulos de oficina y en 12 meses o menos regresan por articulos de tecnologia */
SELECT 	AA.anio_cohorte,
		AA.oficina,
		BB.oficina_tecnologia,
        BB.oficina_tecnologia / AA.oficina AS porcentaje
		
FROM
(
	SELECT 	year(a.primer_orden) as anio_cohorte,
			count(distinct a.nombre_cliente) as oficina
	FROM
	(
		SELECT 	nombre_cliente,
				min(fecha_orden) as primer_orden
		FROM 	cohort.supertienda
		where 	categoria = "Suministros de oficina"
		group by 1
	) as a
	GROUP BY 1
) AS AA
LEFT JOIN
(
	SELECT 	year(a.primer_orden) as anio_cohorte,
			count(distinct b.nombre_cliente) as oficina_tecnologia
	FROM
	(
		SELECT 	nombre_cliente,
				min(fecha_orden) as primer_orden
		FROM 	cohort.supertienda
		where 	categoria = "Suministros de oficina"
		group by 1
	) as a
	INNER JOIN cohort.supertienda as b on a.nombre_cliente = b.nombre_cliente
	WHERE b.Categoria="Tecnología" AND b.Fecha_Orden > a.primer_orden AND timestampdiff(MONTH,a.primer_orden,b.fecha_orden) <= 12
	GROUP BY 1
) AS BB 
ON AA.anio_cohorte = BB.anio_cohorte;
/*
anio_cohorte	oficina	oficina_tecnologia	porcentaje
2019	518	166	0.3205
2020	169	69	0.4083
2021	83	40	0.4819
2022	23	8	0.3478
*/


/* Calculos Acumulados */

/* Desglosado por cliente, obtener la categoria de su primera orden, fecha de su primera orden y obtener la fecha 10 meses despues de su primera orden */
select 	distinct nombre_cliente,
		first_value(categoria) over (partition by nombre_cliente order by fecha_orden asc) as primera_categoria,
        min(fecha_orden) over (partition by nombre_cliente) as primera_orden,
        min(fecha_orden) over (partition by nombre_cliente) + interval 10 month as primeros_10_meses
from 	cohort.supertienda;
/*
nombre_cliente	primera_categoria	primera_orden	primeros_10_meses
Aaron Bergman	Suministros de Oficina	2019-02-18	2019-12-18
Aaron Hawkins	Suministros de Oficina	2019-04-22	2020-02-22
Aaron Smayling	Suministros de Oficina	2019-07-27	2020-05-27
Adam Bellavance	Suministros de Oficina	2020-09-18	2021-07-18
Adam Hart	Suministros de Oficina	2019-11-16	2020-09-16
...
*/

/* Desglosado por año y primera categoria de compra, calcular el numero de compradores inicial, el numero de ordenes, las ordenes promedio por cliente, la suma de ventas y venta promedio */
select 	extract(year from a.primera_orden) as anio,
		primera_categoria,
        count(distinct a.nombre_cliente) as poblacion_inicial,
        count(b.fecha_orden) as ordenes,
        count(b.fecha_orden) / count(distinct a.nombre_cliente) as ordenes_por_cliente,
        round(sum(b.ventas),2) as ventas_acumuladas,
        round(sum(b.ventas) / count(distinct a.nombre_cliente),2) as venta_promedio
from
(
	select 	distinct nombre_cliente,
			first_value(categoria) over (partition by nombre_cliente order by fecha_orden asc) as primera_categoria,
			min(fecha_orden) over (partition by nombre_cliente) as primera_orden,
			min(fecha_orden) over (partition by nombre_cliente) + interval 10 month as primeros_10_meses
	from 	cohort.supertienda
) as a
LEFT JOIN cohort.supertienda as b on a.nombre_cliente = b.nombre_cliente 
AND b.fecha_orden between a.primera_orden and a.primeros_10_meses
group by 1,2;
/*
anio	primera_categoria	poblacion_inicial	ordenes	ordenes_por_cliente	ventas_acumuladas	venta_promedio
2019	Muebles	216	1013	4.6898	309671.54	1433.66
2019	Suministros de Oficina	339	1253	3.6962	216083.06	637.41
2019	Tecnología	50	171	3.4200	44316.91	886.34
2020	Muebles	38	212	5.5789	47505.20	1250.14
2020	Suministros de Oficina	79	287	3.6329	57412.51	726.74
...
*/


/* 4-10 Analisis Transversal mediante Cohorte */

/* Obtener el numero de legisladores por año */
select 	b.fecha,
		count(distinct a.idlegislador) as legisladores
from cohort.legisladoresusa as a
inner join cohort.tablafechas as b on b.Fecha between a.InicioPeriodo and a.FinPeriodo
group by 1;
/*
fecha	legisladores
1789-12-31	89
1790-12-31	95
1791-12-31	99
1792-12-31	101
1793-12-31	141
1794-12-31	140
...
*/

/* Obtener el id del legislador y la fecha de su primer periodo y siglo de su primer periodo */
select 	IDLegislador,
		min(InicioPeriodo) as primer_periodo,
        floor((year(min(InicioPeriodo))+99)/100) as siglo_primer_periodo
from cohort.legisladoresusa
group by 1;
/*
IDLegislador	primer_periodo	siglo_primer_periodo
B000944	1993-01-05 00:00:00	1993
C000127	1993-01-05 00:00:00	1993
C000141	1987-01-06 00:00:00	1987
C000174	1983-01-03 00:00:00	1983
C001070	2007-01-04 00:00:00	2007
...
*/

/* Usar las 2 consultas anteriores para obtener el numero de legisladores por siglo de su primer periodo y por cada fecha de la tabla fechas*/
select 	siglo_primer_periodo,
		b.fecha,
        count(distinct a.IDLegislador) as legisladores
from cohort.legisladoresusa as a
inner join cohort.tablafechas as b on b.Fecha between a.InicioPeriodo and a.FinPeriodo
inner join 
(
	select 	IDLegislador,
			min(InicioPeriodo) as primer_periodo,
			floor((year(min(InicioPeriodo))+99)/100) as siglo_primer_periodo
	from cohort.legisladoresusa
	group by 1
) as c on c.idlegislador = a.idlegislador
group by 1,2;
/*
siglo_primer_periodo	fecha	legisladores
18	1789-12-31	89
18	1790-12-31	95
18	1791-12-31	99
18	1792-12-31	101
18	1793-12-31	141
18	1794-12-31	140
...
*/

/* Obtener deglosado por fecha y siglo del primer periodo, el numero parcial de legisladores por inicio de su primer periodo, el total de legisladores de ese año y el porcentaje de cada siglo */
select 	fecha,
		siglo_primer_periodo,
        legisladores as poblacion_parcial,
        sum(legisladores) over (partition by fecha) as poblacion_total,
		legisladores / sum(legisladores) over (partition by fecha) as porcentaje
from
(
select 	siglo_primer_periodo,
		b.fecha,
        count(distinct a.IDLegislador) as legisladores
from cohort.legisladoresusa as a
inner join cohort.tablafechas as b on b.Fecha between a.InicioPeriodo and a.FinPeriodo
inner join 
(
	select 	IDLegislador,
			min(InicioPeriodo) as primer_periodo,
			floor((year(min(InicioPeriodo))+99)/100) as siglo_primer_periodo
	from cohort.legisladoresusa
	group by 1
) as c on c.idlegislador = a.idlegislador
group by 1,2
) as d;
/*
fecha	siglo_primer_periodo	poblacion_parcial	poblacion_total	porcentaje
1789-12-31	18	89	89	1.0000
1790-12-31	18	95	95	1.0000
1791-12-31	18	99	99	1.0000
1792-12-31	18	101	101	1.0000
1793-12-31	18	141	141	1.0000
1794-12-31	18	140	140	1.0000
1795-12-31	18	145	145	1.0000
1796-12-31	18	150	150	1.0000
1797-12-31	18	152	152	1.0000
1798-12-31	18	155	155	1.0000
1799-12-31	18	148	148	1.0000
1800-12-31	18	151	151	1.0000
1801-12-31	18	97	154	0.6299
1801-12-31	19	57	154	0.3701
1802-12-31	18	92	151	0.6093
1802-12-31	19	59	151	0.3907
1803-12-31	18	68	184	0.3696
1803-12-31	19	116	184	0.6304
1804-12-31	18	71	188	0.3777
1804-12-31	19	117	188	0.6223
1805-12-31	18	54	188	0.2872
1805-12-31	19	134	188	0.7128
...
*/

/* Este desglose se puede realizar para cualquier categoría */

