       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 2.1.0                               *
       //  Programm : PEEK32                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 26.11.97  Raddatz                                 *
       //  geändert : 27.04.99  2.1.0                                   *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //                                                               *
       //  Konvertieren nicht darstellbarer Zeichen                     *
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

      /COPY QCOPYLE,SET0006

      /COPY QCOPYLE,USR8163

      /define internal_prototype
      /COPY QCOPYLE,PPEEK32
      /undefine internal_prototype

      /COPY QCOPYLE,F_PEEK53

       dcl-s x               like(int4_t);
       dcl-s pbuffer         pointer;
       dcl-s char            char(1) based(pChar);

       dcl-s isInzSr         like(bool_t) inz(bfalse);

       //*******************************************************************
       //                 S T E U E R  -  R O U T I N E                    *
       //*******************************************************************

       dcl-pi peek32;
         io_buffer       likeds(rcdbuffer_t);
         i_bufflen       const like(int4_t);
         i_ccsid         const like(int4_t);
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pi;
       //----------------------------------------------------*

       //  Register error handler
       ceehdlr(%paddr('errorHandler')
              : *null: *omit);

       exsr inzsr;

       o_msgid = '';
       o_msgdta = '';

       //    Zeichen mit einer DOUBLE BYTE CCSID, wie 1200 oder 13488
       //    können zur Zeit nicht geprüft werden.
       if (i_ccsid <> 0);
          exsr check_ucs2;
       else;
          exsr check_sbcs;
       endif;

       return;

       //============================================================*
       //    Prüfen UCS2 Zeichenkette auf ungültige Zeichen          *
       //============================================================*

       begsr check_ucs2;

          //      DBCS Zeichen lassen sich zur Zeit nicht prüfen.

       endsr;

       //============================================================*
       //    Prüfen SBCS Zeichenkette auf ungültige Zeichen          *
       //============================================================*

       begsr check_sbcs;

          pbuffer = %addr(io_buffer);

          for x = 1 to i_bufflen;
             pChar = pbuffer + (x-1);
             if (char < x'40' or char = x'FF');
                char = set_cvtc;
                o_msgid = 'USR8163';
                usr81631 = set_cvtc;
                o_msgdta = usr8163;
             else;
                // Zeichen beibehalten
             endif;
          endfor;

       endsr;

       //============================================================*
       //    GetUsrSetg    Ermitteln der Standardsprache             *
       //============================================================*

       begsr getUsrSetg;

          set0006 = f_getusrsg('*CVTCHR');

       endsr;

       //====================================================*
       //  InzSr --  Initialize program                      *
       //====================================================*

       begsr inzsr;

          if (isInzSr = btrue);
             leavesr;
          endif;

          isInzSr = btrue;

          exsr getUsrSetg;

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

