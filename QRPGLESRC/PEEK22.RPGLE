**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK22                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 29.10.97  Raddatz                                 *
//  geändert : 27.04.99  2.1.0                                   *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Generieren der Defaulttastenbelegung                         *
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

dcl-f default keyed usropn extdesc('PEEKUSR') extfile(g_default) rename(fpeekusr: fdefault)
  prefix(d_);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,SDS
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK22
/undefine internal_prototype

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

//  Benutzer der Standardeinstellungen
dcl-c DFT_USER '*NONE';

dcl-s g_default char(21) inz;
dcl-s wrk_sectn like(section_t) inz;
dcl-s wrk_key like(key_t) inz;
dcl-s wrk_data like(set0000_t) inz;

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek22;
  i_mode    like(mode_t) const;
  i_section like(section_t) const;
end-pi;

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

//  Kopieren für alle Bereiche der Standardeinstellungen ...
if (i_section = '*ALL');

  g_default = %trim(f_getPrdLb()) + '/PEEKUSR';
  open(e) default;

  if (not %error());
    setll (DFT_USER) fdefault;
    reade (DFT_USER) fdefault;
    dow (not %eof(default));
      wrk_sectn = d_section;
      exsr delRecords;
      exsr addRecords;
      //  ... weiter mit dem nächsten Bereich
      setgt (DFT_USER: wrk_sectn) fdefault;
      reade (DFT_USER) fdefault;
    enddo;

    close default;
  endif;

else;

  //  Kopieren für ein Programm
  wrk_sectn = i_section;
  exsr delRecords;
  exsr addRecords;

endif;

*inlr = '1';

//============================================================*
//    delRecords    Löschen von Datensätzen                   *
//============================================================*

begsr delRecords;

  if (i_mode = '*REPLACE'
      or i_mode = '*DELETE');

    //  Alle Schlüssel des Bereichs, auch '*ENTER' und die leere
    //  Auswahl, die vor '*F01' sortiert werden.
    p_setllUsr(wrk_sectn);

    dow (f_readeUsr(wrk_sectn: wrk_key)= '0');
      f_deletUsr(wrk_sectn: wrk_key);
    enddo;

  else;
  //    Löschen bestehender Datensätze nur bei
  //    Betriebsart *REPLACE oder *DELETE.
  //    Sonst nicht!
  endif;

endsr;

//============================================================*
//    addRecords    Hinzufügen von Datensätzen                *
//============================================================*

begsr addRecords;

  if (i_mode = '*ADD'
      or i_mode = '*REPLACE');

    p_setllDft(wrk_sectn);

    dow (f_readeDft(wrk_sectn: wrk_key: wrk_data)='0');
      f_writeUsr(wrk_sectn :
                wrk_key   :
                wrk_data  );
    enddo;

  else;
  //    Hinzufügen von Datensätzen nur in der
  //    Betriebsart *ADD oder *REPLACE.
  //    Sonst nicht!
  endif;

endsr;

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

