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
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

dcl-f peek48fm workstn(*ext) usage(*input:*output)
      usropn infds(workstn);

dcl-ds workstn likeds(workstn_t);
dcl-ds cursorPosition likeds(cursorPosition_t) inz;

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,D_WORKSTN
/COPY QCOPYLE,ShortCmd_D
/COPY QCOPYLE,SDS
/COPY QCOPYLE,KEYL0100
/COPY QCOPYLE,SCRNFKEYS
/COPY QCOPYLE,CEECNDHDLR

/COPY QCOPYLE,USR8100

/COPY QCOPYLE,SET0008

/define internal_prototype
/COPY QCOPYLE,PPEEK48
/undefine internal_prototype

/COPY QCOPYLE,PPEEK21
/COPY QCOPYLE,PPEEK23
/COPY QCOPYLE,PPEEK37
/COPY QCOPYLE,PPEEK38
/COPY QCOPYLE,PPEEK40

/COPY QCOPYLE,PPEEK51
/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58
/COPY QCOPYLE,PPEEK63

dcl-ds set0008 likeds(set0008_t) inz;

dcl-s yfkeys          char(18) dim(32) inz;
dcl-s ynbrofkeys      like(int4_t) inz;
dcl-s ymsgid          char(7) inz(*blanks);
dcl-s ymsgdta         char(512) inz(*blanks);

dcl-s ypgmcmd         char(10) inz(*blanks);
dcl-s ycmddta         like(pgmcmddt_t) inz;

dcl-s yfield          char(10) inz(*blanks);

dcl-s ysqlorder       char(512) inz(*blanks);

dcl-s yretfile        char(10) inz(*blanks);
dcl-s yretlib         char(10) inz(*blanks);

dcl-s sfbot           like(int4_t) inz;
dcl-c nbrfkeys const(3);

dcl-s peek21_name     like(pgmcalln_t) inz;
dcl-s peek23_name     like(pgmcalln_t) inz;
dcl-s peek37_name     like(pgmcalln_t) inz;
dcl-s peek38_name     like(pgmcalln_t) inz;
dcl-s peek40_name     like(pgmcalln_t) inz;

