**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK12                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 02.10.97  Raddatz                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Auswahl Satzformat                                           *
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

dcl-f peek12fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbsfl: SflRec);

dcl-f peekfmt usropn infds(Peek_01_DS) prefix(f_);

dcl-ds workstn likeds(workstn_t);

dcl-ds Peek_01_DS likeds(infds_t);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,D_INFDS
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,RCDL0200
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,ShortCmd_D
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,SDS

/define internal_prototype
/copy QCOPYLE,PPEEK12
/undefine internal_prototype

/copy QCOPYLE,USR8100

dcl-ds rcdl0200 likeds(RCDL0200_t) inz;

dcl-s sfbot like(int4_t) inz;

dcl-s lastRcdNbr like(rcdNbr_t) inz;
dcl-s SflPage like(int4_t) inz;
dcl-s SflRec like(SflPage) inz;
dcl-s SflLastRcd like(SflPage) inz;
dcl-c NBR_F_KEYS 3;

dcl-s peek21_name like(pgmCallN_t) inz;
dcl-s peek23_name like(pgmCallN_t) inz;

//  PEEK21
dcl-s YPgmCmd char(10) inz(*blanks);
dcl-s YCmdDta like(pgmCmdDt_t) inz(*blanks);
dcl-s YMsgID char(7) inz(*blanks);
dcl-s YMsgDta char(512) inz(*blanks);

//  PEEK23
dcl-s yFKeys char(18) dim(32) inz(*blanks);
dcl-s yNbrOfKeys like(int4_t) inz;

/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23
/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

/copy QCOPYLE,CEECNDHDLR

dcl-s isInzSr like(bool_t) inz(bFalse);
dcl-s isExitPgm like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek12;
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyright_t) const;
  i_fmtName   like(fmt_t) const;
  i_fmtMode   like(mode_t) const;
  o_rcdl0200  likeds(RCDL0200_t);
  o_fmtNbr    like(int2_t);
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr First;

