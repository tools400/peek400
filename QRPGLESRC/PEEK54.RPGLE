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
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

dcl-f peekenv usage(*update:*delete:*output) keyed usropn prefix(en_);
dcl-f peekfld keyed usropn prefix(p_);

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,FILD0100
/COPY QCOPYLE,ENV0001
/COPY QCOPYLE,SDS
/COPY QCOPYLE,CEECNDHDLR

/define internal_prototype
/COPY QCOPYLE,PPEEK54
/undefine internal_prototype

/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

dcl-pr main;
  i_file          value  like(gi_file   );
  i_lib           value  like(gi_lib    );
  i_mbr           value  like(gi_mbr    );
  i_rcdfmt        value  like(gi_rcdfmt );
  i_rcdfmtid      value  like(gi_rcdfmtid);
  i_envfile       value  like(gi_envfile);
  i_envlib        value  like(gi_envlib );
  i_envmbr        value  like(gi_envmbr );
  i_isautosave    value  like(gi_isautosave);
  i_pintabr       value  like(gi_pintabr) dim(12);
  i_nbrpinr       value  like(gi_nbrpinr);
  i_pintabc       value  like(gi_pintabc) dim(12);
  i_nbrpinc       value  like(gi_nbrpinc);
  i_accmode       value  like(gi_accmode);
  i_sqlsel        value  like(gi_sqlsel );
  i_sqlord        value  like(gi_sqlord );
  i_iskeylower    value  like(gi_iskeylower);
  o_msgid         like(go_msgid  );
  o_msgdta        like(go_msgdta );
end-pr;

//*******************************************************************
//           Programmsteuerung                                      *
//*******************************************************************

dcl-pi peek54;
  gi_file         const like(file_t);
  gi_lib          const like(lib_t);
  gi_mbr          const like(mbr_t);
  gi_rcdfmt       const like(fmt_t);
  gi_rcdfmtid     const like(fmtid_t);
  gi_envfile      const like(file_t);
  gi_envlib       const like(lib_t);
  gi_envmbr       const like(mbr_t);
  gi_isautosave   const like(bool_t);
  gi_pintabr      const like(pintabr_t) dim(12);
  gi_nbrpinr      const like(int4_t);
  gi_pintabc      const like(fieldnme_t) dim(12);
  gi_nbrpinc      const like(int4_t);
  gi_accmode      const like(accessmode_t);
  gi_sqlsel       const like(sqlwhere_t);
  gi_sqlord       const like(sqlorder_t);
  gi_iskeylower   const like(bool_t);
  go_msgid        like(msgid_t);
  go_msgdta       like(msgdta_t);
end-pi;

dcl-ds p_key1 likerec(fpeekfld: *key);
//----------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

main(gi_file    :
      gi_lib     :
      gi_mbr     :
      gi_rcdfmt  :
      gi_rcdfmtid:
      gi_envfile :
      gi_envlib  :
      gi_envmbr  :
      gi_isautosave:
      gi_pintabr :
      gi_nbrpinr :
      gi_pintabc :
      gi_nbrpinc :
      gi_accmode :
      gi_sqlsel  :
      gi_sqlord  :
      gi_iskeylower :
      go_msgid   :
      go_msgdta  );

return;

//===================================================================*
//  Prozedur:  p_crtUsrSg                                 (Body)     *
//===================================================================*