dcl-s tempscnfld      like(scnfld  ) inz;
dcl-s tempfldpos      like(fldpos  ) inz;
dcl-s tempfield       like(##where ) inz;
dcl-s templen         like(int4_t) inz;
dcl-s tempcsrrow      like(int4_t) inz;
dcl-s tempcsrcol      like(int4_t) inz;
dcl-s tempfldlen      like(int4_t) inz;
dcl-s tempfldby       like(int4_t) inz;

dcl-ds pfile qualified;
  name            like(io_file);
  library         like(io_library);
  member          like(io_member);
  format          like(io_rcdfmt);
end-ds;

dcl-s isInzSr         like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

dcl-pi peek48;
  i_dsp80         const like(dsp80_t);
  i_copyright     const like(copyrght_t);
  io_file         like(file_t);
  io_library      like(lib_t);
  io_member       like(mbr_t);
  io_rcdfmt       like(fmt_t);
  i_accessmode    const like(accessmode_t);
  io_sqlwhere     like(sqlwhere_t);
  io_sqlorder     like(sqlorder_t);
  i_enablewhere   const like(bool_t);
  i_enableorder   const like(bool_t);
  o_msgid         like(msgid_t);
  o_msgdta        like(msgdta_t);
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
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#2;
  when (sfbot = 3) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#3;
  when (sfbot = 4) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#4;
  when (sfbot = 5) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#5;
  when (sfbot = 6) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#6;
  when (sfbot = 7) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#7;
  when (sfbot = 8) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
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
        : ypgmcmd: ycmddta: ymsgid: ymsgdta);
  if (ymsgid <> *blanks);
    p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
    ymsgid = '';
    ymsgdta = '';
    iter;
  endif;

  //  Abfragen der Programmbefehle
  select;
  //  F3  - Ende
  when (ypgmcmd = '*EXIT');
    exsr c_endpgm;
    leave;
  //  F4  - Prompt
  when (ypgmcmd = '*PROMPT');
    tempscnfld = scnfld;
    tempfldpos = fldpos;
    exsr c_prompt;
    iter;

  //  F5  - Aktualisieren
  when (ypgmcmd = '*REFRESH');
    exsr c_refresh;
    iter;

  //  F9  - Auswählen Sortierfolge
  when (ypgmcmd = '*DSPDBR');
    tempscnfld = scnfld;
    tempfldpos = fldpos;
    exsr c_selectky;
    iter;

  //  F11 - Einfügen Keyfelder
  when (ypgmcmd = '*INSKEYFLD');
    tempscnfld = scnfld;
    tempfldpos = fldpos;
    exsr c_inskeyfd;
    iter;

  //  F12 - Ende
  when (ypgmcmd = '*CANCEL');
    exsr c_endpgm;
    leave;

  //  F24 - Weitere Tasten
  when (ypgmcmd = '*MOREKEYS');
    exsr c_morekeys;

  //  Datenfreigabe
  when (ypgmcmd = '*ENTER');
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

  if sql_preparestatement(
             '1'       :
             pfile.name    :
             pfile.library :
             pfile.member  :
             pfile.format  :
             ##where       :
             ##order       :
             ymsgid        :
             ymsgdta       )
     = bTrue;
    io_file      = pfile.name;
    io_library   = pfile.library;
    io_member    = pfile.member;
    io_rcdfmt    = pfile.format;
    io_sqlwhere  = ##where;
    io_sqlorder  = ##order;
    *in99 = '0';
    if (ymsgid <> '');
      p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
      ymsgid = '';
      ymsgdta = '';
    endif;
  else;
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

  select;
  when (tempscnfld = '##WHERE' or ##where = set0008.set_prmt);
    if (*in71 = *on);
      p_sndpgmmg('USR8195': '': sds.pgmname);
    else;
      exsr pmt_field;
    endif;

  when (tempscnfld = '##ORDER' or ##order = set0008.set_prmt);
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

  peek37(i_dsp80: i_copyright: yfield
        :  ymsgid: ymsgdta);

  if (ymsgid = '');

    templen = %checkr(' ': yfield);

    select;
    when (tempscnfld = '##WHERE');
      ##where = %replace(%trimr(yfield) + ' '
                        : ##where
                        : tempfldpos
                        : 0);
      tempcsrrow =  5;
      tempcsrcol = 17;
      tempfldpos = tempfldpos + templen + 1;
      tempfldlen = %len(##where);
      tempfldby  = 42;

    when (tempscnfld = '##ORDER');
      ##order  = %replace(%trimr(yfield) + ' '
                         : ##order
                         : tempfldpos
                         : 0);
      tempcsrrow = 12;
      tempcsrcol = 17;
      tempfldpos = tempfldpos + templen + 1;
      tempfldlen = %len(##where);
      tempfldby  = 42;

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
    p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
    ymsgid = '';
    ymsgdta = '';
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

  peek40(i_dsp80: i_copyright
        : io_file: io_library: io_member
        : io_rcdfmt: bTrue
        : yretfile: yretlib
        : ymsgid: ymsgdta);
  if yretfile = *blanks
     or *in99 = *on;
  //  ... keine Auswahl getroffen
  else;
    io_file = yretfile;
    io_library = yretlib;
    exsr ins_field;
  endif;

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

  ysqlorder = '';
  peek38(io_file: io_library: ysqlorder);

  tempfield = ysqlorder;
  //*   ' '           Checkr    tempField     tempLen
  templen = %checkr(' ': tempfield);

  select;
  when (tempscnfld = '##WHERE');
    %subst(##where: tempfldpos: templen)
    = tempfield;
  when (tempscnfld = '##ORDER');
    %subst(##order : tempfldpos: templen)
    = tempfield;
  endsl;

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

  if (i_accessmode = key_seq) and
     (##order  = ' '    );
    tempscnfld = '##ORDER';
    tempfldpos = 1;
    exsr c_inskeyfd;
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

  // - Füllen der Bildschirmfelder
  exsr bzoff1;
  exsr fill##;

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

  // - Programm initialisieren
  p_rmvpgmmg(sds.pgmname);
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
        : yfkeys: ynbrofkeys);
  scrnfkeys = %subarr(yfkeys: 1);

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

