/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

Pregunta_5 = LOAD 'data.tsv' USING PigStorage('\t') AS (letter:CHARARRAY, set_letter:CHARARRAY, set_dict:CHARARRAY);
Specific_Column = FOREACH Pregunta_5 GENERATE set_letter;
Specific_Column_Separate = FOREACH Specific_Column GENERATE FLATTEN(TOKENIZE(set_letter)) AS letra;
Specific_Column_Filter = FILTER Specific_Column_Separate BY (letra MATCHES'.*[a-z].*');
Agrupation = GROUP Specific_Column_Filter BY letra;
Count_letter = FOREACH Agrupation GENERATE group, COUNT(Specific_Column_Filter);
STORE Count_letter INTO 'output' USING PigStorage(',');