dcl-proc main;
  dcl-pi *N;
    i_file          value  like(gi_file   );
    i_lib           value  like(gi_lib    );
    i_mbr           value  like(gi_mbr    );
    i_rcdfmt        value  like(gi_rcdfmt );
    i_rcdfmtid      value  like(gi_rcdfmtid);
    i_envfile       value  like(gi_envfile);
    i_envlib        value  like(gi_envlib );
    i_envmbr        value  like(gi_envmbr );
    i_isautosave    value  like(gi_isautosave);
    i_pintabr       value  like(gi_pintabr) dim(12);
    i_nbrpinr       value  like(gi_nbrpinr);
    i_pintabc       value  like(gi_pintabc) dim(12);
    i_nbrpinc       value  like(gi_nbrpinc);
    i_accmode       value  like(gi_accmode);
    i_sqlsel        value  like(gi_sqlsel );
    i_sqlord        value  like(gi_sqlord );
    i_iskeylower    value  like(gi_iskeylower);
    o_msgid         like(go_msgid  );
    o_msgdta        like(go_msgdta );
  end-pi;

  //  Arbeitsfelder
  dcl-s pfile           like(file_t);
  dcl-s plib            like(lib_t);
  dcl-s pmbr            like(mbr_t);
  dcl-s pfmt            like(fmt_t);
  dcl-s penvmbr         like(i_envmbr);
  dcl-s cansave         like(bool_t);
  dcl-s pmsgid          like(msgid_t);
  dcl-s pmsgdta         like(msgdta_t);

  //  Nachrichten
  /COPY QCOPYLE,USR9992
  //---------------------------------------------------*

  if (i_envmbr = '*FILE');
    penvmbr = i_file;
  else;
    penvmbr = i_envmbr;
  endif;

  //  Basiert auf physischer Datei ...
  f_basedpf(i_file    :
           i_lib     :
           i_mbr     :
           i_rcdfmt  :
           -1        :
           pfile     :
           plib      :
           pmbr      :
           pfmt      );

  //  Überschreiben Datei ...
  f_execute('OVRDBF ' +
             'FILE(PEEKENV) ' +
             'TOFILE(' +
               %trim(i_envlib) + '/' +
               %trim(i_envfile) + ') ' +
             'MBR(' + %trim(penvmbr) + ') ' +
             'OVRSCOPE(*ACTGRPDFN) ' +
             'SHARE(*NO) ' +
             'SEQONLY(*NO) SECURE(*YES)'
           : pmsgid: pmsgdta);
  pmsgid = '';
  pmsgdta = '';

  //  Prüfen, ob gespeichert werden darf
  if (i_isautosave = bTrue);
    open(e) peekenv;
    if not %error();
      cansave =  checkAutoSave(pfile: plib);
      close peekenv;
    else;
      //     Fehler beim Öffnen aufgetreten
      clear usr9992;
      usr9992.var1 = 3;
      usr9992.var2 = i_file;
      usr9992.var3 = i_lib;
      usr9992.var4 = penvmbr;
      f_sndmsgtocmdline('USR9992': usr9992);
      cansave = bFalse;
    endif;
  else;
    cansave = bTrue;
  endif;

  //  Löschen alte Daten ...
  if (cansave = bTrue);

    clearEnvironment(i_envfile  :
            i_envlib   :
            penvmbr    :
            o_msgid    :
            o_msgdta   );

    if (go_msgid = ' ');

      //  Öffnen Datei ...
      open peekenv;

      //  Ausgeben AccessMode ...
      writeAccessMode(pfile     :
               plib      :
               i_accmode );

      //  Ausgeben Datei ...
      writeFile(pfile  :
            plib   :
            i_file );

      //  Ausgeben Bibliothek ...
      writeLibrary(pfile :
           plib  :
           i_lib );

      //  Ausgeben Teildatei ...
      writeMember(pfile :
           plib  :
           i_mbr );

      //  Ausgeben Satzformat ...
      writeRecordFormat(pfile    :
              plib     :
              i_rcdfmt );

      //  Ausgeben Satzformat-ID ...
      writeRecordFormatID(pfile     :
                plib      :
                i_rcdfmtid);

      //  Ausgeben SqlSelect ...
      writeSQLSelect(pfile     :
              plib      :
              i_sqlsel  );

      //  Ausgeben SqlOrder ...
      writeSQLOrder(pfile     :
              plib      :
              i_sqlord  );

      //  Ausgeben isKeyLower ...
      writeIsKeyLowerCase(pfile       :
                  plib        :
                  i_iskeylower);

      //  Ausgeben Layout ...
      writeLayout(pfile     :
              plib      );

      //  Ausgeben Pin-Record ...
      writePinnedRecords(pfile    :
               plib     :
               i_pintabr:
               i_nbrpinr);

      //  Ausgeben Pin-Column ...
      writePinnedColumns(pfile    :
               plib     :
               i_pintabc:
               i_nbrpinc);

      //  Schließen Datei ...
      close peekenv;

    endif;
  endif;

  //  Löschen Überschreibung ...
  f_execute('DLTOVR ' +
             'FILE(PEEKENV) ' +
             'LVL(*ACTGRPDFN) '
           : pmsgid: pmsgdta);
  pmsgid = '';
  pmsgdta = '';

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_clrEnv                                   (Body)     *
//===================================================================*

