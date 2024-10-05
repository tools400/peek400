**free
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
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

dcl-f peekenv keyed usropn prefix(en_);
dcl-f peekfld usage(*update:*delete) keyed usropn prefix(p_);

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,FILD0100
/COPY QCOPYLE,SET0015
/COPY QCOPYLE,ENV0001
/COPY QCOPYLE,SDS
/COPY QCOPYLE,CEECNDHDLR

/define internal_prototype
/COPY QCOPYLE,PPEEK55
/undefine internal_prototype

/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

dcl-pr main;
  i_file          value like(gi_file);
  i_lib           value like(gi_lib);
  i_mbr           value like(gi_mbr);
  i_rcdFmt        value like(gi_rcdFmt);
  i_rcdFmtID      value like(gi_rcdFmtID);
  i_envFile       value like(gi_envFile);
  i_envLib        value like(gi_envLib);
  i_envMbr        value like(gi_envMbr);
  i_option        value like(gi_option);
  o_pinTabR       like(go_pinTabR) dim(12);
  o_nbrPinR       like(go_nbrPinR);
  o_pinTabC       like(go_pinTabC) dim(12);
  o_nbrPinC       like(go_nbrpinc);
  o_file          like(go_file);
  o_lib           like(go_lib);
  o_mbr           like(go_mbr);
  o_rcdFmt        like(go_rcdFmt);
  o_accMode       like(go_accMode);
  o_sqlSel        like(go_sqlSel);
  o_sqlOrd        like(go_sqlOrd);
  o_isKeyLower    like(go_isKeyLower);
  o_msgID         like(go_msgID);
  o_msgDta        like(go_msgDta);
end-pr;


dcl-c NOT_FOUND '*NOTFOUND';

//*******************************************************************
//           Programmsteuerung                                      *
//*******************************************************************

