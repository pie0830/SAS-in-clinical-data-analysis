/*今天收到小leader的新需求，在ADSL里加上RACEMLTP变量，需要对RACE1-4先进行alphabetical 排序，然后把不为空的RACE1-4合并到RACEMLTP*/
/*行内排序问题*/
/*reference: http://www.360doc.com/content/15/0108/02/19760344_439138654.shtml */
/*Method 1 call sortc*/
data _null_;
   array x(8) $10
      ('tweedledum' 'tweedledee' 'baboon' 'baby'
       'humpty' 'dumpty' 'banana' 'babylon');
   call sortc(of x(*));
   put +3 x(*);/*不知道这个+3是用来干嘛的*/
run;

/*1.call sortc 里的变量长度要一致，call完之后变量的内容都会打乱按字母从小到大排列（空格<数字<大写<小写）*/
