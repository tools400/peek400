       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 3.0.0                               *
       //  Programm : PEEK63                                            *
       //  Typ      : RPGLE                                             *
       //                                                               *
       //  erstellt : 25.01.07  Raddatz                                 *
       //  geändert :                                                   *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //                                                               *
       //  Peek/400 - Dateizugriffsroutinen                             *
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
       ctl-opt nomain;
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT

      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,D_CLib
      /COPY QCOPYLE,D_CLib2
      /COPY QCOPYLE,USR9994
      /COPY QCOPYLE,SDS

      /COPY QCOPYLE,PPEEK53
      /COPY QCOPYLE,PPEEK58
      /COPY QCOPYLE,PPEEK63

       dcl-c OPER_OPEN      const('*OPEN');
       dcl-c OPER_CHAIN_RRN const('*CHAIN_RRN');

       dcl-c OPER_CHAIN_KEY const('*CHAIN_KEY');

       dcl-c OPER_SETLL_RRN const('*SETLL_RRN');

       dcl-c OPER_SETLL_KEY const('*SETLL_KEY');
       dcl-c OPER_SETGT_RRN const('*SETGT_RRN');
       dcl-c OPER_SETGT_KEY const('*SETGT_KEY');
       dcl-c OPER_READ      const('*READ');
       dcl-c OPER_READP     const('*READP');
       dcl-c OPER_CLOSE     const('*CLOSE');
       dcl-c OPER_DELETE    const('*DELETE');
       dcl-c OPER_UNLOCK    const('*UNLOCK');

       dcl-c ERROR_RRN      const(-1);

       dcl-pr clearerrormsg;
         io_hfile        likeds(hfile_t);
       end-pr;

       dcl-pr clearbufferandnullmap;
         i_rfile         const  likeds(rfile_t );
         io_rcdbuffer    like(rcdbuf_t);
         io_nullmap      like(nullmap_t)
            dim(null_map_size);
       end-pr;

       dcl-pr copyinnullmap;
         i_rfile         const  likeds(rfile_t );
         io_nullmap      like(nullmap_t) dim(null_map_size);
       end-pr;

       //  Returns the value of the specified mode parameter.
       dcl-pr getmode varchar(16);
         i_mode          varchar(512) value;
         i_parm          varchar(16) value;
         i_default       varchar(16) value;
       end-pr;

       dcl-pr seteof;
         io_hfile        likeds(hfile_t);
         i_operation     char(10) value;
       end-pr;

       //===================================================================*
       //  Opens a given file.                                   (Body)     *
       //===================================================================*

       dcl-proc cio_open export;
       dcl-pi *N like(bool_t);
         o_hfile                likeds(hfile_t);
         i_file          const  like(file_t);
         i_lib           const  like(lib_t);
         i_mbr           const  like(mbr_t);
         i_rcdformat     const  like(rcdFmt_t);
         i_mode          pointer const  options(*string);
       end-pi;

       dcl-s fd pointer;

       dcl-ds rfile likeds(rfile_t) based(fd);
       dcl-ds riofb likeds(riofb_t) based(priofb);
       // ----------------------------------------------------------------------

       p_clrerrno();

       clear o_hfile;

       monitor;
          fd = ropen(%trim(i_lib ) + '/' +
                     %trim(i_file) + '(' +
                     %trim(i_mbr) + ')'
                     : i_mode);
          if (fd <> *null and i_rcdformat <> '' and i_rcdformat <> '*FIRST');
             rformat(fd: %trim(i_rcdformat));
          endif;
       on-error;
          fd = *null;
       endmon;

       if fd = *null;
          o_hfile.errno = f_errno();
          return bfalse;
       endif;

       o_hfile.fd        = fd;
       o_hfile.isopen    = btrue;
       o_hfile.name      = i_file;
       o_hfile.lib       = i_lib;
       o_hfile.mbr       = i_mbr;
       o_hfile.rcdformat = i_rcdformat;
       o_hfile.errno     = 0;
       o_hfile.lastoper  = OPER_OPEN;
       o_hfile.arrseq    = getmode(%str(i_mode): 'arrseq': 'N');
       o_hfile.msgid     = '';
       o_hfile.msgdta    = '';

       return btrue;

       end-proc;

       //===================================================================*
       //  Checks whether the file identified by i_hFile is open or not.
       //===================================================================*

       dcl-proc cio_isopen export;
       dcl-pi *N like(bool_t);
         i_hfile         const  likeds(hfile_t);
       end-pi;
       // ------------------------------------------------------------------------

       if (i_hfile.fd = *null);
          return bfalse;
       endif;

       return i_hfile.isopen;

       end-proc;

       //===================================================================*
       //  Returns the name of the file identified by i_hFile.
       //===================================================================*

       dcl-proc cio_getfile export;
       dcl-pi *N like(file_t);
         i_hfile         const  likeds(hfile_t);
       end-pi;
       // ------------------------------------------------------------------------

       if (cio_isopen(i_hfile) = bFalse);
          return '';
       endif;

       return i_hfile.name;

       end-proc;

       //===================================================================*
       //  Returns the name of the library that contains the file
       //  identified by i_hFile.
       //===================================================================*

       dcl-proc cio_getlibrary export;
       dcl-pi *N like(lib_t);
         i_hfile         const  likeds(hfile_t);
       end-pi;
       // ------------------------------------------------------------------------

       if (cio_isopen(i_hfile) = bFalse);
          return '';
       endif;

       return i_hfile.lib;

       end-proc;

       //===================================================================*
       //  Returns the name of the member of the file identified by i_hFile.
       //===================================================================*

       dcl-proc cio_getmember export;
       dcl-pi *N like(lib_t);
         i_hfile         const  likeds(hfile_t);
       end-pi;
       // ------------------------------------------------------------------------

       if (cio_isopen(i_hfile) = bFalse);
          return '';
       endif;

       return i_hfile.mbr;

       end-proc;

       //===================================================================*
       //  Returns the name of the record format of the file identified
       //  by i_hFile.
       //===================================================================*

       dcl-proc cio_getrecordformat export;
       dcl-pi *N char(10);
         i_hfile         const  likeds(hfile_t);
       end-pi;
       // ------------------------------------------------------------------------

       if (cio_isopen(i_hfile) = bFalse);
          return '';
       endif;

       return i_hfile.rcdformat;

       end-proc;

       //===================================================================*
       //  Returns the record length of the file identified by i_hFile.
       //===================================================================*

       dcl-proc cio_getrecordlength export;
       dcl-pi *N int(10);
         i_hfile         const  likeds(hfile_t);
       end-pi;

       dcl-ds rfile likeds(rfile_t  )
       based(i_hfile.fd);
       // ----------------------------------------------------------------------

       if (cio_isopen(i_hfile) = bFalse);
          return -1;
       endif;

       return rfile.buflen;

       end-proc;

       //===================================================================*
       //  Returns the record number of the current record of the file
       //  identified by i_hFile.
       //===================================================================*

       dcl-proc cio_getrrn export;
       dcl-pi *N int(10);
         i_hfile         const  likeds(hfile_t);
       end-pi;

       dcl-ds rfile likeds(rfile_t) based(i_hfile.fd);
       dcl-ds riofb likeds(riofb_t) based(priofb);
       // ----------------------------------------------------------------------

       if (cio_isopen(i_hfile) = bFalse);
          return -1;
       endif;

       priofb = %addr(rfile.riofb);

       return riofb.rrn;

       end-proc;

       //===================================================================*
       //  Returns the record number of the current record of the file
       //  identified by i_hFile.
       //===================================================================*

       dcl-proc cio_getmbrnbr export;
       dcl-pi *N int(10);
         i_hfile         const  likeds(hfile_t);
       end-pi;

       dcl-ds xxiofb likeds(xxiofb_t) based(pxxiofb);
       dcl-ds xxiofb_db likeds(xxiofb_db_t) based(pxxiofb_db);
       // ----------------------------------------------------------------------

       if (cio_isopen(i_hfile) = bFalse);
          return -1;
       endif;

       pxxiofb = riofbk(i_hfile.fd);
       pxxiofb_db = pxxiofb + %size(xxiofb);

       return xxiofb_db.data_mbr_num;

       end-proc;

       //===================================================================*
       //  Returns the file information data structure of the file
       //  identified by i_hFile.
       //===================================================================*

       dcl-proc cio_getinfds export;
       dcl-pi *N likeds(infds_t);
         i_hfile         const  likeds(hfile_t);
       end-pi;

       //  Funktionswert
       dcl-ds infds likeds(infds_t) inz;
       // ----------------------------------------------------------------------

       clear infds;
       infds.isOpen  = cio_isopen(i_hfile);
       infds.file    = cio_getfile(i_hfile);
       infds.library = cio_getlibrary(i_hfile);
       infds.rcdlen  = cio_getrecordlength(i_hfile);
       infds.member  = cio_getmember(i_hfile);
       infds.rcdfmt  = cio_getrecordformat(i_hfile);
       infds.mbrnbr  = cio_getmbrnbr(i_hfile);
       infds.rcdnbr  = cio_getrrn(i_hfile);

       return infds;

       end-proc;

       //===================================================================*
       //  Returns TRUE if the file is in error.
       //===================================================================*

       dcl-proc cio_iserror export;
       dcl-pi *N like(bool_t);
         i_hfile         const  likeds(hfile_t);
       end-pi;
       // ------------------------------------------------------------------------

       if (i_hfile.errno <> 0 or i_hfile.msgid <> '');
          return btrue;
       else;
          return bfalse;
       endif;

       end-proc;

       //===================================================================*
       //  Sets an error.
       //===================================================================*

       dcl-proc cio_seterrormsg export;
       dcl-pi *N;
         io_hfile        likeds(hfile_t);
         i_msgid         const  like(msgid_t);
         i_msgdta        const  like(msgdta_t);
       end-pi;
       // ------------------------------------------------------------------------

       io_hfile.errno  = -1;
       io_hfile.msgid  = i_msgid;
       io_hfile.msgdta = i_msgdta;

       end-proc;

       //===================================================================*
       //  Gets the current error message.
       //===================================================================*

       dcl-proc cio_geterrormsg export;
       dcl-pi *N;
         i_hfile         const  likeds(hfile_t);
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pi;

      /COPY QCOPYLE,USR0012                      ?
       // ------------------------------------------------------------------------

       if (i_hfile.msgid <> '');
          o_msgid  = i_hfile.msgid;
          o_msgdta = i_hfile.msgdta;
       else;
          clear usr0012;
          usr0012.var1 = cio_geterrortext(i_hfile);
          usr0012.var2 = cio_geterror(i_hfile);
          o_msgid  = 'USR0012';
          o_msgdta = usr0012;
       endif;

       end-proc;

       //===================================================================*
       //  Returns the latest error number associated to file i_hFile.
       //===================================================================*

       dcl-proc cio_geterror export;
       dcl-pi *N int(10);
         i_hfile         const  likeds(hfile_t);
       end-pi;
       // ------------------------------------------------------------------------

       return i_hfile.errno;

       end-proc;

       //===================================================================*
       //  Returns the latest error text associated to file i_hFile.
       //===================================================================*

       dcl-proc cio_geterrortext export;
       dcl-pi *N varchar(512);
         i_hfile         const  likeds(hfile_t);
       end-pi;
       // ------------------------------------------------------------------------

       if (i_hfile.msgid <> '');
          return f_msgtext(i_hfile.msgid: i_hfile.msgdta);
       else;
          return %trimr(f_strerror(i_hfile.errno));
       endif;

       end-proc;

       //===================================================================*
       //  Reads the record identified by i_rrn from a given file.
       //===================================================================*

       dcl-proc cio_chainwithrrn export;
       dcl-pi *N like(bool_t);
         io_hfile        likeds(hfile_t);
         i_rrn           const  like(rcdnbr_t);
         i_dolock        const  like(bool_t);
         io_rcdbuffer    like(rcdbuf_t);
         io_nullmap      like(nullmap_t) dim(null_map_size);
       end-pi;

       dcl-s options         int(10) inz(dft);

       dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
       dcl-ds riofb likeds(riofb_t) based(priofb);
       // ----------------------------------------------------------------------

       p_clrerrno();
       clearerrormsg(io_hfile);

       clearbufferandnullmap(rfile: io_rcdbuffer: io_nullmap);

       if (i_dolock = bTrue);
          options = dft;
       else;
          options = no_lock;
       endif;

       priofb = rreadd(io_hfile.fd
                       : %addr(io_rcdbuffer): %size(io_rcdbuffer)
                       : options: i_rrn);
       if (riofb.numbyt <> rfile.buflen);
          io_hfile.errno = f_errno();
          return bfalse;
       endif;

       copyinnullmap(rfile: io_nullmap);

       io_hfile.lastoper = OPER_CHAIN_RRN;
       io_hfile.errno = 0;

       return btrue;

       end-proc;

       //===================================================================*
       //  Reads the record identified by i_key from a given file.
       //===================================================================*

       dcl-proc cio_chainwithkey export;
       dcl-pi *N like(bool_t);
         io_hfile        likeds(hfile_t);
         i_key           const  like(keybuf_t);
         i_dolock        const  like(bool_t);
         io_rcdbuffer    like(rcdbuf_t);
         io_nullmap      like(nullmap_t) dim(null_map_size);
       end-pi;

       dcl-s options         int(10) inz(dft);
       dcl-s key             like(i_key      ) inz;
       dcl-s keylen          int(10) inz;

       dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
       dcl-ds riofb likeds(riofb_t) based(priofb);
       // ----------------------------------------------------------------------

       p_clrerrno();
       clearerrormsg(io_hfile);

       clearbufferandnullmap(rfile: io_rcdbuffer: io_nullmap);

       if (i_dolock = btrue);
          options = f_bitor(dft: key_eq);
       else;
          options = f_bitor(no_lock: key_eq);
       endif;

       key = i_key;
       keylen = %len(key);

       priofb = rreadk(io_hfile.fd
                       : %addr(io_rcdbuffer): %size(io_rcdbuffer)
                       : options: %addr(key): keylen);
       if (riofb.numbyt <> rfile.buflen) or (riofb.numbyt = eof);
          io_hfile.errno = f_errno();
          return bfalse;
       endif;

       copyinnullmap(rfile: io_nullmap);

       io_hfile.lastoper = OPER_CHAIN_KEY;
       io_hfile.errno = 0;

       return btrue;

       end-proc;

       //===================================================================*
       //  Positions the file right before the record identifed by i_rrn.
       //===================================================================*

       dcl-proc cio_setllwithrrn export;
       dcl-pi *N like(bool_t);
         io_hfile        likeds(hfile_t);
         i_rrn           const  like(rcdnbr_t);
       end-pi;

       dcl-s errornbr int(10) inz;
       dcl-s options uns(10) inz;

       dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
       dcl-ds riofb likeds(riofb_t) based(priofb);
       // ----------------------------------------------------------------------

       clearerrormsg(io_hfile);

       // Setzen Datenzeiger auf angegebene Satznummer
       // (auch auf gelöschte Datensatze)
       options = f_bitor(rrn_eq: no_lock);

       p_clrerrno();
       priofb = rlocate(io_hfile.fd: *null: i_rrn: options);

       select;
       when riofb.numbyt = 0;   // Datensatz nicht vorhanden
          p_clrerrno();
          priofb = rreadn(io_hfile.fd : *null: 0: no_lock);
          errornbr = f_errno();
       when riofb.numbyt = 1;   // Datensatz vorhanden
          p_clrerrno();
          priofb = rreads(io_hfile.fd : *null: 0: no_lock);
          errornbr = f_errno();
          if riofb.numbyt = 0 and errornbr = eiorecerr_c;   // wahrscheinlich ein
             // gelöschter Datensatz
             p_clrerrno();
             priofb = rreadn(io_hfile.fd : *null: 0: no_lock);
          endif;
       endsl;

       // Datensatz nicht vorhanden, also ans Ende der Datei positionieren
       if (riofb.numbyt = 0);
          options = f_bitor(end  : no_lock);
          p_clrerrno();
          priofb = rlocate(io_hfile.fd: *null: i_rrn: options);
       endif;

       if (riofb.numbyt = eof);
          io_hfile.errno = f_errno();   // "End of File" erreicht
          return bfalse;
       endif;

       if (riofb.numbyt <> rfile.buflen);
          io_hfile.errno = f_errno();
          return bfalse;
       endif;

       io_hfile.lastoper = OPER_SETLL_RRN;
       io_hfile.errno = 0;

       return btrue;

       end-proc;

       //===================================================================*
       //  Positions the file right before the record identifed by i_key.
       //===================================================================*

       dcl-proc cio_setllwithkey export;
       dcl-pi *N like(bool_t);
         io_hfile        likeds(hfile_t);
         i_key           const  like(keybuf_t);
       end-pi;

       dcl-s options         uns(10) inz;
       dcl-s key             like(i_key      ) inz;
       dcl-s keylen          int(10) inz;

       dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
       dcl-ds riofb likeds(riofb_t) based(priofb);
       // ----------------------------------------------------------------------

       p_clrerrno();
       clearerrormsg(io_hfile);

       // Setzen Datenzeiger auf angegebenen Schlüssel
       key = i_key;
       keylen = %len(key);

       options = f_bitor(key_ge: prior: data_only);

       priofb = rlocate(io_hfile.fd: %addr(key): keylen: options);
       if (riofb.numbyt = 0 or riofb.numbyt = eof);
          options = f_bitor(start: data_only);
          priofb = rlocate(io_hfile.fd: %addr(key): keylen: options);
       endif;

       if (riofb.numbyt = 0); // or (RIOFB.numByt = EOF);
          io_hfile.errno = f_errno();   //Fehler bei _Rlocate() aufgetreten
          return bfalse;
       endif;

       io_hfile.lastoper = OPER_SETLL_KEY;
       io_hfile.errno = 0;

       return btrue;

       end-proc;

       //===================================================================*
       //  Positions the file right after the record identifed by i_rrn.
       //===================================================================*

       dcl-proc cio_setgtwithrrn export;
       dcl-pi *N like(bool_t);
         io_hfile        likeds(hfile_t);
         i_rrn           const  like(rcdnbr_t);
       end-pi;

       dcl-s options         uns(10) inz;

       dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
       dcl-ds riofb likeds(riofb_t) based(priofb);
       // ----------------------------------------------------------------------

       p_clrerrno();
       clearerrormsg(io_hfile);

       // Setzen Datenzeiger auf angegebene Satznummer
       // (auch auf gelöschte Datensatze)
       options = f_bitor(rrn_eq: no_lock);

       priofb = rlocate(io_hfile.fd: *null: i_rrn: options);
       if (riofb.numbyt = 0);
          options = f_bitor(end: no_lock);
          priofb = rlocate(io_hfile.fd: *null: i_rrn: options);
       endif;

       if (riofb.numbyt = 0);
          io_hfile.errno = f_errno();   // Fehler bei _Rlocate() aufgetreten
          return bfalse;
       endif;

       if (riofb.numbyt = eof);
          io_hfile.errno = f_errno();   // "End of File" erreicht
          return bfalse;
       endif;

       // Einlesen Datensatz
       priofb = rreads(io_hfile.fd : *null: 0: no_lock);
       if (riofb.numbyt = 0 and f_errno() = eiorecerr_c);   // wahrscheinlich ein
          // gelöschter Datensatz
          priofb = rreadn(io_hfile.fd : *null: 0: no_lock);
       endif;

       if (riofb.numbyt <> rfile.buflen);
          io_hfile.errno = f_errno();
          return bfalse;
       endif;

       io_hfile.lastoper = OPER_SETGT_RRN;
       io_hfile.errno = 0;

       return btrue;

       end-proc;

       //===================================================================*
       //  Positions the file right after the record identifed by i_key.
       //===================================================================*

       dcl-proc cio_setgtwithkey export;
       dcl-pi *N like(bool_t);
         io_hfile        likeds(hfile_t);
         i_key           const  like(keybuf_t);
       end-pi;

       dcl-s options         uns(10) inz;
       dcl-s key             like(i_key      ) inz;
       dcl-s keylen          int(10) inz;

       dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
       dcl-ds riofb likeds(riofb_t) based(priofb);
       // ----------------------------------------------------------------------

       p_clrerrno();
       clearerrormsg(io_hfile);

       // Setzen Datenzeiger auf angegebenen Schlüssel
       key = i_key;
       keylen = %len(key);

       options = f_bitor(key_gt: prior: data_only);

       priofb = rlocate(io_hfile.fd: %addr(key): keylen: options);
       if (riofb.numbyt = 0) or (riofb.numbyt = eof);
          options = f_bitor(end: data_only);
          priofb = rlocate(io_hfile.fd: %addr(key): keylen: options);
       endif;

       if (riofb.numbyt = 0); // or (RIOFB.numByt = EOF);
          io_hfile.errno = f_errno();   // Fehler bei _Rlocate() aufgetreten
          return bfalse;
       endif;

       io_hfile.lastoper = OPER_SETGT_KEY;
       io_hfile.errno = 0;

       return btrue;

       end-proc;

       //===================================================================*
       //  Returns the next record from the file.
       //===================================================================*

       dcl-proc cio_read export;
       dcl-pi *N like(bool_t);
         io_hfile        likeds(hfile_t);
         i_dolock        const  like(bool_t);
         io_rcdbuffer    like(rcdbuf_t);
         io_nullmap      like(nullmap_t) dim(null_map_size);
       end-pi;

       dcl-s options     int(10) inz(dft);
       dcl-s function    varchar(32) inz;
       dcl-s msgid       like(msgid_t) inz;
       dcl-s msgdta      like(msgdta_t) inz;

       dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
       dcl-ds riofb likeds(riofb_t) based(priofb);
       // ----------------------------------------------------------------------

       p_clrerrno();
       clearerrormsg(io_hfile);

       clearbufferandnullmap(rfile: io_rcdbuffer: io_nullmap);

       if (i_dolock = bTrue);
          options = dft;
       else;
          options = no_lock;
       endif;

       if (io_hfile.lastoper = OPER_SETLL_RRN) or
          (io_hfile.lastoper = OPER_SETGT_RRN);
          //?(io_hFile.lastOper = cOPER_SETLL_KEY) or
          //?(io_hFile.lastOper = cOPER_SETGT_KEY);
          function = '_Rreads';
          priofb = rreads(io_hfile.fd
                          : %addr(io_rcdbuffer): %size(io_rcdbuffer)
                          : options);
       else;
          function = '_Rreadn';
          priofb = rreadn(io_hfile.fd
                          : %addr(io_rcdbuffer): %size(io_rcdbuffer)
                          : options);
       endif;

       io_hfile.errno = f_errno();

       if (io_hfile.errno <> 0);
          clear usr9994;
          usr9994.var1 = f_errno();
          usr9994.var2 = function;
          usr9994.var3 = f_strerror(f_errno());
          msgid  = 'USR9994';
          msgdta = usr9994;
          p_sndpgmmg(msgid: msgdta: '*': msg_t_diag);
          return btrue;   // Return "EOF" to caller
       endif;

       select;
       when riofb.numbyt = eof;
          io_hfile.lastoper = OPER_READ;
          io_hfile.errno = 0;
          return btrue;   // Return "EOF" to caller
       endsl;

       copyinnullmap(rfile: io_nullmap);
       io_hfile.lastoper = OPER_READ;
       io_hfile.errno = 0;

       return bfalse;  // Return "found" to caller

       end-proc;

       //===================================================================*
       //  Returns the previous record from the file.
       //===================================================================*

       dcl-proc cio_readp export;
       dcl-pi *N like(bool_t);
         io_hfile        likeds(hfile_t);
         i_dolock        const  like(bool_t);
         io_rcdbuffer    like(rcdbuf_t);
         io_nullmap      like(nullmap_t) dim(null_map_size);
       end-pi;

       dcl-s options     int(10) inz(dft);
       dcl-s function    varchar(32) inz;
       dcl-s msgid       like(msgid_t) inz;
       dcl-s msgdta      like(msgdta_t) inz;

       dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
       dcl-ds riofb likeds(riofb_t) based(priofb);
       // ----------------------------------------------------------------------

       p_clrerrno();
       clearerrormsg(io_hfile);

       clearbufferandnullmap(rfile: io_rcdbuffer: io_nullmap);

       if i_dolock = btrue;
          options = dft;
       else;
          options = no_lock;
       endif;

       if (io_hfile.lastoper = OPER_SETLL_RRN) or
          (io_hfile.lastoper = OPER_SETGT_RRN);
          //?(io_hFile.lastOper = cOPER_SETLL_KEY) or
          //?(io_hFile.lastOper = cOPER_SETGT_KEY);
          function = '_Rreads';
          priofb = rreads(io_hfile.fd
                          : %addr(io_rcdbuffer): %size(io_rcdbuffer)
                          : options);
       else;
          function = '_Rreadp';
          priofb = rreadp(io_hfile.fd
                          : %addr(io_rcdbuffer): %size(io_rcdbuffer)
                          : options);
       endif;

       io_hfile.errno = f_errno();

       if (io_hfile.errno <> 0);
          clear usr9994;
          usr9994.var1 = f_errno();
          usr9994.var2 = function;
          usr9994.var3 = f_strerror(f_errno());
          msgid  = 'USR9994';
          msgdta = usr9994;
          p_sndpgmmg(msgid: msgdta: '*': msg_t_diag);
          return btrue;   // Return "EOF" to caller
       endif;


       select;
       when riofb.numbyt = eof;
          io_hfile.lastoper = OPER_READP;
          io_hfile.errno = 0;
          return btrue;   // Return "EOF" to caller
       endsl;

       copyinnullmap(rfile: io_nullmap);
       io_hfile.lastoper = OPER_READP;
       io_hfile.errno = 0;

       return bfalse;  // Return "found" to caller

       end-proc;

       //===================================================================*
       //  Deletes the record that is currently locked for update.
       //===================================================================*

       dcl-proc cio_delete export;
       dcl-pi *N like(bool_t);
         io_hfile        likeds(hfile_t);
       end-pi;

       dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
       dcl-ds riofb likeds(riofb_t) based(priofb);
       // ----------------------------------------------------------------------

       p_clrerrno();
       clearerrormsg(io_hfile);

       priofb = rdelete(io_hfile.fd);
       if (riofb.numbyt = 0);
          io_hfile.errno = f_errno();
          return bfalse;
       endif;

       io_hfile.lastoper = OPER_DELETE;
       io_hfile.errno = 0;

       return btrue;

       end-proc;

       //===================================================================*
       //  Releases the lock on the currently locked record.
       //===================================================================*

       dcl-proc cio_unlock export;
       dcl-pi *N like(bool_t);
         io_hfile        likeds(hfile_t);
       end-pi;

       dcl-s rc int(10);

       dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
       // ------------------------------------------------------------------------

       p_clrerrno();
       clearerrormsg(io_hfile);

       rc = rrlslck(io_hfile.fd);
       if (rc = 0);
          io_hfile.errno = f_errno();
          return bFalse;
       endif;

       io_hfile.lastoper = OPER_UNLOCK;
       io_hfile.errno = 0;

       return bTrue;

       end-proc;

       //===================================================================*
       //  Closes the file identifed by io_hFile.
       //===================================================================*

       dcl-proc cio_close export;
       dcl-pi *N like(bool_t);
         io_hfile        likeds(hfile_t);
       end-pi;
       // ------------------------------------------------------------------------

       p_clrerrno();
       clearerrormsg(io_hfile);

       if (rclose(io_hfile.fd) <> 0);
          io_hfile.errno = f_errno();
          return bFalse;
       endif;

       clear io_hfile;
       io_hfile.isopen = bfalse;
       io_hfile.lastoper = OPER_CLOSE;
       io_hfile.errno = 0;

       return bTrue;

       end-proc;

       //===================================================================*
       //  Sets the EOF indicator for a READ operation.
       //  === Used by SQL_nextRow() ===
       //===================================================================*

       dcl-proc cio_seteof_read export;
       dcl-pi *N;
         io_hfile        likeds(hfile_t);
       end-pi;
       // ------------------------------------------------------------------------

       seteof(io_hfile: OPER_READ);

       end-proc;

       //===================================================================*
       //  Sets the EOF indicator for a READP operation.
       //  === Used by SQL_previousRow() ===
       //===================================================================*

       dcl-proc cio_seteof_readp export;
       dcl-pi *N;
         io_hfile        likeds(hfile_t);
       end-pi;
       // ------------------------------------------------------------------------

       seteof(io_hfile: OPER_READP);

       end-proc;

       //===================================================================*
       //  *** private ***
       //  Sets the EOF indicator for a READ or READP operation.
       //===================================================================*

       dcl-proc seteof;
       dcl-pi *N;
         io_hfile        likeds(hfile_t);
         i_operation     char(10) value;
       end-pi;

       dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
       dcl-ds riofb likeds(riofb_t) based(priofb);
       // ----------------------------------------------------------------------

       priofb = %addr(rfile.riofb);

       io_hfile.lastoper = i_operation;
       io_hfile.errno = 0;

       riofb.rrn    = 0;
       riofb.numbyt = eof;

       end-proc;

       //===================================================================*
       //  *** private ***
       //  Clears the error information.
       //===================================================================*

       dcl-proc clearerrormsg;
       dcl-pi *N;
         io_hfile        likeds(hfile_t);
       end-pi;
       // ------------------------------------------------------------------------

       io_hfile.errno  = 0;
       io_hfile.msgid  = '';
       io_hfile.msgdta = '';

       end-proc;

       //===================================================================*
       //  *** private ***
       //  Clears the file IO-buffer and NULL-map.
       //===================================================================*

       dcl-proc clearbufferandnullmap;
       dcl-pi *N;
         i_rfile         const  likeds(rfile_t );
       io_rcdbuffer    like(rcdbuf_t);
       io_nullmap      like(nullmap_t)
            dim(null_map_size);
       end-pi;

       dcl-s x int(10);
       // ------------------------------------------------------------------------

       %subst(io_rcdbuffer: 1: i_rfile.buflen) = '';

       for x = 1 to i_rfile.nmaplen;
          io_nullmap(x) = 0;   // setzen auf "nicht NULL"
       endfor;

       end-proc;

       //===================================================================*
       //  *** private ***
       //  Copies the file IN-NULL-map.
       //===================================================================*

       dcl-proc copyinnullmap;
       dcl-pi *N;
         i_rfile         const  likeds(rfile_t );
         io_nullmap      like(nullmap_t) dim(null_map_size);
       end-pi;

       dcl-s x int(10);
       dcl-s innullmap zoned(1) dim(null_map_size) based(i_rfile.pinnull);
       // ------------------------------------------------------------------------

       for x = 1 to i_rfile.nmaplen;
          io_nullmap(x) = innullmap(x);
       endfor;

       end-proc;

       //===================================================================*
       //  *** private ***
       //  Returns the value of the specified mode parameter.
       //===================================================================*

       dcl-proc getmode;
       dcl-pi *N varchar(16);
         i_mode          varchar(512) value;
         i_parm          varchar(16) value;
         i_default       varchar(16) value;
       end-pi;

       //  Local fields
       dcl-s x int(10);
       dcl-s y int(10);
       // ------------------------------------------------------------------------

       i_mode    = %trim(i_mode);
       i_parm    = %trim(i_parm);
       i_default = %trim(i_default);

       x = %scan(i_parm + '=': i_mode);
       if x = 0;
          return i_default;
       endif;

       x = x + %len(i_parm) + 1;

       y = %scan(' ': i_mode: x);
       if (y = 0);
          return %subst(i_mode: x);
       endif;

       return %subst(i_mode: x: y-1-x);

       end-proc;

