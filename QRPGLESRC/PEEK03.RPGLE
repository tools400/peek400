       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 2.0.0                               *
       //  Programm : PEEK03                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 23.10.97  Raddatz                                 *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Dokumentation:                                               *
       //                                                               *
       //  Aktualisieren der Feldliste mit Schlüsselinformationen       *
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

       dcl-f peekfld usage(*update:*delete) keyed usropn prefix(f_);

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,KEYL0100
      /COPY QCOPYLE,ERR_D_SDS
      /COPY QCOPYLE,CEECNDHDLR

      /COPY QCOPYLE,USR0006

      /define internal_prototype
      /COPY QCOPYLE,PPEEK03
      /undefine internal_prototype

      /COPY QCOPYLE,PPEEK41
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58

       dcl-s peek41_name     like(pgmcalln_t) inz;

       dcl-ds fldl0100 likeds(fldl0100_t) inz;

       dcl-s rtncode         like(int4_t) inz;
       dcl-s nbrofkey        like(int4_t) inz;

       dcl-s x               like(int4_t) inz;
       dcl-s y               like(int4_t) inz;
       dcl-s z               like(int4_t) inz;
       dcl-s tempstr         like(i_sqlorder ) inz;
       dcl-ds keyl0100 likeds(keyl0100_t) based(pkeyl0100);
       dcl-ds keyl0100_sql likeds(keyl0100_t) inz;
       dcl-s data            char(512) inz;
       dcl-s numkeyfld       like(int4_t);

       dcl-s isinzsr         like(bool_t) inz(bfalse);

       //*******************************************************************
       //                 S T E U E R  -  R O U T I N E                    *
       //*******************************************************************

       dcl-pi peek03;
         i_qfile         const likeds(qobj_t);
       i_rcdfmt        const like(fmt_t);
       i_access        char(1) const;
       i_sqlorder      char(512) const;
       o_msgid         like(msgid_t);
       o_msgdta        like(msgdta_t);
       end-pi;
       // --------------------------------------------------------------------
       // Stand Alone Fields - TOP
       // --------------------------------------------------------------------
       dcl-s do_x1           packed(7);
       // --------------------------------------------------------------------
       // Stand Alone Fields - BOTTOM
       // --------------------------------------------------------------------

       //----------------------------------------------------*
     C     f_key         klist
     C                   kfld                    f_field

       //---------------------------------------------------*

       //  Register error handler
       ceehdlr(%paddr('errorHandler')
              : *null: *omit);

       exsr inzsr;

       exsr first;
       //---------------------------------------------------*

       if i_access = sql_seq;
          exsr sqlseq;
       else;
          exsr otherseq;
       endif;

       if nbrofkey <= *zeros;
          o_msgid = 'USR0006';
          usr00061 = i_qfile.name;
          usr00062 = i_qfile.lib;
          o_msgdta = usr0006;
       else;
          o_msgid = *blanks;
          o_msgdta = *blanks;
       endif;

       *inlr = '1';

       //====================================================*
       //  sqlSeq     SQL-Auswahl                            *
       //====================================================*

       begsr sqlseq;

          pkeyl0100 = %addr(keyl0100_sql);

          numkeyfld = 0;

          x = 1;
          exsr getnextfld;

          dow y > 1;

             tempstr = %trim(%subst(i_sqlorder: x: y-x));
             //  Ende des Feldes ...
             z = %scan('"': tempstr: 2);
             keyl0100.apkeyf =
              %trim(%subst(tempstr: 2: z-2));

             //  Alles hinter dem Feld ...
             tempstr = %trim(%subst(tempstr: z+1));

             if (tempstr = 'DESC');
                keyl0100.apkseq  = 'D';
                numkeyfld = numkeyfld + 1;
                keyl0100.apkeyn = numkeyfld;
                exsr addkeyinf;
             else;
                keyl0100.apkseq  = 'A';
                numkeyfld = numkeyfld + 1;
                keyl0100.apkeyn = numkeyfld;
                exsr addkeyinf;
             endif;

             x = y + 1;
             exsr getnextfld;
          enddo;

       endsr;

       //====================================================*
       //  getNextFld  nächstes Feld im SQL-String           *
       //====================================================*

       begsr getnextfld;

          if x > 512;
             y = 0;
          else;

             y = %scan(',': i_sqlorder: x);

             if (y = 0) and
                (%subst(i_sqlorder: x) <> ' ');
                y = %checkr(' ': i_sqlorder);
                y = y + 1;
             endif;

          endif;

       endsr;

       //====================================================*
       //  otherSeq   keine SQl-Auswahl                      *
       //====================================================*

       begsr otherseq;

          pkeyl0100 = %addr(data);

          //  Abrufen der Dateiinformationen ...
          peek41(i_qfile: i_rcdfmt
                : '*CREATE': rtncode: data);
          if (rtncode <= 0);
             //  ... schade, Aufruf ist fehlgeschlagen
          else;
             //  Einlesen der Schlüsselinformationen ...
             peek41(i_qfile: i_rcdfmt
                   : '*KEY': nbrofkey: data);

             for do_x1 = 1 to nbrofkey;
                peek41(i_qfile: i_rcdfmt
                      : '*READKEY': rtncode: data);
                exsr addkeyinf;
             endfor;

          endif;

       endsr;

       //====================================================*
       //  AddKeyInf  Hinzufügen Schlüsselinformationen      *
       //====================================================*

       begsr addkeyinf;

          f_field = keyl0100.apkeyf;
          chain f_key fpeekfld;
          *in11 = not %found;
          if *in11 = *off;
             f_desc = keyl0100.apkseq;
             f_kseq = keyl0100.apkeyn;
             fldl0100 = f_ffd;
             fldl0100.f1keyf = '1';
             f_ffd = fldl0100;
             update fpeekfld;
          endif;

       endsr;

       //====================================================*
       //  First  --  Initialize program                     *
       //====================================================*

       begsr first;

          nbrofkey = *zeros;

          // - Meldung
          p_sndstsmg('USR8137': i_qfile);

          // - Los gehts'
          o_msgid = *blanks;
          o_msgdta = *blanks;

       endsr;

       //====================================================*
       //  InzSr --  Initialize program                      *
       //====================================================*

       begsr inzsr;

          if (isinzsr = btrue);
             leavesr;
          endif;

          isinzsr = btrue;

          peek41_name = f_pgmcalln('PEEK41');

          open peekfld;

       endsr;

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


