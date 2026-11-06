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
dcl-s yMsgId char(7) inz(*blanks);
dcl-s yMsgDta char(512) inz(*blanks);

dcl-s yPgmCmd char(10) inz(*blanks);
dcl-s yCmdDta like(pgmcmddt_t) inz;

dcl-s yField char(10) inz(*blanks);

dcl-s ySqlOrder like(sqlOrder_t) inz(*blanks);

dcl-s yRetFile char(10) inz(*blanks);
dcl-s yRetLib char(10) inz(*blanks);

dcl-s sfbot like(int4_t) inz;
dcl-c nbrfkeys 3;

dcl-s peek21_name like(pgmcalln_t) inz;
dcl-s peek23_name like(pgmcalln_t) inz;
dcl-s peek37_name like(pgmcalln_t) inz;
dcl-s peek38_name like(pgmcalln_t) inz;
dcl-s peek40_name like(pgmcalln_t) inz;

dcl-s tempscnfld like(scnfld) inz;
dcl-s tempfldpos like(fldpos) inz;
dcl-s templen like(int4_t) inz;
dcl-s tempcsrrow like(int4_t) inz;
dcl-s tempcsrcol like(int4_t) inz;
dcl-s tempfldlen like(int4_t) inz;
dcl-s tempfldby like(int4_t) inz;

//  Einfügen der Schlüsselfelder in ##ORDER
dcl-s inskeys like(sqlOrder_t) inz;
dcl-s keylen like(int4_t) inz;
dcl-s scanpos like(int4_t) inz;
dcl-s usedlen like(int4_t) inz;

dcl-ds pfile qualified;
  name    like(io_file);
  library like(io_library);
  member  like(io_member);
  format  like(io_rcdfmt);
end-ds;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek48;
  i_dsp80       like(dsp80_t) const;
  i_copyright   like(copyrght_t) const;
  io_file       like(file_t);
  io_library    like(lib_t);
  io_member     like(mbr_t);
  io_rcdfmt     like(fmt_t);
  i_accessmode  like(accessmode_t) const;
  io_sqlwhere   like(sqlwhere_t);
  io_sqlorder   like(sqlorder_t);
  i_enablewhere like(bool_t) const;
  i_enableorder like(bool_t) const;
  o_msgid       like(msgid_t);
  o_msgdta      like(msgdta_t);
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
  write msgctl;

  //  Anzeigen der Befehlstasten
  select;
  when (sfbot = 2) and
     (yNbrOfKeys > nbrfkeys * (sfbot - 1));
    write pbbot#2;
  when (sfbot = 3) and
     (yNbrOfKeys > nbrfkeys * (sfbot - 1));
    write pbbot#3;
  when (sfbot = 4) and
     (yNbrOfKeys > nbrfkeys * (sfbot - 1));
    write pbbot#4;
  when (sfbot = 5) and
     (yNbrOfKeys > nbrfkeys * (sfbot - 1));
    write pbbot#5;
  when (sfbot = 6) and
     (yNbrOfKeys > nbrfkeys * (sfbot - 1));
    write pbbot#6;
  when (sfbot = 7) and
     (yNbrOfKeys > nbrfkeys * (sfbot - 1));
    write pbbot#7;
  when (sfbot = 8) and
     (yNbrOfKeys > nbrfkeys * (sfbot - 1));
    write pbbot#8;
  other;
    write pbbot#1;
    sfbot = 1;
  endsl;

  //  Anzeigen Bildschirm
  exfmt bild01;

  //  Berechnen Zeile/Spalte
  cursorposition.row = workstn.csrpos / 256;
  cursorposition.column = %rem(workstn.csrpos: 256);

  //  Nachrichten löschen
  p_rmvpgmmg(sds.pgmname);

  //  Merken Cursorposition
  exsr keepcsrpos;

  //  Bezugszahlen löschen
  exsr bzoff1;

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmname
        : yPgmCmd: yCmdDta: yMsgId: yMsgDta);
  if (yMsgId <> *blanks);
    p_sndpgmmg(yMsgId: yMsgDta: sds.pgmname);
    yMsgId = '';
    yMsgDta = '';
    iter;
  endif;

  //  Abfragen der Programmbefehle
  select;
  //  F3  - Ende
  when (yPgmCmd = '*EXIT');
    exsr c_endpgm;
    leave;
  //  F4  - Prompt
  when (yPgmCmd = '*PROMPT');
    tempscnfld = scnfld;
    tempfldpos = fldpos;
    exsr c_prompt;
    iter;

  //  F5  - Aktualisieren
  when (yPgmCmd = '*REFRESH');
    exsr c_refresh;
    iter;

  //  F9  - Auswählen Sortierfolge
  when (yPgmCmd = '*DSPDBR');
    tempscnfld = scnfld;
    tempfldpos = fldpos;
    exsr c_selectky;
    iter;

  //  F11 - Einfügen Keyfelder
  when (yPgmCmd = '*INSKEYFLD');
    tempscnfld = scnfld;
    tempfldpos = fldpos;
    exsr c_inskeyfd;
    iter;

  //  F12 - Ende
  when (yPgmCmd = '*CANCEL');
    exsr c_endpgm;
    leave;

  //  F24 - Weitere Tasten
  when (yPgmCmd = '*MOREKEYS');
    exsr c_morekeys;

  //  Datenfreigabe
  when (yPgmCmd = '*ENTER');
    exsr c_enter;
    if (*in99 = *off);
      o_msgid = 'USR8112';
      o_msgdta = *blanks;
      leave;
    endif;

  other;
    //  Falsche Taste gedrückt
    p_wrongkey(workstn.aid: sds.pgmname);
    iter;
  endsl;