dcl-pi peek55;
  gi_file         const like(file_t);
  gi_lib          const like(lib_t);
  gi_mbr          const like(mbr_t);
  gi_rcdFmt       const like(fmt_t);
  gi_rcdFmtID     const like(fmtid_t);
  gi_envFile      const like(file_t);
  gi_envLib       const like(lib_t);
  gi_envMbr       const like(mbr_t);
  gi_option       const like(option_t);
  go_pinTabR      like(pintabr_t) dim(12);
  go_nbrPinR      like(int4_t);
  go_pinTabC      like(fieldnme_t) dim(12);
  go_nbrpinc      like(int4_t);
  go_file         like(file_t);
  go_lib          like(lib_t);
  go_mbr          like(mbr_t);
  go_rcdFmt       like(fmt_t);
  go_accMode      like(accessmode_t);
  go_sqlSel       like(sqlwhere_t);
  go_sqlOrd       like(sqlorder_t);
  go_isKeyLower   like(bool_t);
  go_msgID        like(msgid_t);
  go_msgDta       like(msgdta_t);
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
      go_nbrpinc    :
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
  dcl-pi *N;
    i_file          value  like(gi_file);
    i_lib           value  like(gi_lib);
    i_mbr           value  like(gi_mbr);
    i_rcdFmt        value  like(gi_rcdFmt);
    i_rcdFmtID      value  like(gi_rcdFmtID);
    i_envFile       value  like(gi_envFile);
    i_envLib        value  like(gi_envLib);
    i_envMbr        value  like(gi_envMbr);
    i_option        value  like(gi_option);
    o_pinTabR       like(go_pinTabR) dim(12);
    o_nbrPinR       like(go_nbrPinR);
    o_pinTabC       like(go_pinTabC) dim(12);
    o_nbrPinC       like(go_nbrpinc);
    o_file          like(go_file);
    o_lib           like(go_lib);
    o_mbr           like(go_mbr);
    o_rcdFmt        like(go_rcdFmt);
    o_accMode       like(go_accMode);
    o_sqlSel        like(go_sqlSel);
    o_sqlOrd        like(go_sqlOrd);
    o_isKeyLower    like(go_isKeyLower);
    o_msgID         like(go_msgID);
    o_msgDta        like(go_msgDta);
  end-pi;

  //  Arbeitsfelder
  dcl-s pFile           like(file_t);
  dcl-s pLib            like(lib_t);
  dcl-s pMbr            like(mbr_t);
  dcl-s pFmt            like(rcdFmt_t);
  dcl-s pEnvMbr         like(i_envMbr);
  dcl-s RrcdFmtID       like(fmtID_t);
  dcl-s pMsgID          like(msgID_t);
  dcl-s pMsgDta         like(msgDta_t);

  dcl-ds set0015 likeds(set0015_t) inz;

  /COPY QCOPYLE,USR8234
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
      set0015 = f_getusrsg('*ENVFILE'  );
      i_envFile = set0015.set_envfil;
      i_envLib  = set0015.set_envlib;
    other;
    //  ... genau diese Datei
    endsl;

    //  Sonderwerte i_envLib ...
    select;
    //  ... *PRDLIB
    when (i_envLib = '*PRDLIB');
      i_envLib = sds.pgmlib;
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
    open peekenv;

    if (i_option = '*SLCLAYOUT');

      loadRecordFormatID(RrcdFmtID);
      if (RrcdFmtID <> '' and RrcdFmtID <> i_rcdFmtID);
        clear usr8234;
        usr8234.var1 = i_envFile;
        usr8234.var2 = i_envLib;
        usr8234.var3 = i_envMbr;
        o_msgID  = 'USR8234';
        o_msgDta = usr8234;
        leave;
      endif;

      o_file   = i_file;
      o_lib    = i_lib;
      o_mbr    = i_mbr;
      o_rcdFmt = i_rcdFmt;

      loadLayout(i_file: i_lib);

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

        //  Einlesen AccessMode ...  (dateiunabhängig)
        loadAccessMode(o_accMode);

        //  Einlesen SqlSelect ...   (phys. Datei muss gleich sein)
        loadSQLSelect(pFile: '*NONE': o_sqlSel);

        //  Einlesen SqlOrder ...    (phys. Datei muss gleich sein)
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
    close peekenv;

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
  dcl-pi *N extproc(*dclcase);
    o_file          like(go_file);
  end-pi;

  //  definieren Arbeitsfelder ...
  //---------------------------------------------------*

  clear en_key4;
  en_key4.en_user = '*ALL';
  en_key4.en_section = '*FILE';
  chain %kds(en_key4: 2) fpeekenv;
  if (not %found(peekenv));
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
  dcl-pi *N extproc(*dclcase);
    o_lib           like(go_lib);
  end-pi;

  //  definieren Arbeitsfelder ...
  //---------------------------------------------------*

  clear en_key4;
  en_key4.en_user = '*ALL';
  en_key4.en_section = '*LIB';
  chain %kds(en_key4: 2) fpeekenv;
  if (not %found(peekenv));
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
  dcl-pi *N extproc(*dclcase);
    o_mbr           like(go_mbr);
  end-pi;

  //  definieren Arbeitsfelder ...
  //---------------------------------------------------*

  clear en_key4;
  en_key4.en_user = '*ALL';
  en_key4.en_section = '*MBR';
  chain %kds(en_key4: 2) fpeekenv;
  if (not %found(peekenv));
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
  dcl-pi *N extproc(*dclcase);
    o_rcdfmt        like(go_rcdFmt);
  end-pi;

  //  definieren Arbeitsfelder ...
  //---------------------------------------------------*

  clear en_key4;
  en_key4.en_user = '*ALL';
  en_key4.en_section = '*RCDFMT';
  chain %kds(en_key4: 2) fpeekenv;
  if (not %found(peekenv));
    o_rcdfmt = NOT_FOUND;
  else;
    o_rcdfmt = en_data;
  endif;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadRcdFmtID                             (Body)     *
//===================================================================*

dcl-proc loadRecordFormatID;
  dcl-pi *N extproc(*dclcase);
    o_rcdfmtid      like(fmtid_t);
  end-pi;

  //  definieren Arbeitsfelder ...
  //---------------------------------------------------*

  clear en_key4;
  en_key4.en_user = '*ALL';
  en_key4.en_section = '*RCDFMTID';
  chain %kds(en_key4: 2) fpeekenv;
  if (not %found(peekenv));
    o_rcdfmtid = '';
  else;
    o_rcdfmtid = en_data;
  endif;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadAccM                                 (Body)     *
//===================================================================*

dcl-proc loadAccessMode;
  dcl-pi *N extproc(*dclcase);
    o_accmode       like(go_accMode);
  end-pi;

  //  definieren Arbeitsfelder ...
  //---------------------------------------------------*

  clear en_key4;
  en_key4.en_user = '*ALL';
  en_key4.en_section = '*ACCMODE';
  chain %kds(en_key4: 2) fpeekenv;
  if (not %found(peekenv));
    o_accmode = KEY_SEQ;
  else;
    o_accmode = en_data;
  endif;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadSqlS                                 (Body)     *
//===================================================================*

