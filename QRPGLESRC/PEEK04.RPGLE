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
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,KEYL0100
/COPY QCOPYLE,CEECNDHDLR
/COPY QCOPYLE,SDS

/COPY QCOPYLE,USR0006

/define internal_prototype
/COPY QCOPYLE,PPEEK04
/undefine internal_prototype

/COPY QCOPYLE,PPEEK41
/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

dcl-s peek41_name     like(pgmcalln_t) inz;

dcl-s data            char(512) inz;
dcl-s nbrofkey        like(int4_t) inz;

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

dcl-pi peek04;
  i_qfile         const likeds(qobj_t);
  i_rcdfmt        const like(fmt_t);
  o_msgid         like(msgid_t);
  o_msgdta        like(msgdta_t);
end-pi;

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

//  Abrufen der Dateiinformationen ...
peek41(i_qfile: i_rcdfmt: '*CREATE'
      : nbrofkey: data);

if (nbrofkey <= 0);
//  ... schade, Aufruf ist fehlgeschlagen
else;
  //  Abrufen der Schlüsselfeldinformationen ...
  peek41(i_qfile: i_rcdfmt: '*KEY'
        : nbrofkey: data);

  if (nbrofkey <= *zeros);
    o_msgid = 'USR0006';
    usr0006.var1 = i_qfile.name;
    usr0006.var2 = i_qfile.lib;
    o_msgdta = usr0006;
  else;
    o_msgid = *blanks;
    o_msgdta = *blanks;
  endif;
endif;

*inlr = '1';

//====================================================*
//  First  --  Initialize program                     *
//====================================================*

begsr first;

  nbrofkey = *zeros;

  // - Meldung
  //**                Callp     p_sndStsMg('USR8137': XQFile)

  // - Los gehts'
  o_msgid = *blanks;
  o_msgdta = *blanks;

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  peek41_name = f_pgmcalln('PEEK41');

endsr;

//============================================================*
//  Program error handler                                     *
//============================================================*

dcl-proc errorhandler;
  dcl-pi *N;
    i_condtoken     value likeds(cee_fc_t);
    i_pcommarea     int(10) value;
    o_action        int(10);
    o_newcondtoken  likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

