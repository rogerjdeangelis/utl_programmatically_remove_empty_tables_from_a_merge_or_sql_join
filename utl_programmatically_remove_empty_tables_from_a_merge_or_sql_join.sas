Programmatically remove empty tables from a merge or sql join;

see
https://communities.sas.com/t5/Base-SAS-Programming/merge-data-Table/m-p/433937

INPUT
=====

  Algorithm
     remove B from merge a b c

  %macro utl_nlobs(dsn);
     %let dsid=%sysfunc(open(&dsn));%sysfunc(attrn(&dsid,nlobs)) %let rc=%sysfunc(close(&dsid));
  %mend utl_lnobs;

  Three datasets

  WORK.A total obs=2

    ID    X

     1    1
     1    2


  * B is empty;
  WORK.B     Observations     0
  DATA       Variables        3


  WORK.C total obs=2

   ID    Z

    1    3
    1    4


PROCESS
=======

   data want;
     merge
      %sysfunc(ifc(%utl_nlobs(a),a,%str( )))
      %sysfunc(ifc(%utl_nlobs(b),b,%str( )))
      %sysfunc(ifc(%utl_nlobs(c),c,%str( )))
    ;
   run;quit;


OUTPUT
======

  WORK.WANT total obs=2

   ID    X    Z

    1    1    3
    1    2    4
*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;

data a;
id=1; x=1; output;
id=1; x=2; output;
run;

/* Empty dataset */
data b;
length id x y 8;
stop;
run;

data c;
id=1; z=3; output;
id=1; z=4; output;
run;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

data want;
  merge
   %sysfunc(ifc(%utl_nlobs(a),a,%str( )))
   %sysfunc(ifc(%utl_nlobs(b),b,%str( )))
   %sysfunc(ifc(%utl_nlobs(c),c,%str( )))
 ;
run;quit;

1992  data want;
1993    merge
MLOGIC(UTL_NLOBS):  Beginning execution.
1994     %sysfunc(ifc(%utl_nlobs(a),a,%str( )))
MLOGIC(UTL_NLOBS):  Parameter DSN has value a
MLOGIC(UTL_NLOBS):  %LET (variable name is DSID)
SYMBOLGEN:  Macro variable DSN resolves to a
SYMBOLGEN:  Macro variable DSID resolves to 1
MLOGIC(UTL_NLOBS):  %LET (variable name is RC)
SYMBOLGEN:  Macro variable DSID resolves to 1
MLOGIC(UTL_NLOBS):  Ending execution.
MLOGIC(UTL_NLOBS):  Beginning execution.
1995     %sysfunc(ifc(%utl_nlobs(b),b,%str( )))
MLOGIC(UTL_NLOBS):  Parameter DSN has value b
MLOGIC(UTL_NLOBS):  %LET (variable name is DSID)
SYMBOLGEN:  Macro variable DSN resolves to b
SYMBOLGEN:  Macro variable DSID resolves to 1
MLOGIC(UTL_NLOBS):  %LET (variable name is RC)
SYMBOLGEN:  Macro variable DSID resolves to 1
MLOGIC(UTL_NLOBS):  Ending execution.
MLOGIC(UTL_NLOBS):  Beginning execution.
1996     %sysfunc(ifc(%utl_nlobs(c),c,%str( )))
MLOGIC(UTL_NLOBS):  Parameter DSN has value c
MLOGIC(UTL_NLOBS):  %LET (variable name is DSID)
SYMBOLGEN:  Macro variable DSN resolves to c
SYMBOLGEN:  Macro variable DSID resolves to 1
MLOGIC(UTL_NLOBS):  %LET (variable name is RC)
SYMBOLGEN:  Macro variable DSID resolves to 1
MLOGIC(UTL_NLOBS):  Ending execution.
1997   ;
1998  run;

NOTE: There were 2 observations read from the data set WORK.A.
NOTE: There were 2 observations read from the data set WORK.C.
NOTE: The data set WORK.WANT has 2 observations and 3 variables.
NOTE: DATA statement used (Total process time):
      real time           0.02 seconds
      user cpu time       0.00 seconds
      system cpu time     0.01 seconds
      memory              713.65k
      OS Memory           22484.00k
      Timestamp           02/04/2018 02:25:25 PM
      Step Count                        490  Switch Count  0

1998!     quit;



