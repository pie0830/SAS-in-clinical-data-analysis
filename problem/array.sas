/* 使用array对变量进行条件判断 */

array col aeacnot1-aeacnot4 aeacno1o aeacno2o aeacno3o aeacno4o;
do over col;
if col='' then col='';
end;
