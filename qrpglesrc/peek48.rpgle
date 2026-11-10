**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - SQL-Select/Order by                          *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK50                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 16.03.99  Raddatz                                 *
//  geändert : 27.04.99  2.1.0                                   *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - SQL-Select/Order by                               *
//                                                               *
//===============================================================*
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

dcl-f peek48fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

dcl-ds workstn likeds(workstn_t);
dcl-ds cursorPosition likeds(cursorPosition_t) inz;

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/d_workstn.rpgleinc'
/copy 'qcopyle/shortcmd_d.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/keyl0100.rpgleinc'
/copy 'qcopyle/scrnfkeys.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/copy 'qcopyle/usr8100.rpgleinc'

/copy 'qcopyle/set0008.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek48.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek21.rpgleinc'
/copy 'qcopyle/ppeek23.rpgleinc'
/copy 'qcopyle/ppeek37.rpgleinc'
/copy 'qcopyle/ppeek38.rpgleinc'
/copy 'qcopyle/ppeek40.rpgleinc'

/copy 'qcopyle/ppeek51.rpgleinc'
/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'
/copy 'qcopyle/ppeek63.rpgleinc'

dcl-ds set0008 likeds(set0008_t) inz;

dcl-s yFKeys char(18) dim(32) inz;
dcl-s yNbrOfKeys like(int4_t) inz;
dcl-s yMsgID char(7) inz(*blanks);
dcl-s yMsgDta char(512) inz(*blanks);

dcl-s yPgmCmd char(10) inz(*blanks);
dcl-s yCmdDta like(pgmCmdDt_t) inz;

dcl-s yField char(10) inz(*blanks);

dcl-s ySqlOrder like(sqlOrder_t) inz(*blanks);

dcl-s yRetFile char(10) inz(*blanks);
dcl-s yRetLib char(10) inz(*blanks);

dcl-s sfBot like(int4_t) inz;
dcl-c NbrFKeys 3;

dcl-s peek21_name like(pgmCallN_t) inz;
dcl-s peek23_name like(pgmCallN_t) inz;
dcl-s peek37_name like(pgmCallN_t) inz;
dcl-s peek38_name like(pgmCallN_t) inz;
dcl-s peek40_name like(pgmCallN_t) inz;

dcl-s tempScnFld like(scnFld) inz;
dcl-s tempFldPos like(fldPos) inz;
dcl-s tempLen like(int4_t) inz;
dcl-s tempCsrRow like(int4_t) inz;
dcl-s tempCsrCol like(int4_t) inz;
dcl-s tempFldLen like(int4_t) inz;
dcl-s tempFldBy like(int4_t) inz;

//  Einfügen der Schlüsselfelder in ##ORDER
dcl-s insKeys like(sqlOrder_t) inz;
dcl-s keyLen like(int4_t) inz;
dcl-s scanpos like(int4_t) inz;
dcl-s usedLen like(int4_t) inz;

dcl-ds pFile qualified;
  name    like(io_file);
  library like(io_library);
  member  like(io_member);
  format  like(io_rcdFmt);
end-ds;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek48;
  i_dsp80       like(dsp80_t) const;
  i_copyright   like(copyright_t) const;
  io_file       like(file_t);
  io_library    like(lib_t);
  io_member     like(mbr_t);
  io_rcdFmt     like(fmt_t);
  i_accessMode  like(accessMode_t) const;
  io_sqlWhere   like(sqlWhere_t);
  io_sqlOrder   like(sqlOrder_t);
  i_enableWhere like(bool_t) const;
  i_enableOrder like(bool_t) const;
  o_msgID       like(msgId_t);
  o_msgDta      like(msgDta_t);
end-pi;
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler'): *null: *omit);

exsr inzsr;

exsr first;

//---------------------------------------------------*
//  Schleife für Programmbearbeitung

