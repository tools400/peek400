**free
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

dcl-f peek48fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

dcl-ds workstn likeds(workstn_t);
dcl-ds cursorPosition likeds(cursorPosition_t) inz;

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,ShortCmd_D
/copy QCOPYLE,SDS
/copy QCOPYLE,KEYL0100
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,CEECNDHDLR

/copy QCOPYLE,USR8100

/copy QCOPYLE,SET0008

/define internal_prototype
/copy QCOPYLE,PPEEK48
/undefine internal_prototype

/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23
/copy QCOPYLE,PPEEK37
/copy QCOPYLE,PPEEK38
/copy QCOPYLE,PPEEK40

/copy QCOPYLE,PPEEK51
/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58
/copy QCOPYLE,PPEEK63

dcl-ds set0008 likeds(set0008_t) inz;

dcl-s yFKeys char(18) dim(32) inz;
dcl-s yNbrOfKeys like(int4_t) inz;
dcl-s YMsgID char(7) inz(*blanks);
dcl-s YMsgDta char(512) inz(*blanks);

dcl-s YPgmCmd char(10) inz(*blanks);
dcl-s YCmdDta like(pgmCmdDt_t) inz;

dcl-s YField char(10) inz(*blanks);

dcl-s YSqlOrder like(sqlOrder_t) inz(*blanks);

dcl-s yRetFile char(10) inz(*blanks);
dcl-s yRetLib char(10) inz(*blanks);

dcl-s sfbot like(int4_t) inz;
dcl-c NbrFKeys 3;

dcl-s peek21_name like(pgmCallN_t) inz;
dcl-s peek23_name like(pgmCallN_t) inz;
dcl-s peek37_name like(pgmCallN_t) inz;
dcl-s peek38_name like(pgmCallN_t) inz;
dcl-s peek40_name like(pgmCallN_t) inz;

dcl-s tempScnFld like(ScnFld) inz;
dcl-s tempFldPos like(FldPos) inz;
dcl-s tempLen like(int4_t) inz;
dcl-s tempCsrRow like(int4_t) inz;
dcl-s tempCsrCol like(int4_t) inz;
dcl-s tempFldLen like(int4_t) inz;
dcl-s tempFldBy like(int4_t) inz;

//  Einfügen der Schlüsselfelder in ##ORDER
dcl-s inskeys like(sqlOrder_t) inz;
dcl-s keyLen like(int4_t) inz;
dcl-s scanpos like(int4_t) inz;
dcl-s usedlen like(int4_t) inz;

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

exsr First;

//---------------------------------------------------*
//  Schleife für Programmbearbeitung

