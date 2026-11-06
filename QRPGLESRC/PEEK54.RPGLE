**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK54                                            *
//  Typ      : RPGLE                                             *
//                                                               *
//  erstellt : 04.05.99  RADDATZ                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Dokumentation:                                               *
//                                                               *
//  Peek/400 - Sichern Arbeitsumgebung                           *
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

dcl-f peekEnv usage(*update: *delete: *output) keyed usropn prefix(en_);
dcl-f peekFld keyed usropn prefix(p_);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,FILD0100
/copy QCOPYLE,ENV0001
/copy QCOPYLE,SDS
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK54
/undefine internal_prototype

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-pr main;
  i_file       like(gi_file) value;
  i_lib        like(gi_lib) value;
  i_mbr        like(gi_mbr) value;
  i_rcdFmt     like(gi_rcdFmt) value;
  i_rcdFmtID   like(gi_rcdFmtID) value;
  i_envFile    like(gi_envFile) value;
  i_envLib     like(gi_envLib) value;
  i_envMbr     like(gi_envMbr) value;
  i_isAutoSave like(gi_isAutoSave) value;
  i_pinTabR    like(gi_pinTabR) dim(12) value;
  i_nbrPinR    like(gi_nbrPinR) value;
  i_pinTabC    like(gi_pinTabC) dim(12) value;
  i_nbrPinC    like(gi_nbrPinC) value;
  i_accMode    like(gi_accMode) value;
  i_sqlSel     like(gi_sqlSel) value;
  i_sqlOrd     like(gi_sqlOrd) value;
  i_isKeyLower like(gi_isKeyLower) value;
  o_msgID      like(go_msgID);
  o_msgDta     like(go_msgDta);
end-pr;

//*******************************************************************
//           Programmsteuerung                                      *
//*******************************************************************
dcl-pi peek54;
  gi_file       like(file_t) const;
  gi_lib        like(lib_t) const;
  gi_mbr        like(mbr_t) const;
  gi_rcdFmt     like(fmt_t) const;
  gi_rcdFmtID   like(fmtId_t) const;
  gi_envFile    like(file_t) const;
  gi_envLib     like(lib_t) const;
  gi_envMbr     like(mbr_t) const;
  gi_isAutoSave like(bool_t) const;
  gi_pinTabR    like(pinTabR_t) dim(12) const;
  gi_nbrPinR    like(int4_t) const;
  gi_pinTabC    like(fieldNme_t) dim(12) const;
  gi_nbrPinC    like(int4_t) const;
  gi_accMode    like(accessMode_t) const;
  gi_sqlSel     like(sqlWhere_t) const;
  gi_sqlOrd     like(sqlOrder_t) const;
  gi_isKeyLower like(bool_t) const;
  go_msgID      like(msgId_t);
  go_msgDta     like(msgDta_t);
end-pi;

dcl-ds p_key1 likerec(fpeekfld: *key);
//----------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

main(gi_file    :
      gi_lib     :
      gi_mbr     :
      gi_rcdFmt  :
      gi_rcdFmtID:
      gi_envFile :
      gi_envLib  :
      gi_envMbr  :
      gi_isAutoSave:
      gi_pinTabR :
      gi_nbrPinR :
      gi_pinTabC :
      gi_nbrPinC :
      gi_accMode :
      gi_sqlSel  :
      gi_sqlOrd  :
      gi_isKeyLower :
      go_msgID   :
      go_msgDta  );

return;

//===================================================================*
//  Prozedur:  p_crtUsrSg                                 (Body)     *
//===================================================================*

dcl-proc main;
  dcl-pi *n;
    i_file       like(gi_file) value;
    i_lib        like(gi_lib) value;
    i_mbr        like(gi_mbr) value;
    i_rcdFmt     like(gi_rcdFmt) value;
    i_rcdFmtID   like(gi_rcdFmtID) value;
    i_envFile    like(gi_envFile) value;
    i_envLib     like(gi_envLib) value;
    i_envMbr     like(gi_envMbr) value;
    i_isAutoSave like(gi_isAutoSave) value;
    i_pinTabR    like(gi_pinTabR) dim(12) value;
    i_nbrPinR    like(gi_nbrPinR) value;
    i_pinTabC    like(gi_pinTabC) dim(12) value;
    i_nbrPinC    like(gi_nbrPinC) value;
    i_accMode    like(gi_accMode) value;
    i_sqlSel     like(gi_sqlSel) value;
    i_sqlOrd     like(gi_sqlOrd) value;
    i_isKeyLower like(gi_isKeyLower) value;
    o_msgID      like(go_msgID);
    o_msgDta     like(go_msgDta);
  end-pi;

  //  Arbeitsfelder
  dcl-s pFile like(file_t);
  dcl-s pLib like(lib_t);
  dcl-s pMbr like(mbr_t);
  dcl-s pFmt like(fmt_t);
  dcl-s pEnvMbr like(i_envMbr);
  dcl-s canSave like(bool_t);
  dcl-s pMsgID like(msgId_t);
  dcl-s pMsgDta like(msgDta_t);

  //  Nachrichten
