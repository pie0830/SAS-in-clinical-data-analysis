/* A waterfall chart is commonly used in the Oncology domain to track the change in tumor size for subjects in a study by treatment. */
/* The graph display the change in tumor size for each subject in the study by descending percent change from baseline */

title 'Change in Tumor Size'; 
title2 'ITT Population';
proc sgplot data=TumorSize nowall noborder;
 styleattrs datacolors=(cxbf0000 cx4f4f4f) datacontrastcolors=(black);
 vbar cid / response=change group=group categoryorder=respdesc
 datalabel=label datalabelattrs=(size=5 weight=bold)
 groupdisplay=cluster clusterwidth=1;
 refline 20 -30 / lineattrs=(pattern=shortdash);
 xaxis display=none;
 yaxis values=(60 to -100 by -20);
 inset "C= Complete Response" "R= Partial Response" "S= Stable Disease"
 "P= Progressive Disease" "E= Early Death" / title='BCR'
 position=bottomleft border textattrs=(size=6 weight=bold);
 keylegend / title='' location=inside position=topright across=1 border;
run;
