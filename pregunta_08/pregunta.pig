/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

Pregunta_7 = LOAD 'data.tsv' USING PigStorage('\t') AS (letter: CHARARRAY, set_letter: CHARARRAY, set_maps: CHARARRAY);
Select_columns = FOREACH Pregunta_7 GENERATE FLATTEN(TOKENIZE(set_letter,',')) AS set_letter_separate, FLATTEN(TOKENIZE(set_maps,',')) AS set_maps_separate;
Select_columns_replace = FOREACH Select_columns GENERATE REPLACE(set_letter_separate,'([^a-zA-Z\\s]+)','') AS letra, REPLACE(set_maps_separate,'([^a-zA-Z\\s]+)','') AS key;
Select_columns_tuple = FOREACH Select_columns_replace GENERATE TOTUPLE(letra,key) AS tupla;
Select_columns_grouped = GROUP Select_columns_tuple BY tupla;
Select_columns_counted = FOREACH Select_columns_grouped GENERATE group, COUNT(Select_columns_tuple);
STORE Select_columns_counted INTO 'output' USING PigStorage(',');