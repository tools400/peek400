**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Mappen TASTE/BEFEHL                          *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK21                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 27.10.97  Raddatz                                 *
//  geändert : 27.04.99  2.1.0                                   *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Mappen einer gedrückten Taste auf einen Programmbefehl       *
//                                                               *
// ============================================================= *
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'


/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/d_workstn.rpgleinc'
/copy 'qcopyle/shortcmd_d.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek21.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

/copy 'qcopyle/usr8143.rpgleinc'

dcl-s wrk_eof char(1) inz(bFalse);

dcl-s wrk_sectn like(section_t);
dcl-s wrk_key like(key_t);
dcl-s tmp_key like(key_t);
dcl-s wrk_data like(set0000_t);
dcl-s wrk_exclK like(pgmCmd_t) dim(25);
dcl-s p like(int4_t);

dcl-s isExit05 ind inz(bFalse);
dcl-s exit05 like(pgmCallN_t);

dcl-ds qPgm qualified;
  name char(10);
  lib  char(10);
end-ds;

dcl-pr chgActEvt extpgm(exit05);
  gi_file    char(10) const;
  gi_lib     char(10) const;
  gi_user    char(10) const;
  gi_pgm     char(10) const;
  gi_type    char(10) const;
  gio_option char(10);
end-pr;

dcl-ds g_exit05 qualified;
  user char(10) inz;
  file char(10) inz;
  lib  char(10) inz;
end-ds;

dcl-pr callExit05;
  i_pgm    char(10) const;
  i_type   char(10) const;
  io_value char(10);
end-pr;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek21;
  i_scnAID   like(scnAID_t) const;
  i_pgm      like(pgm_t) const;
  o_pgmCmd   like(pgmCmd_t);
  o_cmdDta   like(pgmCmdDt_t);
  o_msgID    like(msgId_t);
  o_msgDta   like(msgDta_t);
  i_exclKeys like(pgmCmd_t) dim(25) options(*nopass) const;
end-pi;

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

wrk_key = *blanks;

if (%subst(i_scnAID: 1: 1) = '#');
  exsr mapSflOpt;
else;
  exsr mapCmdKey;
endif;

return;

//============================================================*
//    mapSflOpt    Übersetzen Subfileauswahlen                *
//============================================================*

begsr mapSflOpt;

  //*                 SUBST (P) XscnAID:2     wrk_key
  wrk_key = %subst(i_scnAID: 2);

  //   Übersetzen key code vor dem Mapping:
  callExit05(i_pgm: '*OPTION': wrk_key);

  exsr mapUsrInp;

endsr;

//============================================================*
//    mapCmdKey     Übersetzen Tastendruck in Programmbefehl  *
//============================================================*

begsr mapCmdKey;

  select;
  when (i_scnAID = k_f1);
    wrk_key = '*F01';
  when (i_scnAID = k_f2);
    wrk_key = '*F02';
  when (i_scnAID = k_f3);
    wrk_key = '*F03';
  when (i_scnAID = k_f4);
    wrk_key = '*F04';
  when (i_scnAID = k_f5);
    wrk_key = '*F05';
  when (i_scnAID = k_f6);
    wrk_key = '*F06';
  when (i_scnAID = k_f7);
    wrk_key = '*F07';
  when (i_scnAID = k_f8);
    wrk_key = '*F08';
  when (i_scnAID = k_f9);
    wrk_key = '*F09';
  when (i_scnAID = k_f10);
    wrk_key = '*F10';
  when (i_scnAID = k_f11);
    wrk_key = '*F11';
  when (i_scnAID = k_f12);
    wrk_key = '*F12';
  when (i_scnAID = k_f13);
    wrk_key = '*F13';
  when (i_scnAID = k_f14);
    wrk_key = '*F14';
  when (i_scnAID = k_f15);
    wrk_key = '*F15';
  when (i_scnAID = k_f16);
    wrk_key = '*F16';
  when (i_scnAID = k_f17);
    wrk_key = '*F17';
  when (i_scnAID = k_f18);
    wrk_key = '*F18';
  when (i_scnAID = k_f19);
    wrk_key = '*F19';
  when (i_scnAID = k_f20);
    wrk_key = '*F20';
  when (i_scnAID = k_f21);
    wrk_key = '*F21';
  when (i_scnAID = k_f22);
    wrk_key = '*F22';
  when (i_scnAID = k_f23);
    wrk_key = '*F23';
  when (i_scnAID = k_f24);
    wrk_key = '*F24';
  when (i_scnAID = k_clear);
    wrk_key = '*CLEAR';
  when (i_scnAID = k_delete);
    wrk_key = '*DELETE';
  when (i_scnAID = k_enter);
    wrk_key = '*ENTER';
  when (i_scnAID = k_help);
    wrk_key = '*HELP';
  when (i_scnAID = k_page_down);
    wrk_key = '*PAGEDOWN';
  when (i_scnAID = k_page_up);
    wrk_key = '*PAGEUP';
  when (i_scnAID = k_print_screen);
    wrk_key = '*PRINT';
  when (i_scnAID = k_reset);
    wrk_key = '*RESET';
  when (i_scnAID = k_light_pen);
    wrk_key = '*LIGHTPEN';

  other;
    //  Unbekanntes AID-Byte ...
    //  muß unbekannte HEX-Wert einer
    //  unbekannten Taste sein.
    wrk_key = *blanks;
    p_keyToMsg(i_scnAID: o_msgID: o_msgDta);
  endsl;

  if (wrk_key = '');
    leavesr;
  endif;

  //   Übersetzen key code vor dem Mapping:
  callExit05(i_pgm: '*CMDKEY': wrk_key);

  exsr mapUsrInp;

