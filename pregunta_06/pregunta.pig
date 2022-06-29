/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

Pregunta_6 = LOAD 'data.tsv' USING PigStorage('\t') AS (letter:CHARARRAY, set_letter:CHARARRAY, set_map:CHARARRAY);
Specific_Column = FOREACH Pregunta_6 GENERATE set_map;
Specific_Column_Separate = FOREACH Specific_Column GENERATE FLATTEN(TOKENIZE(set_map)) AS letras;
Specific_Column_Replace = FOREACH Specific_Column_Separate GENERATE REPLACE (letras,'([^a-zA-Z\\s]+)','') as letras;
Agrupation = GROUP Specific_Column_Replace BY letras;
Count_letter = FOREACH Agrupation GENERATE group, COUNT(Specific_Column_Replace);
STORE Count_letter INTO 'output' USING PigStorage(',');
