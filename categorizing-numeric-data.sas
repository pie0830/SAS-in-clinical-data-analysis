data demog;
  set demog;
    by subject;
    
    if .z < age <= 18 then age_cat = 1;               /*留意这个‘.z’的用法，学起来*/
    else if 18 < age <= 60 then age_cat = 2;
    else if 60 < age then age_cat = 3;
run;
