/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Genere una relación con el apellido y su longitud. Ordene por longitud y 
por apellido. Obtenga la siguiente salida.

  Hamilton,8
  Garrett,7
  Holcomb,7
  Coffey,6
  Conway,6

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

Pregunta_10 = LOAD 'data.csv' USING PigStorage(',') AS (id:CHARARRAY, name:CHARARRAY, last_name:CHARARRAY, date:CHARARRAY, color:CHARARRAY, value:int);
Select_column = FOREACH Pregunta_10 GENERATE name, last_name;
Select_column_len = FOREACH Select_column GENERATE last_name, SIZE(last_name) AS length;
Select_column_order = ORDER Select_column_len BY length DESC, last_name ASC;
Select_column_limit = LIMIT Select_column_order 5;
STORE Select_column_limit INTO 'output' USING PigStorage(',');
