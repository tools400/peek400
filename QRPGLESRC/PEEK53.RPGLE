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
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

dcl-f peekusr usage(*update:*delete:*output) keyed usropn prefix(s_)
      infds(file_00_ds) extfile(g_peekusr);

dcl-f default keyed usropn extdesc('PEEKUSR')
      rename(fpeekusr: fdefault) prefix(d_) infds(file_01_ds)
      extfile(g_default);

dcl-ds file_00_ds likeds(infds_t);
dcl-ds file_01_ds likeds(infds_t);

dcl-s g_peekusr       char(21);
dcl-s g_default       char(21);

dcl-s g_isinit        like(bool_t) inz(bFalse);
dcl-s g_user          like(user_t) inz;
dcl-s g_file          like(file_t) inz;
dcl-s g_lib           like(lib_t) inz;

dcl-pr f_initusrs        like(set0000_t);
  i_key           const  like(key_t);
end-pr;

dcl-pr p_opnfile;
  o_msgid         char(7);
  o_msgdta        char(512);
end-pr;

dcl-pr p_opndft;
  o_msgid         char(7);
  o_msgdta        char(512);
end-pr;

dcl-pr p_initsrvpgm;
end-pr;

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,D_INFDS
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,D_COLORATR
/COPY QCOPYLE,SDS

/COPY QCOPYLE,SET0001
/COPY QCOPYLE,SET0002
/COPY QCOPYLE,SET0003
/COPY QCOPYLE,SET0004
/COPY QCOPYLE,SET0005
/COPY QCOPYLE,SET0006
/COPY QCOPYLE,SET0007
/COPY QCOPYLE,SET0008
/COPY QCOPYLE,SET0009
/COPY QCOPYLE,SET0010
/COPY QCOPYLE,SET0011
/COPY QCOPYLE,SET0012
/COPY QCOPYLE,SET0013
/COPY QCOPYLE,SET0014
/COPY QCOPYLE,SET0015
/COPY QCOPYLE,SET0016

/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

/COPY QCOPYLE,PPEEK22

dcl-s peek22_name     like(pgmcalln_t) inz;

dcl-ds u_key3 likerec(fpeekusr: *key);
dcl-ds d_key3 likerec(fdefault: *key);

//===================================================================*
//  Prozedur:  p_crtUsrSg                                 (Body)     *
//===================================================================*

dcl-proc p_crtusrsg export;
  dcl-pi *N;
    i_prodlib       const  like(lib_t);
    i_user          const  like(user_t);
    o_msgID         like(msgid_t);
    o_msgDta        like(msgdta_t);
  end-pi;

  dcl-s cmd             char(256) inz;
  // ------------------------------------------------------------------------
  p_initsrvpgm();

  if (not f_exist('PEEKUSR': i_prodlib: '*FILE': *omit: o_msgID: o_msgDta));
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

  if (not f_exist(i_user: i_prodlib: '*FILE': *omit: o_msgID: o_msgDta));
    return;
  endif;

  o_msgID = '';
  o_msgDta = '';

end-proc;

//===================================================================*
//  Prozedur:  f_getUsrSg                                 (Body)     *
//===================================================================*

dcl-proc f_getusrsg export;
  dcl-pi *N        like(set0000_t);
    i_key           const  like(key_t);
    o_msgid         char(7) options(*nopass);
    o_msgdta        char(512) options(*nopass);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_getusrsg      like(set0000_t) inz;

  //  Hilfsfelder für optionale Parameter ...
  dcl-s o2_msgid        like(o_msgid) inz;
  dcl-s o3_msgdta       like(o_msgdta) inz;

  //  definieren Arbeitsfelder ...
  dcl-s x               like(int4_t);
  dcl-s y               like(int4_t);
  dcl-s set0000         like(set0000_t);
  // ------------------------------------------------------------------------
  p_initsrvpgm();

  p_opnfile(o2_msgid: o3_msgdta);
  if (o2_msgid = ' ');

    clear u_key3;
    u_key3.s_user = g_user;
    u_key3.s_section = '*PGM';
    u_key3.s_key = i_key;
    chain %kds(u_key3: 3) fpeekusr;
    if (%found(peekusr));
      set0000 = f_initusrs(i_key);
      exsr chkusrsetg;
      update fpeekusr;
    else;
      s_data  = f_initusrs(i_key);
      write fpeekusr;
    endif;

    f_getusrsg = s_data;

  endif;

  //  Füllen optionale Rückgabeparameter ...
  if (%parms() >= %parmnum(o_msgid));
    o_msgid = o2_msgid;
  endif;

  if (%parms() >= %parmnum(o_msgdta));
    o_msgdta = o3_msgdta;
  endif;

  return f_getusrsg;

  // ---------------------------------------------------------- *
  //    ChkUsrSetg    Prüfen der Benutzervoreinstellungen       *
  //                  auf Aktualität                            *
  // ---------------------------------------------------------- *

  begsr chkusrsetg;

    //  Ende der alten Daten
    x = %scan(x'8B': s_data: 1);
    if (x = 0);
      x = %checkr(' ': s_data);
    else;
      x = x - 1;
    endif;

    //  Ende der neuen Daten
    y = %scan(x'8B': set0000: 1) - 1;

    //  Aktualisieren, wenn die neuen Daten
    //  länger als die "Altdaten" sind ...
    if (y > x);
      //  ... extrahieren alte Daten
      s_data = %subst(s_data: 1: x);
      //  ... extrahieren überhang der neuen Daten
      x = x + 1;
      set0000 = %subst(set0000: x);
      //  ... zusammenfügen alt + neu
      %subst(s_data: x) = set0000;
    endif;

  endsr;