/copy QCOPYLE,USR9992
  //---------------------------------------------------*

  if (i_envMbr = '*FILE');
    pEnvMbr = i_file;
  else;
    pEnvMbr = i_envMbr;
  endif;

  //  Basiert auf physischer Datei ...
  f_basedPF(i_file    :
           i_lib     :
           i_mbr     :
           i_rcdFmt  :
           -1        :
           pFile     :
           pLib      :
           pMbr      :
           pFmt      );

  //  Überschreiben Datei ...
  f_execute('OVRDBF ' +
             'FILE(PEEKENV) ' +
             'TOFILE(' +
               %trim(i_envLib) + '/' +
               %trim(i_envFile) + ') ' +
             'MBR(' + %trim(pEnvMbr) + ') ' +
             'OVRSCOPE(*ACTGRPDFN) ' +
             'SHARE(*NO) ' +
             'SEQONLY(*NO) SECURE(*YES)'
           : pMsgID: pMsgDta);
  pMsgID = '';
  pMsgDta = '';

  //  Prüfen, ob gespeichert werden darf
  if (i_isAutoSave = bTrue);
    open(e) peekEnv;
    if (not %error());
      canSave =  checkAutoSave(pFile: pLib);
      close peekEnv;
    else;
      //     Fehler beim Öffnen aufgetreten
      clear usr9992;
      usr9992.var1 = 3;
      usr9992.var2 = i_file;
      usr9992.var3 = i_lib;
      usr9992.var4 = pEnvMbr;
      f_sndMsgToCmdLine('USR9992': usr9992);
      canSave = bFalse;
    endif;
  else;
    canSave = bTrue;
  endif;

  //  Löschen alte Daten ...
  if (canSave = bTrue);

    clearEnvironment(i_envFile  :
            i_envLib   :
            pEnvMbr    :
            o_msgID    :
            o_msgDta   );

    if (go_msgID = ' ');

      //  Öffnen Datei ...
      open peekEnv;

      //  Ausgeben accessMode ...
      writeAccessMode(pFile     :
               pLib      :
               i_accMode );

      //  Ausgeben Datei ...
      writeFile(pFile  :
            pLib   :
            i_file );

      //  Ausgeben Bibliothek ...
      writeLibrary(pFile :
           pLib  :
           i_lib );

      //  Ausgeben Teildatei ...
      writeMember(pFile :
           pLib  :
           i_mbr );

      //  Ausgeben Satzformat ...
      writeRecordFormat(pFile    :
              pLib     :
              i_rcdFmt );

      //  Ausgeben Satzformat-ID ...
      writeRecordFormatID(pFile     :
                pLib      :
                i_rcdFmtID);

      //  Ausgeben SqlSelect ...
      writeSQLSelect(pFile     :
              pLib      :
              i_sqlSel  );

      //  Ausgeben sqlOrder ...
      writeSQLOrder(pFile     :
              pLib      :
              i_sqlOrd  );

      //  Ausgeben isKeyLower ...
      writeIsKeyLowerCase(pFile       :
                  pLib        :
                  i_isKeyLower);

      //  Ausgeben Layout ...
      writeLayout(pFile     :
              pLib      );

      //  Ausgeben Pin-Record ...
      writePinnedRecords(pFile    :
               pLib     :
               i_pinTabR:
               i_nbrPinR);

      //  Ausgeben Pin-Column ...
      writePinnedColumns(pFile    :
               pLib     :
               i_pinTabC:
               i_nbrPinC);

      //  Schließen Datei ...
      close peekEnv;

    endif;
  endif;

  //  Löschen Überschreibung ...
  f_execute('DLTOVR ' +
             'FILE(PEEKENV) ' +
             'LVL(*ACTGRPDFN) '
           : pMsgID: pMsgDta);
  pMsgID = '';
  pMsgDta = '';

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_clrEnv                                   (Body)     *
//===================================================================*

