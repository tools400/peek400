**FREE
//
//====================================================*
//  Definitionen für Format: RTVM0100  (QMHRTVM)      *
//====================================================*
//
dcl-ds rtvm0100 len(2048);
  rt1_bytret      int(10) inz(0);
  rt1_bytavl      int(10) inz(0);
  rt1_lnmgrt      int(10) inz(0);
  rt1_lnmgav      int(10) inz(0);
  rt1_lnmhrt      int(10) inz(0);
  rt1_lnmhav      int(10) inz(0);
  rt1_data        char(2024) inz(*blanks);
end-ds;
//
