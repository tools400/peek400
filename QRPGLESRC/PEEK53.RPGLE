**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK053                                           *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 27.04.99  Raddatz                                 *
//  geändert : 27.04.99  2.1.0                                   *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Zugriff auf Benutzerdaten                         *
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
ctl-opt nomain;
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

dcl-f peekusr usage(*update: *delete: *output) keyed usropn prefix(s_) infds(File_00_DS)
  extfile(g_peekusr);

dcl-f default keyed usropn extdesc('PEEKUSR') rename(fpeekusr: fdefault) prefix(d_)
  infds(File_01_DS) extfile(g_default);

dcl-ds File_00_DS likeds(infds_t);
dcl-ds File_01_DS likeds(infds_t);

dcl-s g_peekusr char(21);
dcl-s g_default char(21);

dcl-s g_isInit like(bool_t) inz(bFalse);
dcl-s g_user like(user_t) inz;
dcl-s g_file like(file_t) inz;
dcl-s g_lib like(lib_t) inz;

dcl-pr f_initUsrS like(SET0000_t);
  i_key like(KEY_t) const;
end-pr;

dcl-pr p_opnFile;
  o_msgID  char(7);
  o_msgDta char(512);
end-pr;

dcl-pr p_opnDft;
  o_msgID  char(7);
  o_msgDta char(512);
end-pr;

dcl-pr p_initSrvPgm;
end-pr;

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,D_INFDS
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_COLORATR
/copy QCOPYLE,SDS

/copy QCOPYLE,SET0001
/copy QCOPYLE,SET0002
/copy QCOPYLE,SET0003
/copy QCOPYLE,SET0004
/copy QCOPYLE,SET0005
/copy QCOPYLE,SET0006
/copy QCOPYLE,SET0007
/copy QCOPYLE,SET0008
/copy QCOPYLE,SET0009
/copy QCOPYLE,SET0010
/copy QCOPYLE,SET0011
/copy QCOPYLE,SET0012
/copy QCOPYLE,SET0013
/copy QCOPYLE,SET0014
/copy QCOPYLE,SET0015
/copy QCOPYLE,SET0016

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

/copy QCOPYLE,PPEEK22

dcl-s peek22_name like(pgmCallN_t) inz;

dcl-ds U_Key3 likerec(fpeekusr: *key);
dcl-ds d_key3 likerec(fdefault: *key);

//===================================================================*
//  Prozedur:  p_crtUsrSg                                 (Body)     *
//===================================================================*

dcl-proc p_crtUsrSg export;
  dcl-pi *n;
    i_prodLib like(lib_t) const;
    i_user    like(user_t) const;
    o_msgID   like(msgId_t);
    o_msgDta  like(msgDta_t);
  end-pi;

  dcl-s cmd char(256) inz;
  // ------------------------------------------------------------------------
  p_initSrvPgm();

  if (not f_exist('PEEKUSR': i_prodLib: '*FILE': *omit: o_msgID: o_msgDta));
    return;
  endif;

  cmd = 'CRTDUPOBJ -
           OBJ(PEEKUSR) +
           FROMLIB(' + i_prodlib + ') +
           OBJTYPE(*FILE) +
           TOLIB(*FROMLIB) +
           NEWOBJ(' + i_user + ') +
           DATA(*NO)';

  f_execute(cmd     :
           o_msgID :
           o_msgDta);

  if (not f_exist(i_user: i_prodLib: '*FILE': *omit: o_msgID: o_msgDta));
    return;
  endif;

  o_msgID = '';
  o_msgDta = '';

end-proc;

//===================================================================*
//  Prozedur:  f_getUsrSg                                 (Body)     *
//===================================================================*