dcl-proc clearEnvironment;
  dcl-pi *n extproc(*dclcase);
    i_envFile like(gi_envFile);
    i_envLib  like(gi_envLib);
    i_envMbr  like(gi_envMbr);
    o_msgID   like(go_msgID);
    o_msgDta  like(go_msgDta);
  end-pi;

  //  definieren Arbeitsfelder ...
  //---------------------------------------------------*

  f_execute('CLRPFM'          +
           ' FILE('          +
           %trim(i_envLib)   +
           '/'               +
           %trim(i_envFile)  +
           ')'               +
           ' MBR('           +
           %trim(i_envMbr)   +
           ')'               :
           o_msgID           :
           o_msgDta          );

end-proc;

//===================================================================*
//  Prozedur:  p_file                                     (Body)     *
//===================================================================*

dcl-proc writeFile;
  dcl-pi *n extproc(*dclcase);
    i_file  like(gi_file);
    i_lib   like(gi_lib);
    i_fileX like(gi_file);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *n;
    idx    zoned(10) inz;
    chrIdx char(10) overlay(idx);
  end-ds;
  //---------------------------------------------------*

  clear fpeekenv;

  en_user    = '*ALL';
  en_section = '*FILE';
  en_file    = i_file;
  en_lib     = i_lib;
  en_key     = chrIdx;
  en_data    = i_fileX;

  write fpeekenv;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_lib                                      (Body)     *
//===================================================================*

dcl-proc writeLibrary;
  dcl-pi *n extproc(*dclcase);
    i_file like(gi_file);
    i_lib  like(gi_lib);
    i_libX like(gi_lib);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *n;
    idx    zoned(10) inz;
    chrIdx char(10) overlay(idx);
  end-ds;
  //---------------------------------------------------*

  clear fpeekenv;

  en_user    = '*ALL';
  en_section = '*LIB';
  en_file    = i_file;
  en_lib     = i_lib;
  en_key     = chrIdx;
  en_data    = i_libX;

  write fpeekenv;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_mbr                                      (Body)     *
//===================================================================*

dcl-proc writeMember;
  dcl-pi *n extproc(*dclcase);
    i_file like(gi_file);
    i_lib  like(gi_lib);
    i_mbr  like(gi_mbr);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *n;
    idx    zoned(10) inz;
    chrIdx char(10) overlay(idx);
  end-ds;
  //---------------------------------------------------*

  clear fpeekenv;

  en_user    = '*ALL';
  en_section = '*MBR';
  en_file    = i_file;
  en_lib     = i_lib;
  en_key     = chrIdx;
  en_data    = i_mbr;

  write fpeekenv;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_rcdFmt                                   (Body)     *
//===================================================================*

dcl-proc writeRecordFormat;
  dcl-pi *n extproc(*dclcase);
    i_file   like(gi_file);
    i_lib    like(gi_lib);
    i_rcdFmt like(gi_rcdFmt);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *n;
    idx    zoned(10) inz;
    chrIdx char(10) overlay(idx);
  end-ds;
  //---------------------------------------------------*

  clear fpeekenv;

  en_user    = '*ALL';
  en_section = '*RCDFMT';
  en_file    = i_file;
  en_lib     = i_lib;
  en_key     = chrIdx;
  en_data    = i_rcdFmt;

  write fpeekenv;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_rcdFmtID                                 (Body)     *
//===================================================================*

dcl-proc writeRecordFormatID;
  dcl-pi *n extproc(*dclcase);
    i_file     like(gi_file);
    i_lib      like(gi_lib);
    i_rcdFmtID like(gi_rcdFmtID);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *n;
    idx    zoned(10) inz;
    chrIdx char(10) overlay(idx);
  end-ds;
  //---------------------------------------------------*

  clear fpeekenv;

  en_user    = '*ALL';
  en_section = '*RCDFMTID';
  en_file    = i_file;
  en_lib     = i_lib;
  en_key     = chrIdx;
  en_data    = i_rcdFmtID;

  write fpeekenv;

  return;

end-proc;

//===================================================================*
//  Prozedur:  f_checkAutoSave                            (Body)     *
//===================================================================*

