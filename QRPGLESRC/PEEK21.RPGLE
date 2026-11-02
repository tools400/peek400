**free
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
/COPY QCOPYLE,D_WORKSTN
/COPY QCOPYLE,ShortCmd_D
/COPY QCOPYLE,SDS
/COPY QCOPYLE,CEECNDHDLR

/define internal_prototype
/COPY QCOPYLE,PPEEK21
/undefine internal_prototype

/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

/COPY QCOPYLE,USR8143

dcl-s wrk_eof         char(1) inz(bFalse);

dcl-s wrk_sectn       like(section_t);
dcl-s wrk_key         like(key_t);
dcl-s tmp_key         like(key_t);
dcl-s wrk_data        like(set0000_t);
dcl-s wrk_exclk       like(pgmcmd_t) dim(25);
dcl-s p               like(int4_t);

dcl-s isexit05        ind inz(bFalse);
dcl-s exit05          like(pgmcalln_t);

dcl-ds qpgm qualified;
  name            char(10);
  lib             char(10);
end-ds;

dcl-pr chgactevt        extpgm(exit05);
  gi_file         char(10) const;
  gi_lib          char(10) const;
  gi_user         char(10) const;
  gi_pgm          char(10) const;
  gi_type         char(10) const;
  gio_option      char(10);
end-pr;

dcl-ds g_exit05 qualified;
  user            char(10) inz;
  file            char(10) inz;
  lib             char(10) inz;
end-ds;

dcl-pr callexit05;
  i_pgm           char(10) const;
  i_type          char(10) const;
  io_value        char(10);
end-pr;

dcl-s isInzSr         like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

dcl-pi peek21;
  i_scnaid        const like(scnaid_t);
  i_pgm           const like(pgm_t);
  o_pgmcmd        like(pgmcmd_t);
  o_cmddta        like(pgmcmddt_t);
  o_msgid         like(msgid_t);
  o_msgdta        like(msgdta_t);
  i_exclkeys      const like(pgmcmd_t) dim(25)
       options(*nopass);
end-pi;

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

wrk_key = *blanks;

if (%subst(i_scnaid: 1: 1) = '#');
  exsr mapsflopt;
else;
  exsr mapcmdkey;
endif;

return;

//============================================================*
//    MapSflOpt    Übersetzen Subfileauswahlen                *
//============================================================*

begsr mapsflopt;

  //*                 SUBST (P) XscnAID:2     Wrk_Key
  wrk_key = %subst(i_scnaid: 2);

  //   Übersetzen key code vor dem Mapping:
  callexit05(i_pgm: '*OPTION': wrk_key);

  exsr mapusrinp;

endsr;

//============================================================*
//    MapCmdKey     Übersetzen Tastendruck in Programmbefehl  *
//============================================================*

begsr mapcmdkey;

  select;
  when (i_scnaid = k_f1);
    wrk_key = '*F01';
  when (i_scnaid = k_f2);
    wrk_key = '*F02';
  when (i_scnaid = k_f3);
    wrk_key = '*F03';
  when (i_scnaid = k_f4);
    wrk_key = '*F04';
  when (i_scnaid = k_f5);
    wrk_key = '*F05';
  when (i_scnaid = k_f6);
    wrk_key = '*F06';
  when (i_scnaid = k_f7);
    wrk_key = '*F07';
  when (i_scnaid = k_f8);
    wrk_key = '*F08';
  when (i_scnaid = k_f9);
    wrk_key = '*F09';
  when (i_scnaid = k_f10);
    wrk_key = '*F10';
  when (i_scnaid = k_f11);
    wrk_key = '*F11';
  when (i_scnaid = k_f12);
    wrk_key = '*F12';
  when (i_scnaid = k_f13);
    wrk_key = '*F13';
  when (i_scnaid = k_f14);
    wrk_key = '*F14';
  when (i_scnaid = k_f15);
    wrk_key = '*F15';
  when (i_scnaid = k_f16);
    wrk_key = '*F16';
  when (i_scnaid = k_f17);
    wrk_key = '*F17';
  when (i_scnaid = k_f18);
    wrk_key = '*F18';
  when (i_scnaid = k_f19);
    wrk_key = '*F19';
  when (i_scnaid = k_f20);
    wrk_key = '*F20';
  when (i_scnaid = k_f21);
    wrk_key = '*F21';
  when (i_scnaid = k_f22);
    wrk_key = '*F22';
  when (i_scnaid = k_f23);
    wrk_key = '*F23';
  when (i_scnaid = k_f24);
    wrk_key = '*F24';
  when (i_scnaid = k_clear);
    wrk_key = '*CLEAR';
  when (i_scnaid = k_delete);
    wrk_key = '*DELETE';
  when (i_scnaid = k_enter);
    wrk_key = '*ENTER';
  when (i_scnaid = k_help);
    wrk_key = '*HELP';
  when (i_scnaid = k_page_down);
    wrk_key = '*PAGEDOWN';
  when (i_scnaid = k_page_up);
    wrk_key = '*PAGEUP';
  when (i_scnaid = k_print_screen);
    wrk_key = '*PRINT';
  when (i_scnaid = k_reset);
    wrk_key = '*RESET';
  when (i_scnaid = k_light_pen);
    wrk_key = '*LIGHTPEN';

  other;
    //  Unbekanntes AID-Byte ...
    //  muß unbekannte HEX-Wert einer
    //  unbekannten Taste sein.
    wrk_key = *blanks;
    p_keytomsg(i_scnaid: o_msgid: o_msgdta);
  endsl;

  if (wrk_key = '');
    leavesr;
  endif;

  //   Übersetzen key code vor dem Mapping:
  callexit05(i_pgm: '*CMDKEY': wrk_key);

  exsr mapusrinp;

