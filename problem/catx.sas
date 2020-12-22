/*catx()神仙函数*/

*********************************;
解决了最近做listing遇到的问题。

catx(<分界符>，of <变量>)
<分界符>：这里是连接字符串间的分界符，可以是空格‘ ’，逗号‘，’等按需操作。
of <变量>：of最好加上，of var：，这样可以连接同前缀的变量，结合前置的proc transpose使用，非常方便

[!]函数优点是对还有缺失值的变量连接非常友好，help里解释了函数的运行原理：
Blank items do not produce delimiters at the beginning or end of the result, nor do blank items produce multiple consecutive delimiters.
函数读到空值不会在其开头和结尾插入分界符,也不会插入连续的分界符。

看sas support给出的例程。
函数官方help链接：
https://documentation.sas.com/?cdcId=pgmsascdc&cdcVersion=9.4_3.5&docsetId=lefunctionsref&docsetTarget=n0p7wxtk0hvn83n1pveisbcp2ae9.htm&locale=en
*********************************;

data one;
   length x1-x4 $1;
   input x1-x4;
   datalines;
A B C D
E . F G
H . . J
;
run;
data two;
   set one;
   SP='^';
   test1=catx(sp, of x1-x4);
   test2=trim(left(x1)) || sp || trim(left(x2)) || sp || trim(left(x3)) || sp || 
      trim(left(x4));
run;
   
proc print data=two;
run;
