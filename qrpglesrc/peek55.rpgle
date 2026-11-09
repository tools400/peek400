**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Laden Arbeitsumgebung                        *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK55                                            *
//  Typ      : RPGLE                                             *
//                                                               *
//  erstellt : 04.05.99  RADDATZ                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Dokumentation:                                               *
//                                                               *
//  Peek/400 - Laden Arbeitsumgebung                             *
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
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

dcl-f peekEnv keyed usropn prefix(en_);
dcl-f peekFld usage(*update: *delete) keyed usropn prefix(p_);

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/fild0100.rpgleinc'
/copy 'qcopyle/set0015.rpgleinc'
/copy 'qcopyle/env0001.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek55.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

dcl-pr main;
  i_file       like(gi_file) value;
  i_lib        like(gi_lib) value;
  i_mbr        like(gi_mbr) value;
  i_rcdFmt     like(gi_rcdFmt) value;
  i_rcdFmtID   like(gi_rcdFmtID) value;
  i_envFile    like(gi_envFile) value;
  i_envLib     like(gi_envLib) value;
  i_envMbr     like(gi_envMbr) value;
  i_option     like(gi_option) value;
  o_pinTabR    like(go_pinTabR) dim(12);
  o_nbrPinR    like(go_nbrPinR);
  o_pinTabC    like(go_pinTabC) dim(12);
  o_nbrPinC    like(go_nbrPinC);
  o_file       like(go_file);
  o_lib        like(go_lib);
  o_mbr        like(go_mbr);
  o_rcdFmt     like(go_rcdFmt);
  o_accMode    like(go_accMode);
  o_sqlSel     like(go_sqlSel);
  o_sqlOrd     like(go_sqlOrd);
  o_isKeyLower like(go_isKeyLower);
  o_msgID      like(go_msgID);
  o_msgDta     like(go_msgDta);
end-pr;


dcl-c NOT_FOUND '*NOTFOUND';

//*******************************************************************
//           Programmsteuerung                                      *
//*******************************************************************
dcl-pi peek55;
  gi_file       like(file_t) const;
  gi_lib        like(lib_t) const;
  gi_mbr        like(mbr_t) const;
  gi_rcdFmt     like(fmt_t) const;
  gi_rcdFmtID   like(fmtId_t) const;
  gi_envFile    like(file_t) const;
  gi_envLib     like(lib_t) const;
  gi_envMbr     like(mbr_t) const;
  gi_option     like(option_t) const;
  go_pinTabR    like(pinTabR_t) dim(12);
  go_nbrPinR    like(int4_t);
  go_pinTabC    like(fieldNme_t) dim(12);
  go_nbrPinC    like(int4_t);
  go_file       like(file_t);
  go_lib        like(lib_t);
  go_mbr        like(mbr_t);
  go_rcdFmt     like(fmt_t);
  go_accMode    like(accessMode_t);
  go_sqlSel     like(sqlWhere_t);
  go_sqlOrd     like(sqlOrder_t);
  go_isKeyLower like(bool_t);
  go_msgID      like(msgId_t);
  go_msgDta     like(msgDta_t);
end-pi;

dcl-ds en_key4 likerec(fpeekenv: *key);
dcl-ds p_key1 likerec(fpeekfld: *key);
//----------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