dcl-proc clearEnvironment;
  dcl-pi *N extproc(*dclcase);
    i_envfile       like(gi_envfile);
    i_envlib        like(gi_envlib );
    i_envmbr        like(gi_envmbr );
    o_msgid         like(go_msgid  );
    o_msgdta        like(go_msgdta );
  end-pi;

  //  definieren Arbeitsfelder ...
  //---------------------------------------------------*

  f_execute('CLRPFM'          +
           ' FILE('          +
           %trim(i_envlib)   +
           '/'               +
           %trim(i_envfile)  +
           ')'               +
           ' MBR('           +
           %trim(i_envmbr)   +
           ')'               :
           o_msgid           :
           o_msgdta          );

end-proc;

//===================================================================*
//  Prozedur:  p_file                                     (Body)     *
//===================================================================*

dcl-proc writeFile;
  dcl-pi *N extproc(*dclcase);
    i_file          like(gi_file   );
    i_lib           like(gi_lib    );
    i_filex         like(gi_file   );
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *N;
    idx             zoned(10) inz;
    chridx          char(10) overlay(idx);
  end-ds;
  //---------------------------------------------------*

  clear fpeekenv;

  en_user    = '*ALL';
  en_section = '*FILE';
  en_file    = i_file;
  en_lib     = i_lib;
  en_key     = chridx;
  en_data    = i_filex;

  write fpeekenv;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_lib                                      (Body)     *
//===================================================================*

dcl-proc writeLibrary;
  dcl-pi *N extproc(*dclcase);
    i_file          like(gi_file   );
    i_lib           like(gi_lib    );
    i_libx          like(gi_lib    );
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *N;
    idx             zoned(10) inz;
    chridx          char(10) overlay(idx);
  end-ds;
  //---------------------------------------------------*

  clear fpeekenv;

  en_user    = '*ALL';
  en_section = '*LIB';
  en_file    = i_file;
  en_lib     = i_lib;
  en_key     = chridx;
  en_data    = i_libx;

  write fpeekenv;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_mbr                                      (Body)     *
//===================================================================*

dcl-proc writeMember;
  dcl-pi *N extproc(*dclcase);
    i_file          like(gi_file   );
    i_lib           like(gi_lib    );
    i_mbr           like(gi_mbr    );
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *N;
    idx             zoned(10) inz;
    chridx          char(10) overlay(idx);
  end-ds;
  //---------------------------------------------------*

  clear fpeekenv;

  en_user    = '*ALL';
  en_section = '*MBR';
  en_file    = i_file;
  en_lib     = i_lib;
  en_key     = chridx;
  en_data    = i_mbr;

  write fpeekenv;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_rcdFmt                                   (Body)     *
//===================================================================*

dcl-proc writeRecordFormat;
  dcl-pi *N extproc(*dclcase);
    i_file          like(gi_file   );
    i_lib           like(gi_lib    );
    i_rcdfmt        like(gi_rcdfmt );
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *N;
    idx             zoned(10) inz;
    chridx          char(10) overlay(idx);
  end-ds;
  //---------------------------------------------------*

  clear fpeekenv;

  en_user    = '*ALL';
  en_section = '*RCDFMT';
  en_file    = i_file;
  en_lib     = i_lib;
  en_key     = chridx;
  en_data    = i_rcdfmt;

  write fpeekenv;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_rcdFmtID                                 (Body)     *
//===================================================================*

dcl-proc writeRecordFormatID;
  dcl-pi *N extproc(*dclcase);
    i_file          like(gi_file    );
    i_lib           like(gi_lib     );
    i_rcdfmtid      like(gi_rcdfmtid);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *N;
    idx             zoned(10) inz;
    chridx          char(10) overlay(idx);
  end-ds;
  //---------------------------------------------------*

  clear fpeekenv;

  en_user    = '*ALL';
  en_section = '*RCDFMTID';
  en_file    = i_file;
  en_lib     = i_lib;
  en_key     = chridx;
  en_data    = i_rcdfmtid;

  write fpeekenv;

  return;

