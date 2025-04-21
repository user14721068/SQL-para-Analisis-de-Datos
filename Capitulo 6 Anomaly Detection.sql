/**************************************** DETECCION DE ANOMALIAS ****************************************/

/* 6-1 Introduccion */

/* 6-2 Cuando usar SQL */

/* 
Cuando sí usar SQL: Cuando los datos estan ya en una base de datos y no se requiere un analisis estadistico profundo. 
Cuando no usar SQL: SQL no puede implementar analisis estadistico o de aprendizaje de maquina. Deteccion de anomalias en tiempo real.
*/

/* 6-3 Detectar Anomalias por Ordenamiento */

/* Este capitulo se usaran los datos de registros de tormentas  */
select *
from anomalias.storms;
/*
storms_id,name,year,month,day,hour,lat,long,status,category,wind,pressure,tropicalstorm_force_diameter,hurricane_force_diameter,location
1,AL011852,1852,8,26,6,30.20,-88.60,hurricane,3,100,961,NA,NA,"Central of USA"
2,AL031853,1853,9,3,12,19.70,-56.20,hurricane,4,130,924,NA,NA,"Near the east coast of Costa Rica"
3,AL031854,1854,9,7,12,28.00,-78.60,hurricane,3,110,938,NA,NA,"Central of Costa Rica"
4,AL031854,1854,9,8,18,31.60,-81.10,hurricane,3,100,950,NA,NA,"Southern of Cuba"
5,AL031854,1854,9,8,20,31.70,-81.10,hurricane,3,100,950,NA,NA,"Near the east coast of Japón"
...
*/

/* Obtener por categoria del evento, cuantos eventos (tormenta, huracan o depresion) se han presentado */
select 	category as categoria,
		count(*) as tormentas
from anomalias.storms
group by 1
order by 2;
/*
categoria	tormentas
5	134
4	684
3	855
2	1346
1	3233
-1	3799
0	7735
*/

/* Obtener la consulta anterior como porcentaje respecto del total de eventos. Obtener la información solo de huracanes. */
select 	category as categoria,
		count(*) as tormentas,
        (select count(*) from anomalias.storms where status="hurricane") as total,
        100*count(*)/(select count(*) from anomalias.storms) as pct_total
from anomalias.storms
where status="hurricane"
group by 1
order by 2;
/*
categoria	tormentas	total	pct_total
5	134	6250	0.7534
4	684	6250	3.8457
3	855	6250	4.8072
2	1345	6250	7.5621
1	3232	6250	18.1716
*/

/* 6-4 Anomalias con Estadistica */

/* Para los eventos de tipo huracan, ordenar por la velocidad del viento y obtener los percentiles */
select 	status,
		wind,
        percent_rank() over (partition by status order by wind) as percentil
from anomalias.storms
where status="hurricane";
/*
status	wind	percentil
hurricane	65	0
hurricane	65	0
hurricane	65	0
hurricane	65	0
hurricane	65	0
...
hurricane	160	0.9990398463754201
hurricane	160	0.9990398463754201
hurricane	160	0.9990398463754201
hurricane	160	0.9990398463754201
hurricane	165	1
*/

/* De la tabla anterior redondear el percentil a 4 decimales y hacer un conteo de cuantos huracanes hubo */
select	status,
		wind,
		round(percentil,4),
		count(*)
from
(
	select  status,
			wind,
			percent_rank() over (partition by status order by wind) as percentil
	from anomalias.storms
	where status="hurricane"
) as a
group by 1,2,3
order by 2 DESC;
/*
status	wind	round(percentil,4)	count(*)
hurricane	165	1.0000	1
hurricane	160	0.9990	6
hurricane	155	0.9960	19
hurricane	150	0.9920	25
hurricane	145	0.9862	36
...
hurricane	85	0.5172	466
hurricane	80	0.4215	598
hurricane	75	0.3044	732
hurricane	70	0.1797	779
hurricane	65	0.0000	1123
*/

/* Ordenando de manera ascendente por "wind" obtener 100 buckets con aproximadamente el mismo numero de elementos cada uno */
select 	status,
		wind,
        ntile(100) over (partition by status order by wind) as bucket
from anomalias.storms
where status="hurricane"
order by 1,2 desc;
/*
status	wind	bucket
hurricane	165	100
hurricane	160	100
hurricane	160	100
hurricane	160	100
hurricane	160	100
...
hurricane	65	18
hurricane	65	18
hurricane	65	18
hurricane	65	18
hurricane	65	18
*/

/* Ordenando de manera ascendente por "wind" obtener 4 buckets con aproximadamente el mismo numero de elementos cada uno */
select 	status,
		wind,
        ntile(4) over (partition by status order by wind) as bucket
from anomalias.storms
where status="hurricane"
order by 1,2 desc;
/*
status	wind	bucket
hurricane	165	4
hurricane	160	4
hurricane	160	4
hurricane	160	4
hurricane	160	4
...
hurricane	65	1
hurricane	65	1
hurricane	65	1
hurricane	65	1
hurricane	65	1
*/

/* Con la consulta anterior obtener donde empieza y termina cada bucket */
select 	bucket,
		min(wind) as minimo,
        max(wind) as maximo
from 
(select 	status,
		wind,
        ntile(4) over (partition by status order by wind) as bucket
from anomalias.storms
where status="hurricane"
order by 1,2 desc) as a
group by 1;
/*
bucket	minimo	maximo
4	100	165
3	80	100
2	70	80
1	65	70
*/

/* Calcular la desviación estandar de la columna wind */
select std(wind)
from anomalias.storms;
/*
std(wind)
26.96644326383179
*/

/* Obtener el z_score = (Xi - Media) / Desviación Estandar */
select 	wind,
		avg(wind) over () as media,
        round(std(wind) over (),4) as desv,
        round((wind - avg(wind) over ())/round(std(wind) over (),4),4) as z_score
from anomalias.storms
order by 1 desc;
/*
wind	media	desv	z
165	56.3697	26.9664	4.0284
160	56.3697	26.9664	3.8429
160	56.3697	26.9664	3.8429
160	56.3697	26.9664	3.8429
160	56.3697	26.9664	3.8429
...
*/

/* De la consulta anterior obtener el valor maximo y minimo del z_score */
select 	max(z_score),
		min(z_score)
from 
(select 	wind,
		avg(wind) over () as media,
        round(std(wind) over (),4) as desv,
        round((wind - avg(wind) over ())/round(std(wind) over (),4),4) as z_score
from anomalias.storms
order by 1 desc) as a
/*
max(z_score)	min(z_score)
4.0284	-1.7195
*/

/* 6-5 Anomalias con Graficas */




