       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 1.4.0                               *
       //  Programm : PEEK36                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 29.01.1998  Raddatz                               *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //                                                               *
       //  Peek/400 - Prüfen Datum-, Zeit, Zeitstempelfelder            *
       //                                                               *
       //  geändert : 01.04.04  für Version 2.2.2                       *
       //                     added support for time format *HMS, *EUR  *
       //                     added support for date format *EUR        *
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

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,CEECNDHDLR

      /COPY QCOPYLE,USR8171

      /define internal_prototype
      /COPY QCOPYLE,PPEEK36
      /undefine internal_prototype

      /COPY QCOPYLE,PPEEK53
      /COPY QCOPYLE,PPEEK58

       dcl-s r_dateiso       date(*iso) inz(*loval );
       dcl-s r_dateeur       date(*eur) inz(*loval );
       dcl-s r_timeiso       time(*iso) inz(*loval );
       dcl-s r_timehms       time(*hms) inz(*loval );
       dcl-s r_timeeur       time(*eur) inz(*loval );
       dcl-s r_timestmp      timestamp inz(*loval );
       dcl-s r_fldlen        like(int4_t);
       dcl-s r_pos           like(int4_t);
       dcl-s r_buffer        like(i_buffer);
       dcl-c r_bufflen       const(%size(i_buffer));

       //*******************************************************************
       //                 S T E U E R  -  R O U T I N E                    *
       //*******************************************************************

       dcl-pi peek36;
         i_buffer        char(128) const;
         i_type          char(1) const;
         i_dattimfmt     const like(fldl0100_t.f1dtfm);
         i_separator     const like(fldl0100_t.f1dtsp);
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pi;

       //  Register error handler
       ceehdlr(%paddr('errorHandler')
              : *null: *omit);
       exsr first;

       //  Prüfen Format für ...
       select;
          // ... Datum
       when i_type = 'L';
          select;
             // ... *EUR
          when i_dattimfmt = '*EUR';
             r_dateeur = %date(i_buffer: *eur);
             // ... *ISO
          other;
             r_dateiso = %date(i_buffer: *iso);
          endsl;
          r_fldlen = 10;
          // ... Zeit
       when i_type = 'T';
          select;
             // ... *HMS
          when i_dattimfmt = '*HMS';
             r_timehms = %time(i_buffer: *hms);
             // ... *EUR
          when i_dattimfmt = '*EUR';
             r_timeeur = %time(i_buffer: *eur);
             // ... *ISO
          other;
             r_timeiso = %time(i_buffer: *iso);
          endsl;
          r_fldlen = 8;
          // ... Zeitstempel
       when i_type = 'Z';
          r_timestmp = %timestamp(i_buffer);
          r_fldlen = 26;
       other;
          p_kill('Incorrect time format: ' +
                i_dattimfmt);
       endsl;

       r_pos = r_fldlen + 1;
       if r_pos <= r_bufflen;
          r_buffer = %subst(i_buffer: r_pos);
       else;
          r_buffer = '';
       endif;

       if r_buffer = '';
          // ... Alles in Ordnung
       else;
          p_kill('Incorrect timestamp format: ' + i_dattimfmt);
       endif;

       return;

       //============================================================*
       //    First         Initialisierung                           *
       //============================================================*

       begsr first;

          o_msgid = '';
          o_msgdta = '';

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

