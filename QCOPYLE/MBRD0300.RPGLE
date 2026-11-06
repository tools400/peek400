**free
//===============================================================*
//                                                               *
//  Additional information about MBRD0200:                       *
//                                                               *
//                                                               *
//===============================================================*

//  API format MBRD0200
//  (data structure can be used within the calling program
//  to splitt XValue into its units.)
dcl-ds mbrd0300_t qualified template;
  m3bytret               int(10);
  m3bytavl               int(10);
  m3file                 char(10);
  m3library              char(10);
  m3member               char(10);
  m3attr                 char(10);
  m3srctyp               char(10);
  m3objcrtdt             char(13);
  m3srcchgdt             char(13);
  m3text                 char(50);
  m3srcfile              char(1);
  m3remote               char(1);
  m3filetyp              char(1);
  m3odpshare             char(1);
  m3res_01               char(2);
  m3nbrrcdon             int(10);
  m3nbrrcddl             int(10);
  m3dtaspcsz             uns(10);
  m3accspcsz             uns(10);
  m3numbasedonmbr        int(10);
  m3chgdatetime          char(13);
  m3savdatetime          char(13);
  m3rstdatetime          char(13);
  m3expdate              char(7);
  m3reserved_1           char(4);
  m3mediapref            int(5);
  m3numdaysused          int(10);
  m3datelstused          char(7);
  m3useresdate           char(7);
  m3reserved_2           char(2);
  m3dtasizemult          int(10);
  m3accsizemult          int(10);
  m3mbrtxtccsid          int(10);
  m3ofsaddinf            int(10);
  m3lenaddinf            int(10);
  m3numrcds              uns(10);
  m3numdltrcds           uns(10);
  m3reserved_3           char(6);
  m3joinmbr              char(1);
  m3accpathmaint         char(1);
  m3sqlfiletype          char(10);
  m3reserved_4           char(1);
  m3alwread              char(1);
  m3alwwrite             char(1);
  m3alwupdate            char(1);
  m3alwdelete            char(1);
  m3reserved_5           char(1);
  m3rcdsforcewrite       int(10);
  m3maxpercentdltrcdsalw int(10);
  m3initnumrcds          int(10);
  m3incnumrcds           int(10);
  m3maxnuminc            int(10);
  m3currnuminc           uns(10);
  m3rcdcapacity          uns(10);
  m3rcdslcpgm            char(10);
  m3rcdslclib            char(10);
  m3numcstidx            int(5);
  m3ofscstidxinf         int(10);
  m3reserved_6           char(46);
end-ds;
//   Array of CHAR(112)	Record format and based-on file list
//   Array of CHAR(320)	Constraint indexes information

//  Record Format and Based-On File List Entry
dcl-ds mbrd0300_basedone_t qualified template;
  basedonfile     char(10);
  basedonlib      char(10);
  basedonmbr      char(10);
  fmtname         char(10);
  lfrcdfmtnbr     int(10);
  nbrrcds         int(10);
  nbrdltrcds      int(10);
  accpathsize     int(10);
  accpathsizem    int(10);
  accpathshared   char(1);
  accpathvalid    char(1);
  accpathheld     char(1);
  accpathownrfile char(10);
  accpathownrlib  char(10);
  accpathownrmbr  char(10);
  accpathjrn      char(1);
  reserved_1      char(2);
  nbrrcdsu        int(10);
  nbrdltrcdsu     int(10);
  reserved_2      char(8);
end-ds;

