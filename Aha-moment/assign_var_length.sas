
data mddt_char;
   set mddt.mddt_sdtm; 
/* 这一步就是选择相应study和相应domain和所有type为char的变量 */
  if domain='NF' and m20180115^='NA' and type='Char';
/* 这里生成一个新变量，把char型变量跟它的长度结合起来，为下一步赋值到一个宏变量里做准备   */
/* 这里catx（）的分隔符一定要和下面的sql步的分隔符一致，用空格的原因是因为这里的宏变量是为了后面定义变量服务的 */
  v_l=catx(' ',variable_name,length);
run;
proc sql noprint;
  select v_l into:v_l_c separated by ' ' from mddt_char(where=(variable_name not in ('EPOCH')));
quit;
%put &v_l_c;
