**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Generische Abfrage-Window                    *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.2.0                               *
//  Programm : PEEK59                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 06.08.1999  Raddatz                               *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Generische Nachrichtenabfrage                     *
//                                                               *
//===============================================================*
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

dcl-f peek59fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

dcl-ds workstn likeds(workstn_t);

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/d_workstn.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/scrnfkeys.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/copy 'qcopyle/usr8100.rpgleinc'
/copy 'qcopyle/usr8190.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek59.rpgleinc'
/undefine internal_prototype

//  Peek21
dcl-s yPgmCmd like(pgmCmd_t);
dcl-s yCmdDta like(pgmCmdDt_t);
dcl-s yMsgID like(msgId_t);
dcl-s yMsgDta like(msgDta_t);

//  Peek23:
dcl-s yKey char(10);
dcl-s yFKeys like(fKeyDsp_t) dim(32);
dcl-s yNbrOfKeys like(int4_t);

dcl-s sfBot like(int4_t);
dcl-c NbrFKeys 2;
dcl-s msgText char(200);
dcl-s strPos like(uint4_t);
dcl-s nbrOfKeys like(int4_t);

dcl-s peek21_name like(pgmCallN_t);
dcl-s peek23_name like(pgmCallN_t);

dcl-s x like(int4_t) inz;
dcl-s tmpFkey like($$fkey01);
dcl-s int1 like(int4_t);
dcl-s int2 like(int4_t);
dcl-s isChanged like(bool_t) inz(bFalse);

dcl-s options uns(10);

dcl-pr atoi int(10) extproc('atoi');
  i_string pointer value;
end-pr;

/copy 'qcopyle/ppeek21.rpgleinc'
/copy 'qcopyle/ppeek23.rpgleinc'

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

dcl-s $$fkey like($$fkey01) dim(24);

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek59;
  i_dsp80  like(dsp80_t) const;
  i_type   like(type_t) const;
  i_msgID  like(msgId_t) const;
  i_msgDta like(msgDta_t) const;
  i_keys   like(keys_t) const;
  o_msgID  like(msgId_t);
  o_msgDta like(msgDta_t);
end-pi;
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

