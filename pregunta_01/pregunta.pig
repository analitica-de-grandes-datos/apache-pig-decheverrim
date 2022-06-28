/* 
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra.
Almacene los resultados separados por comas. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

Pregunta_1 = LOAD 'data.tsv' USING PigStorage('\t') AS (letra:CHARARRAY,fecha:CHARARRAY,valor:int);
grouped = GROUP Pregunta_1 BY letra;
Count = FOREACH grouped GENERATE group, COUNT(Pregunta_1);

STORE Count INTO 'output' USING PigStorage(',');


