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



