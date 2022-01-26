/*proc report example*/
	proc report data=t_aesocpt split='~' nowd ;
		title1 ' ';
		title2 justify=center bold 'Table - Adverse Events by SOC and PT';
		title3 justify=center bold 'Study Population: Safety Population';

		columns ("SARS-CoV-2 DNA" 
(
(("Cohort"  (term)) ("Cohort 1 Test Product (Dosage: 1mg/dose)~N = 4"  
  col1) ("Cohort 1 Matching Placebo~N = 1" 
  col2))
)
) socfl ;
			define term / display 'System Organ Class~    Preferred Term' style(header)={font_weight=bold just=left};
			define col1 / display center '         ' style(header)={font_weight=bold};
			define col2 / display center '         ' style(header)={font_weight=bold};
			define socfl / noprint;

	compute socfl;
	if socfl='Y' then call define (1,'style','style={fontweight=bold BACKGROUNDCOLOR=#edf2f9 color=#112277}');
	if socfl='Y' then call define (2,'style','style={BACKGROUNDCOLOR=#edf2f9 color=#112277}');
	if socfl='Y' then call define (3,'style','style={BACKGROUNDCOLOR=#edf2f9 color=#112277}');
	endcomp;

	compute term;
	if term='Subjects with AEs (Related to IMP)' then call define (_row_,'style','style={bordertopcolor=black bordertopwidth=3pt}');
	endcomp;

	compute after / style=[just=left];
	line 'Remark: N = Number of subjects studied        ( ) = Percentage of subjects with AEs        [ ] = Number of AEs';
	line 'Events are coded using MedDRA (Version 24.1).';
	line 'Data to be ordered by most frequent system organ class, then by most frequent preferred term within system organ class.';
	endcomp;

		footnote1 justify=left "Program Location: &file_latest_SRC";

		footnote2 justify=left "Program Run by: Claire Wei (Statistical/Database Programmer)";

		footnote3 justify=left "Date/Time Created &datetime_listing_gen
 based on the dataset as of %sysfunc(mdy(%substr(&dataset_date,5,2),%substr(&dataset_date,7,2),%substr(&dataset_date,1,4)),date9.):
%sysfunc(substr(&dataset_time,1,2)):%sysfunc(substr(&dataset_time,3,2)):%sysfunc(substr(&dataset_time,5,2))";
	run;



































