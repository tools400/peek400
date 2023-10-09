**FREE
//===============================================================*
//                                                               *
//  Additional information about MBRD0200:                       *
//                                                               *
//                                                               *
//===============================================================*
//
//  API format MBRD0200
//  (data structure can be used within the calling program
//  to splitt XValue into its units.)
dcl-ds mbrd0200_t qualified template;
  m2bytret        int(10);
  m2bytavl        int(10);
  m2file          char(10);
  m2library       char(10);
  m2member        char(10);
  m2attr          char(10);
  m2srctyp        char(10);
  m2objcrtdt      char(13);
  m2srcchgdt      char(13);
  m2text          char(50);
  m2srcfile       char(1);
  m2remote        char(1);
  m2filetyp       char(1);
  m2odpshare      char(1);
  m2res_01        char(2);
  m2nbrrcdon      int(10);
  m2nbrrcddl      int(10);
  m2dtaspcsz      uns(10);
  m2accspcsz      uns(10);
  m2numbasedonmbr
  int(10);
  m2chgdatetime   char(13);
  m2savdatetime   char(13);
  m2rstdatetime   char(13);
  m2expdate       char(7);
  m2reserved_1    char(4);
  m2mediapref     int(5);
  m2numdaysused   int(10);
  m2datelstused   char(7);
  m2useresdate    char(7);
  m2reserved_2    char(2);
  m2dtasizemult   int(10);
  m2accsizemult   int(10);
  m2mbrtxtccsid   int(10);
  m2ofsaddinf     int(10);
  m2lenaddinf     int(10);
  m2numrcds       uns(10);
  m2numdltrcds    uns(10);
  m2reserved_3    char(6);
end-ds;
//