dcl-proc f_getUsrSg export;
  dcl-pi *n like(SET0000_t);
    i_key    like(KEY_t) const;
    o_msgID  char(7) options(*nopass);
    o_msgDta char(512) options(*nopass);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_getUsrSg like(SET0000_t) inz;

  //  Hilfsfelder für optionale Parameter ...
  dcl-s o2_msgID like(o_msgID) inz;
  dcl-s o3_msgDta like(o_msgDta) inz;

  //  definieren Arbeitsfelder ...
  dcl-s x like(int4_t);
  dcl-s y like(int4_t);
  dcl-s set0000 like(SET0000_t);
  // ------------------------------------------------------------------------
  p_initSrvPgm();

  p_opnFile(o2_msgID: o3_msgDta);
  if (o2_msgID = ' ');

    clear U_Key3;
    U_Key3.S_User = g_user;
    U_Key3.S_Section = '*PGM';
    U_Key3.S_Key = i_key;
    chain %kds(U_Key3: 3) fpeekusr;
    if (%found(peekusr));
      set0000 = f_initUsrS(i_key);
      exsr chkUsrSetg;
      update fpeekusr;
    else;
      S_Data  = f_initUsrS(i_key);
      write fpeekusr;
    endif;

    f_getUsrSg = S_Data;

  endif;

  //  Füllen optionale Rückgabeparameter ...
  if (%parms() >= %parmnum(o_msgID));
    o_msgID = o2_msgID;
  endif;

  if (%parms() >= %parmnum(o_msgDta));
    o_msgDta = o3_msgDta;
  endif;

  return f_getUsrSg;

  // ---------------------------------------------------------- *
  //    ChkUsrSetg    Prüfen der Benutzervoreinstellungen       *
  //                  auf Aktualität                            *
  // ---------------------------------------------------------- *

  begsr chkUsrSetg;

    //  Ende der alten Daten
    x = %scan(x'8B': S_Data: 1);
    if (x = 0);
      x = %checkr(' ': S_Data);
    else;
      x = x - 1;
    endif;

    //  Ende der neuen Daten
    y = %scan(x'8B': set0000: 1) - 1;

    //  Aktualisieren, wenn die neuen Daten
    //  länger als die "Altdaten" sind ...
    if (y > x);
      //  ... extrahieren alte Daten
      S_Data = %subst(S_Data: 1: x);
      //  ... extrahieren überhang der neuen Daten
      x = x + 1;
      set0000 = %subst(set0000: x);
      //  ... zusammenfügen alt + neu
      %subst(S_Data: x) = set0000;
    endif;

  endsr;

end-proc;

//===================================================================*
//  Prozedur:  p_updUsrSg                                 (Body)     *
//===================================================================*

dcl-proc p_updUsrSg export;
  dcl-pi *n;
    i_key  like(KEY_t) const;
    i_data like(SET0000_t) const;
  end-pi;

  //  definieren Arbeitsfelder
  dcl-s msgID char(7) inz;
  dcl-s msgDta char(512) inz;
  // ------------------------------------------------------------------------
  p_initSrvPgm();

  p_opnFile(msgID: msgDta);

  clear U_Key3;
  U_Key3.S_User = g_user;
  U_Key3.S_Section = '*PGM';
  U_Key3.S_Key = i_key;
  chain %kds(U_Key3: 3) fpeekusr;
  if (%found(peekusr));
    S_Data = i_data;
    update fpeekusr;
  endif;

end-proc;

//===================================================================*
//  Prozedur:  f_chainUsr                                 (Body)     *
//  Returns bFalse ('0') on success, else bTrue ('1').               *
//===================================================================*

