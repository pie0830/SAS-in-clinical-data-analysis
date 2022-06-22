title 'method one: use proc means, alpha = 0.05, two sided test';

PROC MEANS DATA=sashelp.class n mean stderr lclm uclm alpha=0.05 vardef=df;
 class sex;
 VAR height; 
 OUTPUT OUT=xxtmp N=n MEAN=mean STDERR=stderr LCLM=lclm Uclm=uclm;
RUN;

*** method three: use proc summary - this is the correct one;

PROC MEANS DATA=sashelp.class noprint;
 class sex;
 VAR height;
 OUTPUT OUT=xxtmp_1 N=n MEAN=mean STDERR=stderr LCLM=lclm UCLM=uclm;
RUN;

DATA xxtmp_2;
 SET xxtmp_1;
 lo=mean - (TINV (0.975 , n-1) * stderr);
 hi=mean + (TINV (0.975 , n-1) * stderr);
RUN;

title 'method two: use proc summary - this is the correct one';

proc print data=xxtmp_2;
run;
