       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 1.4.0                               *
       //  Programm : PEEK28                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 03.11.97  Raddatz                                 *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //                                                               *
       //  Ermitteln Systemwerte                                        *
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

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,QWCRSVAL
      /COPY QCOPYLE,CEECNDHDLR

      /define internal_prototype
      /COPY QCOPYLE,PPEEK28
      /undefine internal_prototype

      /COPY QCOPYLE,PPEEK53
      /COPY QCOPYLE,PPEEK58

       dcl-ds yrcvvar len(128) inz;
         rcvnbrret       int(10);
         rcvoffset       int(10);
         rcvdata         char(120);
       end-ds;

       dcl-ds ysystemval len(128) inz;
         systemval       char(10);
         typeofdata      char(1);
         infstatus       char(1);
         lenofdata       int(10);
         sysvaldata      char(112);
       end-ds;

       dcl-s x        like(int4_t) inz;
       dcl-ds errcode likeds(errcode_t) inz;

       //*******************************************************************
       //                 S T E U E R  -  R O U T I N E                    *
       //*******************************************************************

       dcl-pi peek28;
         i_attr          const like(attr_t);
         i_nomsg         const like(bool_t);
         o_attrlen       like(int4_t);
         o_attrtype      like(attrtype_t);
         o_attrvalue     like(attrvalue_t);
       end-pi;

       //---------------------------------------------------*

       //  Register error handler
       ceehdlr(%paddr('errorHandler')
              : *null: *omit);

       // - Meldung
       if i_nomsg = btrue;
          p_sndstsmg('USR8157': ' ');
       else;
          //        keine Statusmeldung ausgeben
       endif;

       clear errcode;
       errcode.bytprv = %size(errcode);

       qwcrsval(yrcvvar: %size(yrcvvar): 1
               : i_attr: errcode);

       if (errcode.bytavl = 0);
          exsr getattr;
       else;
          o_attrlen = 0;
          o_attrtype = '';
          o_attrvalue = '';
       endif;

       return;

       //====================================================*
       //  GetAttr -  Abrufen der Attributwertes             *
       //====================================================*

       begsr getattr;

          x = rcvoffset + 1;
          ysystemval = %subst(yrcvvar: x);

          o_attrlen = lenofdata;
          o_attrtype = typeofdata;

          x = 1;
          o_attrvalue =
           %subst(sysvaldata: x: o_attrlen);

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

