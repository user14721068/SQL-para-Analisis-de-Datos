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
   Experimento contínuo: Estudiar una variable cuantitativa. Por ejemplo, cuanto dinero gastó un cliente en mi sitio web.*/

/* Trabajaremos con datos de  */
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