endsr;

//============================================================*
//    mapUsrInp     Übersetzen Tastendruck in Programmbefehl  *
//============================================================*

begsr mapUsrInp;

  //   Übersetzen ...
  wrk_sectn = '*' + %trim(i_pgm);
  if (f_chainUsr(wrk_sectn :
              wrk_key   :
              wrk_data  ) = '0'   and
      f_isKeyExc(wrk_data  :
              wrk_exclK )= '0');

    //   Übersetzen key code nach dem Mapping:
    callExit05(i_pgm: '*EVENT': wrk_data);

    o_pgmCmd = wrk_data;
    o_cmdDta = *blanks;
    o_msgID = *blanks;
    o_msgDta = *blanks;
  else;

    //   Übersetzen key code nach dem Mapping:
    callExit05(i_pgm: '*USROPT': wrk_key);

    //   Prüfen auf Kurzbefehl ...
    wrk_sectn = '*CMD';
    if (f_chainUsr(wrk_sectn: wrk_key: wrk_data)='0');
      o_pgmCmd = '*CMD';
      o_cmdDta = wrk_data;
      o_msgID = *blanks;
      o_msgDta = *blanks;
    else;

      exsr chkEntry;
      //  Wenn Tasten definiert sind,
      //  Dann Fehlermeldung ausgeben ...
      if (wrk_eof = bFalse);
        o_pgmCmd = *blanks;
        o_cmdDta = *blanks;
        o_msgID = 'USR8143';
        usr8143.var1 = wrk_key;
        o_msgDta = usr8143;
      else;
        o_pgmCmd = '*EXIT';
        o_cmdDta = *blanks;
        o_msgID = *blanks;
        o_msgDta = *blanks;
      endif;
    endif;
  endif;

endsr;

//============================================================*
//    chkEntry      Prüfen auf Einträge zum Programm          *
//============================================================*

begsr chkEntry;

  //   Prüfen ...
  wrk_sectn = '*' + %trim(i_pgm);
  p_setllUsr(wrk_sectn: '*F01');
  if (f_readeUsr(wrk_sectn: tmp_key) = '1');
    wrk_eof = bTrue;
  else;
    if (tmp_key < '*F01'
        or tmp_key > '*F24');
      wrk_eof = bTrue;
    else;
      wrk_eof = bFalse;
    endif;
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Programm initialisieren
  //**                Callp     p_rmvPgmMg(sds.pgmName)

  o_msgID = *blanks;
  o_msgDta = *blanks;
  //   Prüfen auf Ausschlüsse ...
  if (%parms() >= %parmnum(i_exclKeys));
    wrk_exclK = %subarr(i_exclKeys: 1);
  else;
    wrk_exclK(*) = '';
  endif;

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  exit05 = f_pgmCallN('EXIT05');

  p = %scan('/': exit05);
  if (p > 1);
    qPgm.lib = %subst(exit05: 1: p-1);
    if (p < %len(exit05));
      qPgm.name = %subst(exit05: p+1);
      isExit05  = f_exist(qPgm.name
                         : qPgm.lib
                         : '*PGM');
    endif;
  endif;

  g_exit05.user =
    f_getUsr(g_exit05.file: g_exit05.lib);

endsr;

//============================================================*
//    Aufrufen EXIT05                                         *
//============================================================*
dcl-proc callExit05;
  dcl-pi *n;
    i_pgm    char(10) const;
    i_type   char(10) const;
    io_value char(10);
  end-pi;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if (isExit05);
    monitor;
      chgActEvt(g_exit05.file: g_exit05.lib: g_exit05.user
                : i_pgm: i_type: io_value);
    on-error;
      p_rmvPgmMg('*');
      isExit05 = bFalse;
    endmon;
  endif;


end-proc;

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

