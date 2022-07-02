/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
Pregunta_31 = LOAD 'data.csv' USING PigStorage(',') AS (id:CHARARRAY, name:CHARARRAY, last_name:CHARARRAY, date:DATETIME, color:CHARARRAY, value:int);

Select_column_years = FOREACH Pregunta_31 GENERATE GetYear(date) as year;
Select_column_grouped = GROUP Select_column_years BY year;
Select_column_counted = FOREACH Select_column_grouped GENERATE group, COUNT(Select_column_years);

STORE Select_column_counted INTO 'output' USING PigStorage(',');