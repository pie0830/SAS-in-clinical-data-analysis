data club1;
   input Idno Name $18.
      Team $ 25-30 Startwght Endwght;
   datalines;
023 David Shaw         red    189 165
049 Amelia Serrano     yellow 189 165
;
run;

/*$ 25-30中的$声明了Name变量为字符型，25-30声明了Name取dataline里的第25-30个字符*/

/*理解了上一个注释之后，下面这段程序就懂了*/

data adverse;
   input subjectid $ 1-7 ae $ 9-41;
   datalines;
   100-101 HEADACHE
   100-105 HEDACHE
   100-110 MYOCARDIAL INFARCTION
   200-004 MI
   ;
   run;
   
proc freq 
        data = adverse;
        tables ae;
run;
