*Use system option and libname to create folder;

options dlcreatedir; *allow to create the folder if it doesn't exist;

libname SDTM 'A:\folder'; *if 'folder' doesn't exists in A: before, then 'folder' would be created;

*if you want to create folder and subfolder;
**It's not allowed to create subfolder directly without folder;
***Method 1;
libname SDTM0 'A:\folder';
libname SDTM 'A:\folder\subfolder';
libname SDTM0 clear; *It is suggested that clear the libary that you do not need;

***Method 2;
libname SDTM ('A:\folder','A:\folder\subfolder');
libname SDTM clear; *Remember to keep the library that you want only;
libname SDTM 'A:\folder\subfolder';


*__________Claire Wei 24Aug2022__________;
