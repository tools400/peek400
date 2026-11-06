**free

//====================================================*
//  Definitionen für Format: RTVM0100  (QMHRTVM)      *
//====================================================*

dcl-ds rtvm0100 len(2048);
  RT1_BytRet int(10) inz(0);
  RT1_BytAvl int(10) inz(0);
  RT1_LnMgRt int(10) inz(0);
  RT1_LnMgAv int(10) inz(0);
  RT1_LnMhRt int(10) inz(0);
  RT1_LnMhAv int(10) inz(0);
  RT1_Data   char(2024) inz(*blanks);
end-ds;