dow ('1');

  //  Nachrichten anzeigen
  *in89 = '0';
  write msgctl;

  //  Anzeigen der Befehlstasten
  select;
  when ((sfbot = 2) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#2;
  when ((sfbot = 3) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#3;
  when ((sfbot = 4) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#4;
  when ((sfbot = 5) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#5;
  when ((sfbot = 6) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#6;
  when ((sfbot = 7) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#7;
  when ((sfbot = 8) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#8;
  other;
    write pbbot#1;
    sfbot = 1;
  endsl;

  //  Anzeigen Bildschirm
  exfmt bild01;

  //  Berechnen Zeile/Spalte
  cursorPosition.row = workstn.csrPos / 256;
  cursorPosition.column = %rem(workstn.csrPos: 256);

  //  Nachrichten löschen
  p_rmvPgmMg(sds.pgmName);

  //  Merken Cursorposition
  exsr KeepCsrPos;

  //  Bezugszahlen löschen
  exsr bzoff1;

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmName
        : YPgmCmd: YCmdDta: YMsgID: YMsgDta);
  if (YMsgID <> *blanks);
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    YMsgID = '';
    YMsgDta = '';
    iter;
  endif;

  //  Abfragen der Programmbefehle
  select;
  //  F3  - Ende
  when (YPgmCmd = '*EXIT');
    exsr C_EndPgm;
    leave;
  //  F4  - Prompt
  when (YPgmCmd = '*PROMPT');
    tempScnFld = ScnFld;
    tempFldPos = FldPos;
    exsr C_Prompt;
    iter;

  //  F5  - Aktualisieren
  when (YPgmCmd = '*REFRESH');
    exsr C_Refresh;
    iter;

  //  F9  - Auswählen Sortierfolge
  when (YPgmCmd = '*DSPDBR');
    tempScnFld = ScnFld;
    tempFldPos = FldPos;
    exsr C_SelectKy;
    iter;

  //  F11 - Einfügen Keyfelder
  when (YPgmCmd = '*INSKEYFLD');
    tempScnFld = ScnFld;
    tempFldPos = FldPos;
    exsr C_InsKeyFd;
    iter;

  //  F12 - Ende
  when (YPgmCmd = '*CANCEL');
    exsr C_EndPgm;
    leave;

  //  F24 - Weitere Tasten
  when (YPgmCmd = '*MOREKEYS');
    exsr C_MoreKeys;

  //  Datenfreigabe
  when (YPgmCmd = '*ENTER');
    exsr C_Enter;
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
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr C_Enter;

  exsr DltCsrPos;

  ##order = SQL_quote(##order);

  if (SQL_prepareStatement(
         '1': pFile.name: pFile.library: pFile.member: pFile.format:
         ##where: ##order: YMsgID: YMsgDta));
    io_file      = pFile.name;
    io_library   = pFile.library;
    io_member    = pFile.member;
    io_rcdFmt    = pFile.format;
    io_sqlWhere  = ##where;
    io_sqlOrder  = ##order;
    *in99 = '0';
  else;
    if (YMsgID <> '');
      p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
      YMsgID = '';
      YMsgDta = '';
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
//    C_EndPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr C_EndPgm;

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
//    C_Prompt      F4  - Prompt                              *
//============================================================*

begsr C_Prompt;

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
      exsr Pmt_Field;
    endif;

  when (tempScnFld = '##ORDER');
    if (*in72 = *on);
      p_sndPgmMg('USR8195': '': sds.pgmName);
    else;
      exsr Pmt_Field;
    endif;

  other;
    p_sndPgmMg('USR8179': '': sds.pgmName);
  endsl;

endsr;

//============================================================*
//    Pmt_Field     Prompt - Field                            *
//============================================================*

begsr Pmt_Field;

  peek37(i_dsp80: i_copyright: YField
        :  YMsgID: YMsgDta);

  if (YMsgID = '');

    tempLen = %checkr(' ': YField);

    select;
    when (tempScnFld = '##WHERE');
      if (set0008.set_prmt <> ' ' and ##where = set0008.set_prmt);
        ##where = '';
        tempFldPos = 1;
      endif;
      ##where = %replace(%trimr(YField) + ' '
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
      ##order  = %replace(%trimr(YField) + ' '
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

    CsrRow = tempCsrRow;
    CsrCol = tempCsrCol - 1;

  else;
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    YMsgID = '';
    YMsgDta = '';
  endif;

endsr;

//============================================================*
//    C_Refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr C_Refresh;

  exsr bzoff1;
  exsr fill##;

endsr;

//============================================================*
//    C_SelectKy    Auswählen Sortierfolge                    *
//============================================================*

begsr C_SelectKy;

  select;
  when (tempScnFld = '##ORDER');
    if (*in72 = *on);
      p_sndPgmMg('USR8195': '': sds.pgmName);
    else;
      exsr Slc_Key;
    endif;
  other;
    p_sndPgmMg('USR8211': '': sds.pgmName);
  endsl;

endsr;

//============================================================*
//    Slc_Key       Auswählen Sortierfolge                   *
//============================================================*

begsr Slc_Key;

  YMsgID = '';
  YMsgDta = '';
  peek40(i_dsp80: i_copyright
        : io_file: io_library: io_member
        : io_rcdFmt: bTrue
        : yRetFile: yRetLib
        : YMsgID: YMsgDta);

  select;
  //  ... Fehler von PEEK40 (USR8100: mit F3/F12 verlassen)
  when (YMsgID <> '' and YMsgID <> 'USR8100');
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
  //  ... Datei ausgewählt
  when (yRetFile <> *blanks);
    io_file = yRetFile;
    io_library = yRetLib;
    exsr Ins_Field;
  endsl;

  YMsgID = '';
  YMsgDta = '';

endsr;

//============================================================*
//    C_InsKeyFd    Insert Key Fields                         *
//============================================================*

begsr C_InsKeyFd;

  select;
  when (tempScnFld = '##ORDER');
    if (*in72 = *on);
      p_sndPgmMg('USR8195': '': sds.pgmName);
    else;
      exsr Ins_Field;
    endif;
  other;
    p_sndPgmMg('USR8211': '': sds.pgmName);
  endsl;

endsr;

//============================================================*
//    Ins_Field     Insert Key Fields                         *
//============================================================*

begsr Ins_Field;

  YSqlOrder = '';
  peek38(io_file: io_library: YSqlOrder);
  inskeys = %trimr(YSqlOrder);

  //  Die Schlüsselfelder werden an der Cursorposition in ##ORDER
  //  eingefügt, vorhandener Text rückt nach rechts (wie bei F4).
  usedlen = %len(%trimr(##order));
  if (tempFldPos - 1 > usedlen);
    usedlen = tempFldPos - 1;
  endif;

  //  Nur ganze Schlüsselfelder einfügen, soweit sie Platz haben.
  if (%len(inskeys) > %len(##order) - usedlen);
    keyLen = 0;
    scanpos = %scan(', ': inskeys);
    dow (scanpos > 0 and scanpos - 1 <= %len(##order) - usedlen);
      keyLen = scanpos - 1;
      if (scanpos + 2 > %len(inskeys));
        leave;
      endif;
      scanpos = %scan(', ': inskeys: scanpos + 2);
    enddo;
    inskeys = %subst(inskeys: 1: keyLen);
    //  USR8176: Warnung: Zeichenkette zu lang.
    p_sndPgmMg('USR8176': '': sds.pgmName);
  endif;

  if (%len(inskeys) > 0);
    ##order = %replace(inskeys: ##order: tempFldPos: 0);
  endif;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr C_MoreKeys;

  sfbot = sfbot + 1;

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
    exsr Ins_Field;
  endif;

endsr;

//============================================================*
//    KeepCsrPos    Beibehalten der Cursorposition            *
//============================================================*

begsr KeepCsrPos;

  //  Beibehalten der Cursorosition
  CsrRow = cursorPosition.row - zei;
  CsrCol = cursorPosition.column - pos;
  CsrCol = CsrCol - 1;

endsr;

//============================================================*
//    DltCsrPos     Löschen der Cursorposition                *
//============================================================*

begsr DltCsrPos;

  //  Löschen der Cursorosition
  CsrRow = *zeros;
  CsrCol = *zeros;

endsr;

//============================================================*
//    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr GetUsrSetg;

  //  *PROMPT
  set0008 = f_getUsrSg('*PROMPT');

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr SetScreen;

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

begsr First;

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
  exsr GetUsrSetg;

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

  exsr DltCsrPos;

  o_msgID = '';
  o_msgDta = '';

  // - Darstellung der Befehlstasten
  sfbot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr SetScreen;

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
  peek37_name = f_pgmCallN('PEEK37');
  peek38_name = f_pgmCallN('PEEK38');
  peek40_name = f_pgmCallN('PEEK40');

  peek23(sds.pgmName: '*ALL': NbrFKeys
        : yFKeys: yNbrOfKeys);
  ScrnFKeys = %subarr(yFKeys: 1);

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

