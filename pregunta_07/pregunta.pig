/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

Pregunta_7 = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
            letter:chararray,
            set_letter:chararray,
            lista:chararray
    );

Columns_selected = FOREACH Pregunta_7 GENERATE letter, TOKENIZE(set_letter,',') AS set_separate, TOKENIZE(lista,',') AS list_separate;
Group_columns = FOREACH Columns_selected GENERATE letter, COUNT(set_separate) AS count_set_separate, COUNT(list_separate) AS count_list_separate;
Order_columns = ORDER Group_columns BY letter, count_set_separate, count_list_separate asc;
STORE Order_columns INTO 'output' USING PigStorage(',');