end-proc;

//===================================================================*
//  Prozedur:  f_checkAutoSave                            (Body)     *
//===================================================================*

dcl-proc checkAutoSave;
  dcl-pi *N like(bool_t) extproc(*dclcase);
    i_file          like(gi_file   );
    i_lib           like(gi_lib    );
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds en_key1 qualified;
    user            like(en_user   );
  end-ds;

  dcl-ds en_key3 qualified;
    user            like(en_user   );
    section         like(en_section);
    file            like(en_file   );
  end-ds;

  dcl-ds en_key4 qualified;
    user            like(en_user   );
    section         like(en_section);
    file            like(en_file   );
    lib             like(en_lib    );
  end-ds;

  //  Nachrichten
  /COPY QCOPYLE,USR9992
  //---------------------------------------------------*

  en_key1.user    = *loval;
  setll %kds(en_key1) fpeekenv;
  read fpeekenv;
  if (%eof(peekenv));
    return bTrue;
  endif;

  en_key3.user    = '*ALL';
  en_key3.section = '*FILE';
  en_key3.file    = i_file;
  chain %kds(en_key3) fpeekenv;
  if (not %found(peekenv));
    clear usr9992;
    usr9992.var1 = 1;
    usr9992.var2 = i_file;
    usr9992.var3 = '*N';
    usr9992.var4 = '*N';
    f_sndmsgtocmdline('USR9992': usr9992);
    return bFalse;
  endif;

  en_key4.user    = '*ALL';
  en_key4.section = '*FILE';
  en_key4.file    = i_file;
  en_key4.lib     = i_lib;
  chain %kds(en_key4) fpeekenv;
  if (not %found(peekenv));
    clear usr9992;
    usr9992.var1 = 2;
    usr9992.var2 = i_lib;
    usr9992.var3 = '*N';
    usr9992.var4 = '*N';
    f_sndmsgtocmdline('USR9992': usr9992);
    return bFalse;
  endif;

  return bTrue;


end-proc;

//===================================================================*
//  Prozedur:  p_accMode                                  (Body)     *
//===================================================================*

dcl-proc writeAccessMode;
  dcl-pi *N extproc(*dclcase);
    i_file          like(gi_file   );
    i_lib           like(gi_lib    );
    i_accmode       like(gi_accmode);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *N;
    idx             zoned(10) inz;
    chridx          char(10) overlay(idx);
  end-ds;
  //---------------------------------------------------*

  clear fpeekenv;

  en_user    = '*ALL';
  en_section = '*ACCMODE';
  en_file    = i_file;
  en_lib     = i_lib;
  en_key     = chridx;
  en_data    = i_accmode;

  write fpeekenv;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_sqlSel                                   (Body)     *
//===================================================================*

dcl-proc writeSQLSelect;
  dcl-pi *N extproc(*dclcase);
    i_file          like(gi_file   );
    i_lib           like(gi_lib    );
    i_sqlsel        like(gi_sqlsel );
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *N;
    idx             zoned(10) inz;
    chridx          char(10) overlay(idx);
  end-ds;

  dcl-s strpos          like(int4_t) inz;
  dcl-s lensql          like(int4_t) inz;
  dcl-s lendata         like(int4_t) inz;
  //---------------------------------------------------*

  clear fpeekenv;

  idx     = 1;
  strpos  = 1;
  lensql  = %len(%trim(i_sqlsel));
  lendata = %len(en_data);

  dow strpos < lensql;

    en_user    = '*ALL';
    en_section = '*SQLSELECT';
    en_file    = i_file;
    en_lib     = i_lib;
    en_key     = chridx;
    en_data    = %subst(i_sqlsel:strpos:lendata);

    write fpeekenv;

    idx    = idx + 1;
    strpos = strpos + lendata;
  enddo;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_sqlOrd                                   (Body)     *
//===================================================================*

