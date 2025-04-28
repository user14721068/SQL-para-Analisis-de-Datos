/**************************************** ANALISIS DE EXPERIMENTOS ****************************************/

/* 7-1 Introduccion */

/* AB Testing: El AB Testing (o prueba A/B) es una técnica estadística muy utilizada en marketing, desarrollo web, ciencia de datos y 
otras áreas para comparar dos versiones de algo (como una página web, un anuncio o una funcionalidad) y determinar cuál funciona mejor. 
Conceptos básicos del AB Testing
Objetivo:
Comparar dos grupos (A y B) para ver si hay diferencias significativas en una métrica clave (ej.: tasa de conversión, clics, ventas).
Ejemplo:
Versión A (actual): Botón verde en un sitio web.
Versión B (nueva): Botón rojo.
Métrica a comparar: % de usuarios que hacen clic.
Hipótesis:
Hipótesis nula (H₀): No hay diferencia entre A y B.
Hipótesis alternativa (H₁): Hay una diferencia significativa.
Métricas comunes:
Tasa de conversión, retención, tiempo en página, ingresos por usuario, etc.
*/

/* 7-2 Por que si y por que no usar SQL */

/* SQL se usa para extraer los datos y manipularlos, para análisis estadístico se requiere software como Python, R, o Excel */

/*   7-3 Correlacion vs Causalidad */

/* El principio "correlación no implica causalidad" es uno de los conceptos más importantes en estadística y ciencia de datos. 
Significa que aunque dos variables parezcan estar relacionadas (es decir, cambian juntas), no necesariamente una causa la otra. 
3 Razones por las que correlación ≠ causalidad
-Variables confusoras (tercer factor):
	Una tercera variable influye en ambas.
	Ejemplo:
	Correlación entre ventas de sombrillas y tormentas.
	La variable confusora es la lluvia (aumenta ambas).
-Causalidad inversa:
	La dirección de la relación es al revés de lo que se asume.
	Ejemplo:
	Correlación entre "más policías" y "más crímenes".
	En realidad, las ciudades con más crimen contratan más policías.
-Pura coincidencia (correlación espuria):
	La relación es aleatoria y no tiene lógica.
	Ejemplo:
	Correlación entre el número de piratas y el calentamiento global.
Para probar que A causa B, se necesitan:
-Experimentos controlados:
	Como los A/B tests, donde se aísla la variable de interés (ej.: cambiar solo el color de un botón).
-Métodos estadísticos avanzados:
	Modelos de regresión con variables instrumentales.
	Análisis de series temporales (para descartar tendencias).
-Teoría sólida:
	Un mecanismo lógico que explique por qué A debería causar B.
*/

/* 7-4 Experimentos Binarios */

/* Experimento binario: Buscamos ver si se realizó o no una acción de interés. Ejemplo: Los clientes dan click o no dan click en una página web.
   Experimento contínuo: Estudiar una variable cuantitativa. Por ejemplo, cuanto dinero gastó un cliente en mi sitio web.
   Como herramientas estadísticas se usará la prueba ji-cuadrada y la prueba t de student
   */

/* Trabajaremos con datos de una página web */
select * 
from experimentos.paginaweb;
/*
user_id	variant	views	clicks	purchased_items	experiment_date	lastpurch_date	country
1	control	12	0	4	2020-01-01	2020-01-10	Argentina
2	control	3	1	3	2020-01-01	2020-01-31	Chile
3	control	12	0	2	2020-01-01	2020-01-18	México
4	control	2	0	3	2020-01-01	2020-01-18	Perú
5	control	4	0	4	2020-01-01	2020-01-26	México
...
*/

/* Agrupar por variable variant y obtener cuantos registros tienen click y cuantos no */
select 	variant,
		count(case when clicks=1 then 1 end) as si_click,
        count(case when clicks=0 then 1 end) as no_click
from experimentos.paginaweb
group by 1;
/*
variant	si_click	no_click
control	32628	32372
test	32593	32407
*/

/* Agrupando por la variable variant obtener el total de usuario, el total de clicks y el porcentaje de clicks */
select 	variant,
		count(*) as intentos_totales,
        count(case when clicks=1 then 1 end) as num_exitos,
        count(case when clicks=1 then 1 end)/count(*) as porcentaje_exitos
from experimentos.paginaweb
group by 1;
/*
variant	intentos_totales	num_exitos	porcentaje_exitos
control	65000	32628	0.5020
test	65000	32593	0.5014
*/

/* Utilizando un software estadístico se puede realizar la prueba de hipotesis H0:La tasa de exito difiere entre ambos grupos vs H0:La tasa de exito no difiere */
/* Con una confianza del 95% se rechaza H0 */


/* 7-5 Experimentos Continuos */

/* Queremos comproar si los valores promedio del experimento en el grupo de control y en el grupo con el "tratamiento" son significativamente diferentes 
   La prueba que usaremos es la T de Student
*/

/* Obtener por cada grupo el numero de intentos totales, el promedio de visitas y la desviación estandar */
select 	variant,
		count(*) as tamaño_muestra,
		avg(views) as promedio,
        round(std(views),2) as desviacion_std
from experimentos.paginaweb
group by 1;
/*
variant	tamaño_muestra	promedio	desviacion_std
control	65000	4.9802	5.83
test	65000	5.0366	6.35
*/