dcl-proc checkAutoSave;
  dcl-pi *n like(bool_t) extproc(*dclcase);
    i_file like(gi_file);
    i_lib  like(gi_lib);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds en_key1 qualified;
    user like(en_user);
  end-ds;

  dcl-ds en_key3 qualified;
    user    like(en_user);
    section like(en_section);
    file    like(en_file);
  end-ds;

  dcl-ds en_key4 qualified;
    user    like(en_user);
    section like(en_section);
    file    like(en_file);
    lib     like(en_lib);
  end-ds;

  //  Nachrichten
/copy QCOPYLE,USR9992
  //---------------------------------------------------*

  en_key1.user    = *loval;
  setll %kds(en_key1) fpeekenv;
  read fpeekenv;
  if (%eof(peekEnv));
    return bTrue;
  endif;

  en_key3.user    = '*ALL';
  en_key3.section = '*FILE';
  en_key3.file    = i_file;
  chain %kds(en_key3) fpeekenv;
  if (not %found(peekEnv));
    clear usr9992;
    usr9992.var1 = 1;
    usr9992.var2 = i_file;
    usr9992.var3 = '*N';
    usr9992.var4 = '*N';
    f_sndMsgToCmdLine('USR9992': usr9992);
    return bFalse;
  endif;

  en_key4.user    = '*ALL';
  en_key4.section = '*FILE';
  en_key4.file    = i_file;
  en_key4.lib     = i_lib;
  chain %kds(en_key4) fpeekenv;
  if (not %found(peekEnv));
    clear usr9992;
    usr9992.var1 = 2;
    usr9992.var2 = i_lib;
    usr9992.var3 = '*N';
    usr9992.var4 = '*N';
    f_sndMsgToCmdLine('USR9992': usr9992);
    return bFalse;
  endif;

  return bTrue;


end-proc;

//===================================================================*
//  Prozedur:  p_accMode                                  (Body)     *
//===================================================================*

dcl-proc writeAccessMode;
  dcl-pi *n extproc(*dclcase);
    i_file    like(gi_file);
    i_lib     like(gi_lib);
    i_accMode like(gi_accMode);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *n;
    idx    zoned(10) inz;
    chrIdx char(10) overlay(idx);
  end-ds;
  //---------------------------------------------------*

  clear fpeekenv;

  en_user    = '*ALL';
  en_section = '*ACCMODE';
  en_file    = i_file;
  en_lib     = i_lib;
  en_key     = chrIdx;
  en_data    = i_accMode;

  write fpeekenv;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_sqlSel                                   (Body)     *
//===================================================================*

dcl-proc writeSQLSelect;
  dcl-pi *n extproc(*dclcase);
    i_file   like(gi_file);
    i_lib    like(gi_lib);
    i_sqlSel like(gi_sqlSel);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *n;
    idx    zoned(10) inz;
    chrIdx char(10) overlay(idx);
  end-ds;

  dcl-s strPos like(int4_t) inz;
  dcl-s lenSql like(int4_t) inz;
  dcl-s lenData like(int4_t) inz;
  dcl-s lenpart like(int4_t) inz;
  //---------------------------------------------------*

  clear fpeekenv;

  //  Die Anweisung wird in Stücken von %len(en_data) Zeichen gesichert,
  //  das letzte Stück ist kürzer. PEEK55 hängt die Stücke ungekürzt
  //  aneinander.
  idx     = 1;
  strPos  = 1;
  lenSql  = %len(%trimr(i_sqlSel));
  lenData = %len(en_data);

  dow (strPos <= lenSql);

    lenpart = lenSql - strPos + 1;
    if (lenpart > lenData);
      lenpart = lenData;
    endif;

    en_user    = '*ALL';
    en_section = '*SQLSELECT';
    en_file    = i_file;
    en_lib     = i_lib;
    en_key     = chrIdx;
    en_data    = %subst(i_sqlSel: strPos: lenpart);

    write fpeekenv;

    idx    = idx + 1;
    strPos = strPos + lenData;
  enddo;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_sqlOrd                                   (Body)     *
//===================================================================*

