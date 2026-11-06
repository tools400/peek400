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
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT


/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,ShortCmd_D
/copy QCOPYLE,SDS
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK21
/undefine internal_prototype

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

/copy QCOPYLE,USR8143

dcl-s Wrk_EOF char(1) inz(bFalse);

dcl-s Wrk_Sectn like(SECTION_t);
dcl-s Wrk_Key like(KEY_t);
dcl-s Tmp_Key like(KEY_t);
dcl-s Wrk_Data like(SET0000_t);
dcl-s Wrk_ExclK like(pgmCmd_t) dim(25);
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

exsr First;

Wrk_Key = *blanks;

if (%subst(i_scnAID: 1: 1) = '#');
  exsr MapSflOpt;
else;
  exsr MapCmdKey;
endif;

return;

//============================================================*
//    MapSflOpt    Übersetzen Subfileauswahlen                *
//============================================================*

begsr MapSflOpt;

  //*                 SUBST (P) XscnAID:2     Wrk_Key
  Wrk_Key = %subst(i_scnAID: 2);

  //   Übersetzen key code vor dem Mapping:
  callExit05(i_pgm: '*OPTION': Wrk_Key);

  exsr MapUsrInp;

endsr;

//============================================================*
//    MapCmdKey     Übersetzen Tastendruck in Programmbefehl  *
//============================================================*

begsr MapCmdKey;

  select;
  when (i_scnAID = k_f1);
    Wrk_Key = '*F01';
  when (i_scnAID = k_f2);
    Wrk_Key = '*F02';
  when (i_scnAID = k_f3);
    Wrk_Key = '*F03';
  when (i_scnAID = k_f4);
    Wrk_Key = '*F04';
  when (i_scnAID = k_f5);
    Wrk_Key = '*F05';
  when (i_scnAID = k_f6);
    Wrk_Key = '*F06';
  when (i_scnAID = k_f7);
    Wrk_Key = '*F07';
  when (i_scnAID = k_f8);
    Wrk_Key = '*F08';
  when (i_scnAID = k_f9);
    Wrk_Key = '*F09';
  when (i_scnAID = k_f10);
    Wrk_Key = '*F10';
  when (i_scnAID = k_f11);
    Wrk_Key = '*F11';
  when (i_scnAID = k_f12);
    Wrk_Key = '*F12';
  when (i_scnAID = k_f13);
    Wrk_Key = '*F13';
  when (i_scnAID = k_f14);
    Wrk_Key = '*F14';
  when (i_scnAID = k_f15);
    Wrk_Key = '*F15';
  when (i_scnAID = k_f16);
    Wrk_Key = '*F16';
  when (i_scnAID = k_f17);
    Wrk_Key = '*F17';
  when (i_scnAID = k_f18);
    Wrk_Key = '*F18';
  when (i_scnAID = k_f19);
    Wrk_Key = '*F19';
  when (i_scnAID = k_f20);
    Wrk_Key = '*F20';
  when (i_scnAID = k_f21);
    Wrk_Key = '*F21';
  when (i_scnAID = k_f22);
    Wrk_Key = '*F22';
  when (i_scnAID = k_f23);
    Wrk_Key = '*F23';
  when (i_scnAID = k_f24);
    Wrk_Key = '*F24';
  when (i_scnAID = k_clear);
    Wrk_Key = '*CLEAR';
  when (i_scnAID = k_delete);
    Wrk_Key = '*DELETE';
  when (i_scnAID = k_enter);
    Wrk_Key = '*ENTER';
  when (i_scnAID = k_help);
    Wrk_Key = '*HELP';
  when (i_scnAID = k_page_down);
    Wrk_Key = '*PAGEDOWN';
  when (i_scnAID = k_page_up);
    Wrk_Key = '*PAGEUP';
  when (i_scnAID = k_print_screen);
    Wrk_Key = '*PRINT';
  when (i_scnAID = k_reset);
    Wrk_Key = '*RESET';
  when (i_scnAID = k_light_pen);
    Wrk_Key = '*LIGHTPEN';

  other;
    //  Unbekanntes AID-Byte ...
    //  muß unbekannte HEX-Wert einer
    //  unbekannten Taste sein.
    Wrk_Key = *blanks;
    p_keyToMsg(i_scnAID: o_msgID: o_msgDta);
  endsl;

  if (Wrk_Key = '');
    leavesr;
  endif;

  //   Übersetzen key code vor dem Mapping:
  callExit05(i_pgm: '*CMDKEY': Wrk_Key);

  exsr MapUsrInp;

endsr;

//============================================================*
//    MapUsrInp     Übersetzen Tastendruck in Programmbefehl  *
//============================================================*

begsr MapUsrInp;

  //   Übersetzen ...
  Wrk_Sectn = '*' + %trim(i_pgm);
  if (f_chainUsr(Wrk_Sectn :
              Wrk_Key   :
              Wrk_Data  ) = '0'   and
      f_isKeyExc(Wrk_Data  :
              Wrk_ExclK )= '0');

    //   Übersetzen key code nach dem Mapping:
    callExit05(i_pgm: '*EVENT': Wrk_Data);

    o_pgmCmd = Wrk_Data;
    o_cmdDta = *blanks;
    o_msgID = *blanks;
    o_msgDta = *blanks;
  else;

    //   Übersetzen key code nach dem Mapping:
    callExit05(i_pgm: '*USROPT': Wrk_Key);

    //   Prüfen auf Kurzbefehl ...
    Wrk_Sectn = '*CMD';
    if (f_chainUsr(Wrk_Sectn: Wrk_Key: Wrk_Data)='0');
      o_pgmCmd = '*CMD';
      o_cmdDta = Wrk_Data;
      o_msgID = *blanks;
      o_msgDta = *blanks;
    else;

      exsr ChkEntry;
      //  Wenn Tasten definiert sind,
      //  Dann Fehlermeldung ausgeben ...
      if (Wrk_EOF = bFalse);
        o_pgmCmd = *blanks;
        o_cmdDta = *blanks;
        o_msgID = 'USR8143';
        usr8143.var1 = Wrk_Key;
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
//    ChkEntry      Prüfen auf Einträge zum Programm          *
//============================================================*

begsr ChkEntry;

  //   Prüfen ...
  Wrk_Sectn = '*' + %trim(i_pgm);
  p_setllUsr(Wrk_Sectn: '*F01');
  if (f_readeUsr(Wrk_Sectn: Tmp_Key) = '1');
    Wrk_EOF = bTrue;
  else;
    if (Tmp_Key < '*F01'
        or Tmp_Key > '*F24');
      Wrk_EOF = bTrue;
    else;
      Wrk_EOF = bFalse;
    endif;
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr First;

  // - Programm initialisieren
  //**                Callp     p_rmvPgmMg(sds.pgmName)

  o_msgID = *blanks;
  o_msgDta = *blanks;
  //   Prüfen auf Ausschlüsse ...
  if (%parms() >= %parmnum(i_exclKeys));
    Wrk_ExclK = %subarr(i_exclKeys: 1);
  else;
    Wrk_ExclK(*) = '';
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

