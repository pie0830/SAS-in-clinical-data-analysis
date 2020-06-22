/*take AE for example*/
%let _SortKey = %str(usubjid aestdtc aeendtc aespid aeterm aedecod);

proc sort data=ae out=test dupout=chk nodupkey;
  by &_SortKey;
 run;
 
data chk;
  set chk;
  if ^missing(usubjid) then put "Warning:SortKey is not unique!";
run;
