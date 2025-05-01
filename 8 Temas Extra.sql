/**************************************** TEMAS EXTRA ****************************************/

/* 8-1 Introduccion */

/* 8-2 Cuando usar SQL */

/* 8-3 Cuando usar ETL */

/* 8-4 Cuando usar otras herramientas */

/* 8.5 Comentar código */

/* 8.6 Estilo */

/* 8.7 Almacenamiento de código */

/* 8-8 Orden de Evaluacion */

/*
Se ejecutan en el siguiente orden:
-FROM (incluyendo JOINS en su clausula ON)
-WHERE
-GROUP BY
-HAVING
-WINDOW FUNCTION
-SELECT
-DISTINCT
-UNION
-ORDER BY
-LIMIT y OFFSET
*/

/* 8-9 Tablas Temporales */

/* 
Las tablas temporales son tablas que pueden ser creadas y existiran unicamente durante la sesión actual y se eliminaran automaticamente cuando la sesión finalice.
Para crear una tabla temporal se requiere permiso de escritura en la base de datos 
*/

/* Crear una tabla temporal */
CREATE TEMPORARY TABLE new_schema.T_ciudades
(
ciudad_id	INT PRIMARY KEY AUTO_INCREMENT,
ciudad		VARCHAR(25) 		
);

/* Consulta sobre la tabla temporal */
select *
from new_schema.T_ciudades;
/*
ciudad_id	ciudad

*/

/* Insertar filas a la tabla temporal */
INSERT INTO new_schema.T_ciudades(ciudad)
select 	distinct ciudad 
from 	cohort.supertienda;

/* Consulta sobre la tabla temporal */
select *
from new_schema.T_ciudades;
/*
ciudad_id	ciudad
ciudad_id	ciudad
1	Houston
2	Naperville
3	Philadelphia
4	Henderson
5	Athens
...
*/

/* Se puede crear y poblar la tabla temporal en una sola sentencia */
DROP TABLE new_schema.T_ciudades;

CREATE TEMPORARY TABLE new_schema.T_ciudades AS
SELECT distinct ciudad
FROM cohort.supertienda;

select *
from new_schema.T_ciudades;
/*
ciudad
Houston
Naperville
Philadelphia
Henderson
Athens
...
 */

/* 8-10 Expresiones de Tabla Comunes */

WITH cte_primer_compra as
(
SELECT 	nombre_cliente,
		min(fecha_orden) as primer_compra
from	cohort.supertienda
group by 1
)
SELECT 	timestampdiff(year,a.primer_compra,b.fecha_orden) as periodos,
		count(distinct(b.nombre_cliente)) as cohorte_retenida
from 	cte_primer_compra as a JOIN cohort.supertienda as b on a.nombre_cliente=b.nombre_cliente
group by 1;
/*
periodos	cohorte_retenida
0	800
1	619
2	588
3	403
*/

/* 8-11 Grouping Sets */

/* Usaremos la tabla supermarket_sales */
select *
from crearsetscomplejos.supermarket_sales;
/*
supermarket_sales_id	Invoice_ID	Branch	City	Customer_type	Gender	Product_line	Unit_price	Quantity	Tax_5%	Total	Date	Time	Payment	cogs	gross_margin_percentage	gross_income	Rating
1	750-67-8428	A	Yangon	Member	Female	Health and beauty	74.69	7	26.141500000000000000000000000000	548.971500000000000000000000000000	01/05/2019 12:00:00 a. m.	13:08:00	Ewallet	522.83	4.761904762000000000000000000000	26.141500000000000000000000000000	9.10
2	226-31-3081	C	Naypyitaw	Normal	Female	Electronic accessories	15.28	5	3.820000000000000000000000000000	80.220000000000000000000000000000	03/08/2019 12:00:00 a. m.	10:29:00	Cash	76.40	4.761904762000000000000000000000	3.820000000000000000000000000000	9.60
3	631-41-3108	A	Yangon	Normal	Male	Home and lifestyle	46.33	7	16.215500000000000000000000000000	340.525500000000000000000000000000	03/03/2019 12:00:00 a. m.	13:23:00	Credit card	324.31	4.761904762000000000000000000000	16.215500000000000000000000000000	7.40
4	123-19-1176	A	Yangon	Member	Male	Health and beauty	58.22	8	23.288000000000000000000000000000	489.048000000000000000000000000000	1/27/2019	20:33:00	Ewallet	465.76	4.761904762000000000000000000000	23.288000000000000000000000000000	8.40
5	373-73-7910	A	Yangon	Normal	Male	Sports and travel	86.31	7	30.208500000000000000000000000000	634.378500000000000000000000000000	02/08/2019 12:00:00 a. m.	10:37:00	Ewallet	604.17	4.761904762000000000000000000000	30.208500000000000000000000000000	5.30
...
*/

/* Obtener el total de ingreso por tipo de cliente */
select	customer_type,
		round(sum(total),2) as venta_total