dcl-proc writeSQLOrder;
  dcl-pi *N extproc(*dclcase);
    i_file          like(gi_file   );
    i_lib           like(gi_lib    );
    i_sqlord        like(gi_sqlord );
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *N;
    idx             zoned(10) inz;
    chridx          char(10) overlay(idx);
  end-ds;

  dcl-s strpos          like(int4_t) inz;
  dcl-s lensql          like(int4_t) inz;
  dcl-s lendata         like(int4_t) inz;
  //---------------------------------------------------*

  clear fpeekenv;

  idx     = 1;
  strpos  = 1;
  lensql  = %len(%trim(i_sqlord));
  lendata = %len(en_data);

  dow strpos < lensql;

    en_user    = '*ALL';
    en_section = '*SQLORDER';
    en_file    = i_file;
    en_lib     = i_lib;
    en_key     = chridx;
    en_data    = %subst(i_sqlord:strpos:lendata);

    write fpeekenv;

    idx    = idx + 1;
    strpos = strpos + lendata;
  enddo;

  return;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_isKeyLower                               (Body)     *
//===================================================================*

dcl-proc writeIsKeyLowerCase;
  dcl-pi *N extproc(*dclcase);
    i_file          like(gi_file       );
    i_lib           like(gi_lib        );
    i_iskeylower    like(gi_iskeylower );
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *N;
    idx             zoned(10) inz;
    chridx          char(10) overlay(idx);
  end-ds;
  //---------------------------------------------------*

  clear fpeekenv;

  en_user    = '*ALL';
  en_section = '*KEYLUC';
  en_file    = i_file;
  en_lib     = i_lib;
  en_key     = chridx;
  en_data    = i_iskeylower;

  write fpeekenv;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_wrtPinR                                  (Body)     *
//===================================================================*

dcl-proc writePinnedRecords;
  dcl-pi *N extproc(*dclcase);
    i_file          like(gi_file   );
    i_lib           like(gi_lib    );
    i_pintabr       like(gi_pintabr)
         dim(12);
    i_nbrpinr       like(gi_nbrpinr);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *N;
    idx             zoned(10) inz;
    chridx          char(10) overlay(idx);
  end-ds;
  //---------------------------------------------------*

  for idx = 1 to i_nbrpinr;

    clear fpeekenv;

    en_user    = '*ALL';
    en_section = '*PINROW';
    en_file    = i_file;
    en_lib     = i_lib;
    en_key     = chridx;
    en_data    = i_pintabr(idx);

    write fpeekenv;
  endfor;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_wrtPinC                                  (Body)     *
//===================================================================*

dcl-proc writePinnedColumns;
  dcl-pi *N extproc(*dclcase);
    i_file          like(gi_file   );
    i_lib           like(gi_lib    );
    i_pintabc       like(gi_pintabc)
         dim(12);
    i_nbrpinc       like(gi_nbrpinc);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-ds *N;
    idx             zoned(10) inz;
    chridx          char(10) overlay(idx);
  end-ds;
  //---------------------------------------------------*

  for idx = 1 to i_nbrpinc;

    clear fpeekenv;

    en_user    = '*ALL';
    en_section = '*PINCOL';
    en_file    = i_file;
    en_lib     = i_lib;
    en_key     = chridx;
    en_data    = i_pintabc(idx);

    write fpeekenv;
  endfor;

  return;

end-proc;

//===================================================================*
//  Prozedur:  p_wrtLyt                                   (Body)     *
//===================================================================*

dcl-proc writeLayout;
  dcl-pi *N extproc(*dclcase);
    i_file          like(gi_file   );
    i_lib           like(gi_lib    );
  end-pi;

  //  Arbeitsfelder ...
  dcl-ds env0001 likeds(env0001_t) inz(*likeds);
  //---------------------------------------------------*

  open peekfld;

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
    env0001.env_mark   = p_markcol;
    env0001.env_size   = p_maxsize;
    env0001.env_edtcde = p_edtcde;
    en_data = env0001;

    write fpeekenv;

  enddo;

  close peekfld;

  return;

end-proc;

//============================================================*
//  Program error handler                                     *
//============================================================*

dcl-proc errorHandler;
  dcl-pi *N;
    i_condtoken     value likeds(cee_fc_t);
    i_pcommarea     int(10) value;
    o_action        int(10);
    o_newcondtoken  likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

