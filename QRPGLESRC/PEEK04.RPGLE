**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK04                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 28.10.97  Raddatz                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Dokumentation:                                               *
//                                                               *
//  Abrufen der Dateiinformationen: hier prüfen auf              *
//                                  Schlüsselinformationen       *
//                                                               *
// ============================================================= *
// >>PRE-COMPILER<<                                              *
//   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
//                           OBJLIB(&LI) DEVLIB(&LI) +           *
//                           SBMJOB(*NO) BNDDIR(PEEK) +          *
//                           INSTALL(*NO);                       *
//   >>EXECUTE<<                                                 *
// >>END-PRE-COMPILER<<                                          *
//===============================================================*
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,KEYL0100
/copy QCOPYLE,CEECNDHDLR
/copy QCOPYLE,SDS

/copy QCOPYLE,USR0006

/define internal_prototype
/copy QCOPYLE,PPEEK04
/undefine internal_prototype

/copy QCOPYLE,PPEEK41
/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-s peek41_name like(pgmCallN_t) inz;

dcl-s data char(512) inz;
dcl-s nbrOfKey like(int4_t) inz;

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek04;
  i_qFile  likeds(qObj_t) const;
  i_rcdFmt like(fmt_t) const;
  o_msgID  like(msgId_t);
  o_msgDta like(msgDta_t);
end-pi;

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

//  Abrufen der Dateiinformationen ...
peek41(i_qFile: i_rcdFmt: '*CREATE'
      : nbrOfKey: data);

if (nbrOfKey > 0);
  //  Abrufen der Schlüsselfeldinformationen ...
  peek41(i_qFile: i_rcdFmt: '*KEY'
        : nbrOfKey: data);
endif;

//  Auch wenn schon der Abruf der Dateiinformationen fehlgeschlagen
//  ist, gibt es keine Schlüsselinformationen.
if (nbrOfKey <= *zeros);
  o_msgID = 'USR0006';
  usr0006.var1 = i_qFile.name;
  usr0006.var2 = i_qFile.lib;
  o_msgDta = usr0006;
else;
  o_msgID = *blanks;
  o_msgDta = *blanks;
endif;

*inlr = '1';

//====================================================*
//  First  --  Initialize program                     *
//====================================================*

begsr first;

  nbrOfKey = *zeros;

  // - Meldung
  //**                Callp     p_sndStsMg('USR8137': XQFile)

  // - Los gehts'
  o_msgID = *blanks;
  o_msgDta = *blanks;

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  peek41_name = f_pgmCallN('PEEK41');

endsr;

//============================================================*
//  Program error handler                                     *
//============================================================*

dcl-proc errorHandler;
  dcl-pi *n;
    i_condToken    likeds(cee_fc_t) value;
    i_pCommArea    int(10) value;
    o_action       int(10);
    o_newCondToken likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