dow ('1');

  //  Nachrichten anzeigen
  *in89 = '0';
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
  other;
    write pbbot#1;
    sfBot = 1;
  endsl;

  //  Anzeigen Bildschirm
  exfmt bild01;

  //  Berechnen Zeile/Spalte
  cursorPosition.row = workstn.csrPos / 256;
  cursorPosition.column = %rem(workstn.csrPos: 256);

  //  Nachrichten löschen
  p_rmvPgmMg(sds.pgmName);

  //  Merken Cursorposition
  exsr keepCsrPos;

  //  Bezugszahlen löschen
  exsr bzoff1;

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmName
        : yPgmCmd: yCmdDta: yMsgID: yMsgDta);
  if (yMsgID <> *blanks);
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
    iter;
  endif;

  //  Abfragen der Programmbefehle
  select;
  //  F3  - Ende
  when (yPgmCmd = '*EXIT');
    exsr c_endPgm;
    leave;
  //  F4  - Prompt
  when (yPgmCmd = '*PROMPT');
    tempScnFld = scnFld;
    tempFldPos = fldPos;
    exsr c_prompt;
    iter;

  //  F5  - Aktualisieren
  when (yPgmCmd = '*REFRESH');
    exsr c_refresh;
    iter;

  //  F9  - Auswählen Sortierfolge
  when (yPgmCmd = '*DSPDBR');
    tempScnFld = scnFld;
    tempFldPos = fldPos;
    exsr c_selectKy;
    iter;

  //  F11 - Einfügen Keyfelder
  when (yPgmCmd = '*INSKEYFLD');
    tempScnFld = scnFld;
    tempFldPos = fldPos;
    exsr c_insKeyFd;
    iter;

  //  F12 - Ende
  when (yPgmCmd = '*CANCEL');
    exsr c_endPgm;
    leave;

  //  F24 - Weitere Tasten
  when (yPgmCmd = '*MOREKEYS');
    exsr c_moreKeys;

  //  Datenfreigabe
  when (yPgmCmd = '*ENTER');
    exsr c_enter;
    if (*in99 = *off);
      o_msgID = 'USR8112';
      o_msgDta = *blanks;
      leave;
    endif;

  other;
    //  Falsche Taste gedrückt
    p_wrongKey(workstn.aid: sds.pgmName);
    iter;
  endsl;

enddo;

close peek48fm;

return;

