proc sql noprint;
  select count(distinct usubjid) into:bigN1- :bigN2 from for_analysis group by cohort;
  select count(distinct usubjid) into:bigN3 from for_analysis;
quit;
%put &bigN1 &bigN2 &bigN3;
/*发现bigN3出来不是bigN3=1 而是带上了空格 bigN3=     1*/
/*solution 1 by Linyu*/
proc sql noprint;
  select cats(count(distinct usubjid)) into:bigN3 from for_analysis;
quit;

/*solution 2*/
%let bigN3=%sysfunc(strip(&bigN3));
