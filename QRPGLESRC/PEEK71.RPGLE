       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 3.3.0                               *
       //  Programm : PEEK071                                           *
       //  Typ      : RPGLE                                             *
       //                                                               *
       //  erstellt : 27.03.2012   Thomas Raddatz                       *
       //  geändert :                                                   *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //                                                               *
       //  Peek/400 - Character Translation Services                    *
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

       // ------------------------------------
       //  Constants
       // ------------------------------------

       //  Transcoder handle identifier
       dcl-c class_transcoder
             '*CLASS:ccsid.TRANSCODER';

       // ------------------------------------
       //  Type Definitions
       // ------------------------------------
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100

       //  Transcoder handle
       dcl-ds transcoder_t qualified template;
         class           likeds(class_t );
         fromccsid       uns(10);
         toccsid         uns(10);
         hiconv          likeds(iconv_t );
       end-ds;

       dcl-ds class_t qualified template;
         name            like(classname_t );
         size            int(10);
         reserved        char(12);
       end-ds;

       dcl-s classname_t varchar(62) template;

      /COPY QCOPYLE,PPEEK71

      /COPY QCOPYLE,D_CLIB                         C-Runtime Library
      /COPY QCOPYLE,PPEEK53                       Zugriff auf Benutzerdaten
      /COPY QCOPYLE,PPEEK58                       Allgemeine Routinen
      /COPY QCOPYLE,QUSRJOBI                       Retrieve Job Information (QUSRJOBI) API
      /COPY QCOPYLE,QMHSNDPM                       Send Program Message (QMHSNDPM) API

       // ------------------------------------
       //  Internal prototypes
       // ------------------------------------

       //  Performs charcater translation.
       dcl-pr performtranslation uns(10) extproc('performTranslation');
         i_htranscoder   const  like(htranscoder_t);
         i_pinbuf        pointer value;
         i_length        int(10) const;
         o_pto           pointer;
         i_maxsize       int(10) const;
       end-pr;

       //  Returns a transcoder that matches the specified "from CCSID"
       //  from the list of created transcoders.
       dcl-pr findtranscoder like(htranscoder_t) extproc('findTranscoder');
         i_toccsid       uns(10) const;
         i_fromccsid     uns(10) const;
       end-pr;

       //  Produces a transcoder to transcode character data from
       //  and to given CCSIDs.
       dcl-pr createtranscoder like(htranscoder_t) extproc('createTranscoder');
         i_toccsid       uns(10) const;
         i_fromccsid     uns(10) const;
       end-pr;

       //  Kills utility with an ESCAPE message.
       dcl-pr kill extproc('kill');
         i_text          varchar(128) const;
         i_errno         int(10) const  options(*nopass);
       end-pr;

       //  Returns the CCSID of the current job.
       dcl-pr getjobccsid int(10) extproc('getJobCcsid');
       end-pr;

       //  Kills utility, if a given handle is not a transcoder.
       dcl-pr checkhandle extproc('checkHandle');
         i_htranscoder   const  like(htranscoder_t);
       end-pr;

       // ------------------------------------
       //  Global fields & constants
       // ------------------------------------
       dcl-s g_jobccsid      uns(10) inz(0);

       dcl-ds g_transcoders qualified;
         nume            int(10) inz;
         item            likeds(transcodere_t ) dim(64) inz;
       end-ds;

       dcl-ds transcodere_t qualified;
         htranscoder     like(htranscoder_t );
         toccsid         int(10);
         fromccsid       int(10);
       end-ds;

       //=====================================================================*
       //  Returns a Transcoder to convert from a
       //  given CCSID to the job CCSID.
       //=====================================================================*
       dcl-proc transcoder_tojobccsid export;
       dcl-pi *N        like(htranscoder_t );
         i_fromccsid     uns(10) const;
       end-pi;

       //  Return value
       dcl-s htranscoder like(htranscoder_t) inz;
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       htranscoder = findtranscoder(getjobccsid(): i_fromccsid);
       if (transcoder_isnull(htranscoder));
          htranscoder = createtranscoder(getjobccsid(): i_fromccsid);
       endif;

       return htranscoder;

       end-proc;

       //=====================================================================*
       //  Returns a Transcoder to convert from a
       //  given CCSID to the file field CCSID.
       //=====================================================================*
       dcl-proc transcoder_tofieldccsid export;
       dcl-pi *N        like(htranscoder_t );
         i_toccsid       uns(10) const;
       end-pi;

       //  Return value
       dcl-s htranscoder like(htranscoder_t) inz;
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       htranscoder = findtranscoder(i_toccsid: getjobccsid());
       if (transcoder_isnull(htranscoder));
          htranscoder = createtranscoder(i_toccsid: getjobccsid());
       endif;

       return htranscoder;

       end-proc;

       //=====================================================================*
       //  Initializes character translation.
       //=====================================================================*
       dcl-proc transcoder_new export;
       dcl-pi *N        like(htranscoder_t);
         i_toccsid       uns(10) const;
         i_fromccsid     uns(10) const;
       end-pi;

       //  Return value
       dcl-s htranscoder like(htranscoder_t) inz;

       //  Helper fields
       dcl-ds tocode likeds(qtqcode_t) inz;
       dcl-ds fromcode likeds(qtqcode_t) inz;
       dcl-ds hiconv likeds(iconv_t) inz;

       //  Transcoder handle
       dcl-ds transcoder likeds(transcoder_t) based(pTranscoder);
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       clear fromcode;
       fromcode.ccsid         = i_fromccsid;
       fromcode.conversiona   = 0;
       fromcode.substitutiona = 0;
       fromcode.shiftstatea   = 0;
       fromcode.inplenopt     = 0;
       fromcode.erroptmxddta  = 1;
       fromcode.reserved      = *allx'00';

       clear tocode;
       tocode.ccsid         = i_toccsid;
       tocode.conversiona   = 0;
       tocode.substitutiona = 0;
       tocode.shiftstatea   = 0;
       tocode.inplenopt     = 0;
       tocode.erroptmxddta  = 0;
       tocode.reserved      =   *allx'00';

       hiconv = qtqiconv_open(tocode: fromcode);
       if (hiconv.return_value = -1);
          kill('Failed to initialize character conversion': f_errno());
       endif;

       pTranscoder = %alloc(%size(transcoder));

       clear transcoder;
       transcoder.class.name = class_transcoder;
       transcoder.class.size = %size(transcoder);

       transcoder.fromccsid = i_fromccsid;
       transcoder.toccsid   = i_toccsid;
       transcoder.hiconv    = hiconv;

       htranscoder = pTranscoder;

       return htranscoder;

       end-proc;

       //=====================================================================*
       //  Translate a given buffer using dynamic memory allocation.
       //=========================================================================
       //  Parameters:
       //   i_hTranscoder - Handle of the character transcoder.
       //   i_pInBuf      - Pointer to the input buffer.
       //   i_size        - Current size of the input buffer.
       //   o_pOutBuf     - Pointer to the translated output data.
       //   o_msg         - Optional. Error message.

       //  Returns:
       //   rc            - Returns the new length of the buffer.
       //                   Sends escape message CPF9897 on error.
       //=====================================================================*
       dcl-proc transcoder_xlateraw export;
       dcl-pi *N              int(10) opdesc;
         i_htranscoder   const  like(htranscoder_t );
         i_pinbuf        pointer value;
         i_size          int(10) const;
         o_poutbuf       pointer;
       end-pi;

       //  Return value
       dcl-s rc int(10) inz(0);

       //  Helper fields
       dcl-s poutbuf    pointer;
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       checkhandle(i_htranscoder);

       o_poutbuf = *null;
       poutbuf   = *null;

       //  performTranslation() sends CPF9897 on error. For an empty
       //  input buffer it returns 0 and o_pOutBuf stays *null.
       rc = performtranslation(i_htranscoder
                               : i_pinbuf
                               : i_size
                               : poutbuf
                               : -1);

       o_poutbuf = poutbuf;

       return rc;

       end-proc;

       //=====================================================================*
       //  Translates a given buffer.
       //=========================================================================
       //  Parameters:
       //   i_hTranscoder - Handle of the character transcoder.
       //   i_pInBuf      - Pointer to the input buffer.
       //   i_size        - Current size of the input buffer.
       //   i_maxSize     - Optional. Maximum size of the input buffer.
       //   o_msg         - Optional. Error message.

       //  Returns:
       //   rc            - Returns the new length of the buffer.
       //                   Sends escape message CPF9897 on error.
       //=====================================================================*
       dcl-proc transcoder_xlatebuffer export;
       dcl-pi *N              int(10) opdesc;
         i_htranscoder   const  like(htranscoder_t );
         i_pinbuf        pointer value;
         i_size          int(10) const;
         i_maxsize       int(10) const  options(*nopass: *omit);
       end-pi;

       //  Return value
       dcl-s rc int(10) inz(0);

       //  Fields for optional parameters
       dcl-s maxsize    like(i_maxsize  );

       //  Helper fields
       dcl-s poutbuf    pointer;
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       checkhandle(i_htranscoder);

       if (%parms() >= %parmnum(i_maxsize) and %addr(i_maxsize) <> *null);
          maxsize = i_maxsize;
       else;
          maxsize = i_size;
       endif;

       poutbuf = *null;

       //  performTranslation() sends CPF9897 on error.
       rc = performtranslation(i_htranscoder
                               : i_pinbuf
                               : i_size
                               : poutbuf
                               : maxsize);

       if (rc > 0);
          memcpy(i_pinbuf: poutbuf: rc);
       endif;

       if (poutbuf <> *null);
          dealloc(n) poutbuf;
       endif;

       return rc;

       end-proc;

       //=====================================================================*
       //  Translates a given varying string.
       //=========================================================================
       //  Parameters:
       //   i_hTranscoder - Handle of the character transcoder.
       //   i_string      - Varying field containing the input data.
       //   o_msg         - Optional. Error message.

       //  Returns:
       //   string        - Varying field containing the translated data.
       //                   Sends escape message CPF9897 on error.
       //=====================================================================*
       dcl-proc transcoder_xlatestring export;
       dcl-pi *N              varchar(32767) opdesc;
         i_htranscoder   const  like(htranscoder_t );
         i_string        varchar(32767) const   options(*varsize);
       end-pi;

       //  Return value (data covers all 32767 bytes of the string)
       dcl-ds rtn qualified;
         string  varchar(32767);
         len     int(5) pos(1);
         data    char(32767) pos(3);
       end-ds;

       //  Helper fields
       dcl-s pinbuf    pointer;
       dcl-s poutbuf   pointer;
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       checkhandle(i_htranscoder);

       rtn.string = i_string;

       pinbuf  = %addr(rtn.data);
       poutbuf = *null;

       //  performTranslation() sends CPF9897 on error.
       rtn.len = performtranslation(i_htranscoder
                                    : pinbuf
                                    : %len(i_string)
                                    : poutbuf
                                    : %size(rtn.data));

       if (rtn.len > 0);
          memcpy(%addr(rtn.data): poutbuf: rtn.len);
       endif;

       if (poutbuf <> *null);
          dealloc(n) poutbuf;
       endif;

       return rtn.string;

       end-proc;

       //=====================================================================*
       //  Returns the "from CCSID".
       //=========================================================================
       //  Parameters:
       //   i_hTranscoder - Handle of the character transcoder.

       //  Returns:
       //   ccsid         - CCSID, a given buffer or string is translated from.
       //=====================================================================*
       dcl-proc transcoder_getfromccsid export;
       dcl-pi *N              int(10);
         i_htranscoder   const  like(htranscoder_t );
       end-pi;

       //  Transcoder handle
       dcl-ds transcoder likeds(transcoder_t) based(i_htranscoder);
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       checkhandle(i_htranscoder);

       return transcoder.fromccsid;

       end-proc;

       //=====================================================================*
       //  Returns the "to CCSID".
       //=========================================================================
       //  Parameters:
       //   i_hTranscoder - Handle of the character transcoder.

       //  Returns:
       //   ccsid         - CCSID, a given buffer or string is translated to.
       //=====================================================================*
       dcl-proc transcoder_gettoccsid export;
       dcl-pi *N              int(10);
         i_htranscoder   const  like(htranscoder_t );
       end-pi;

       //  Transcoder handle
       dcl-ds transcoder likeds(transcoder_t) based(i_htranscoder);
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       checkhandle(i_htranscoder);

       return transcoder.toccsid;

       end-proc;

       //=====================================================================*
       //  Terminates character translation.
       //=====================================================================*
       dcl-proc transcoder_delete export;
       dcl-pi *N;
         io_htranscoder
              like(htranscoder_t );
       end-pi;

       //  Helper fields
       dcl-s x int(10);
       dcl-s y int(10);

       //  Transcoder handle
       dcl-ds transcoder likeds(transcoder_t) based(io_htranscoder);
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       checkhandle(io_htranscoder);

       //  Remove the transcoder from the list of created transcoders,
       //  otherwise transcoder_toJobCcsid() would return the deleted
       //  handle.
       for x = 1 to g_transcoders.nume;
          if (g_transcoders.item(x).htranscoder = io_htranscoder);
             for y = x to g_transcoders.nume - 1;
                g_transcoders.item(y) = g_transcoders.item(y + 1);
             endfor;
             clear g_transcoders.item(g_transcoders.nume);
             g_transcoders.nume = g_transcoders.nume - 1;
             leave;
          endif;
       endfor;

       iconv_close(transcoder.hiconv);
       clear transcoder;

       dealloc(n) io_htranscoder;

       return;

       end-proc;

       //=====================================================================*
       //  Deletes all transcoders created by transcoder_toJobCcsid() and
       //  transcoder_toFieldCcsid() and forgets the job CCSID. Called at
       //  the start of Peek, so that a changed job CCSID (CHGJOB) is used.
       //=====================================================================*
       dcl-proc transcoder_reset export;
       dcl-pi *N;
       end-pi;

       dcl-s htranscoder like(htranscoder_t);
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       dow (g_transcoders.nume > 0);
          htranscoder = g_transcoders.item(g_transcoders.nume).htranscoder;
          transcoder_delete(htranscoder);
       enddo;

       g_jobccsid = 0;

       return;

       end-proc;

       //=====================================================================*
       //  Returns bTrue if a given Transcoder handle is NULL.
       //=====================================================================*
       dcl-proc transcoder_isnull export;
       dcl-pi *N              ind;
         i_htranscoder   const  like(htranscoder_t );
       end-pi;
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       if (i_htranscoder = transcoder_null());
          return bTrue;
       else;
          return bFalse;
       endif;

       end-proc;

       //=====================================================================*
       //  Returns a Transcoder NULL-handle.
       //=====================================================================*
       dcl-proc transcoder_null export;
       dcl-pi *N        like(htranscoder_t );
       end-pi;
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       return *null;

       end-proc;

       //=====================================================================*
       //  *** private ***
       //  Performs charcater translation. Returns the length of the
       //  transcoded buffer.
       //=====================================================================*
       dcl-proc performtranslation;
       dcl-pi *N              uns(10);
         i_htranscoder   const  like(htranscoder_t );
         i_pinbuf        pointer value;
         i_length        int(10) const;
         o_poutbuf       pointer;
         i_maxsize       int(10) const;
       end-pi;

       //  Return value
       dcl-s length          uns(10) inz;

       //  Helper fields
       dcl-s rc              uns(10) inz;
       dcl-s bytprv          uns(10) inz;
       dcl-s bytleft         uns(10) inz;
       dcl-s bufsize         int(10) inz;
       dcl-s pinbuf          pointer inz;
       dcl-s poutbuf         pointer inz;
       dcl-s extendsize      int(10) inz;
       dcl-s ismaxsize       ind inz(bFalse);
       dcl-s errnbr          int(10) inz;

       //  Transcoder handle
       dcl-ds transcoder likeds(transcoder_t) based(i_htranscoder);
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       //  Nothing to translate: %alloc(0) is not allowed (RNX0425).
       if (i_length <= 0);
          return 0;
       endif;

       bytprv    = i_length;
       bytleft   = i_length;
       bufsize   = i_length;
       pinbuf    = i_pinbuf;
       length    = 0;

       if (o_poutbuf = *null);
          o_poutbuf = %alloc(bufsize);
       endif;

       if (i_maxsize = -1);
          ismaxsize = bFalse;
       else;
          ismaxsize = bTrue;
       endif;

       p_clrerrno();
       dou (rc <> ciconv_error) or (f_errno() <> e2big_c or
            (ismaxsize and bufsize >= i_maxsize));

          if (f_errno() = e2big_c);
             if (ismaxsize and bufsize >= i_maxsize);
                leave;
             endif;
             extendsize = bytprv * 2;
             if (ismaxsize and (bufsize + extendsize) > i_maxsize);
                extendsize = i_maxsize - bufsize;
             endif;
             bufsize   = bufsize + extendsize;
             bytleft   = bytleft + extendsize;
             o_poutbuf = %realloc(o_poutbuf: bufsize);
          endif;

          poutbuf = o_poutbuf + length;
          rc = iconv(transcoder.hiconv: pinbuf: bytprv: poutbuf: bytleft);
          length = poutbuf - o_poutbuf;

       enddo;

       if (rc = ciconv_error);
          errnbr = f_errno();
          //  Release the output buffer, because the escape message
          //  skips the clean-up of the caller.
          dealloc(n) o_poutbuf;
          if (errnbr = e2big_c);
             kill('Target buffer too small to hold result': errnbr);
          else;
             kill('Failed to transcode characters': errnbr);
          endif;
       endif;

       return length;

       end-proc;

       //=====================================================================*
       //  *** private ***
       //  Returns a transcoder that matches the specified "from CCSID"
       //  from the list of created transcoders.
       //=====================================================================*
       dcl-proc findtranscoder;
       dcl-pi *N        like(htranscoder_t );
         i_toccsid       uns(10) const;
         i_fromccsid     uns(10) const;
       end-pi;

       dcl-s x int(10);
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       for x = 1 to g_transcoders.nume;
          if (i_toccsid = g_transcoders.item(x).toccsid and
              i_fromccsid = g_transcoders.item(x).fromccsid);
             return g_transcoders.item(x).htranscoder;
          endif;
       endfor;

       return transcoder_null();

       end-proc;

       //=====================================================================*
       //  *** private ***
       //  Produces a transcoder to transcode character data from
       //  and to given CCSIDs.
       //=====================================================================*
       dcl-proc createtranscoder;
       dcl-pi *N        like(htranscoder_t );
         i_toccsid       uns(10) const;
         i_fromccsid     uns(10) const;
       end-pi;

       dcl-s htranscoder like(htranscoder_t) inz;
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       if (g_transcoders.nume = %elem(g_transcoders.item));
          kill('Maximum number of transcoders reached.');
          return transcoder_null();
       endif;

       //  Count the new transcoder only after transcoder_new() succeeded.
       //  transcoder_new() sends an escape message on error, which
       //  would otherwise leave an empty entry in the list.
       htranscoder = transcoder_new(i_toccsid: i_fromccsid);

       g_transcoders.nume = g_transcoders.nume + 1;

       g_transcoders.item(g_transcoders.nume).htranscoder = htranscoder;
       g_transcoders.item(g_transcoders.nume).toccsid = i_toccsid;
       g_transcoders.item(g_transcoders.nume).fromccsid = i_fromccsid;

       return g_transcoders.item(g_transcoders.nume).htranscoder;

       end-proc;

       //=====================================================================*
       //  *** private ***
       //  Returns the CCSID of the current job.
       //=====================================================================*
       dcl-proc getjobccsid;
       dcl-pi *N              int(10);
       end-pi;

       dcl-ds jobi0400 likeds(jobi0400_t) inz;
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       if (g_jobccsid > 0);
          return g_jobccsid;
       endif;

       qusrjobi(jobi0400: %size(jobi0400): 'JOBI0400': '*': '');
       if (jobi0400.ccsid = 65535);
          g_jobccsid = jobi0400.dftccsid;
       else;
          g_jobccsid = jobi0400.ccsid;
       endif;

       return g_jobccsid;

       end-proc;

       //=====================================================================*
       //  *** private ***
       //  Kills utility with an ESCAPE message, if a given handle is not
       //  a transcoder (*null, deleted or a foreign pointer).
       //=====================================================================*
       dcl-proc checkhandle;
       dcl-pi *N;
         i_htranscoder   const  like(htranscoder_t);
       end-pi;

       //  Transcoder handle
       dcl-ds transcoder likeds(transcoder_t) based(i_htranscoder);
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       if (i_htranscoder = *null);
          kill('Invalid transcoder handle: *NULL');
       endif;

       if (transcoder.class.name <> class_transcoder);
          kill('Invalid transcoder handle');
       endif;

       end-proc;

       //=====================================================================*
       //  *** private ***
       //  Kills utility with an ESCAPE message.
       //  i_errno is optional. If passed, the message contains the
       //  error number and its text, e.g.:
       //    Failed to transcode characters (errno 3491): <text>
       //=====================================================================*
       dcl-proc kill;
       dcl-pi *N;
         i_text          varchar(128) const;
         i_errno         int(10) const  options(*nopass);
       end-pi;

       dcl-s text       varchar(512) inz;
       dcl-s msgkey     char(4) inz;
       dcl-ds qmsgf     likeds(qobj_t) inz;
       dcl-ds errcode   likeds(errcode_t) inz;
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       if (%parms() >= %parmnum(i_errno));
          text = i_text + ' (errno ' + %char(i_errno) + '): '
                 + %trimr(f_strerror(i_errno));
       else;
          text = i_text;
       endif;

       qmsgf.name = 'QCPFMSG';
       qmsgf.lib  = '*LIBL';

       clear errcode;
       errcode.bytprv = %size(errcode);

       //  Send the escape message to the caller of this service
       //  program, so that it does not pass the control boundary.
       qmhsndpm('CPF9897': qmsgf: text: %len(text): '*ESCAPE'
                : '*PGMBDY': 1: msgkey: errcode);

       end-proc;