dcl-proc loadSQLSelect;
  dcl-pi *N extproc(*dclcase);
    i_file          const  like(gi_file   );
    i_lib           const  like(gi_lib    );
    o_sqlsel        like(go_sqlSel );
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-s strPos          like(int4_t) inz;
  dcl-s lenSql          like(int4_t) inz;
  dcl-s lenData         like(int4_t) inz;
  //---------------------------------------------------*

  o_sqlsel = ' ';

  strPos  = 1;
  lenSql  = %len(o_sqlsel);
  lenData = %len(en_data);

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

  dow strPos <= lenSql;

    if (i_lib = '*NONE');
      reade %kds(en_key4: 3) fpeekenv;
    else;
      reade %kds(en_key4: 4) fpeekenv;
    endif;

    if (%eof());
      leave;
    endif;

    %subst(o_sqlsel:strPos:lenData) = en_data;
    strPos   = strPos + lenData;
  enddo;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadSqlO                                 (Body)     *
//===================================================================*

dcl-proc loadSQLOrderBy;
  dcl-pi *N extproc(*dclcase);
    i_file          const  like(gi_file   );
    i_lib           const  like(gi_lib    );
    o_sqlord        like(go_sqlOrd );
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-s strpos          like(int4_t) inz;
  dcl-s lensql          like(int4_t) inz;
  dcl-s lendata         like(int4_t) inz;
  //---------------------------------------------------*

  o_sqlord = ' ';

  strpos  = 1;
  lensql  = %len(o_sqlord);
  lendata = %len(en_data);

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

  dow strpos <= lensql;

    if (i_lib = '*NONE');
      reade %kds(en_key4: 3) fpeekenv;
    else;
      reade %kds(en_key4: 4) fpeekenv;
    endif;

    if (%eof());
      leave;
    endif;

    %subst(o_sqlord:strpos:lendata) = en_data;
    strpos   = strpos + lendata;
  enddo;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadIsKeyLower                           (Body)     *
//===================================================================*

dcl-proc loadIsKeyLowerCase;
  dcl-pi *N extproc(*dclcase);
    i_file          const  like(gi_file       );
    i_lib           const  like(gi_lib        );
    o_iskeylower    like(go_isKeyLower);
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

  if (not %found(peekenv));
    o_iskeylower = KEY_MODE_UPPER;
  else;
    o_iskeylower = en_data;
  endif;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadPinR                                 (Body)     *
//===================================================================*

dcl-proc loadPinnedRecords;
  dcl-pi *N extproc(*dclcase);
    i_file          const  like(gi_file   );
    i_lib           const  like(gi_lib    );
    o_pintabr       like(go_pinTabR)
         dim(12);
    o_nbrpinr       like(go_nbrPinR);
  end-pi;

  //  definieren Arbeitsfelder ...

  dcl-ds *N;
    rcd             zoned(10) inz;
    chrrcd          char(10) overlay(rcd);
  end-ds;
  dcl-ds pintabr likeds(pintabr_t) inz;
  //**                                  prefix(pr_       )
  dcl-s x               int(10) inz;
  //---------------------------------------------------*

  clear pintabr;
  for x = 1 to 12;
    o_pintabr(x) = pintabr;
    o_nbrpinr    = 0;
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

    o_nbrpinr = o_nbrpinr + 1;
    o_pintabr(o_nbrpinr) = en_data;
  enddo;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadPinC                                 (Body)     *
//===================================================================*

dcl-proc loadPinnedColumns;
  dcl-pi *N extproc(*dclcase);
    i_file          const  like(gi_file   );
    i_lib           const  like(gi_lib    );
    o_pintabc       like(go_pinTabC)
         dim(12);
    o_nbrpinc       like(go_nbrpinc);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-s x               int(10) inz;
  //---------------------------------------------------*

  for x = 1 to 12;
    o_pintabc(x) = ' ';
    o_nbrpinc    = 0;
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

    o_nbrpinc = o_nbrpinc + 1;
    o_pintabc(o_nbrpinc) = en_data;
  enddo;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_loadLyt                                  (Body)     *
//===================================================================*

dcl-proc loadLayout;
  dcl-pi *N extproc(*dclcase);
    i_file          const  like(gi_file   );
    i_lib           const  like(gi_lib    );
  end-pi;

  //  Arbeitsfelder ...
  dcl-ds env0001 likeds(env0001_t) inz(*likeds);
  //---------------------------------------------------*

  open peekfld;

  clear en_key4;
  en_key4.en_user = '*ALL';
  en_key4.en_section = '*LAYOUT';
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

    clear p_key1;
    p_key1.p_field = en_key;
    chain %kds(p_key1) fpeekfld;
    if (%found(peekfld));
      env0001 = en_data;
      p_seq     = env0001.env_seq;
      p_hidden  = env0001.env_hidden;
      p_color   = env0001.env_color;
      p_markcol = env0001.env_mark;
      p_maxsize = env0001.env_size;
      p_edtcde  = env0001.env_edtcde;
      update fpeekfld;
    endif;

  enddo;

  close peekfld;

  return;

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

