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
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,ERR_D_SDS
      /COPY QCOPYLE,CEECNDHDLR

      /define internal_prototype
      /COPY QCOPYLE,PPEEK22
      /undefine internal_prototype

      /COPY QCOPYLE,F_PEEK53

       dcl-s wrk_sectn       like(section_t) inz;
       dcl-s wrk_key         like(key_t) inz;
       dcl-s wrk_data        like(set0000_t) inz;

       //*******************************************************************
       //                 S T E U E R  -  R O U T I N E                    *
       //*******************************************************************

       dcl-pi peek22;
         i_mode          char(10) const;
         i_section       char(10) const;
       end-pi;

       //---------------------------------------------------*

       //  Register error handler
       ceehdlr(%paddr('errorHandler')
              : *null: *omit);

       //  Kopieren für alle Programme ...
       if i_section = '*ALL';

          wrk_sectn = '*PEEK05';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK12';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK14';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK17';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK24';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK25';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK26';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK30';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK34';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK37';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK40';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK45';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK47';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK48';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK49';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK50';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK52';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK56';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK57';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK59';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK64';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK68';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PEEK69';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PXXXXXXXX';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*CMD';
          exsr delrecords;
          exsr addrecords;

          wrk_sectn = '*PGM';
          exsr delrecords;
          exsr addrecords;

       else;

          //  Kopieren für ein Programm
          wrk_sectn = i_section;
          exsr delrecords;
          exsr addrecords;

       endif;

       *inlr = '1';

       //============================================================*
       //    DelRecords    Löschen von Datensätzen                   *
       //============================================================*

       begsr delrecords;

          if i_mode = '*REPLACE'
             or i_mode = '*DELETE';

             p_setllusr(wrk_sectn: '*F01');

             dow f_readeusr(wrk_sectn: wrk_key)= '0';
                f_deletusr(wrk_sectn: wrk_key);
             enddo;

          else;
             //    Löschen bestehender Datensäötze nur bei
             //    Betriebsart *REPLACE oder *DELETE.
             //    Sonst nicht!
          endif;

       endsr;

       //============================================================*
       //    AddRecords    Hinzufügen von Datensätzen                *
       //============================================================*

       begsr addrecords;

          if i_mode = '*ADD'
             or i_mode = '*REPLACE';

             p_setlldft(wrk_sectn);

             dow f_readedft(wrk_sectn: wrk_key: wrk_data)='0';
                f_writeusr(wrk_sectn :
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