main(gi_file       :
      gi_lib        :
      gi_mbr        :
      gi_rcdFmt     :
      gi_rcdFmtID   :
      gi_envFile    :
      gi_envLib     :
      gi_envMbr     :
      gi_option     :
      go_pinTabR    :
      go_nbrPinR    :
      go_pinTabC    :
      go_nbrPinC    :
      go_file       :
      go_lib        :
      go_mbr        :
      go_rcdFmt     :
      go_accMode    :
      go_sqlSel     :
      go_sqlOrd     :
      go_isKeyLower :
      go_msgID      :
      go_msgDta     );

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
    i_option     like(gi_option) value;
    o_pinTabR    like(go_pinTabR) dim(12);
    o_nbrPinR    like(go_nbrPinR);
    o_pinTabC    like(go_pinTabC) dim(12);
    o_nbrPinC    like(go_nbrPinC);
    o_file       like(go_file);
    o_lib        like(go_lib);
    o_mbr        like(go_mbr);
    o_rcdFmt     like(go_rcdFmt);
    o_accMode    like(go_accMode);
    o_sqlSel     like(go_sqlSel);
    o_sqlOrd     like(go_sqlOrd);
    o_isKeyLower like(go_isKeyLower);
    o_msgID      like(go_msgID);
    o_msgDta     like(go_msgDta);
  end-pi;

  //  Arbeitsfelder
  dcl-s pFile like(file_t);
  dcl-s pLib like(lib_t);
  dcl-s pMbr like(mbr_t);
  dcl-s pFmt like(rcdFmt_t);
  dcl-s pEnvMbr like(i_envMbr);
  dcl-s rrcdFmtID like(fmtId_t);
  dcl-s pMsgID like(msgId_t);
  dcl-s pMsgDta like(msgDta_t);

  dcl-ds set0015 likeds(set0015_t) inz;

