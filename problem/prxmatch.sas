/* this is the example of how to use prxmatch() */

data _null_;
  if prxmatch("/^((\s*)?(\-?\d+))(\.\d+)?(\s*)?$/",nforres) then nfstresn=input(nforres,best.);

run;