/* Utilizando un software estadístico se puede realizar la prueba de hipotesis H0:el valor promedio entre ambos grupos es distinto vs H0:el valor promedio de mabos grupos no difiere */
/* Con una confianza del 95% se rechaza H0 */

/* 7-6 MAnejando valores sobresalientes */

/* 
Windsorizing: El proceso de reemplazar un número específico de valores extremos por valores más pequeños. 
Binarizar: Tranformar la métrica de contínua a binaria.
*/

/* Agrupar por tipo de grupo, calcular cuantos usuarios hubo, cuantos clientes compraron, cuantos clientes no compraron */
select 	variant,
		count(distinct(user_id)) as usuarios_totales,
		count(case when purchased_items > 0 then 1 end) as si_compro,
		count(case when purchased_items = 0 then 1 end) as no_compro,
        count(case when purchased_items > 0 then 1 end) / count(distinct(user_id)) as porcentaje_compra
from experimentos.paginaweb
group by 1;
/*
variant	usuarios_totales	si_compro	no_compro	porcentaje_compra
control	65000	56934	8066	0.8759
test	65000	56817	8183	0.8741
*/

/* Utilizando un software estadístico se puede realizar la prueba de hipotesis H0:El porcentaje de compras difiere entre ambos grupos vs H0:No difiere */
/* Con una confianza del 95% se rechaza H0 */


/* 7-7 Cajas de Tiempo */

/* 
Obtener la diferencia entre la fecha de observacion y fecha de ultima compra, el grupo, el usuario, el numero de articulos comprados, solo para
aquellos registros donde la fecha de observacion y la fecha de ultima compra difieran a lo mas 15 días 
*/
select 	timestampdiff(day,experiment_date,lastpurch_date) as diferencia_dias,
		variant,
		user_id,
        purchased_items
from 	experimentos.paginaweb
where 	timestampdiff(day,experiment_date,lastpurch_date) <= 15;
/*
diferencia_dias	variant	user_id	purchased_items
9	control	1	4
15	control	6	1
0	control	8	1
7	control	12	1
3	control	13	2
...
*/

/* Usando la consulta anterior obtener por tipo de grupo (control y tratamiento) el total de observaciones, el promedio de articulos comprados y
la desviacion estandar del numero de articulos comprados. Usar la prueba t de student para probar la hipotesis de que la media
de los articulos comprados difiere entre ambos grupos. 
*/
select 	variant, 
		count(user_id) as num_observaciones,
		avg(purchased_items) as prom_articulos,
        round(std(purchased_items),2) as desv_est_articulos
from
(
select 	timestampdiff(day,experiment_date,lastpurch_date) as diferencia_dias,
		variant,
		user_id,
        purchased_items
from 	experimentos.paginaweb
where 	timestampdiff(day,experiment_date,lastpurch_date) <= 15
) as a
group by 1;
/*
variant	num_observaciones	prom_articulos	desv_est_articulos
control	33566	3.4945	2.29
test	33514	3.4970	2.30
*/

/* Utilizando un software estadístico se puede realizar la prueba de hipotesis H0:el numero de items promedio entre ambos grupos es distinto 
vs H0:no es distinto. Conclusión: con una confianza del 95% se rechaza H0 */

/* 7-8 Pre-Post */

/*
Análisis Pre-Post: Compara a la misma población antes y después de un cambio
*/

/* Realizar un analisis del comportamiento de las compras en la pagina web 5 días antes y 5 días después de día de reyes. Usar una prueba estadistica para
probar la hipotesis de que la proporcion de compras es la misma en ambos grupos. */
select 	case
			when experiment_date >= "2020-01-01" and experiment_date <= "2020-01-05" then "pre"
            when experiment_date >= "2020-01-06" and experiment_date <= "2020-01-10" then "post"
		end as grupo,
        count(user_id) as num_usuario,
        count(case when purchased_items > 0 then 1 end) as compras,
        count(case when purchased_items > 0 then 1 end) / count(user_id) as pct_compras
from 	experimentos.paginaweb
where 	experiment_date >= "2020-01-01" and experiment_date <= "2020-01-10"
group by 1;
/*
grupo	num_usuario	compras	pct_compras
pre	13560	11894	0.8771
post	32428	28363	0.8746
*/

/* Utilizando un software estadístico se puede realizar la prueba de hipotesis H0:El porcentaje de compras difiere entre ambos grupos vs H0:No difiere */
/* Con una confianza del 95% se rechaza H0 */

/* 7-9-Analisis Experimento Natural */

/* Experimento natural: Generalmente por razones no intencionales 2 poblaciones son separadas y se observa el comportamiento de ciertas variables en ambas poblaciones. */

/* Comparar las ventas en Chile y Argentina y usar una prueba estadistica para probar la hipotesis de que el porcentaje de compras es distinto en ambos grupos */

select 	country,
		count(user_id) as usuarios,
        count(case when purchased_items > 0 then 1 end) as compras,
		count(case when purchased_items > 0 then 1 end) / count(user_id) as pct_compras
from experimentos.paginaweb
where country in ("Chile","Argentina")
group by 1;
/*
country	usuarios	compras	pct_compras
Argentina	22873	22866	0.9997
Chile	26804	22802	0.8507
*/

/* Utilizando un software estadístico se puede realizar la prueba de hipotesis H0:El porcentaje de compras difiere entre ambos grupos vs H0:No difiere */
/* Con una confianza del 95% no se rechaza H0 */