dow ('1');

  exsr toScreen;

  //  Nachrichten anzeigen
  *in89 = *off;
  write msgCtl;

  //  Anzeigen der Befehlstasten
  select;
  when ((sfBot = 2) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#2;
  when ((sfBot = 3) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#3;
  when ((sfBot = 4) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#4;
  when ((sfBot = 5) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#5;
  when ((sfBot = 6) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#6;
  when ((sfBot = 7) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#7;
  when ((sfBot = 8) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#8;
  when ((sfBot = 9) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#9;
  when ((sfBot = 10) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#10;
  when ((sfBot = 11) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#11;
  when ((sfBot = 12) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#12;
  other;
    write pbbot#1;
    sfBot = 1;
  endsl;

  //  Anzeigen Bildschirm
  exfmt bild01;

  exsr fromScreen;

  //  Nachrichten löschen
  p_rmvPgmMg(sds.pgmName);

  //  Bezugszahlen löschen
  exsr bzoff1;

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmName
        : yPgmCmd: yCmdDta: yMsgID: yMsgDta);
  if (yMsgID <> ' ');
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
    iter;
  endif;

  //  Abfragen der Programmbefehle
  select;
  //  F5  - Aktualisieren
  when (yPgmCmd = '*REFRESH');
    exsr c_refresh;
    iter;
  //  F9  - Yes
  when ((yPgmCmd = '*YES'   )  and
     (f_scan('Y': i_keys  ) <> 0));
    exsr c_yes;
    leave;

  //  F21 - No
  when ((yPgmCmd = '*NO'    ) and
     (f_scan('N': i_keys  ) <> 0));
    exsr c_no;
    leave;

  //  F12 - Cancel
  when ((yPgmCmd = '*CANCEL') and
     (f_scan('C': i_keys  ) <> 0));
    exsr c_cancel;
    leave;

  //  F24 - Weitere Tasten
  when (yPgmCmd = '*MOREKEYS');
    exsr c_moreKeys;
    iter;

  //  Datenfreigabe = OK
  when ((yPgmCmd = '*ENTER' ) and
     (f_scan('E': i_keys  ) <> 0));
    exsr c_enter;
    leave;

  other;
    //  Falsche Taste gedrückt
    p_wrongKey(workstn.aid: sds.pgmName);
    iter;
  endsl;

enddo;

close peek59fm;

*inlr = *on;

//============================================================*
//    BZOFF1        Ausschalten aller Fehlerbezugszahlen      *
//============================================================*

begsr bzoff1;

  //  DSPATR(PC)

  //  DSPATR(RI)

  //  Fehler
  *in99 = '0';

endsr;

//============================================================*
//    c_yes         F9 = Yes                                  *
//============================================================*

begsr c_yes;

  clear usr8190;
  usr8190.var1 = yPgmCmd;
  o_msgID  = 'USR8190';
  o_msgDta = usr8190;

endsr;

//============================================================*
//    c_no          F3 = No                                   *
//============================================================*

begsr c_no;

  clear usr8190;
  usr8190.var1 = yPgmCmd;
  o_msgID  = 'USR8190';
  o_msgDta = usr8190;

endsr;

//============================================================*
//    c_enter       "Datenfreigabetaste" = OK                 *
//============================================================*

begsr c_enter;

  clear usr8190;
  usr8190.var1 = yPgmCmd;
  o_msgID  = 'USR8190';
  o_msgDta = usr8190;

endsr;

//============================================================*
//    c_cancel      F12 = Cancel                              *
//============================================================*

begsr c_cancel;

  clear usr8190;
  usr8190.var1 = yPgmCmd;
  o_msgID  = 'USR8190';
  o_msgDta = usr8190;

endsr;

//============================================================*
//    c_refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  exsr fill##;

endsr;

//============================================================*
//    c_moreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_moreKeys;

  sfBot = sfBot + 1;

endsr;

//============================================================*
//    FILL##        Füllen Bildschirm                         *
//============================================================*

begsr fill##;

  //  Überschrift ...
  select;
  when (i_type = '*INFO');
    $$headLine = f_msgText('MBX0001': ' ');
  when (i_type = '*QUESTION');
    $$headLine = f_msgText('MBX0002': ' ');
  other;
    $$headLine = ' ';
  endsl;

  $$headLine = f_center($$headLine);

  //  Nachrichtentext ...
  msgText = f_msgText(i_msgID: i_msgDta);

  options = cWORDWRAP_PARAGRAPH_MSGD + cWORDWRAP_PARAGRAPH_TRIMR;

  //  ... Zeile 1
  strPos = 1;
  $$line#01 = f_wordWrap(msgText: 40: strPos: options);
  $$line#01 = %triml($$line#01);
  //  ... Zeile 2
  if (strPos > 0);
    $$line#02 = f_wordWrap(msgText: 40: strPos: options);
    $$line#02 = %triml($$line#02);
  endif;
  //  ... Zeile 3
  if (strPos > 0);
    $$line#03 = f_wordWrap(msgText: 40: strPos: options);
    $$line#03 = %triml($$line#03);
  endif;
  //  ... Zeile 4
  if (strPos > 0);
    $$line#04 = f_wordWrap(msgText: 40: strPos: options);
    $$line#04 = %triml($$line#04);
  endif;
  //  ... Zeile 5
  if (strPos > 0);
    $$line#05 = f_wordWrap(msgText: 40: strPos: options);
    $$line#05 = %triml($$line#05);
  endif;

  //  Funktionstasten ...
  nbrOfKeys = 0;
  yFKeys(*) = '';
  $$fkey(*) = '';
  //  ... YES
  if (f_scan('Y': i_keys) <> 0);
    nbrOfKeys = nbrOfKeys + 1;
    yKey = '*YES';
    exsr getKey;
    $$fkey(nbrOfKeys) = yFKeys(1);
  endif;
  //  ... NO
  if (f_scan('N': i_keys) <> 0);
    nbrOfKeys = nbrOfKeys + 1;
    yKey = '*NO';
    exsr getKey;
    $$fkey(nbrOfKeys) = yFKeys(1);
  endif;
  //  ... OK
  if (f_scan('E': i_keys) <> 0);
    nbrOfKeys = nbrOfKeys + 1;
    yKey = '*OK';
    exsr getKey;
    $$fkey(nbrOfKeys) = yFKeys(1);
  endif;
  //  ... CANCEL
  if (f_scan('C': i_keys) <> 0);
    nbrOfKeys = nbrOfKeys + 1;
    yKey = '*CANCEL';
    exsr getKey;
    $$fkey(nbrOfKeys) = yFKeys(1);
  endif;

  //  Sortieren der Funktionstasten nach der Nummer der F-Taste
  //  (in $$fkey: toscreen überträgt es vor jeder Anzeige in die
  //  Bildschirmfelder $$FKEY01 ff.)
  if (nbrOfKeys > 1);
    dou (isChanged = bFalse);
      isChanged = bFalse;
      for x = 2 to nbrOfKeys;
        tmpFkey = %subst($$fkey(x-1): 2)+x'00';
        int1 = atoi(%addr(tmpFkey));
        tmpFkey = %subst($$fkey(x  ): 2)+x'00';
        int2 = atoi(%addr(tmpFkey));
        if (int2 < int1);
          isChanged = bTrue;
          tmpFkey = $$fkey(x-1);
          $$fkey(x-1) = $$fkey(x);
          $$fkey(x  ) = tmpFkey;
        endif;
      endfor;
    enddo;
  endif;

  yNbrOfKeys = nbrOfKeys;

endsr;

//============================================================*
//    getKey        Einlesen F-Taste                          *
//============================================================*

begsr getKey;

  peek23(sds.pgmName: yKey: 0
        : yFKeys: yNbrOfKeys);

endsr;

//============================================================*
//    setScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setScreen;

  if (i_dsp80 = *off);
    //   132-Zeichen Anzeige
    *in88 = *off;
    zei = 6 + 1;
    pos = 40;
  else;
    //    80-Zeichen Anzeige
    *in88 = *on;
    zei = 4 + 3;
    pos = 7;
  endif;

endsr;

//====================================================*
//  Copy program fields to screen.                    *
//====================================================*

begsr toScreen;

  $$fkey01 = $$fkey( 1);
  $$fkey02 = $$fkey( 2);
  $$fkey03 = $$fkey( 3);
  $$fkey04 = $$fkey( 4);
  $$fkey05 = $$fkey( 5);
  $$fkey06 = $$fkey( 6);
  $$fkey07 = $$fkey( 7);
  $$fkey08 = $$fkey( 8);
  $$fkey09 = $$fkey( 9);
  $$fkey10 = $$fkey(10);
  $$fkey11 = $$fkey(11);
  $$fkey12 = $$fkey(12);
  $$fkey13 = $$fkey(13);
  $$fkey14 = $$fkey(14);
  $$fkey15 = $$fkey(15);
  $$fkey16 = $$fkey(16);
  $$fkey17 = $$fkey(17);
  $$fkey18 = $$fkey(18);
  $$fkey19 = $$fkey(19);
  $$fkey20 = $$fkey(20);
  $$fkey21 = $$fkey(21);
  $$fkey22 = $$fkey(22);
  $$fkey23 = $$fkey(23);
  $$fkey24 = $$fkey(24);

endsr;

//====================================================*
//  Copy screen to program fields.                    *
//====================================================*

begsr fromScreen;

  $$fkey( 1) = $$fkey01;
  $$fkey( 2) = $$fkey02;
  $$fkey( 3) = $$fkey03;
  $$fkey( 4) = $$fkey04;
  $$fkey( 5) = $$fkey05;
  $$fkey( 6) = $$fkey06;
  $$fkey( 7) = $$fkey07;
  $$fkey( 8) = $$fkey08;
  $$fkey( 9) = $$fkey09;
  $$fkey(10) = $$fkey10;
  $$fkey(11) = $$fkey11;
  $$fkey(12) = $$fkey12;
  $$fkey(13) = $$fkey13;
  $$fkey(14) = $$fkey14;
  $$fkey(15) = $$fkey15;
  $$fkey(16) = $$fkey16;
  $$fkey(17) = $$fkey17;
  $$fkey(18) = $$fkey18;
  $$fkey(19) = $$fkey19;
  $$fkey(20) = $$fkey20;
  $$fkey(21) = $$fkey21;
  $$fkey(22) = $$fkey22;
  $$fkey(23) = $$fkey23;
  $$fkey(24) = $$fkey24;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Öffnen der Dateien
  open peek59fm;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  o_msgID  = ' ';
  o_msgDta = ' ';

  // - Füllen der Bildschirmfelder
  exsr bzoff1;
  exsr fill##;

  // - Darstellung der Befehlstasten
  sfBot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setScreen;

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  pgmQ = '*';

  peek21_name = f_pgmCallN('PEEK21');
  peek23_name = f_pgmCallN('PEEK23');

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

