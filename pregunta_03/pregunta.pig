/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
Pregunta_3 = LOAD 'data.tsv' USING PigStorage ('\t') AS (letter:chararray,date:chararray,value:int);
Values = FOREACH Pregunta_3 GENERATE value;
Ordenado = ORDER Values BY value asc;

STORE Ordenado INTO 'output' USING PigStorage (',');