/copy 'qcopyle/usr8234.rpgleinc'
  //---------------------------------------------------*

  dou ('1');

    //  Sonderwerte i_envFile ...
    select;
    //  ... *NONE
    when (i_envFile = '*NONE');
      o_msgID  = 'USR8185';
      o_msgDta = ' ';
      leave;
    //  ... *ENVFILE
    when (i_envFile = '*ENVFILE');
      set0015 = f_getUsrSg('*ENVFILE'  );
      i_envFile = set0015.set_envFil;
      i_envLib  = set0015.set_envLib;
    other;
    //  ... genau diese Datei
    endsl;

    //  Sonderwerte i_envLib ...
    select;
    //  ... *PRDLIB
    when (i_envLib = '*PRDLIB');
      i_envLib = sds.pgmLib;
    other;
    //  ... genau diese Bibliothek
    endsl;

    //  Sonderwerte i_envMbr ...
    select;
    //  ... *FILE
    when (i_envMbr  = '*FILE');
      pEnvMbr = i_file;
    other;
      //  ... genau diese Teildatei
      pEnvMbr = i_envMbr;
    endsl;

    //  Prüfen Arbeitsumgebung  ...
    f_exist(i_envFile: i_envLib: '*FILE': pEnvMbr: o_msgID: o_msgDta);

    //  Programm mit Fehlermeldung beenden
    if (o_msgID <> '');
      leave;
    endif;

    //  Überschreiben Datei ...
    f_execute('OVRDBF +
                FILE(PEEKENV) +
                TOFILE(' +
                 %trim(i_envLib) + '/' +
                 %trim(i_envFile) +
                ') +
                MBR(' + %trim(pEnvMbr) + ') +
                OVRSCOPE(*ACTGRPDFN) +
                SHARE(*NO) SEQONLY(*NO) SECURE(*YES)'
              : pMsgID: pMsgDta);
    pMsgID = '';
    pMsgDta = '';

    //  Öffnen Datei ...
    open peekEnv;

    if (i_option = '*SLCLAYOUT');

      //  (kein LEAVE: PEEKENV und die Überschreibung werden unten
      //  wieder entfernt)
      loadRecordFormatID(rrcdFmtID);
      if (rrcdFmtID <> '' and rrcdFmtID <> i_rcdFmtID);
        clear usr8234;
        usr8234.var1 = i_envFile;
        usr8234.var2 = i_envLib;
        usr8234.var3 = i_envMbr;
        o_msgID  = 'USR8234';
        o_msgDta = usr8234;
      else;
        o_file   = i_file;
        o_lib    = i_lib;
        o_mbr    = i_mbr;
        o_rcdFmt = i_rcdFmt;

        //  Das Layout gilt für das Satzformat (geprüft über die ID),
        //  nicht für den Dateinamen, unter dem es gesichert wurde.
        loadLayout('*ALL': '*NONE');
      endif;

    else;

      //  Einlesen Datei ...
      loadFile(o_file);
      if (o_file = NOT_FOUND);
        o_file = i_file;
      endif;

      //  Einlesen Bibliothek ...
      loadLibrary(o_lib);
      if (o_lib = NOT_FOUND);
        o_lib = i_lib;
      endif;

      //  Einlesen Teildatei ...
      loadMember(o_mbr);
      if (o_mbr = NOT_FOUND);
        o_mbr = i_mbr;
      endif;

      //  Einlesen Satzformat ...
      //  (nur bei geänderter Datei)
      if (i_file <> o_file or i_lib  <> o_lib );
        loadRecordFormat(o_rcdFmt);
        if (o_rcdFmt = NOT_FOUND);
          o_rcdFmt = i_rcdFmt;
        endif;
      else;
        o_rcdFmt = i_rcdFmt;
      endif;

      //  Beenden, wenn Datei gewechselt hat, weil die Datei neu geöffnet werden muss
      //  und damit alle Layout und PIN Informationen gelöscht werden. PEEK55 wird dann
      //  von PEEK05 erneut aufgerufen, nachdem die Datei geöffnet worden ist.
      if (o_file = i_file and
          o_lib  = i_lib  and
          o_mbr  = i_mbr  and
          o_rcdFmt = i_rcdFmt);

        // Aber wenn die Datei nicht gewechselt hat, dann ...

        //  Einlesen basierende physiche Datei ...
        f_basedPF(o_file: o_lib: o_mbr: o_rcdFmt: -1: pFile: pLib: pMbr: pFmt);

        //  Einlesen accessMode ...  (dateiunabhängig)
        loadAccessMode(o_accMode);

        //  Einlesen SqlSelect ...   (phys. Datei muss gleich sein)
        loadSQLSelect(pFile: '*NONE': o_sqlSel);

        //  Einlesen sqlOrder ...    (phys. Datei muss gleich sein)
        loadSQLOrderBy(pFile: '*NONE': o_sqlOrd  );

        //  Einlesen isKeyLower ...  (phys. Datei muss gleich sein)
        loadIsKeyLowerCase(pFile: '*NONE': o_isKeyLower);

        //  Einlesen Layout ...          (phys. Datei muss gleich sein)
        loadLayout(pFile: '*NONE');

        //  Einlesen Pin-Record ...      (phys. Datei und Bibliothek müssen gleich sei
        loadPinnedRecords(pFile: pLib: o_pinTabR: o_nbrPinR);

        //  Einlesen Pin-Column ...      (phys. Datei muss gleich sein)
        loadPinnedColumns(pFile: '*NONE': o_pinTabC: o_nbrPinC);

      endif;

    endif;

    //  Schließen Datei ...
    close peekEnv;

    //  Löschen Überschreibung ...
    f_execute('DLTOVR +
                FILE(PEEKENV) +
                LVL(*ACTGRPDFN)'
              : pMsgID: pMsgDta);
    pMsgID = '';
    pMsgDta = '';

  enddo;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadFile                                 (Body)     *
//===================================================================*

dcl-proc loadFile;
  dcl-pi *n extproc(*dclcase);
    o_file like(go_file);
  end-pi;

  //  definieren Arbeitsfelder ...
  //---------------------------------------------------*

  clear en_key4;
  en_key4.en_user = '*ALL';
  en_key4.en_section = '*FILE';
  chain %kds(en_key4: 2) fpeekenv;
  if (not %found(peekEnv));
    o_file = NOT_FOUND;
  else;
    o_file = en_data;
  endif;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadLib                                  (Body)     *
//===================================================================*

dcl-proc loadLibrary;
  dcl-pi *n extproc(*dclcase);
    o_lib like(go_lib);
  end-pi;

  //  definieren Arbeitsfelder ...
  //---------------------------------------------------*

  clear en_key4;
  en_key4.en_user = '*ALL';
  en_key4.en_section = '*LIB';
  chain %kds(en_key4: 2) fpeekenv;
  if (not %found(peekEnv));
    o_lib = NOT_FOUND;
  else;
    o_lib = en_data;
  endif;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadMbr                                  (Body)     *
//===================================================================*

dcl-proc loadMember;
  dcl-pi *n extproc(*dclcase);
    o_mbr like(go_mbr);
  end-pi;

  //  definieren Arbeitsfelder ...
  //---------------------------------------------------*

  clear en_key4;
  en_key4.en_user = '*ALL';
  en_key4.en_section = '*MBR';
  chain %kds(en_key4: 2) fpeekenv;
  if (not %found(peekEnv));
    o_mbr  = NOT_FOUND;
  else;
    o_mbr  = en_data;
  endif;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadRcdFmt                               (Body)     *
//===================================================================*

dcl-proc loadRecordFormat;
  dcl-pi *n extproc(*dclcase);
    o_rcdFmt like(go_rcdFmt);
  end-pi;

  //  definieren Arbeitsfelder ...
  //---------------------------------------------------*

  clear en_key4;
  en_key4.en_user = '*ALL';
  en_key4.en_section = '*RCDFMT';
  chain %kds(en_key4: 2) fpeekenv;
  if (not %found(peekEnv));
    o_rcdFmt = NOT_FOUND;
  else;
    o_rcdFmt = en_data;
  endif;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadRcdFmtID                             (Body)     *
//===================================================================*

dcl-proc loadRecordFormatID;
  dcl-pi *n extproc(*dclcase);
    o_rcdFmtID like(fmtId_t);
  end-pi;

  //  definieren Arbeitsfelder ...
  //---------------------------------------------------*

  clear en_key4;
  en_key4.en_user = '*ALL';
  en_key4.en_section = '*RCDFMTID';
  chain %kds(en_key4: 2) fpeekenv;
  if (not %found(peekEnv));
    o_rcdFmtID = '';
  else;
    o_rcdFmtID = en_data;
  endif;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadAccM                                 (Body)     *
//===================================================================*

dcl-proc loadAccessMode;
  dcl-pi *n extproc(*dclcase);
    o_accMode like(go_accMode);
  end-pi;

  //  definieren Arbeitsfelder ...
  //---------------------------------------------------*

  clear en_key4;
  en_key4.en_user = '*ALL';
  en_key4.en_section = '*ACCMODE';
  chain %kds(en_key4: 2) fpeekenv;
  if (not %found(peekEnv));
    o_accMode = KEY_SEQ;
  else;
    o_accMode = en_data;
  endif;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadSqlS                                 (Body)     *
//===================================================================*

dcl-proc loadSQLSelect;
  dcl-pi *n extproc(*dclcase);
    i_file   like(gi_file) const;
    i_lib    like(gi_lib) const;
    o_sqlSel like(go_sqlSel);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-s strPos like(int4_t) inz;
  dcl-s maxLenSql like(int4_t) inz;
  dcl-s lenData like(int4_t) inz;
  //---------------------------------------------------*

  o_sqlSel = '';

  strPos  = 1;
  maxLenSql  = %len(o_sqlSel: *max);

  clear en_key4;
  en_key4.en_user = '*ALL';
  en_key4.en_section = '*SQLSELECT';
  en_key4.en_file = i_file;

  if (i_lib = '*NONE');
    setll %kds(en_key4: 3) fpeekenv;
  else;
    en_key4.en_lib = i_lib;
    setll %kds(en_key4: 4) fpeekenv;
  endif;

  dow (strPos < maxLenSql);

    if (i_lib = '*NONE');
      reade %kds(en_key4: 3) fpeekenv;
    else;
      reade %kds(en_key4: 4) fpeekenv;
    endif;

    if (%eof());
      leave;
    endif;

    //  Die Stücke ungekürzt aneinanderhängen: Ein Leerzeichen am Ende
    //  eines Stücks gehört zur Anweisung. Gekürzt wird nur das Ergebnis.
    o_sqlSel = o_sqlSel + en_data;
    strPos = %len(o_sqlSel) + 1;
  enddo;

  o_sqlSel = %trimr(o_sqlSel);

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadSqlO                                 (Body)     *
//===================================================================*

dcl-proc loadSQLOrderBy;
  dcl-pi *n extproc(*dclcase);
    i_file   like(gi_file) const;
    i_lib    like(gi_lib) const;
    o_sqlOrd like(go_sqlOrd);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-s strPos like(int4_t) inz;
  dcl-s maxLenSql like(int4_t) inz;
  //---------------------------------------------------*

  o_sqlOrd = '';

  strPos  = 1;
  maxLenSql  = %len(o_sqlOrd: *max);

  clear en_key4;
  en_key4.en_user = '*ALL';
  en_key4.en_section = '*SQLORDER';
  en_key4.en_file = i_file;

  if (i_lib = '*NONE');
    setll %kds(en_key4: 3) fpeekenv;
  else;
    en_key4.en_lib = i_lib;
    setll %kds(en_key4: 4) fpeekenv;
  endif;

  dow (strPos <= maxLenSql);

    if (i_lib = '*NONE');
      reade %kds(en_key4: 3) fpeekenv;
    else;
      reade %kds(en_key4: 4) fpeekenv;
    endif;

    if (%eof());
      leave;
    endif;

    //  Die Stücke ungekürzt aneinanderhängen (siehe loadSQLSelect)
    o_sqlOrd = o_sqlOrd + en_data;
    strPos = %len(o_sqlOrd) + 1;
  enddo;

  o_sqlOrd = %trimr(o_sqlOrd);

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadIsKeyLower                           (Body)     *
//===================================================================*

dcl-proc loadIsKeyLowerCase;
  dcl-pi *n extproc(*dclcase);
    i_file       like(gi_file) const;
    i_lib        like(gi_lib) const;
    o_isKeyLower like(go_isKeyLower);
  end-pi;

  //  definieren Arbeitsfelder ...
  //---------------------------------------------------*

  clear en_key4;
  en_key4.en_user = '*ALL';
  en_key4.en_section = '*KEYLUC';
  en_key4.en_file = i_file;

  if (i_lib = '*NONE');
    chain %kds(en_key4: 3) fpeekenv;
  else;
    en_key4.en_lib = i_lib;
    chain %kds(en_key4: 4) fpeekenv;
  endif;

  if (not %found(peekEnv));
    o_isKeyLower = KEY_MODE_UPPER;
  else;
    o_isKeyLower = en_data;
  endif;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadPinR                                 (Body)     *
//===================================================================*

dcl-proc loadPinnedRecords;
  dcl-pi *n extproc(*dclcase);
    i_file    like(gi_file) const;
    i_lib     like(gi_lib) const;
    o_pinTabR like(go_pinTabR) dim(12);
    o_nbrPinR like(go_nbrPinR);
  end-pi;

  //  definieren Arbeitsfelder ...

  dcl-ds *n;
    rcd    zoned(10) inz;
    chrRcd char(10) overlay(rcd);
  end-ds;
  dcl-ds pIntAbr likeds(pinTabR_t) inz;
  //**                                  prefix(pr_       )
  dcl-s x int(10) inz;
  //---------------------------------------------------*

  clear pIntAbr;
  for x = 1 to 12;
    o_pinTabR(x) = pIntAbr;
    o_nbrPinR    = 0;
  endfor;

  clear en_key4;
  en_key4.en_user = '*ALL';
  en_key4.en_section = '*PINROW';
  en_key4.en_file = i_file;
  en_key4.en_lib = i_lib;
  setll %kds(en_key4: 4) fpeekenv;

  dow ('1');
    reade %kds(en_key4: 4) fpeekenv;
    if (%eof());
      leave;
    endif;

    //  Mehr als 12 Einträge passen nicht in die Tabelle
    if (o_nbrPinR >= %elem(o_pinTabR));
      leave;
    endif;

    o_nbrPinR = o_nbrPinR + 1;
    o_pinTabR(o_nbrPinR) = en_data;
  enddo;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadPinC                                 (Body)     *
//===================================================================*

dcl-proc loadPinnedColumns;
  dcl-pi *n extproc(*dclcase);
    i_file    like(gi_file) const;
    i_lib     like(gi_lib) const;
    o_pinTabC like(go_pinTabC) dim(12);
    o_nbrPinC like(go_nbrPinC);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-s x int(10) inz;
  //---------------------------------------------------*

  for x = 1 to 12;
    o_pinTabC(x) = ' ';
    o_nbrPinC    = 0;
  endfor;

  clear en_key4;
  en_key4.en_user = '*ALL';
  en_key4.en_section = '*PINCOL';
  en_key4.en_file = i_file;

  if (i_lib = '*NONE');
    setll %kds(en_key4: 3) fpeekenv;
  else;
    en_key4.en_lib = i_lib;
    setll %kds(en_key4: 4) fpeekenv;
  endif;

  dow ('1');
    if (i_lib = '*NONE');
      reade %kds(en_key4: 3) fpeekenv;
    else;
      reade %kds(en_key4: 4) fpeekenv;
    endif;

    if (%eof());
      leave;
    endif;

    //  Mehr als 12 Einträge passen nicht in die Tabelle
    if (o_nbrPinC >= %elem(o_pinTabC));
      leave;
    endif;

    o_nbrPinC = o_nbrPinC + 1;
    o_pinTabC(o_nbrPinC) = en_data;
  enddo;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadLyt                                  (Body)     *
//===================================================================*

dcl-proc loadLayout;
  dcl-pi *n extproc(*dclcase);
    i_file like(gi_file) const;
    i_lib  like(gi_lib) const;
  end-pi;

  //  Arbeitsfelder ...
  dcl-ds env0001 likeds(env0001_t) inz(*likeds);
  //---------------------------------------------------*

  open peekFld;

  //  i_file = '*ALL': alle *LAYOUT-Sätze, unabhängig von der Datei
  clear en_key4;
  en_key4.en_user = '*ALL';
  en_key4.en_section = '*LAYOUT';
  en_key4.en_file = i_file;

  select;
  when (i_file = '*ALL');
    setll %kds(en_key4: 2) fpeekenv;
  when (i_lib = '*NONE');
    setll %kds(en_key4: 3) fpeekenv;
  other;
    en_key4.en_lib = i_lib;
    setll %kds(en_key4: 4) fpeekenv;
  endsl;

  dow ('1');
    select;
    when (i_file = '*ALL');
      reade %kds(en_key4: 2) fpeekenv;
    when (i_lib = '*NONE');
      reade %kds(en_key4: 3) fpeekenv;
    other;
      reade %kds(en_key4: 4) fpeekenv;
    endsl;

    if (%eof());
      leave;
    endif;

    clear p_key1;
    p_key1.p_field = en_key;
    chain %kds(p_key1) fpeekfld;
    if (%found(peekFld));
      env0001 = en_data;
      p_seq     = env0001.env_seq;
      p_hidden  = env0001.env_hidden;
      p_color   = env0001.env_color;
      p_markCol = env0001.env_mark;
      p_maxSize = env0001.env_size;
      p_edtCde  = env0001.env_edtCde;
      update fpeekfld;
    endif;

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

