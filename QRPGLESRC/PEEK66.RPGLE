       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 3.1.0                               *
       //  Programm : PEEK65                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 31.07.2008  Raddatz                               *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //                                                               *
       //  Konvertieren Datenformat für Kurzbefehl                      *
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

      /COPY QCOPYLE,D_CLib
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,D_MI
      /COPY QCOPYLE,SDS
      /COPY QCOPYLE,CEECNDHDLR

      /define internal_prototype
      /COPY QCOPYLE,PPEEK66
      /undefine internal_prototype

      /COPY QCOPYLE,PPEEK53
      /COPY QCOPYLE,PPEEK58

       dcl-s numeric_t packed(31:10) template;
       dcl-c cdata_type 'P';
       dcl-c cdigits %len(numeric_t);
       dcl-c cdecpos %decpos(numeric_t);

       dcl-c cchr_x 'x';
       dcl-c cquote '''';

       dcl-pr main extproc('main');
         io_buffer       like(gio_buffer);
         io_length       like(gio_length);
         i_informat      const  likeds(gi_informat);
         i_outformat     const  likeds(gi_outformat);
         o_msgid         like(go_msgid);
         o_msgdta        like(go_msgdta);
       end-pr;

       //  Convert from numeric value.
       dcl-pr convertfromnumeric extproc('convertFromNumeric');
         io_buffer       like(gio_buffer);
         io_length       like(gio_length);
         i_outformat     const  likeds(gi_outformat);
         o_msgid         like(go_msgid);
         o_msgdta        like(go_msgdta);
       end-pr;

       //  Convert from string value.
       dcl-pr convertfromstring extproc('convertFromString');
         io_buffer       like(gio_buffer);
         io_length       like(gio_length);
         i_outformat     const  likeds(gi_outformat );
         o_msgid         like(go_msgid);
         o_msgdta        like(go_msgdta);
       end-pr;

       //  Convert to numeric value.
       dcl-pr converttonumeric extproc('convertToNumeric');
         io_buffer       like(gio_buffer);
         io_length       like(gio_length);
         i_outformat     const  likeds(gi_outformat );
         o_msgid         like(go_msgid);
         o_msgdta        like(go_msgdta);
       end-pr;

       //  Convert to string value.
       dcl-pr converttostring extproc('convertToString');
         io_buffer       like(gio_buffer);
         io_length       like(gio_length);
         i_outformat     const  likeds(gi_outformat);
         o_msgid         like(go_msgid);
         o_msgdta        like(go_msgdta);
       end-pr;

       //*******************************************************************
       //                 S T E U E R  -  R O U T I N E                    *
       //*******************************************************************

       // ENTRY-LISTE
       dcl-pi peek66;
         gio_buffer      like(cmdbuffer_t);
         gio_length      like(int4_t);
         gi_informat     const likeds(fldl0100_t);
         gi_outformat    const likeds(fldl0100_t);
         go_msgid        like(msgid_t);
         go_msgdta       like(msgdta_t);
       end-pi;
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       //  Register error handler
       ceehdlr(%paddr('errorHandler'): *null: *omit);

       main(gio_buffer
            : gio_length
            : gi_informat
            : gi_outformat
            : go_msgid
            : go_msgdta);

       return;


       //========================================================================*
       //  Main - Prozedur
       //========================================================================*
       dcl-proc main;
       dcl-pi *N;
         io_buffer       like(gio_buffer);
         io_length       like(gio_length);
         i_informat      const  likeds(gi_informat);
         i_outformat     const  likeds(gi_outformat);
         o_msgid         like(go_msgid);
         o_msgdta        like(go_msgdta);
       end-pi;
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       clear o_msgid;
       clear o_msgdta;

       if (f_isnumfld(i_informat) = btrue);
          convertfromnumeric(io_buffer: io_length: i_outformat
                             : o_msgid: o_msgdta);
       else;
          convertfromstring(io_buffer: io_length: i_outformat
                             : o_msgid: o_msgdta);
       endif;

       end-proc;

       //========================================================================*
       //  Convert from numeric value.
       //========================================================================*
       dcl-proc convertfromnumeric;
       dcl-pi *N;
         io_buffer       like(gio_buffer);
         io_length       like(gio_length);
         i_outformat     const  likeds(gi_outformat);
         o_msgid         like(go_msgid);
         o_msgdta        like(go_msgdta);
       end-pi;
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       if (f_isnumfld(i_outformat) = btrue);
          converttonumeric(io_buffer: io_length: i_outformat
                           : o_msgid: o_msgdta);
       else;
          converttostring(io_buffer: io_length: i_outformat
                          : o_msgid: o_msgdta);
       endif;

       end-proc;

       //========================================================================*
       //  Convert from string value.
       //========================================================================*
       dcl-proc convertfromstring;
       dcl-pi *N;
         io_buffer       like(gio_buffer);
         io_length       like(gio_length);
         i_outformat     const  likeds(gi_outformat);
         o_msgid         like(go_msgid);
         o_msgdta        like(go_msgdta);
       end-pi;
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       if (f_isnumfld(i_outformat) = btrue);
          converttonumeric(io_buffer: io_length: i_outformat
                           : o_msgid: o_msgdta);
       else;
          converttostring(io_buffer: io_length: i_outformat
                          : o_msgid: o_msgdta);
       endif;

       end-proc;

       //========================================================================*
       //  Convert to numeric value.
       //========================================================================*
       dcl-proc converttonumeric;
       dcl-pi *N;
         io_buffer       like(gio_buffer);
         io_length       like(gio_length);
         i_outformat     const  likeds(gi_outformat);
         o_msgid         like(go_msgid);
         o_msgdta        like(go_msgdta);
       end-pi;

       //  Arbeitsfelder
       dcl-s isonebyteint     like(bool_t);
       dcl-s onebyteintadjust int(10);
       dcl-s innumeric        like(numeric_t);
       dcl-s tmpbuffer        like(io_buffer);
       dcl-s digits           int(10);

      /COPY QCOPYLE,USR8227
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       monitor;
          innumeric = %dec(%subst(io_buffer: 1: io_length): cdigits: cdecpos);
       on-error;
          clear usr8227;
          usr8227.var1 = %subst(io_buffer: 1: io_length);
          usr8227.var2 = cdata_type;
          usr8227.var3 = cdigits;
          usr8227.var4 = cdecpos;
          o_msgid  = 'USR8227';
          o_msgdta = usr8227;
          return;
       endmon;

       if ((i_outformat.f1dtyp = 'B' or
            i_outformat.f1dtyp = 'I' or
            i_outformat.f1dtyp = 'U')
          and f_rpgtointlength(i_outformat.f1digt) = 1);
          isonebyteint = btrue;
          onebyteintadjust = 1;
       else;
          isonebyteint = bfalse;
          onebyteintadjust = 0;
       endif;

       if (f_isfloatfld(i_outformat) = btrue);
          digits = i_outformat.f1flen;
       else;
          digits = i_outformat.f1digt;
       endif;

       clear io_buffer;
       clear io_length;

       cpynv(f_num_descr2(i_outformat.f1dtyp
                          : digits + onebyteintadjust
                          : i_outformat.f1decp)
             : %addr(io_buffer)
             : f_num_descr2(cdata_type
                            : %len(innumeric)
                            : %decpos(innumeric))
             : %addr(innumeric));

       if (isonebyteint = btrue);
          %subst(io_buffer: 1: 1) = %subst(io_buffer: 2: 1);
          %subst(io_buffer: 2: 1) = x'00';
       endif;

       select;
       when (i_outformat.f1dtyp = 'B' or
             i_outformat.f1dtyp = 'I' or
             i_outformat.f1dtyp = 'U');
          io_length = f_rpgtointlength(i_outformat.f1digt);
       when (i_outformat.f1dtyp = 'P');
          io_length = %int(i_outformat.f1digt / 2) + 1;
       when (i_outformat.f1dtyp = 'S');
          io_length = i_outformat.f1digt;
       when (i_outformat.f1dtyp = 'F');
          io_length = i_outformat.f1flen;
       endsl;

       cvthc(%addr(tmpbuffer): %addr(io_buffer): io_length * 2);
       io_length = io_length * 2;
       io_buffer = %subst(tmpbuffer: 1: io_length);

       io_buffer = cchr_x + cquote + %subst(io_buffer: 1: io_length) + cquote;
       io_length = io_length + %len(cchr_x) + %len(cquote) * 2;

       end-proc;

       //========================================================================*
       //  Convert to string value.
       //========================================================================*
       dcl-proc converttostring;
       dcl-pi *N;
         io_buffer       like(gio_buffer);
         io_length       like(gio_length);
         i_outformat     const  likeds(gi_outformat);
         o_msgid         like(go_msgid);
         o_msgdta        like(go_msgdta);
       end-pi;
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       io_buffer = %subst(io_buffer: 1: i_outformat.f1flen);
       io_length = i_outformat.f1flen;

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