//============================================================*
//    c_enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  exsr dltCsrPos;

  ##order = SQL_quote(##order);

  if (SQL_prepareStatement(
         '1': pFile.name: pFile.library: pFile.member: pFile.format:
         ##where: ##order: yMsgID: yMsgDta));
    io_file      = pFile.name;
    io_library   = pFile.library;
    io_member    = pFile.member;
    io_rcdFmt    = pFile.format;
    io_sqlWhere  = ##where;
    io_sqlOrder  = ##order;
    *in99 = '0';
  else;
    if (yMsgID <> '');
      p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
      yMsgID = '';
      yMsgDta = '';
    endif;
    *in99 = '1';
  endif;

endsr;

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
//    c_endPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr c_endPgm;

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

endsr;

//============================================================*
//    c_prompt      F4  - Prompt                              *
//============================================================*

begsr c_prompt;

  //  Steht im Feld nur das Prompt-Zeichen (z. B. '?'), gilt der Prompt
  //  diesem Feld, auch wenn der Cursor nicht darin steht. Der
  //  ausgewählte Feldname ersetzt das Zeichen (pmt_field).
  if (set0008.set_prmt <> ' ');
    if (##where = set0008.set_prmt and tempScnFld <> '##ORDER');
      tempScnFld = '##WHERE';
    elseif (##order = set0008.set_prmt and tempScnFld <> '##WHERE');
      tempScnFld = '##ORDER';
    endif;
  endif;

  select;
  when (tempScnFld = '##WHERE');
    if (*in71 = *on);
      p_sndPgmMg('USR8195': '': sds.pgmName);
    else;
      exsr pmt_field;
    endif;

  when (tempScnFld = '##ORDER');
    if (*in72 = *on);
      p_sndPgmMg('USR8195': '': sds.pgmName);
    else;
      exsr pmt_field;
    endif;

  other;
    p_sndPgmMg('USR8179': '': sds.pgmName);
  endsl;

endsr;

//============================================================*
//    pmt_field     Prompt - Field                            *
//============================================================*

begsr pmt_field;

  peek37(i_dsp80: i_copyright: yField
        :  yMsgID: yMsgDta);

  if (yMsgID = '');

    tempLen = %checkr(' ': yField);

    select;
    when (tempScnFld = '##WHERE');
      if (set0008.set_prmt <> ' ' and ##where = set0008.set_prmt);
        ##where = '';
        tempFldPos = 1;
      endif;
      ##where = %replace(%trimr(yField) + ' '
                        : ##where
                        : tempFldPos
                        : 0);
      tempCsrRow =  5;
      tempCsrCol = 17;
      tempFldPos = tempFldPos + tempLen + 1;
      tempFldLen = %len(##where);
      tempFldBy  = 42;

    when (tempScnFld = '##ORDER');
      if (set0008.set_prmt <> ' ' and ##order = set0008.set_prmt);
        ##order = '';
        tempFldPos = 1;
      endif;
      ##order  = %replace(%trimr(yField) + ' '
                         : ##order
                         : tempFldPos
                         : 0);
      tempCsrRow = 12;
      tempCsrCol = 17;
      tempFldPos = tempFldPos + tempLen + 1;
      tempFldLen = %len(##order);
      tempFldBy  = 42;

    other;
      //  Kein Eingabefeld: nichts einfügen, Cursor nicht versetzen
      leavesr;
    endsl;

    if (tempFldPos > tempFldLen);
      tempFldPos = tempFldLen;
    endif;

    if (%rem(tempFldPos: tempFldBy) = 0);
      tempCsrCol = tempCsrCol + tempFldBy;
    else;
      tempCsrCol = tempCsrCol +
                  %rem(tempFldPos: tempFldBy);
    endif;

    if (%rem(tempFldPos: tempFldBy) = 0);
      tempCsrRow = tempCsrRow +
                  %int(tempFldPos/ tempFldBy) - 1;
    else;
      tempCsrRow = tempCsrRow +
                  %int(tempFldPos/ tempFldBy);
    endif;

    csrRow = tempCsrRow;
    csrCol = tempCsrCol - 1;

  else;
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
  endif;

endsr;

//============================================================*
//    c_refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  exsr bzoff1;
  exsr fill##;

endsr;

//============================================================*
//    c_selectKy    Auswählen Sortierfolge                    *
//============================================================*

begsr c_selectKy;

  select;
  when (tempScnFld = '##ORDER');
    if (*in72 = *on);
      p_sndPgmMg('USR8195': '': sds.pgmName);
    else;
      exsr slc_key;
    endif;
  other;
    p_sndPgmMg('USR8211': '': sds.pgmName);
  endsl;

endsr;

//============================================================*
//    slc_key       Auswählen Sortierfolge                   *
//============================================================*

begsr slc_key;

  yMsgID = '';
  yMsgDta = '';
  peek40(i_dsp80: i_copyright
        : io_file: io_library: io_member
        : io_rcdFmt: bTrue
        : yRetFile: yRetLib
        : yMsgID: yMsgDta);

  select;
  //  ... Fehler von PEEK40 (USR8100: mit F3/F12 verlassen)
  when (yMsgID <> '' and yMsgID <> 'USR8100');
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
  //  ... Datei ausgewählt
  when (yRetFile <> *blanks);
    io_file = yRetFile;
    io_library = yRetLib;
    exsr ins_field;
  endsl;

  yMsgID = '';
  yMsgDta = '';

endsr;

//============================================================*
//    c_insKeyFd    Insert Key Fields                         *
//============================================================*

begsr c_insKeyFd;

  select;
  when (tempScnFld = '##ORDER');
    if (*in72 = *on);
      p_sndPgmMg('USR8195': '': sds.pgmName);
    else;
      exsr ins_field;
    endif;
  other;
    p_sndPgmMg('USR8211': '': sds.pgmName);
  endsl;

endsr;

//============================================================*
//    ins_field     Insert Key Fields                         *
//============================================================*

begsr ins_field;

  ySqlOrder = '';
  peek38(io_file: io_library: ySqlOrder);
  insKeys = %trimr(ySqlOrder);

  //  Die Schlüsselfelder werden an der Cursorposition in ##ORDER
  //  eingefügt, vorhandener Text rückt nach rechts (wie bei F4).
  usedLen = %len(%trimr(##order));
  if (tempFldPos - 1 > usedLen);
    usedLen = tempFldPos - 1;
  endif;

  //  Nur ganze Schlüsselfelder einfügen, soweit sie Platz haben.
  if (%len(insKeys) > %len(##order) - usedLen);
    keyLen = 0;
    scanpos = %scan(', ': insKeys);
    dow (scanpos > 0 and scanpos - 1 <= %len(##order) - usedLen);
      keyLen = scanpos - 1;
      if (scanpos + 2 > %len(insKeys));
        leave;
      endif;
      scanpos = %scan(', ': insKeys: scanpos + 2);
    enddo;
    insKeys = %subst(insKeys: 1: keyLen);
    //  USR8176: Warnung: Zeichenkette zu lang.
    p_sndPgmMg('USR8176': '': sds.pgmName);
  endif;

  if (%len(insKeys) > 0);
    ##order = %replace(insKeys: ##order: tempFldPos: 0);
  endif;

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

  $$sql = 'SELECT * FROM '      +
         %trim(pFile.library)  +
         '/'                   +
         %trim(pFile.name)     +
         '('                   +
         %trim(pFile.member)   +
         ')'                   +
         ' ...';

  ##where = io_sqlWhere;
  ##order = io_sqlOrder;

  //  Schlüsselfolge als Vorgabe, auch wenn ORDER BY nicht geändert
  //  werden darf: Sie hält bei SQL-Zugriff die bisherige Reihenfolge.
  if ((i_accessMode = KEY_SEQ) and
      (##order  = ' '    ));
    tempFldPos = 1;
    exsr ins_field;
  endif;

endsr;

//============================================================*
//    keepCsrPos    Beibehalten der Cursorposition            *
//============================================================*

begsr keepCsrPos;

  //  Beibehalten der Cursorosition
  csrRow = cursorPosition.row - zei;
  csrCol = cursorPosition.column - pos;
  csrCol = csrCol - 1;

endsr;

//============================================================*
//    dltCsrPos     Löschen der Cursorposition                *
//============================================================*

begsr dltCsrPos;

  //  Löschen der Cursorosition
  csrRow = *zeros;
  csrCol = *zeros;

endsr;

//============================================================*
//    getUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr getUsrSetg;

  //  *PROMPT
  set0008 = f_getUsrSg('*PROMPT');

endsr;

//============================================================*
//    setScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setScreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 2;
    pos = 16;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 2;
    pos = 5;
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Ermitteln physische Datei
  f_basedPF(io_file    :
           io_library :
           io_member  :
           io_rcdFmt  :
           1        :
           pFile.name    :
           pFile.library :
           pFile.member  :
           pFile.format  );

  // - Öffnen der Dateien
  open peek48fm;

  // - Programm initialisieren (vor fill##, damit dessen Warnung
  //   USR8176 erhalten bleibt)
  p_rmvPgmMg(sds.pgmName);

  // - Benutzervoreinstellungen (Prompt-Zeichen)
  exsr getUsrSetg;

  // - Setzen Ändern erlaubt für: WHERE und ORDER BY
  if (i_enableWhere = bTrue);
    *in71 = *off;
  else;
    *in71 = *on;
  endif;

  if (i_enableOrder = bTrue);
    *in72 = *off;
  else;
    *in72 = *on;
  endif;

  // - Füllen der Bildschirmfelder
  exsr bzoff1;
  exsr fill##;

  exsr dltCsrPos;

  o_msgID = '';
  o_msgDta = '';

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
  peek37_name = f_pgmCallN('PEEK37');
  peek38_name = f_pgmCallN('PEEK38');
  peek40_name = f_pgmCallN('PEEK40');

  peek23(sds.pgmName: '*ALL': NbrFKeys
        : yFKeys: yNbrOfKeys);
  scrnFKeys = %subarr(yFKeys: 1);

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

