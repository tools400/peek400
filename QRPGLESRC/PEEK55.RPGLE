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
       //  Peek/400 - Laden     Arbeitsumgebung                         *
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

       dcl-pr p_loadfile;
         o_file          like(go_file);
       end-pr;

       dcl-pr p_loadlib;
         o_lib           like(go_lib);
       end-pr;

       dcl-pr p_loadmbr;
         o_mbr           like(go_mbr);
       end-pr;

       dcl-pr p_loadrcdfmt;
         o_rcdfmt        like(go_rcdfmt);
       end-pr;

       dcl-pr p_loadrcdfmtid;
         o_rcdfmtid      like(fmtid_t);
       end-pr;

       dcl-pr p_loadaccm;
         o_accmode       like(go_accmode);
       end-pr;

       dcl-pr p_loadsqls;
         i_file          const  like(gi_file);
         i_lib           const  like(gi_lib);
         o_sqlsel        like(go_sqlsel);
       end-pr;

       dcl-pr p_loadsqlo;
         i_file          const  like(gi_file);
         i_lib           const  like(gi_lib);
         o_sqlord        like(go_sqlord);
       end-pr;

       dcl-pr p_loadiskeylower;
         i_file          const  like(gi_file);
         i_lib           const  like(gi_lib);
         o_iskeylower    like(go_iskeylower);
       end-pr;

       dcl-pr p_main;
         i_file          value  like(gi_file);
         i_lib           value  like(gi_lib);
         i_mbr           value  like(gi_mbr);
         i_rcdfmt        value  like(gi_rcdfmt);
         i_rcdfmtid      value  like(gi_rcdfmtid);
         i_envfile       value  like(gi_envfile);
         i_envlib        value  like(gi_envlib);
         i_envmbr        value  like(gi_envmbr);
         i_option        value  like(gi_option);
         o_pintabr       like(go_pintabr) dim(12);
         o_nbrpinr       like(go_nbrpinr);
         o_pintabc       like(go_pintabc) dim(12);
         o_nbrpinc       like(go_nbrpinc);
         o_file          like(go_file);
         o_lib           like(go_lib);
         o_mbr           like(go_mbr);
         o_rcdfmt        like(go_rcdfmt);
         o_accmode       like(go_accmode);
         o_sqlsel        like(go_sqlsel);
         o_sqlord        like(go_sqlord);
         o_iskeylower    like(go_iskeylower);
         o_msgid         like(go_msgid);
         o_msgdta        like(go_msgdta);
       end-pr;

       dcl-pr p_loadpinr;
         i_file          const  like(gi_file   );
         i_lib           const  like(gi_lib    );
         o_pintabr       like(go_pintabr)
              dim(12);
         o_nbrpinr       like(go_nbrpinr);
       end-pr;

       dcl-pr p_loadpinc;
         i_file          const  like(gi_file   );
         i_lib           const  like(gi_lib    );
         o_pintabc       like(go_pintabc)
              dim(12);
         o_nbrpinc       like(go_nbrpinc);
       end-pr;

       dcl-pr p_loadlyt;
         i_file          const  like(gi_file   );
         i_lib           const  like(gi_lib    );
       end-pr;


       dcl-c NOT_FOUND '*NOTFOUND';

       //*******************************************************************
       //           Programmsteuerung                                      *
       //*******************************************************************

       dcl-pi peek55;
         gi_file         const like(file_t);
         gi_lib          const like(lib_t);
         gi_mbr          const like(mbr_t);
         gi_rcdfmt       const like(fmt_t);
         gi_rcdfmtid     const like(fmtid_t);
         gi_envfile      const like(file_t);
         gi_envlib       const like(lib_t);
         gi_envmbr       const like(mbr_t);
         gi_option       const like(option_t);
         go_pintabr      like(pintabr_t) dim(12);
         go_nbrpinr      like(int4_t);
         go_pintabc      like(fieldnme_t) dim(12);
         go_nbrpinc      like(int4_t);
         go_file         like(file_t);
         go_lib          like(lib_t);
         go_mbr          like(mbr_t);
         go_rcdfmt       like(fmt_t);
         go_accmode      like(accessmode_t);
         go_sqlsel       like(sqlwhere_t);
         go_sqlord       like(sqlorder_t);
         go_iskeylower   like(bool_t);
         go_msgid        like(msgid_t);
         go_msgdta       like(msgdta_t);
       end-pi;

       dcl-ds en_key4 likerec(fpeekenv: *key);
       dcl-ds p_key1 likerec(fpeekfld: *key);
       //----------------------------------------------------*

       //  Register error handler
       ceehdlr(%paddr('errorHandler')
              : *null: *omit);

       p_main(gi_file       :
             gi_lib        :
             gi_mbr        :
             gi_rcdfmt     :
             gi_rcdfmtid   :
             gi_envfile    :
             gi_envlib     :
             gi_envmbr     :
             gi_option     :
             go_pintabr    :
             go_nbrpinr    :
             go_pintabc    :
             go_nbrpinc    :
             go_file       :
             go_lib        :
             go_mbr        :
             go_rcdfmt     :
             go_accmode    :
             go_sqlsel     :
             go_sqlord     :
             go_iskeylower :
             go_msgid      :
             go_msgdta     );

       return;

       //===================================================================*
       //  Prozedur:  p_crtUsrSg                                 (Body)     *
       //===================================================================*

       dcl-proc p_main;
       dcl-pi *N;
         i_file          value  like(gi_file      );
         i_lib           value  like(gi_lib       );
         i_mbr           value  like(gi_mbr       );
         i_rcdfmt        value  like(gi_rcdfmt    );
         i_rcdfmtid      value  like(gi_rcdfmtid  );
         i_envfile       value  like(gi_envfile   );
         i_envlib        value  like(gi_envlib    );
         i_envmbr        value  like(gi_envmbr    );
         i_option        value  like(gi_option    );
         o_pintabr       like(go_pintabr   ) dim(12);
         o_nbrpinr       like(go_nbrpinr   );
         o_pintabc       like(go_pintabc   ) dim(12);
         o_nbrpinc       like(go_nbrpinc   );
         o_file          like(go_file      );
         o_lib           like(go_lib       );
         o_mbr           like(go_mbr       );
         o_rcdfmt        like(go_rcdfmt    );
         o_accmode       like(go_accmode   );
         o_sqlsel        like(go_sqlsel    );
         o_sqlord        like(go_sqlord    );
         o_iskeylower    like(go_iskeylower);
         o_msgid         like(go_msgid     );
         o_msgdta        like(go_msgdta    );
       end-pi;

       //  Arbeitsfelder
       dcl-s pfile           like(file_t);
       dcl-s plib            like(lib_t);
       dcl-s pmbr            like(mbr_t);
       dcl-s pfmt            like(rcdfmt_t);
       dcl-s penvmbr         like(i_envmbr  );
       dcl-s prcdfmtid       like(fmtid_t);
       dcl-s pmsgid          like(msgid_t);
       dcl-s pmsgdta         like(msgdta_t);

       dcl-ds set0015 likeds(set0015_t) inz;

      /COPY QCOPYLE,USR8234
       //---------------------------------------------------*

       dou ('1');

          //  Sonderwerte i_envFile ...
          select;
             //  ... *NONE
          when (i_envfile = '*NONE');
             o_msgid  = 'USR8185';
             o_msgdta = ' ';
             leave;
          //  ... *ENVFILE
          when (i_envfile = '*ENVFILE');
             set0015 = f_getusrsg('*ENVFILE'  );
             i_envfile = set0015.set_envfil;
             i_envlib  = set0015.set_envlib;
          other;
             //  ... genau diese Datei
          endsl;

          //  Sonderwerte i_envLib ...
          select;
             //  ... *PRDLIB
          when i_envlib = '*PRDLIB';
             i_envlib = sds.pgmlib;
          other;
             //  ... genau diese Bibliothek
          endsl;

          //  Sonderwerte i_envMbr ...
          select;
             //  ... *FILE
          when i_envmbr  = '*FILE';
             penvmbr = i_file;
          other;
             //  ... genau diese Teildatei
             penvmbr = i_envmbr;
          endsl;

          //  Prüfen Arbeitsumgebung  ...
          f_execute('CHKOBJ +
                      OBJ(' +
                       %trim(i_envlib) + '/' +
                       %trim(i_envfile) +
                      ') +
                      OBJTYPE(*FILE) +
                      MBR(' + %trim(penvmbr) + ') +
                      AUT(*USE)'
                    : o_msgid: o_msgdta);

          //  Programm mit Fehlermeldung beenden
          if (o_msgid <> '');
             leave;
          endif;

          //  Überschreiben Datei ...
          f_execute('OVRDBF +
                      FILE(PEEKENV) +
                      TOFILE(' +
                       %trim(i_envlib) + '/' +
                       %trim(i_envfile) +
                      ') +
                      MBR(' + %trim(penvmbr) + ') +
                      OVRSCOPE(*ACTGRPDFN) +
                      SHARE(*NO) SEQONLY(*NO) SECURE(*YES)'
                    : pmsgid: pmsgdta);
          pmsgid = '';
          pmsgdta = '';

          //  Öffnen Datei ...
          open peekenv;

          if (i_option = '*SLCLAYOUT');
             p_loadrcdfmtid(prcdfmtid);
             if prcdfmtid <> '' and prcdfmtid <> i_rcdfmtid;
                clear usr8234;
                usr8234.var1 = i_envfile;
                usr8234.var2 = i_envlib;
                usr8234.var3 = i_envmbr;
                o_msgid  = 'USR8234';
                o_msgdta = usr8234;
                leave;
             endif;

             o_file   = i_file;
             o_lib    = i_lib;
             o_mbr    = i_mbr;
             o_rcdfmt = i_rcdfmt;
          else;
             //  Einlesen Datei ...
             p_loadfile(o_file);
             if (o_file = NOT_FOUND);
                o_file = i_file;
             endif;

             //  Einlesen Bibliothek ...
             p_loadlib(o_lib);
             if (o_lib = NOT_FOUND);
                o_lib = i_lib;
             endif;

             //  Einlesen Teildatei ...
             p_loadmbr(o_mbr);
             if (o_mbr = NOT_FOUND);
                o_mbr = i_mbr;
             endif;

             //  Einlesen Satzformat ...
             //  (nur bei geänderter Datei)
             if (i_file <> o_file or i_lib  <> o_lib );
                p_loadrcdfmt(o_rcdfmt);
                if (o_rcdfmt = NOT_FOUND);
                   o_rcdfmt = i_rcdfmt;
                endif;
             else;
                o_rcdfmt = i_rcdfmt;
             endif;

          endif;

          //  Basiert auf physischer Datei ...
          f_basedpf(o_file: o_lib: o_mbr: o_rcdfmt
                    : -1: pfile: plib: pmbr: pfmt);

          //  Einlesen AccessMode ...  (dateiunabhängig)
          p_loadaccm(o_accmode);

          //  Einlesen SqlSelect ...   (phys. Datei muss gleich sein)
          p_loadsqls(pfile: '*NONE': o_sqlsel);

          //  Einlesen SqlOrder ...    (phys. Datei muss gleich sein)
          p_loadsqlo(pfile: '*NONE': o_sqlord  );

          //  Einlesen isKeyLower ...  (phys. Datei muss gleich sein)
          p_loadiskeylower(pfile: '*NONE': o_iskeylower);

          //  Beenden, wenn Datei gewechselt hat, weil die Datei neu geöffnet werden muss
          //  und damit alle Layout und PIN Informationen gelöscht werden. PEEK55 wird dann
          //  von PEEK05 erneut aufgerufen, nachdem die Datei geöffnet worden ist.
          if (o_file = i_file and
              o_lib  = i_lib  and
              o_mbr  = i_mbr  and
              o_rcdfmt = i_rcdfmt);
          // Aber wenn die Datei nicht gewechselt hat, dann ...

          //  Einlesen Layout ...          (phys. Datei muss gleich sein)
          p_loadlyt(pfile: '*NONE');

          //  Einlesen Pin-Record ...      (phys. Datei und Bibliothek müssen gleich sei
          p_loadpinr(pfile: plib: o_pintabr: o_nbrpinr);

          //  Einlesen Pin-Column ...      (phys. Datei muss gleich sein)
          p_loadpinc(pfile: '*NONE': o_pintabc: o_nbrpinc);

          endif;

          //  Schließen Datei ...
          close peekenv;

          //  Löschen Überschreibung ...
          f_execute('DLTOVR +
                      FILE(PEEKENV) +
                      LVL(*ACTGRPDFN)'
                    : pmsgid: pmsgdta);
          pmsgid = '';
          pmsgdta = '';

       enddo;

       return;

       end-proc;

       //===================================================================*
       //  Prozedur:  p_loadFile                                 (Body)     *
       //===================================================================*

       dcl-proc p_loadfile;
       dcl-pi *N;
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

       dcl-proc p_loadlib;
       dcl-pi *N;
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

       dcl-proc p_loadmbr;
       dcl-pi *N;
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

       dcl-proc p_loadrcdfmt;
       dcl-pi *N;
         o_rcdfmt        like(go_rcdfmt);
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

       dcl-proc p_loadrcdfmtid;
       dcl-pi *N;
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

       dcl-proc p_loadaccm;
       dcl-pi *N;
         o_accmode       like(go_accmode);
       end-pi;

       //  definieren Arbeitsfelder ...
       //---------------------------------------------------*

       clear en_key4;
       en_key4.en_user = '*ALL';
       en_key4.en_section = '*ACCMODE';
       chain %kds(en_key4: 2) fpeekenv;
       if (not %found(peekenv));
          o_accmode = key_seq;
       else;
          o_accmode = en_data;
       endif;

       return;

       end-proc;

       //===================================================================*
       //  Prozedur:  p_loadSqlS                                 (Body)     *
       //===================================================================*

       dcl-proc p_loadsqls;
       dcl-pi *N;
         i_file          const  like(gi_file   );
         i_lib           const  like(gi_lib    );
         o_sqlsel        like(go_sqlsel );
       end-pi;

       //  definieren Arbeitsfelder ...
       dcl-s strpos          like(int4_t) inz;
       dcl-s lensql          like(int4_t) inz;
       dcl-s lendata         like(int4_t) inz;
       //---------------------------------------------------*

       o_sqlsel = ' ';

       strpos  = 1;
       lensql  = f_len(o_sqlsel);
       lendata = f_len(en_data);

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

       dow strpos <= lensql;

          if i_lib = '*NONE';
             reade %kds(en_key4: 3) fpeekenv;
          else;
             reade %kds(en_key4: 4) fpeekenv;
          endif;

          if (%eof());
             leave;
          endif;

          %subst(o_sqlsel:strpos:lendata) = en_data;
          strpos   = strpos + lendata;
       enddo;

       return;

       end-proc;

       //===================================================================*
       //  Prozedur:  p_loadSqlO                                 (Body)     *
       //===================================================================*

       dcl-proc p_loadsqlo;
       dcl-pi *N;
         i_file          const  like(gi_file   );
         i_lib           const  like(gi_lib    );
         o_sqlord        like(go_sqlord );
       end-pi;

       //  definieren Arbeitsfelder ...
       dcl-s strpos          like(int4_t) inz;
       dcl-s lensql          like(int4_t) inz;
       dcl-s lendata         like(int4_t) inz;
       //---------------------------------------------------*

       o_sqlord = ' ';

       strpos  = 1;
       lensql  = f_len(o_sqlord);
       lendata = f_len(en_data);

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

          if i_lib = '*NONE';
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

       dcl-proc p_loadiskeylower;
       dcl-pi *N;
         i_file          const  like(gi_file       );
         i_lib           const  like(gi_lib        );
         o_iskeylower    like(go_iskeylower);
       end-pi;

       //  definieren Arbeitsfelder ...
       //---------------------------------------------------*

       clear en_key4;
       en_key4.en_user = '*ALL';
       en_key4.en_section = '*KEYLUC';
       en_key4.en_file = i_file;

       if i_lib = '*NONE';
          chain %kds(en_key4: 3) fpeekenv;
       else;
          en_key4.en_lib = i_lib;
          chain %kds(en_key4: 4) fpeekenv;
       endif;

       if (not %found(peekenv));
          o_iskeylower = key_mode_upper;
       else;
          o_iskeylower = en_data;
       endif;

       return;

       end-proc;

       //===================================================================*
       //  Prozedur:  p_loadPinR                                 (Body)     *
       //===================================================================*

       dcl-proc p_loadpinr;
       dcl-pi *N;
         i_file          const  like(gi_file   );
         i_lib           const  like(gi_lib    );
         o_pintabr       like(go_pintabr)
              dim(12);
         o_nbrpinr       like(go_nbrpinr);
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

       dcl-proc p_loadpinc;
       dcl-pi *N;
         i_file          const  like(gi_file   );
         i_lib           const  like(gi_lib    );
         o_pintabc       like(go_pintabc)
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

       if i_lib = '*NONE';
          setll %kds(en_key4: 3) fpeekenv;
       else;
          en_key4.en_lib = i_lib;
          setll %kds(en_key4: 4) fpeekenv;
       endif;

       dow ('1');
          if i_lib = '*NONE';
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

       dcl-proc p_loadlyt;
       dcl-pi *N;
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

       if i_lib = '*NONE';
          setll %kds(en_key4: 3) fpeekenv;
       else;
          en_key4.en_lib = i_lib;
          setll %kds(en_key4: 4) fpeekenv;
       endif;

       dow ('1');
          if i_lib = '*NONE';
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
          if (not %found(peekfld));
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