dcl-proc f_chainUsr export;
  dcl-pi *n like(bool_t);
    i_section like(SECTION_t) const;
    i_key     like(KEY_t) const;
    o_data    like(SET0000_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_chainUsr like(bool_t) inz;
  //  definieren Arbeitsfelder
  dcl-s msgID char(7) inz;
  dcl-s msgDta char(512) inz;
  // ------------------------------------------------------------------------
  p_initSrvPgm();

  clear S_Data;

  p_opnFile(msgID: msgDta);
  if (msgID = '');
    clear U_Key3;
    U_Key3.S_User = g_user;
    U_Key3.S_Section = i_section;
    U_Key3.S_Key = i_key;
    chain(n) %kds(U_Key3: 3) fpeekusr;
    if (%found(peekusr));
      f_chainUsr = '0';
    else;
      f_chainUsr = '1';
    endif;
  else;
    f_chainUsr = '1';
  endif;

  o_data = S_Data;

  return f_chainUsr;

end-proc;

//===================================================================*
//  Prozedur:  f_updatUsr                                 (Body)     *
//  Returns bFalse ('0') on success, else bTrue ('1').               *
//===================================================================*

dcl-proc f_updatUsr export;
  dcl-pi *n like(bool_t);
    i_section like(SECTION_t) const;
    i_key     like(KEY_t) const;
    i_data    like(SET0000_t) const;
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_updatUsr like(bool_t) inz;

  //  definieren Arbeitsfelder
  dcl-s msgID char(7) inz;
  dcl-s msgDta char(512) inz;
  // ------------------------------------------------------------------------
  p_initSrvPgm();

  p_opnFile(msgID: msgDta);
  if (msgID = '');
    clear U_Key3;
    U_Key3.S_User = g_user;
    U_Key3.S_Section = i_section;
    U_Key3.S_Key = i_key;
    chain %kds(U_Key3: 3) fpeekusr;
    if (%found(peekusr));
      S_Data = i_data;
      update(e) fpeekusr;
      if (%error());
        f_updatUsr = bTrue;
      else;
        f_updatUsr = bFalse;
      endif;
    else;
      f_updatUsr = bTrue;
    endif;
  else;
    f_updatUsr = bTrue;
  endif;

  return f_updatUsr;

end-proc;

//===================================================================*
//  Prozedur:  f_deletUsr                                 (Body)     *
//  Returns bFalse ('0') on success, else bTrue ('1').               *
//===================================================================*

dcl-proc f_deletUsr export;
  dcl-pi *n like(bool_t);
    i_section like(SECTION_t) const;
    i_key     like(KEY_t) const;
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_deletUsr like(bool_t) inz;

  //  definieren Arbeitsfelder
  dcl-s msgID char(7) inz;
  dcl-s msgDta char(512) inz;
  // ------------------------------------------------------------------------
  p_initSrvPgm();

  p_opnFile(msgID: msgDta);
  if (msgID = '');
    clear U_Key3;
    U_Key3.S_User = g_user;
    U_Key3.S_Section = i_section;
    U_Key3.S_Key = i_key;
    chain %kds(U_Key3: 3) fpeekusr;
    if (%found(peekusr));
      delete(e) fpeekusr;
      if (%error());
        f_deletUsr = bTrue;
      else;
        f_deletUsr = bFalse;
      endif;
    else;
      f_deletUsr = bTrue;
    endif;
  else;
    f_deletUsr = bTrue;
  endif;

  return f_deletUsr;

end-proc;

//===================================================================*
//  Prozedur:  f_writeUsr                                 (Body)     *
//  Returns bFalse ('0') on success, else bTrue ('1').               *
//===================================================================*

dcl-proc f_writeUsr export;
  dcl-pi *n like(bool_t);
    i_section like(SECTION_t) const;
    i_key     like(KEY_t) const;
    i_data    like(SET0000_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_writeUsr like(bool_t) inz;
  //  definieren Arbeitsfelder
  dcl-s msgID char(7) inz;
  dcl-s msgDta char(512) inz;
  // ------------------------------------------------------------------------
  p_initSrvPgm();

  p_opnFile(msgID: msgDta);
  if (msgID = '');
    S_User = g_user;
    S_Section = i_section;
    S_Key = i_key;
    S_Data = i_data;
    write(e) fpeekusr;
    if (%error());
      f_writeUsr = bTrue;
    else;
      f_writeUsr = bFalse;
    endif;
  else;
    f_writeUsr = bTrue;
  endif;

  return f_writeUsr;

end-proc;

//===================================================================*
//  Prozedur:  p_setllUsr                                 (Body)     *
//===================================================================*

dcl-proc p_setllUsr export;
  dcl-pi *n;
    i_section like(SECTION_t) const;
    i_key     like(KEY_t) options(*nopass) const;
  end-pi;

  //  definieren Arbeitsfelder
  dcl-s msgID char(7) inz;
  dcl-s msgDta char(512) inz;
  // ------------------------------------------------------------------------
  p_initSrvPgm();

  p_opnFile(msgID: msgDta);
  if (msgID = '');

    if (%parms() >= %parmnum(i_key));
      clear U_Key3;
      U_Key3.S_User = g_user;
      U_Key3.S_Section = i_section;
      U_Key3.S_Key = i_key;
      setll %kds(U_Key3: 3) fpeekusr;
    else;
      clear U_Key3;
      U_Key3.S_User = g_user;
      U_Key3.S_Section = i_section;
      setll %kds(U_Key3: 2) fpeekusr;
    endif;

  endif;

end-proc;

//===================================================================*
//  Prozedur:  p_setgtUsr                                 (Body)     *
//===================================================================*

dcl-proc p_setgtUsr export;
  dcl-pi *n;
    i_section like(SECTION_t) const;
    i_key     like(KEY_t) options(*nopass) const;
  end-pi;

  //  definieren Arbeitsfelder
  dcl-s msgID char(7) inz;
  dcl-s msgDta char(512) inz;
  // ------------------------------------------------------------------------
  p_initSrvPgm();

  p_opnFile(msgID: msgDta);
  if (msgID = '');

    if (%parms() >= %parmnum(i_key));
      clear U_Key3;
      U_Key3.S_User = g_user;
      U_Key3.S_Section = i_section;
      U_Key3.S_Key = i_key;
      setgt %kds(U_Key3: 3) fpeekusr;
    else;
      clear U_Key3;
      U_Key3.S_User = g_user;
      U_Key3.S_Section = i_section;
      setgt %kds(U_Key3: 2) fpeekusr;
    endif;

  endif;

end-proc;

//===================================================================*
//  Prozedur:  f_readeUsr                                 (Body)     *
//===================================================================*

dcl-proc f_readeUsr export;
  dcl-pi *n like(bool_t);
    i_section like(SECTION_t) const;
    o_key     like(KEY_t) options(*nopass);
    o_data    like(SET0000_t) options(*nopass);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_readeUsr like(bool_t) inz;

  //  definieren Hilfsfelder für optionale Parameter ...
  dcl-s o2_key like(KEY_t) inz;
  dcl-s o3_data like(SET0000_t) inz;

  //  definieren Arbeitsfelder
  dcl-s msgID char(7) inz;
  dcl-s msgDta char(512) inz;
  // ------------------------------------------------------------------------
  p_initSrvPgm();

  clear S_Key;
  clear S_Data;

  p_opnFile(msgID: msgDta);
  if (msgID = '');
    clear U_Key3;
    U_Key3.S_User = g_user;
    U_Key3.S_Section = i_section;
    reade(n) %kds(U_Key3: 2) fpeekusr;
    if (not %eof());
      f_readeUsr = '0';
    else;
      f_readeUsr = '1';
    endif;
  else;
    f_readeUsr = '1';
  endif;

  o2_key  = S_Key;
  o3_data = S_Data;

  //  Füllen optionale Rückgabeparameter ...
  if (%parms() >= %parmnum(o_key));
    o_key   = o2_key;
  endif;

  if (%parms() >= %parmnum(o_data));
    o_data  = o3_data;
  endif;

  return f_readeUsr;

end-proc;

//===================================================================*
//  Prozedur:  p_setllDft                                 (Body)     *
//===================================================================*

dcl-proc p_setllDft export;
  dcl-pi *n;
    i_section like(SECTION_t) const;
    i_key     like(KEY_t) options(*nopass) const;
  end-pi;

  //  definieren Arbeitsfelder
  dcl-s msgID char(7) inz;
  dcl-s msgDta char(512) inz;
  // ------------------------------------------------------------------------
  p_initSrvPgm();

  p_opnDft(msgID: msgDta);
  if (msgID = ' ');

    clear d_key3;
    d_key3.D_User = '*NONE';
    d_key3.D_Section = i_section;
    if (%parms() >= %parmnum(i_key));
      d_key3.D_Key = i_key;
      setll %kds(d_key3: 3) fdefault;
    else;
      setll %kds(d_key3: 2) fdefault;
    endif;

  endif;

end-proc;

//===================================================================*
//  Prozedur:  f_readeDft                                 (Body)     *
//===================================================================*

dcl-proc f_readeDft export;
  dcl-pi *n like(bool_t);
    i_section like(SECTION_t) const;
    o_key     like(KEY_t) options(*nopass);
    o_data    like(SET0000_t) options(*nopass);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_readeDft like(bool_t) inz;

  //  definieren Hilfsfelder für optionale Parameter ...
  dcl-s o2_key like(KEY_t) inz;
  dcl-s o3_data like(SET0000_t) inz;

  //  definieren Arbeitsfelder
  dcl-s msgID char(7) inz;
  dcl-s msgDta char(512) inz;
  // ------------------------------------------------------------------------
  p_initSrvPgm();

  clear D_Key;
  clear D_Data;

  p_opnDft(msgID: msgDta);
  if (msgID = '');

    clear d_key3;
    d_key3.D_User = '*NONE';
    d_key3.D_Section = i_section;
    reade %kds(d_key3: 2) fdefault;
    if (not %eof());
      f_readeDft = '0';
    else;
      f_readeDft = '1';
    endif;
  else;
    f_readeDft = '1';
  endif;

  o2_key  = D_Key;
  o3_data = D_Data;

  //  Füllen optionale Rückgabeparameter ...
  if (%parms() >= %parmnum(o_key));
    o_key   = o2_key;
  endif;

  if (%parms() >= %parmnum(o_data));
    o_data  = o3_data;
  endif;

  return f_readeDft;

end-proc;

//===================================================================*
//  Prozedur:  p_setUsr                                   (Body)     *
//===================================================================*

dcl-proc p_setUsr export;
  dcl-pi *n;
    i_user like(user_t) const;
    i_file like(file_t) const;
    i_lib  like(lib_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  g_user = i_user;
  g_file = i_file;
  g_lib  = i_lib;

end-proc;

//===================================================================*
//  Prozedur:  f_getUsr                                   (Body)     *
//===================================================================*

dcl-proc f_getUsr export;
  dcl-pi *n like(user_t);
    o_file like(file_t);
    o_lib  like(lib_t);
  end-pi;
  // ------------------------------------------------------------------------

  o_file = g_file;
  o_lib  = g_lib;

  return g_user;

end-proc;

//===================================================================*
//  Prozedur:  f_initUsrS                                 (Body)     *
//===================================================================*

dcl-proc f_initUsrS;
  dcl-pi *n like(SET0000_t);
    i_key like(KEY_t) const;
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_initUsrS like(SET0000_t) inz;

  dcl-ds set0001 likeds(SET0001_t) inz(*likeds);
  dcl-ds set0002 likeds(SET0002_t) inz(*likeds);
  dcl-ds set0003 likeds(SET0003_t) inz(*likeds);
  dcl-ds set0004 likeds(SET0004_t) inz(*likeds);
  dcl-ds set0005 likeds(SET0005_t) inz(*likeds);
  dcl-ds set0006 likeds(set0006_t) inz(*likeds);
  dcl-ds set0007 likeds(set0007_t) inz(*likeds);
  dcl-ds set0008 likeds(set0008_t) inz(*likeds);
  dcl-ds set0009 likeds(set0009_t) inz(*likeds);
  dcl-ds set0010 likeds(set0010_t) inz(*likeds);
  dcl-ds set0011 likeds(set0011_t) inz(*likeds);
  dcl-ds set0012 likeds(set0012_t) inz(*likeds);
  dcl-ds set0013 likeds(set0013_t) inz(*likeds);
  dcl-ds set0014 likeds(set0014_t) inz(*likeds);
  dcl-ds set0015 likeds(set0015_t) inz(*likeds);
  dcl-ds set0016 likeds(set0016_t) inz(*likeds);
  // ----------------------------------------------------------------------

  select;
  //  SET0001 ...
  when (i_key = '*DSPATTR');
    f_initUsrS = set0001;
  //  SET0002 ...
  when (i_key = '*SEARCH');
    f_initUsrS = set0002;
  //  SET0003 ...
  when (i_key = '*ACCESSKEY');
    f_initUsrS = set0003;
  //  SET0004 ...
  when (i_key = '*LANGUAGE');
    f_initUsrS = set0004;
  //  SET0005 ...
  when (i_key = '*SPLASH');
    f_initUsrS = set0005;
  //  SET0006 ...
  when (i_key = '*CVTCHR');
    f_initUsrS = set0006;
  //  SET0007 ...
  when (i_key = '*VERSION');
    f_initUsrS = set0007;
  //  SET0008 ...
  when (i_key = '*PROMPT');
    f_initUsrS = set0008;
  //  SET0009 ...
  when (i_key = '*FLOATKEYS');
    f_initUsrS = set0009;
  //  SET0010 ...
  when (i_key = '*SCROLL');
    f_initUsrS = set0010;
  //  SET0011 ...
  when (i_key = '*DFTDSPMDE');
    f_initUsrS = set0011;
  //  SET0012 ...
  when (i_key = '*CRTPGM');
    f_initUsrS = set0012;
  //  SET0013 ...
  when (i_key = '*SECATRDFT');
    f_initUsrS = set0013;
  //  SET0014 ...
  when (i_key = '*PRVFILE');
    f_initUsrS = set0014;
  //  SET0015 ...
  when (i_key = '*ENVFILE');
    f_initUsrS = set0015;
  //  SET0016 ...
  when (i_key = '*SQLLMTCNT');
    f_initUsrS = set0016;
  //  Fehler ...
  other;
    p_sndPgmMg('USR9999'
     : 'PEEK53, f_initUsrS, i_key: ' + i_key
     : '*' : '*ESCAPE');
  endsl;

  return f_initUsrS;

end-proc;

//===================================================================*
//  Prozedur:  p_opnFile                                  (Body)     *
//  Returns '0' on success, else '1'.                                *
//===================================================================*

dcl-proc p_opnFile;
  dcl-pi *n;
    o_msgID  char(7);
    o_msgDta char(512);
  end-pi;

  dcl-s set0000 like(SET0000_t);
  // ------------------------------------------------------------------------

  //  Öffnen Datei PEEKUSR ...
  if (File_00_DS.IsOpen <> '1');

    g_peekusr = %trim(g_lib) + '/' + %trim(g_file);

    open(e) peekusr;
    if (%error());
      o_msgID  = 'CPF9897';
      o_msgDta = sds.msgText;
    else;

      if (f_chainUsr('*PGM': '*VERSION': set0000) = '1');
        peek22('*REPLACE': '*ALL');
      endif;

      o_msgID  = '';
      o_msgDta = '';
    endif;

  else;
    o_msgID  = '';
    o_msgDta = '';
  endif;

end-proc;

//===================================================================*
//  Prozedur:  p_opnDft                                   (Body)     *
//===================================================================*

dcl-proc p_opnDft;
  dcl-pi *n;
    o_msgID  char(7);
    o_msgDta char(512);
  end-pi;
  // ------------------------------------------------------------------------

  //  Öffnen Datei DEFAULT (PEEKUSR) ...
  if (File_01_DS.IsOpen <> '1');

    g_default = %trim(f_getPrdLb()) + '/' + 'PEEKUSR';

    open(e) default;
    if (%error());
      o_msgID  = 'CPF9897';
      o_msgDta = sds.msgText;
    else;
      o_msgID  = ' ';
      o_msgDta = ' ';
    endif;

  else;
    o_msgID  = ' ';
    o_msgDta = ' ';
  endif;

end-proc;

//===================================================================*
//  Prozedur:  p_initSrvPgm                               (Body)     *
//===================================================================*

dcl-proc p_initSrvPgm;
  dcl-pi *n;
  end-pi;
  // ------------------------------------------------------------------------

  if (g_isInit = bFalse);

    if (g_user = '');
      p_setUsr(sds.user: sds.user: f_getPrdLb());
    endif;

    peek22_name = f_pgmCallN('PEEK22');

    g_isInit = bTrue;
  endif;

end-proc;