end-proc;

//===================================================================*
//  Prozedur:  p_updUsrSg                                 (Body)     *
//===================================================================*

dcl-proc p_updusrsg export;
  dcl-pi *N;
    i_key           const  like(key_t);
    i_data          const  like(set0000_t);
  end-pi;

  //  definieren Arbeitsfelder
  dcl-s msgid           char(7) inz;
  dcl-s msgdta          char(512) inz;
  // ------------------------------------------------------------------------
  p_initsrvpgm();

  p_opnfile(msgid: msgdta);

  clear u_key3;
  u_key3.s_user = g_user;
  u_key3.s_section = '*PGM';
  u_key3.s_key = i_key;
  chain %kds(u_key3: 3) fpeekusr;
  if (%found(peekusr));
    s_data = i_data;
    update fpeekusr;
  endif;

end-proc;

//===================================================================*
//  Prozedur:  f_chainUsr                                 (Body)     *
//  Returns bFalse ('0') on success, else bTrue ('1').               *
//===================================================================*

dcl-proc f_chainusr export;
  dcl-pi *N        like(bool_t);
    i_section       const  like(section_t);
    i_key           const  like(key_t);
    o_data          like(set0000_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_chainusr      like(bool_t) inz;
  //  definieren Arbeitsfelder
  dcl-s msgid           char(7) inz;
  dcl-s msgdta          char(512) inz;
  // ------------------------------------------------------------------------
  p_initsrvpgm();

  clear s_data;

  p_opnfile(msgid: msgdta);
  if (msgid = '');
    clear u_key3;
    u_key3.s_user = g_user;
    u_key3.s_section = i_section;
    u_key3.s_key = i_key;
    chain(n) %kds(u_key3: 3) fpeekusr;
    if (%found(peekusr));
      f_chainusr = '0';
    else;
      f_chainusr = '1';
    endif;
  else;
    f_chainusr = '1';
  endif;

  o_data = s_data;

  return f_chainusr;

end-proc;

//===================================================================*
//  Prozedur:  f_updatUsr                                 (Body)     *
//  Returns bFalse ('0') on success, else bTrue ('1').               *
//===================================================================*

dcl-proc f_updatusr export;
  dcl-pi *N        like(bool_t);
    i_section       const  like(section_t);
    i_key           const  like(key_t);
    i_data          const  like(set0000_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_updatusr      like(bool_t) inz;

  //  definieren Arbeitsfelder
  dcl-s msgid           char(7) inz;
  dcl-s msgdta          char(512) inz;
  // ------------------------------------------------------------------------
  p_initsrvpgm();

  p_opnfile(msgid: msgdta);
  if (msgid = '');
    clear u_key3;
    u_key3.s_user = g_user;
    u_key3.s_section = i_section;
    u_key3.s_key = i_key;
    chain %kds(u_key3: 3) fpeekusr;
    if (%found(peekusr));
      s_data = i_data;
      update(e) fpeekusr;
      if (%error());
        f_updatusr = bFalse;
      else;
        f_updatusr = bTrue;
      endif;
    else;
      f_updatusr = bFalse;
    endif;
  else;
    f_updatusr = bFalse;
  endif;

  return f_updatusr;

end-proc;

//===================================================================*
//  Prozedur:  f_deletUsr                                 (Body)     *
//  Returns bFalse ('0') on success, else bTrue ('1').               *
//===================================================================*

dcl-proc f_deletusr export;
  dcl-pi *N        like(bool_t);
    i_section       const  like(section_t);
    i_key           const  like(key_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_deletusr      like(bool_t) inz;

  //  definieren Arbeitsfelder
  dcl-s msgid           char(7) inz;
  dcl-s msgdta          char(512) inz;
  // ------------------------------------------------------------------------
  p_initsrvpgm();

  p_opnfile(msgid: msgdta);
  if (msgid = '');
    clear u_key3;
    u_key3.s_user = g_user;
    u_key3.s_section = i_section;
    u_key3.s_key = i_key;
    chain %kds(u_key3: 3) fpeekusr;
    if (%found(peekusr));
      delete(e) fpeekusr;
      if (%error());
        f_deletusr = bTrue;
      else;
        f_deletusr = bFalse;
      endif;
    else;
      f_deletusr = bTrue;
    endif;
  else;
    f_deletusr = bTrue;
  endif;

  return f_deletusr;

end-proc;

//===================================================================*
//  Prozedur:  f_writeUsr                                 (Body)     *
//  Returns bFalse ('0') on success, else bTrue ('1').               *
//===================================================================*

dcl-proc f_writeusr export;
  dcl-pi *N        like(bool_t);
    i_section       const  like(section_t);
    i_key           const  like(key_t);
    i_data          like(set0000_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_writeusr      like(bool_t) inz;
  //  definieren Arbeitsfelder
  dcl-s msgid           char(7) inz;
  dcl-s msgdta          char(512) inz;
  // ------------------------------------------------------------------------
  p_initsrvpgm();

  p_opnfile(msgid: msgdta);
  if (msgid = '');
    s_user = g_user;
    s_section = i_section;
    s_key = i_key;
    s_data = i_data;
    write(e) fpeekusr;
    if (%error());
      f_writeusr = bTrue;
    else;
      f_writeusr = bFalse;
    endif;
  else;
    f_writeusr = bTrue;
  endif;

  return f_writeusr;

end-proc;

//===================================================================*
//  Prozedur:  p_setllUsr                                 (Body)     *
//===================================================================*

dcl-proc p_setllusr export;
  dcl-pi *N;
    i_section       const  like(section_t);
    i_key           const  like(key_t) options(*nopass);
  end-pi;

  //  definieren Arbeitsfelder
  dcl-s msgid           char(7) inz;
  dcl-s msgdta          char(512) inz;
  // ------------------------------------------------------------------------
  p_initsrvpgm();

  p_opnfile(msgid: msgdta);
  if (msgid = '');

    if (%parms() >= %parmnum(i_key));
      clear u_key3;
      u_key3.s_user = g_user;
      u_key3.s_section = i_section;
      u_key3.s_key = i_key;
      setll %kds(u_key3: 3) fpeekusr;
    else;
      clear u_key3;
      u_key3.s_user = g_user;
      u_key3.s_section = i_section;
      setll %kds(u_key3: 2) fpeekusr;
    endif;

  endif;

end-proc;

//===================================================================*
//  Prozedur:  p_setgtUsr                                 (Body)     *
//===================================================================*

dcl-proc p_setgtusr export;
  dcl-pi *N;
    i_section       const  like(section_t);
    i_key           const  like(key_t) options(*nopass);
  end-pi;

  //  definieren Arbeitsfelder
  dcl-s msgid           char(7) inz;
  dcl-s msgdta          char(512) inz;
  // ------------------------------------------------------------------------
  p_initsrvpgm();

  p_opnfile(msgid: msgdta);
  if (msgid = '');

    if (%parms() >= %parmnum(i_key));
      clear u_key3;
      u_key3.s_user = g_user;
      u_key3.s_section = i_section;
      u_key3.s_key = i_key;
      setgt %kds(u_key3: 3) fpeekusr;
    else;
      clear u_key3;
      u_key3.s_user = g_user;
      u_key3.s_section = i_section;
      setgt %kds(u_key3: 2) fpeekusr;
    endif;

  endif;

end-proc;

//===================================================================*
//  Prozedur:  f_readeUsr                                 (Body)     *
//===================================================================*

dcl-proc f_readeusr export;
  dcl-pi *N        like(bool_t);
    i_section       const  like(section_t);
    o_key           like(key_t) options(*nopass);
    o_data          like(set0000_t) options(*nopass);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_readeusr      like(bool_t) inz;

  //  definieren Hilfsfelder für optionale Parameter ...
  dcl-s o2_key          like(key_t) inz;
  dcl-s o3_data         like(set0000_t) inz;

  //  definieren Arbeitsfelder
  dcl-s msgid           char(7) inz;
  dcl-s msgdta          char(512) inz;
  // ------------------------------------------------------------------------
  p_initsrvpgm();

  clear s_key;
  clear s_data;

  p_opnfile(msgid: msgdta);
  if (msgid = '');
    clear u_key3;
    u_key3.s_user = g_user;
    u_key3.s_section = i_section;
    reade(n) %kds(u_key3: 2) fpeekusr;
    if (not %eof());
      f_readeusr = '0';
    else;
      f_readeusr = '1';
    endif;
  else;
    f_readeusr = '1';
  endif;

  o2_key  = s_key;
  o3_data = s_data;

  //  Füllen optionale Rückgabeparameter ...
  if (%parms() >= %parmnum(o_key));
    o_key   = o2_key;
  endif;

  if (%parms() >= %parmnum(o_data));
    o_data  = o3_data;
  endif;

  return f_readeusr;

end-proc;

//===================================================================*
//  Prozedur:  p_setllDft                                 (Body)     *
//===================================================================*

dcl-proc p_setlldft export;
  dcl-pi *N;
    i_section       const  like(section_t);
    i_key           const  like(key_t) options(*nopass);
  end-pi;

  //  definieren Arbeitsfelder
  dcl-s msgid           char(7) inz;
  dcl-s msgdta          char(512) inz;
  // ------------------------------------------------------------------------
  p_initsrvpgm();

  p_opndft(msgid: msgdta);
  if (msgid = ' ');

    clear d_key3;
    d_key3.d_user = '*NONE';
    d_key3.d_section = i_section;
    d_key3.d_key = i_key;
    if (%parms() >= %parmnum(i_key));
      setll %kds(d_key3: 3) fdefault;
    else;
      setll %kds(d_key3: 2) fdefault;
    endif;

  endif;

end-proc;

//===================================================================*
//  Prozedur:  f_readeDft                                 (Body)     *
//===================================================================*

dcl-proc f_readedft export;
  dcl-pi *N        like(bool_t);
    i_section       const  like(section_t);
    o_key           like(key_t)
         options(*nopass);
    o_data          like(set0000_t)
         options(*nopass);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_readedft      like(bool_t) inz;

  //  definieren Hilfsfelder für optionale Parameter ...
  dcl-s o2_key          like(key_t) inz;
  dcl-s o3_data         like(set0000_t) inz;

  //  definieren Arbeitsfelder
  dcl-s msgid           char(7) inz;
  dcl-s msgdta          char(512) inz;
  // ------------------------------------------------------------------------
  p_initsrvpgm();

  clear d_key;
  clear d_data;

  p_opndft(msgid: msgdta);
  if (msgid = '');

    clear d_key3;
    d_key3.d_user = '*NONE';
    d_key3.d_section = i_section;
    reade %kds(d_key3: 2) fdefault;
    if (not %eof());
      f_readedft = '0';
    else;
      f_readedft = '1';
    endif;
  else;
    f_readedft = '1';
  endif;

  o2_key  = d_key;
  o3_data = d_data;

  //  Füllen optionale Rückgabeparameter ...
  if (%parms() >= %parmnum(o_key));
    o_key   = o2_key;
  endif;

  if (%parms() >= %parmnum(o_data));
    o_data  = o3_data;
  endif;

  return f_readedft;

end-proc;

//===================================================================*
//  Prozedur:  p_setUsr                                   (Body)     *
//===================================================================*

dcl-proc p_setusr export;
  dcl-pi *N;
    i_user          const  like(user_t);
    i_file          const  like(file_t);
    i_lib           const  like(lib_t);
  end-pi;
  // ------------------------------------------------------------------------

  g_user = i_user;
  g_file = i_file;
  g_lib  = i_lib;

end-proc;

//===================================================================*
//  Prozedur:  f_getUsr                                   (Body)     *
//===================================================================*

dcl-proc f_getusr export;
  dcl-pi *N        like(user_t);
    o_file          like(file_t);
    o_lib           like(lib_t);
  end-pi;
  // ------------------------------------------------------------------------

  o_file = g_file;
  o_lib  = g_lib;

  return g_user;

end-proc;

//===================================================================*
//  Prozedur:  f_initUsrS                                 (Body)     *
//===================================================================*

dcl-proc f_initusrs;
  dcl-pi *N        like(set0000_t);
    i_key           const  like(key_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_initusrs      like(set0000_t) inz;

  dcl-ds set0001 likeds(set0001_t) inz(*likeds);
  dcl-ds set0002 likeds(set0002_t) inz(*likeds);
  dcl-ds set0003 likeds(set0003_t) inz(*likeds);
  dcl-ds set0004 likeds(set0004_t) inz(*likeds);
  dcl-ds set0005 likeds(set0005_t) inz(*likeds);
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
    f_initusrs = set0001;
  //  SET0002 ...
  when (i_key = '*SEARCH');
    f_initusrs = set0002;
  //  SET0003 ...
  when (i_key = '*ACCESSKEY');
    f_initusrs = set0003;
  //  SET0004 ...
  when (i_key = '*LANGUAGE');
    f_initusrs = set0004;
  //  SET0005 ...
  when (i_key = '*SPLASH');
    f_initusrs = set0005;
  //  SET0006 ...
  when (i_key = '*CVTCHR');
    f_initusrs = set0006;
  //  SET0007 ...
  when (i_key = '*VERSION');
    f_initusrs = set0007;
  //  SET0008 ...
  when (i_key = '*PROMPT');
    f_initusrs = set0008;
  //  SET0009 ...
  when (i_key = '*FLOATKEYS');
    f_initusrs = set0009;
  //  SET0010 ...
  when (i_key = '*SCROLL');
    f_initusrs = set0010;
  //  SET0011 ...
  when (i_key = '*DFTDSPMDE');
    f_initusrs = set0011;
  //  SET0012 ...
  when (i_key = '*CRTPGM');
    f_initusrs = set0012;
  //  SET0013 ...
  when (i_key = '*SECATRDFT');
    f_initusrs = set0013;
  //  SET0014 ...
  when (i_key = '*PRVFILE');
    f_initusrs = set0014;
  //  SET0015 ...
  when (i_key = '*ENVFILE');
    f_initusrs = set0015;
  //  SET0016 ...
  when (i_key = '*SQLLMTCNT');
    f_initusrs = set0016;
  //  Fehler ...
  other;
    p_sndpgmmg('USR9999'
     : 'PEEK53, f_initUsrS, i_key: ' + i_key
     : '*' : '*ESCAPE');
  endsl;

  return f_initusrs;

end-proc;

//===================================================================*
//  Prozedur:  p_opnFile                                  (Body)     *
//  Returns '0' on success, else '1'.                                *
//===================================================================*

dcl-proc p_opnfile;
  dcl-pi *N;
    o_msgid         char(7);
    o_msgdta        char(512);
  end-pi;

  dcl-s set0000         like(set0000_t);
  // ------------------------------------------------------------------------

  //  Öffnen Datei PEEKUSR ...
  if (file_00_ds.isOpen <> '1');

    g_peekusr = %trim(g_lib) + '/' + %trim(g_file);

    open(e) peekusr;
    if (%error());
      o_msgid  = 'CPF9897';
      o_msgdta = sds.msgtext;
    else;

      if (f_chainusr('*PGM': '*VERSION': set0000) = '1');
        peek22('*REPLACE': '*ALL');
      endif;

      o_msgid  = '';
      o_msgdta = '';
    endif;

  else;
    o_msgid  = '';
    o_msgdta = '';
  endif;

end-proc;

//===================================================================*
//  Prozedur:  p_opnDft                                   (Body)     *
//===================================================================*

dcl-proc p_opndft;
  dcl-pi *N;
    o_msgid         char(7);
    o_msgdta        char(512);
  end-pi;
  // ------------------------------------------------------------------------

  //  Öffnen Datei DEFAULT (PEEKUSR) ...
  if (file_01_ds.isOpen <> '1');

    g_default = %trim(f_getprdlb()) + '/' + 'PEEKUSR';

    open(e) default;
    if (%error());
      o_msgid  = 'CPF9897';
      o_msgdta = sds.msgtext;
    else;
      o_msgid  = ' ';
      o_msgdta = ' ';
    endif;

  else;
    o_msgid  = ' ';
    o_msgdta = ' ';
  endif;

end-proc;

//===================================================================*
//  Prozedur:  p_initSrvPgm                               (Body)     *
//===================================================================*

dcl-proc p_initsrvpgm;
  dcl-pi *N;
  end-pi;
  // ------------------------------------------------------------------------

  if (g_isinit = bFalse);

    if (g_user = '');
      p_setusr(sds.user: sds.user: f_getprdlb());
    endif;

    peek22_name = f_pgmcalln('PEEK22');

    g_isinit = bTrue;
  endif;

end-proc;

