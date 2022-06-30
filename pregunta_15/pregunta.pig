/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname,
       color
   FROM 
       u 
   WHERE color = 'blue' AND firstname LIKE 'Z%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/

Pregunta_15 = LOAD 'data.csv' USING PigStorage(',') AS (id:CHARARRAY, name:CHARARRAY, last_name:CHARARRAY, date:CHARARRAY, color:CHARARRAY, value:int);
Select_colors = FOREACH Pregunta_15 GENERATE name, color;
Select_colors_filter = FILTER Select_colors BY (name MATCHES '.*^[Z].*') AND (color MATCHES 'blue');

STORE Select_colors_filter INTO 'output' USING PigStorage(' ');

