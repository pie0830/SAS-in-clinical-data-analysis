	proc report data=t_ce split='~';
		title1 ' ';
		title2 justify=center bold 'Table - Summary of Reactogenicity';
		title3 justify=center bold 'Study Population: Safety Population';
		columns ("SARS-CoV-2 DNA" 
(
(("Cohort"  ("      " ("     " term))) ("Cohort 1 Test Product (Dosage: 1mg/dose)" "N = 4" 
 "Maximum Grade" all_t g1_t g2_t g3_t g4_t g5_t) ("Cohort 1 Matching Placebo" "N = 1"
 "Maximum Grade" all_p g1_p g2_p g3_p g4_p g5_p))
)
);
			define term / display left 'Reactogencity Term' style(header)={font_weight=bold};
			define all_t / display center 'All' style(header)={font_weight=bold};
			define g1_t / display center 'G1' style(header)={font_weight=bold};
			define g2_t / display center 'G2' style(header)={font_weight=bold};
			define g3_t / display center 'G3' style(header)={font_weight=bold};
			define g4_t / display center 'G4' style(header)={font_weight=bold};
			define g5_t / display center 'G5' style(header)={font_weight=bold};
			define all_p / display center 'All' style(header)={font_weight=bold};
			define g1_p / display center 'G1' style(header)={font_weight=bold};
			define g2_p / display center 'G2' style(header)={font_weight=bold};
			define g3_p / display center 'G3' style(header)={font_weight=bold};
			define g4_p / display center 'G4' style(header)={font_weight=bold};
			define g5_p / display center 'G5' style(header)={font_weight=bold};

	compute after / style=[just=left];
	line 'Remark: N = Number of subjects studied        ( ) = Percentage of subjects with Reactogenicity        [ ] = Number of Reactogenicity';
	line 'G1 = Grade 1 / Mild; G2 = Grade 2 / Moderate; G3 = Grade 3 / Severe; G4 = Grade 4 / Life-Threatening';
	endcomp;

		footnote1 justify=left "Program Location: &file_latest_SAFREV";

		footnote2 justify=left "Program Run by: Claire Wei (Statistical/Database Programmer)";

		footnote3 justify=left "Date/Time Created &datetime_listing_gen
 based on the dataset as of %sysfunc(mdy(%substr(&dataset_date,5,2),%substr(&dataset_date,7,2),%substr(&dataset_date,1,4)),date9.):
%sysfunc(substr(&dataset_time,1,2)):%sysfunc(substr(&dataset_time,3,2)):%sysfunc(substr(&dataset_time,5,2))";
	run;
