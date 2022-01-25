
*data lookup;
%macro data_lookup(ds,domain,model);
	%global testcd_empty test_empty cat_exist scat_exist stresu_exist;

	proc sql noprint;
		*for key definition;

		*the macro variable ne 0 if the concerned column is not empty;
		select count(%if %upcase(&model)=SDTM %then &domain.TESTCD; %else %if %upcase(&model)=ADAM %then %substr(&domain,3,2)TESTCD;) into :testcd_empty trimmed from &ds;
		select count(%if %upcase(&model)=SDTM %then &domain.TEST; %else %if %upcase(&model)=ADAM %then %substr(&domain,3,2)TEST;) into :test_empty trimmed from &ds;

		*the macro variable=1 if the concerned variable exists;
		select count(*) into :obj_exist trimmed from sashelp.vcolumn
			where libname='WORK' and memname=upcase("&domain") and upcase(substr(strip(name),3))='OBJ';
		select count(*) into :cat_exist trimmed from sashelp.vcolumn
			where libname='WORK' and memname=upcase("&domain") and upcase(substr(strip(name),3))='CAT';
		select count(*) into :scat_exist trimmed from sashelp.vcolumn
			where libname='WORK' and memname=upcase("&domain") and upcase(substr(strip(name),3))='SCAT';
		select count(*) into :stresu_exist trimmed from sashelp.vcolumn
			where libname='WORK' and memname=upcase("&domain") and upcase(substr(strip(name),3))='STRESU';
		select count(*) into :fast_exist trimmed from sashelp.vcolumn
			where libname='WORK' and memname=upcase("&domain") and upcase(substr(strip(name),3))='FAST';
	quit;
	%put &obj_exist &cat_exist;

	%if %upcase(&model)=SDTM %then %do;

		*for **TEST, **ORRESU, **ORNRLO, **ORNRHI, **STRESU, **STNRLO, **STNRHI;
		data &ds;
			set &ds;
			length SEX $ 1 &domain.STNRC $20;	*to control the variable type, in case it is not available;

			if 0 then set lookuptable_sdtm;	*to initialise the variables;
			if _n_=1 then do;	*to create the hash object once;
				declare hash lookuptable(dataset:'lookuptable_sdtm (where=(DOMAIN=upcase("&domain")))',multidata:'yes',ordered:'yes');
				lookuptable.definekey('DOMAIN'
										%if &testcd_empty ne 0 %then ,'TESTCD';
										%if &test_empty ne 0 %then ,'TEST';
										%if &obj_exist=1 %then ,'OBJ';
										%if &cat_exist=1 %then ,'CAT';
										%if &scat_exist=1 %then ,'SCAT';
										%if &fast_exist=1 %then ,'FAST';);
				lookuptable.definedata(all:'yes');
				lookuptable.definedone();
			end;
			rc=lookuptable.find(key:DOMAIN
								%if &testcd_empty ne 0 %then ,key:&domain.TESTCD;
								%if &test_empty ne 0 %then ,key:&domain.TEST;
								%if &obj_exist=1 %then ,key:&domain.OBJ;
								%if &cat_exist=1 %then ,key:&domain.CAT;
								%if &scat_exist=1 %then ,key:&domain.SCAT;
								%if &fast_exist=1 %then ,key:&domain.FAST;);
			lookuptable.has_next(result:has_next);
			if rc=0 /*have a matched record for the keys defined above*/ and has_next ne 0 /*have further records for the key*/
			then do while(has_next ne 0 /*to loop through all records*/ and (
				/*1: sex not matched*/
				(~missing(GENDER) and strip(SEX) ne strip(GENDER)) or
				/*2: not in age range*/
				(~missing(AGE) and ~(AGE>=AGELO and AGE<=AGEHI)) or	/*!the comparators are fixed for now*/
				/*3: not in the date range*/
				(~missing(STARTDTC) and ~(&domain.DTC>=STARTDTC)) or /*!the comparators are fixed for now*/
				(~missing(ENDDTC) and ~(&domain.DTC<=ENDDTC))
			));
				rc=lookuptable.find_next();	*to look for the next record;
				lookuptable.has_next(result:has_next);	*to check if there are further records for the key;
			end;

			if %if &testcd_empty ne 0 and &test_empty = 0 %then strip(&domain.TESTCD)=strip(TESTCD);
				%if &test_empty ne 0 and &testcd_empty = 0 %then strip(&domain.TEST)=strip(TEST);
				and (missing(GENDER) or strip(SEX)=strip(GENDER)) 
				and (missing(STARTDTC) or &domain.DTC>=STARTDTC)
				and (missing(ENDDTC) or &domain.DTC<=ENDDTC)
			then do;
				if ~missing(TESTCD) then &domain.TESTCD=strip(TESTCD);
				if ~missing(TEST) then &domain.TEST=strip(TEST);
				if ~missing(ORRESU) then &domain.ORRESU=strip(ORRESU);
				if ~missing(STRESU) then &domain.STRESU=strip(STRESU);
				/*if the both age limits are not imputed, the age should fall into range*/
				if (AGELO=. and AGEHI=999) or (AGE>=AGELO and AGE<=AGEHI) /*!the comparators are fixed for now*/ then do;
					if ~missing(ORNRLO) then &domain.ORNRLO=ORNRLO;
					if ~missing(ORNRHI) then &domain.ORNRHI=ORNRHI;
					if ~missing(STNRLO) then &domain.STNRLO=STNRLO;
					if ~missing(STNRHI) then &domain.STNRHI=STNRHI;
					if ~missing(STNRC) then &domain.STNRC=STNRC;
				end;
			end;
		run;
	%end;
	%else %if %upcase(&model)=ADAM %then %do;
		*for PARAM, PARAMCD;
		data &ds;
			set &ds;

			if 0 then set lookuptable_adam; *to initialise the variables;
			if _n_=1 then do;	*to create the hash object once;
				declare hash lookuptable(dataset:'lookuptable_adam');
				lookuptable.definekey('TESTCD' /**TESTCD is a required variable*/
										%if &obj_exist=1 %then ,'OBJ';
										%if &cat_exist=1 %then ,'CAT';
										%if &scat_exist=1 %then ,'SCAT';
										%if &stresu_exist=1 %then ,'STRESU';);
				lookuptable.definedata(all:'yes');
				lookuptable.definedone();
			end;

			rc=lookuptable.find(key:%substr(&domain,3,2)TESTCD
								%if &obj_exist=1 %then ,key:%substr(&domain,3,2)OBJ;
								%if &cat_exist=1 %then ,key:%substr(&domain,3,2)CAT;
								%if &scat_exist=1 %then ,key:%substr(&domain,3,2)SCAT;
								%if &stresu_exist=1 %then ,key:%substr(&domain,3,2)STRESU;);
		run;		
	%end;
%mend data_lookup;

#Search and Lookup With a Simple Key;
*example;

data match_on_movie_titles(drop=rc);
if 0 then set mydata.movies
              mydata.actors; /* load variable properties into hash tables */
if _n_=1 then do;
declare hash hashactors (dataset:'mydata.actors'); /* declare the name hashactors for hash */
hashactors.definekey ('Title');
hashactors.definedata ('Actor_Leading','Actor_supporting'); /* define columns of data */
hashactors.definedone (); /* complete hash table defintion */
end;
set mydata.movies;
if hashactors.find(key:title)=0 then output; /* lookup TITLE in MOVIES table using HashActors object */
run;




