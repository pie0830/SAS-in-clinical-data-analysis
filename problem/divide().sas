/* 除法不要直接用运算符，用divide（）会更好，这样就不会报NOTE:DIVISION BY ZERO的Note了 */
data _null_;
  c2=divide(r,d);
  c2=r/d;
  c2=ifn(d=0,.,r/d);
/* ifn()函数是一个包含了二元判断的函数   */
run;
