/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada    letter minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

Pregunta_5 = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
            letter:chararray,
            set_letters:chararray,
            lista:int
    );

Select_column = FOREACH Pregunta_5 GENERATE set_letters;
Select_column_separate = FOREACH Select_column GENERATE FLATTEN(TOKENIZE(set_letters)) AS letter;
Select_column_filter = FILTER Select_column_separate BY (letter MATCHES '.*[a-z].*');
Select_column_grouped = GROUP Select_column_filter BY letter;
Select_column_counted = FOREACH Select_column_grouped GENERATE group, COUNT(Select_column_filter);
STORE Select_column_counted INTO 'output' USING PigStorage(',');


