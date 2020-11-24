proc sql noprint;
  select count(distinct usubjid) into:bigN1- :bigN2 from for_analysis group by cohort;
  select count(distinct usubjid) into:bigN3 from for_analysis;
quit;
%put &bigN1 &bigN2 &bigN3;
