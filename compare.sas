％macro comp(prod,val);
  proc sql noprint;
    select count(*) into: count1 separated by '' from &prod;
  quit;
  %put &count1;
  
   proc sql noprint;
    select count(*) into: count2 separated by '' from &val;
  quit;
  %put &count2; 
  
  %if &count1. > 0 and &count2. > 0 %then %do;
    proc compare data=&prod compare=&val out=d_&prod outall outnoequal listall;run;
  %end;
    %else %do;
      data result1;
        length result $200;
        result = "&prod obs: &count1.,&val obs: &count2.";
      run;
      proc print data = result1;run;
    %end;
%mend comp;