dow (isExitPgm = bFalse);

  //  Prüfen Positionierung der Subfile
  if ((sfsanr <= 0     )  or
      (sfsanr >  SflRec));
    sfsanr = 1;
  endif;

  //  Modus: DROP/FOLD
  *in86 = sflmde;

  //  Nachrichten anzeigen
  *in89 = '0';
  write msgctl;

  //  "Keine Sätze ..."
  if (*in80 = *off);
    write pbleer;
  endif;

  //  Anzeigen der Befehlstasten
  write pbbot#0;

  select;
  when ((sfbot = 2) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#2;
  when ((sfbot = 3) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#3;
  when ((sfbot = 4) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#4;
  when ((sfbot = 5) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#5;
  when ((sfbot = 6) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#6;
  other;
    write pbbot#1;
    sfbot = 1;
  endsl;

  //  Anzeige der Subfile
  exfmt pbctl;

  //  Nachrichten löschen
  p_rmvPgmMg(sds.pgmName);

  //  Aktuelle Satz-Nr.
  sfsanr = SflCsr;

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmName
        : YPgmCmd: YCmdDta: YMsgID: YMsgDta);
  if (YMsgID <> *blanks);
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    iter;
  endif;

  //  Abfragen der Befehlstasten
  select;
  //  F3  - Ende
  when (YPgmCmd = '*EXIT');
    exsr C_EndPgm;
    leave;

  //  F5  - Aktualisieren
  when (YPgmCmd = '*REFRESH');
    exsr C_Refresh;
    iter;

  //  F12 - Ende
  when (YPgmCmd = '*CANCEL');
    exsr C_EndPgm;
    leave;

  //  Datenfreigabe
  when (YPgmCmd = '*ENTER');
    exsr C_Enter;

  //  F24 - Weitere Tasten
  when (YPgmCmd = '*MOREKEYS');
    exsr C_MoreKeys;

  other;
    //  Falsche Taste gedrückt
    p_wrongKey(workstn.aid: sds.pgmName);
    iter;
  endsl;

enddo;

close peekfmt;

*inlr = *on;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr C_Enter;

  if (*in80 = *off);
  // Subfile ist leer
  else;
    dow ('1');
      readc pbsfl;
      if (%eof());
        leave;
      endif;

      //  Die erste markierte Zeile auswählen. Weitere Markierungen und
      //  Zeilen, deren Markierung wieder gelöscht wurde, ignorieren.
      if (sfpau <> '');
        o_rcdl0200 = $$rcdl0200;
        o_fmtNbr = fmtnbr;
        leave;
      endif;
    enddo;
  endif;

  if (o_rcdl0200 <> '');
    isExitPgm = bTrue;
  endif;

endsr;

//============================================================*
//    C_EndPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr C_EndPgm;

  write rmvwdw;

  p_rmvPgmMg(sds.pgmName);

  o_msgID = 'USR8100';

  select;
  when (workstn.aid = k_f3);
    usr8100.var1 = 'F3';
  when (workstn.aid = k_f12);
    usr8100.var1 = 'F12';
  other;
    usr8100.var1 = 'Fxx';
  endsl;

  o_msgDta = usr8100;

  o_rcdl0200 = *blanks;
  o_fmtNbr = *zeros;

endsr;

//============================================================*
//    C_Refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr C_Refresh;

  exsr PBFirstRcd;
  exsr PBInit;
  exsr PBSetLL;
  exsr PBReadUp;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr C_MoreKeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    PBInit        Initialisieren der Subfile zur Anzeige    *
//                  der nächsten Seite                        *
//============================================================*

begsr PBInit;

  *in89 = '0';
  write msgctl;

  *in80 = '0'; // SFLDSP
  *in81 = '1'; // SFLDSPCTL
  *in82 = '1'; // SFLCLR
  *in83 = '1'; // SFLEND
  write pbctl;

  *in82 = '0'; // SFLCLR

  SflRec = *zeros;

  SflLastRcd = *zeros;

endsr;

//============================================================*
//    PBFirstRcd    Ersten geschriebenen Satz der Subfile     *
//                  einlesen                                  *
//============================================================*

begsr PBFirstRcd;

  if (*in80 = *off);
    lastRcdNbr = 0;
  else;

    chain 1 pbsfl;

    if (not %found());
      lastRcdNbr = 0;
    else;
      lastRcdNbr = recordNbr;
    endif;
  endif;

endsr;

//============================================================*
//    PBReadUP      Vorwärts füllen der Subfile               *
//============================================================*

begsr PBReadUp;

  dow ('1');
    read fpeekfmt;
    if (%eof());
      *in83 = bTrue;
      leave;
    endif;

    SflRec = SflRec + 1;

    if (SflRec > 9999);
      *in83 = bTrue;
      leave;
    endif;

    exsr PBFill;

    write pbsfl;

    SflLastRcd = SflRec;

    if (SflRec >= SflPage);
      leave;
    endif;
  enddo;

  exsr PBExit;

endsr;

//============================================================*
//    PBExit        Hinter füllen Subfile                     *
//============================================================*

begsr PBExit;

  exsr PBFirstRcd;

endsr;

//============================================================*
//    PBFill        Füllen Subfilesatz                        *
//============================================================*

begsr PBFill;

  sfpau = *blanks;
  rcdl0200 = F_Fmt;
  $$rcdl0200 = F_Fmt;
  $$Format = rcdl0200.R2FmtName;
  $$text = rcdl0200.R2Text;
  recordNbr = Peek_01_DS.RcdNbr;
  fmtnbr = F_FmtNbr;

  *in80 = '1'; // SFLDSP
  lastRcdNbr = Peek_01_DS.RcdNbr;

endsr;

//============================================================*
//    PBSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr PBSetLL;

  setll lastRcdNbr fpeekfmt;

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr SetScreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 4;
    pos = 12;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 4;
    pos = 8;
  endif;

  SflPage = *hival;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr First;

  // - Dateien öffnen
  open peekfmt;

  o_msgID = *blanks;
  o_msgDta = *blanks;

  // - Prüfen auf Satzformat
  if ((i_fmtMode = MODE_BATCH) and
      ((Peek_01_DS.nbrOfRcd = 1) or (i_fmtName <> '')));
    setll 1 fpeekfmt;
    dou (%eof(peekfmt));
      read fpeekfmt;
      if (not %eof(peekfmt));
        rcdl0200 = F_Fmt;
        if ((rcdl0200.R2FmtName = i_fmtName) or
            ((Peek_01_DS.nbrOfRcd = 1) and (i_fmtName = '')));
          o_rcdl0200 = F_Fmt;
          o_fmtNbr = F_FmtNbr;
          isExitPgm = bTrue;
          leavesr;
        endif;
      endif;
    enddo;
  endif;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  o_rcdl0200 = *blanks;
  o_fmtNbr = *zeros;

  // - Darstellung der Subfile
  sflmde = '1';

  // - Darstellung der Befehlstasten
  sfbot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr SetScreen;

  // - Subfile füllen
  lastRcdNbr = 1;
  exsr PBInit;
  exsr PBSetLL;
  exsr PBReadUp;

  // - Copyright
  p_sndPgmMg('USR9999': i_copyright: sds.pgmName);

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  PGMQ = '*';

  peek21_name = f_pgmCallN('PEEK21');
  peek23_name = f_pgmCallN('PEEK23');

  peek23(sds.pgmName: '*ALL': NBR_F_KEYS
        : yFKeys: yNbrOfKeys);
  ScrnFKeys = %subarr(yFKeys: 1);

  open peek12fm;

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