enddo;

close peek48fm;

return;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  exsr dltcsrpos;

  ##order = sql_quote(##order);

  if (sql_preparestatement(
         '1': pfile.name: pfile.library: pfile.member: pfile.format:
         ##where: ##order: yMsgId: yMsgDta));
    io_file      = pfile.name;
    io_library   = pfile.library;
    io_member    = pfile.member;
    io_rcdfmt    = pfile.format;
    io_sqlwhere  = ##where;
    io_sqlorder  = ##order;
    *in99 = '0';
  else;
    if (yMsgId <> '');
      p_sndpgmmg(yMsgId: yMsgDta: sds.pgmname);
      yMsgId = '';
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
//    C_EndPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr c_endpgm;

  p_rmvpgmmg(sds.pgmname);

  o_msgid = 'USR8100';

  select;
  when (workstn.aid = k_f3);
    usr8100.var1 = 'F3';
  when (workstn.aid = k_f12);
    usr8100.var1 = 'F12';
  other;
    usr8100.var1 = 'Fxx';
  endsl;

  o_msgdta = usr8100;

endsr;

//============================================================*
//    C_Prompt      F4  - Prompt                              *
//============================================================*

begsr c_prompt;

  //  Steht im Feld nur das Prompt-Zeichen (z. B. '?'), gilt der Prompt
  //  diesem Feld, auch wenn der Cursor nicht darin steht. Der
  //  ausgewählte Feldname ersetzt das Zeichen (pmt_field).
  if (set0008.set_prmt <> ' ');
    if (##where = set0008.set_prmt and tempscnfld <> '##ORDER');
      tempscnfld = '##WHERE';
    elseif (##order = set0008.set_prmt and tempscnfld <> '##WHERE');
      tempscnfld = '##ORDER';
    endif;
  endif;

  select;
  when (tempscnfld = '##WHERE');
    if (*in71 = *on);
      p_sndpgmmg('USR8195': '': sds.pgmname);
    else;
      exsr pmt_field;
    endif;

  when (tempscnfld = '##ORDER');
    if (*in72 = *on);
      p_sndpgmmg('USR8195': '': sds.pgmname);
    else;
      exsr pmt_field;
    endif;

  other;
    p_sndpgmmg('USR8179': '': sds.pgmname);
  endsl;

endsr;

//============================================================*
//    Pmt_Field     Prompt - Field                            *
//============================================================*

begsr pmt_field;

  peek37(i_dsp80: i_copyright: yField
        :  yMsgId: yMsgDta);

  if (yMsgId = '');

    templen = %checkr(' ': yField);

    select;
    when (tempscnfld = '##WHERE');
      if (set0008.set_prmt <> ' ' and ##where = set0008.set_prmt);
        ##where = '';
        tempfldpos = 1;
      endif;
      ##where = %replace(%trimr(yField) + ' '
                        : ##where
                        : tempfldpos
                        : 0);
      tempcsrrow =  5;
      tempcsrcol = 17;
      tempfldpos = tempfldpos + templen + 1;
      tempfldlen = %len(##where);
      tempfldby  = 42;

    when (tempscnfld = '##ORDER');
      if (set0008.set_prmt <> ' ' and ##order = set0008.set_prmt);
        ##order = '';
        tempfldpos = 1;
      endif;
      ##order  = %replace(%trimr(yField) + ' '
                         : ##order
                         : tempfldpos
                         : 0);
      tempcsrrow = 12;
      tempcsrcol = 17;
      tempfldpos = tempfldpos + templen + 1;
      tempfldlen = %len(##order);
      tempfldby  = 42;

    other;
      //  Kein Eingabefeld: nichts einfügen, Cursor nicht versetzen
      leavesr;
    endsl;

    if (tempfldpos > tempfldlen);
      tempfldpos = tempfldlen;
    endif;

    if (%rem(tempfldpos: tempfldby) = 0);
      tempcsrcol = tempcsrcol + tempfldby;
    else;
      tempcsrcol = tempcsrcol +
                  %rem(tempfldpos: tempfldby);
    endif;

    if (%rem(tempfldpos: tempfldby) = 0);
      tempcsrrow = tempcsrrow +
                  %int(tempfldpos/ tempfldby) - 1;
    else;
      tempcsrrow = tempcsrrow +
                  %int(tempfldpos/ tempfldby);
    endif;

    csrrow = tempcsrrow;
    csrcol = tempcsrcol - 1;

  else;
    p_sndpgmmg(yMsgId: yMsgDta: sds.pgmname);
    yMsgId = '';
    yMsgDta = '';
  endif;

endsr;

//============================================================*
//    C_Refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  exsr bzoff1;
  exsr fill##;

endsr;

//============================================================*
//    C_SelectKy    Auswählen Sortierfolge                    *
//============================================================*

begsr c_selectky;

  select;
  when (tempscnfld = '##ORDER');
    if (*in72 = *on);
      p_sndpgmmg('USR8195': '': sds.pgmname);
    else;
      exsr slc_key;
    endif;
  other;
    p_sndpgmmg('USR8211': '': sds.pgmname);
  endsl;

endsr;

//============================================================*
//    Slc_Key       Auswählen Sortierfolge                   *
//============================================================*

begsr slc_key;

  yMsgId = '';
  yMsgDta = '';
  peek40(i_dsp80: i_copyright
        : io_file: io_library: io_member
        : io_rcdfmt: bTrue
        : yRetFile: yRetLib
        : yMsgId: yMsgDta);

  select;
  //  ... Fehler von PEEK40 (USR8100: mit F3/F12 verlassen)
  when (yMsgId <> '' and yMsgId <> 'USR8100');
    p_sndpgmmg(yMsgId: yMsgDta: sds.pgmname);
  //  ... Datei ausgewählt
  when (yRetFile <> *blanks);
    io_file = yRetFile;
    io_library = yRetLib;
    exsr ins_field;
  endsl;

  yMsgId = '';
  yMsgDta = '';

endsr;

//============================================================*
//    C_InsKeyFd    Insert Key Fields                         *
//============================================================*

begsr c_inskeyfd;

  select;
  when (tempscnfld = '##ORDER');
    if (*in72 = *on);
      p_sndpgmmg('USR8195': '': sds.pgmname);
    else;
      exsr ins_field;
    endif;
  other;
    p_sndpgmmg('USR8211': '': sds.pgmname);
  endsl;

endsr;

//============================================================*
//    Ins_Field     Insert Key Fields                         *
//============================================================*

begsr ins_field;

  ySqlOrder = '';
  peek38(io_file: io_library: ySqlOrder);
  inskeys = %trimr(ySqlOrder);

  //  Die Schlüsselfelder werden an der Cursorposition in ##ORDER
  //  eingefügt, vorhandener Text rückt nach rechts (wie bei F4).
  usedlen = %len(%trimr(##order));
  if (tempfldpos - 1 > usedlen);
    usedlen = tempfldpos - 1;
  endif;

  //  Nur ganze Schlüsselfelder einfügen, soweit sie Platz haben.
  if (%len(inskeys) > %len(##order) - usedlen);
    keylen = 0;
    scanpos = %scan(', ': inskeys);
    dow (scanpos > 0 and scanpos - 1 <= %len(##order) - usedlen);
      keylen = scanpos - 1;
      if (scanpos + 2 > %len(inskeys));
        leave;
      endif;
      scanpos = %scan(', ': inskeys: scanpos + 2);
    enddo;
    inskeys = %subst(inskeys: 1: keylen);
    //  USR8176: Warnung: Zeichenkette zu lang.
    p_sndpgmmg('USR8176': '': sds.pgmname);
  endif;

  if (%len(inskeys) > 0);
    ##order = %replace(inskeys: ##order: tempfldpos: 0);
  endif;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_morekeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    FILL##        Füllen Bildschirm                         *
//============================================================*

begsr fill##;

  $$sql = 'SELECT * FROM '      +
         %trim(pfile.library)  +
         '/'                   +
         %trim(pfile.name)     +
         '('                   +
         %trim(pfile.member)   +
         ')'                   +
         ' ...';

  ##where = io_sqlwhere;
  ##order = io_sqlorder;

  //  Schlüsselfolge als Vorgabe, auch wenn ORDER BY nicht geändert
  //  werden darf: Sie hält bei SQL-Zugriff die bisherige Reihenfolge.
  if (i_accessmode = KEY_SEQ) and
     (##order  = ' '    );
    tempfldpos = 1;
    exsr ins_field;
  endif;

endsr;

//============================================================*
//    KeepCsrPos    Beibehalten der Cursorposition            *
//============================================================*

begsr keepcsrpos;

  //  Beibehalten der Cursorosition
  csrrow = cursorposition.row - zei;
  csrcol = cursorposition.column - pos;
  csrcol = csrcol - 1;

endsr;

//============================================================*
//    DltCsrPos     Löschen der Cursorposition                *
//============================================================*

begsr dltcsrpos;

  //  Löschen der Cursorosition
  csrrow = *zeros;
  csrcol = *zeros;

endsr;

//============================================================*
//    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr getusrsetg;

  //  *PROMPT
  set0008 = f_getusrsg('*PROMPT');

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setscreen;

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
  f_basedpf(io_file    :
           io_library :
           io_member  :
           io_rcdfmt  :
           1        :
           pfile.name    :
           pfile.library :
           pfile.member  :
           pfile.format  );

  // - Öffnen der Dateien
  open peek48fm;

  // - Programm initialisieren (vor fill##, damit dessen Warnung
  //   USR8176 erhalten bleibt)
  p_rmvpgmmg(sds.pgmname);

  // - Benutzervoreinstellungen (Prompt-Zeichen)
  exsr getusrsetg;

  // - Setzen Ändern erlaubt für: WHERE und ORDER BY
  if (i_enablewhere = bTrue);
    *in71 = *off;
  else;
    *in71 = *on;
  endif;

  if (i_enableorder = bTrue);
    *in72 = *off;
  else;
    *in72 = *on;
  endif;

  // - Füllen der Bildschirmfelder
  exsr bzoff1;
  exsr fill##;

  exsr dltcsrpos;

  o_msgid = '';
  o_msgdta = '';

  // - Darstellung der Befehlstasten
  sfbot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setscreen;

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

  peek21_name = f_pgmcalln('PEEK21');
  peek23_name = f_pgmcalln('PEEK23');
  peek37_name = f_pgmcalln('PEEK37');
  peek38_name = f_pgmcalln('PEEK38');
  peek40_name = f_pgmcalln('PEEK40');

  peek23(sds.pgmname: '*ALL': nbrfkeys
        : yFKeys: yNbrOfKeys);
  scrnfkeys = %subarr(yFKeys: 1);

endsr;

//============================================================*
//  Program error handler                                     *
//============================================================*

dcl-proc errorhandler;
  dcl-pi *n;
    i_condtoken    likeds(cee_fc_t) value;
    i_pcommarea    int(10) value;
    o_action       int(10);
    o_newcondtoken likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