dcl-proc writeSQLOrder;
  dcl-pi *n extproc(*dclcase);
    i_file   like(gi_file);
    i_lib    like(gi_lib);
    i_sqlOrd like(gi_sqlOrd);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *n;
    idx    zoned(10) inz;
    chrIdx char(10) overlay(idx);
  end-ds;

  dcl-s strPos like(int4_t) inz;
  dcl-s lenSql like(int4_t) inz;
  dcl-s lenData like(int4_t) inz;
  dcl-s lenpart like(int4_t) inz;
  //---------------------------------------------------*

  clear fpeekenv;

  //  Die Anweisung wird in Stücken von %len(en_data) Zeichen gesichert,
  //  das letzte Stück ist kürzer. PEEK55 hängt die Stücke ungekürzt
  //  aneinander.
  idx     = 1;
  strPos  = 1;
  lenSql  = %len(%trimr(i_sqlOrd));
  lenData = %len(en_data);

  dow (strPos <= lenSql);

    lenpart = lenSql - strPos + 1;
    if (lenpart > lenData);
      lenpart = lenData;
    endif;

    en_user    = '*ALL';
    en_section = '*SQLORDER';
    en_file    = i_file;
    en_lib     = i_lib;
    en_key     = chrIdx;
    en_data    = %subst(i_sqlOrd: strPos: lenpart);

    write fpeekenv;

    idx    = idx + 1;
    strPos = strPos + lenData;
  enddo;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_isKeyLower                               (Body)     *
//===================================================================*

dcl-proc writeIsKeyLowerCase;
  dcl-pi *n extproc(*dclcase);
    i_file       like(gi_file);
    i_lib        like(gi_lib);
    i_isKeyLower like(gi_isKeyLower);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *n;
    idx    zoned(10) inz;
    chrIdx char(10) overlay(idx);
  end-ds;
  //---------------------------------------------------*

  clear fpeekenv;

  en_user    = '*ALL';
  en_section = '*KEYLUC';
  en_file    = i_file;
  en_lib     = i_lib;
  en_key     = chrIdx;
  en_data    = i_isKeyLower;

  write fpeekenv;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_wrtPinR                                  (Body)     *
//===================================================================*

dcl-proc writePinnedRecords;
  dcl-pi *n extproc(*dclcase);
    i_file    like(gi_file);
    i_lib     like(gi_lib);
    i_pinTabR like(gi_pinTabR) dim(12);
    i_nbrPinR like(gi_nbrPinR);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *n;
    idx    zoned(10) inz;
    chrIdx char(10) overlay(idx);
  end-ds;
  //---------------------------------------------------*

  for idx = 1 to i_nbrPinR;

    clear fpeekenv;

    en_user    = '*ALL';
    en_section = '*PINROW';
    en_file    = i_file;
    en_lib     = i_lib;
    en_key     = chrIdx;
    en_data    = i_pinTabR(idx);

    write fpeekenv;
  endfor;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_wrtPinC                                  (Body)     *
//===================================================================*

dcl-proc writePinnedColumns;
  dcl-pi *n extproc(*dclcase);
    i_file    like(gi_file);
    i_lib     like(gi_lib);
    i_pinTabC like(gi_pinTabC) dim(12);
    i_nbrPinC like(gi_nbrPinC);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *n;
    idx    zoned(10) inz;
    chrIdx char(10) overlay(idx);
  end-ds;
  //---------------------------------------------------*

  for idx = 1 to i_nbrPinC;

    clear fpeekenv;

    en_user    = '*ALL';
    en_section = '*PINCOL';
    en_file    = i_file;
    en_lib     = i_lib;
    en_key     = chrIdx;
    en_data    = i_pinTabC(idx);

    write fpeekenv;
  endfor;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_wrtLyt                                   (Body)     *
//===================================================================*

dcl-proc writeLayout;
  dcl-pi *n extproc(*dclcase);
    i_file like(gi_file);
    i_lib  like(gi_lib);
  end-pi;

  //  Arbeitsfelder ...
  dcl-ds env0001 likeds(env0001_t) inz(*likeds);
  //---------------------------------------------------*

  open peekFld;

  clear p_key1;
  p_key1.p_field = ' ';
  setll %kds(p_key1: 1) fpeekfld;

  dow ('1');
    read fpeekfld;
    if (%eof());
      leave;
    endif;

    clear fpeekenv;

    en_user    = '*ALL';
    en_section = '*LAYOUT';
    en_file    = i_file;
    en_lib     = i_lib;
    en_key     = p_field;

    clear env0001;
    env0001.env_seq    = p_seq;
    env0001.env_hidden = p_hidden;
    env0001.env_color  = p_color;
    env0001.env_mark   = p_markCol;
    env0001.env_size   = p_maxSize;
    env0001.env_edtCde = p_edtCde;
    en_data = env0001;

    write fpeekenv;

  enddo;

  close peekFld;

  return;

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

