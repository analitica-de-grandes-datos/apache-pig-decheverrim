/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

Pregunta_30 = LOAD 'data.csv' USING PigStorage(',') AS (id:CHARARRAY, name:CHARARRAY, last_name:CHARARRAY, date:CHARARRAY, color:CHARARRAY, value:int);

Select_columns_dates = FOREACH Pregunta_30 GENERATE date,
    SUBSTRING(date, 8, 10) as x,
    GetDay(ToDate(date)) as y,
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    ToString(ToDate(date), 'EEEE'),
    'Monday', 'lunes'),
    'Tuesday', 'martes'),
    'Wednesday', 'miercoles'),
    'Thursday', 'jueves'),
    'Friday', 'viernes'),
    'Saturday', 'sabado'),
    'Sunday', 'domingo') as dia;

Select_columns_string = FOREACH Select_columns_dates GENERATE date, x, y, SUBSTRING(dia,0, 3), dia;


STORE Select_columns_string INTO 'output' USING PigStorage(',');