endsr;

//============================================================*
//    MapUsrInp     Übersetzen Tastendruck in Programmbefehl  *
//============================================================*

begsr mapusrinp;

  //   Übersetzen ...
  wrk_sectn = '*' + %trim(i_pgm);
  if f_chainusr(wrk_sectn :
             wrk_key   :
             wrk_data  ) = '0'   and
     f_iskeyexc(wrk_data  :
             wrk_exclk )= '0';

    //   Übersetzen key code nach dem Mapping:
    callexit05(i_pgm: '*EVENT': wrk_data);

    o_pgmcmd = wrk_data;
    o_cmddta = *blanks;
    o_msgid = *blanks;
    o_msgdta = *blanks;
  else;

    //   Übersetzen key code nach dem Mapping:
    callexit05(i_pgm: '*USROPT': wrk_key);

    //   Prüfen auf Kurzbefehl ...
    wrk_sectn = '*CMD';
    if (f_chainusr(wrk_sectn: wrk_key: wrk_data)='0');
      o_pgmcmd = '*CMD';
      o_cmddta = wrk_data;
      o_msgid = *blanks;
      o_msgdta = *blanks;
    else;

      exsr chkentry;
      //  Wenn Tasten definiert sind,
      //  Dann Fehlermeldung ausgeben ...
      if (wrk_eof = bFalse);
        o_pgmcmd = *blanks;
        o_cmddta = *blanks;
        o_msgid = 'USR8143';
        usr8143.var1 = wrk_key;
        o_msgdta = usr8143;
      else;
        o_pgmcmd = '*EXIT';
        o_cmddta = *blanks;
        o_msgid = *blanks;
        o_msgdta = *blanks;
      endif;
    endif;
  endif;

endsr;

//============================================================*
//    ChkEntry      Prüfen auf Einträge zum Programm          *
//============================================================*

begsr chkentry;

  //   Prüfen ...
  wrk_sectn = '*' + %trim(i_pgm);
  p_setllusr(wrk_sectn: '*F01');
  if (f_readeusr(wrk_sectn: tmp_key) = '1');
    wrk_eof = bTrue;
  else;
    if tmp_key < '*F01'
       or tmp_key > '*F24';
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

  o_msgid = *blanks;
  o_msgdta = *blanks;
  //   Prüfen auf Ausschlüsse ...
  if %parms() >= %parmnum(i_exclkeys);
    wrk_exclk = %subarr(i_exclkeys: 1);
  else;
    wrk_exclk(*) = '';
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

  exit05 = f_pgmcalln('EXIT05');

  p = %scan('/': exit05);
  if (p > 1);
    qpgm.lib = %subst(exit05: 1: p-1);
    if p < %len(exit05);
      qpgm.name = %subst(exit05: p+1);
      isexit05  = f_exist(qpgm.name
                         : qpgm.lib
                         : '*PGM');
    endif;
  endif;

  g_exit05.user =
    f_getusr(g_exit05.file: g_exit05.lib);

endsr;

//============================================================*
//    Aufrufen EXIT05                                         *
//============================================================*
dcl-proc callexit05;
  dcl-pi *N;
    i_pgm           char(10) const;
    i_type          char(10) const;
    io_value        char(10);
  end-pi;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if (isexit05);
    monitor;
      chgactevt(g_exit05.file: g_exit05.lib: g_exit05.user
                : i_pgm: i_type: io_value);
    on-error;
      p_rmvpgmmg('*');
      isexit05 = bFalse;
    endmon;
  endif;


end-proc;

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