from 	crearsetscomplejos.supermarket_sales
group by 1;
/*
customer_type	venta_total
Member	164223.44
Normal	158743.31
*/

/* Agregar a la tabla anterior los totales de todo */
select	customer_type,
		round(sum(total),2) as venta_total
from 	crearsetscomplejos.supermarket_sales
group by 1 WITH ROLLUP;
/*
customer_type	venta_total
Member	164223.44
Normal	158743.31
NULL	322966.75
*/

/* Es posible usar la sentencia WITH ROLLUP con multiples columnas de agrupamiento */
select	customer_type,
		gender,
		branch,
		round(sum(total),2) as venta_total
from 	crearsetscomplejos.supermarket_sales
group by 1,2,3 WITH ROLLUP
order by 1,2,3;
/*
customer_type	gender	branch	venta_total
NULL	NULL	NULL	322966.75
Member	NULL	NULL	164223.44
Member	Female	NULL	88146.94
Member	Female	A	26643.07
Member	Female	B	26850.43
Member	Female	C	34653.44
Member	Male	NULL	76076.50
Member	Male	A	26994.41
Member	Male	B	26854.25
Member	Male	C	22227.84
Normal	NULL	NULL	158743.31
Normal	Female	NULL	79735.98
Normal	Female	A	26626.10
Normal	Female	B	26077.86
Normal	Female	C	27032.02
Normal	Male	NULL	79007.32
Normal	Male	A	25936.80
Normal	Male	B	26415.12
Normal	Male	C	26655.41
*/

/* 8-12 Muestreo */

select mod(17786,100) as residuo;
/*
residuo
86
*/

/* Hacer una consulta para obtener solo el 1 porciento de los datos */
select 	storms_id,
		name
from 	anomalias.storms
where 	mod(storms_id,100)=86;

/* 8-13 Reduccion de Dimensionalidad */

/* Obtener una lista de paises que mas reseñas hacen sobre los parques de Disney */
select 	pais_origen,
		count(*) as reseñas
from analisistexto.disneyclean
group by 1
order by 2 desc;
/*
pais_origen	reseñas
US	14551
UK	9751
Australia	4679
Canada	2235
India	1511
...
Madagascar	1
Democratic Republic of the Congo	1
El Salvador	1
Sudan	1
Åland Islands	1
*/

/* Usando la consulta anterior, agregar una columna para rankear a los paises segun su numero de reseñas */
select 	pais_origen,
		count(*) as reseñas,
        rank() over (order by count(*) desc) as ranking
from analisistexto.disneyclean
group by 1
order by 2 desc;
/*
pais_origen	reseñas	ranking
US	14551	1
UK	9751	2
Australia	4679	3
Canada	2235	4
India	1511	5
...
Madagascar	1	142
Democratic Republic of the Congo	1	142
El Salvador	1	142
Sudan	1	142
Åland Islands	1	142
*/

/* Usando la consulta anterior obtener los 5 primero paises con mas reseñas y los demas agruparlos en una categoria llamada "otros" */
select 	pais,
		sum(reseñas) as suma_reseñas
from 
(
select 	pais_origen,
		count(*) as reseñas,
        rank() over (order by count(*) desc) as ranking,
        case
			when rank() over (order by count(*) desc) <= 5 then pais_origen
            else "Otros"
        end as pais
from analisistexto.disneyclean
group by 1
order by 2 desc
) as z
group by 1;
/*
pais	suma_reseñas
US	14551
UK	9751
Australia	4679
Canada	2235
India	1511
Otros	9929
*/

/* 8-14 Datos Personales */

/* De la tala supertienda obtener el total de venta por cada cliente pero omitir los datos personales del cliente */
select 	row_number() over (order by nombre_cliente) as cliente,
		venta_total
from
(
select 	nombre_cliente,
		round(sum(ventas),2) as venta_total
from cohort.supertienda
group by 1
order by 1
) as z;
/*
cliente	venta_total
1	886.16
2	1744.70
3	3050.69
4	7755.62
5	3250.34
...
*/

/* En MySQL, la función MD5() calcula un hash MD5 de una cadena de texto dada. Este hash es una representación hexadecimal de 32 caracteres 
de la cadena original, y se utiliza comúnmente para verificar la integridad de datos o como una forma de almacenar contraseñas de forma 
segura (aunque no es la forma más segura actualmente). */
select 	md5(nombre_cliente) as cliente,
		venta_total
from
(
select 	nombre_cliente,
		round(sum(ventas),2) as venta_total
from cohort.supertienda
group by 1
order by 1
) as z;
/*
cliente	venta_total
84135027c3b09a39768e68882bb864fd	886.16
ab04f568883700c4a24aa97febe38d5c	1744.70
cec74cb692da20f0d53fcbdc9e662308	3050.69
437a7a444eef025fd2ff983eaa781fb8	7755.62
76fd68b1b36f27b8aaf5d27946ebb486	3250.34
*/

