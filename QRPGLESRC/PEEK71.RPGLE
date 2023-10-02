      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 3.3.0                               *
      *  Programm : PEEK071                                           *
      *  Typ      : RPGLE                                             *
      *                                                               *
      *  erstellt : 27.03.2012   Thomas Raddatz                       *
      *  geändert :                                                   *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Peek/400 - Character Translation Services                    *
      *                                                               *
      *===============================================================*
      * >>PRE-COMPILER<<                                              *
      *   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
      *                           OBJLIB(&LI) DEVLIB(&LI) +           *
      *                           SBMJOB(*NO) BNDDIR(PEEK) +          *
      *                           INSTALL(*NO);                       *
      *   >>EXECUTE<<                                                 *
      * >>END-PRE-COMPILER<<                                          *
      *===============================================================*
     H NOMAIN
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
      * ------------------------------------
      *  Constants
      * ------------------------------------
      *
      *  ERROR return code
     D cERROR          C                   -1
      *
      *  Transcoder handle identifier
     D CLASS_TRANSCODER...
     D                 C                   '*CLASS:ccsid.TRANSCODER'
      *
      * ------------------------------------
      *  Type Definitions
      * ------------------------------------
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      *
      *  Transcoder handle
     D transcoder_t...
     D                 DS                  qualified               based(pDummy)
     D  class                              likeds(class_t )
     D  fromCcsid                    10U 0
     D  toCcsid                      10U 0
     D  hIconv                             likeds(iconv_t )
      *
     D class_t...
     D                 DS                  qualified               based(pDummy)
     D  name                               like(className_t )
     D  size                         10I 0
     D  reserved                     12A
      *
     D className_t...
     D                 S             62A   varying                 based(pDummy)
      *
      * ------------------------------------
      *  Exported prototypes
      * ------------------------------------
      /COPY QCOPYLE,F_PEEK71
      *
      * ------------------------------------
      *  Imported prototypes
      * ------------------------------------
      /COPY QCOPYLE,D_CLIB                         C-Runtime Library
      /COPY QCOPYLE,F_PEEK53                       Zugriff auf Benutzerdaten
      /COPY QCOPYLE,F_PEEK58                       Allgemeine Routinen
      /COPY QCOPYLE,QUSRJOBI                       Retrieve Job Information (QUSRJOBI) API
      *
      * ------------------------------------
      *  Internal prototypes
      * ------------------------------------
      *
      *  Performs charcater translation.
     D performTranslation...
     D                 PR            10U 0
     D                                     extproc('performTranslation')
     D  i_hTranscoder                      const  like(hTranscoder_t )
     D  i_pInBuf                       *   value
     D  i_length                     10I 0 const
     D  o_pTo                          *
     D  i_maxSize                    10I 0 const
      *
      *  Returns a transcoder that matches the specified "from CCSID"
      *  from the list of created transcoders.
     D findTranscoder...
     D                 PR                         like(hTranscoder_t )
     D                                     extproc('findTranscoder')
     D  i_toCcsid                    10U 0 const
     D  i_fromCcsid                  10U 0 const
      *
      *  Produces a transcoder to transcode character data from
      *  and to given CCSIDs.
     D createTranscoder...
     D                 PR                         like(hTranscoder_t )
     D                                     extproc('createTranscoder')
     D  i_toCcsid                    10U 0 const
     D  i_fromCcsid                  10U 0 const
      *
      *  Kills utility with an ESCAPE message.
     D kill...
     D                 PR
     D                                     extproc('kill')
     D  i_text                      128A   const  varying
      *
      *  Returns the CCSID of the current job.
     D getJobCcsid...
     D                 PR            10I 0
     D                                     extproc('getJobCcsid')
      *
      * ------------------------------------
      *  Global fields & constants
      * ------------------------------------
     D g_jobCcsid      S             10U 0 inz(0)
      *
     D g_transcoders   DS                  qualified
     D  numE                         10I 0 inz
     D  item                               likeds(transcoderE_t ) dim(64) inz
      *
     D transcoderE_t   DS                  qualified
     D  hTranscoder                        like(hTranscoder_t )
     D  toCcsid                      10I 0
     D  fromCcsid                    10I 0
      *
      *=====================================================================*
      *  Returns a Transcoder to convert from a
      *  given CCSID to the job CCSID.
      *=====================================================================*
     P Transcoder_toJobCcsid...
     P                 B                   export
     D                 PI                         like(hTranscoder_t )
     D  i_fromCcsid                  10U 0 const
      *
      *  Return value
     D hTranscoder     S                   like(hTranscoder_t ) inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         hTranscoder = findTranscoder(getJobCcsid(): i_fromCcsid);
         if (Transcoder_isNull(hTranscoder));
            hTranscoder = createTranscoder(getJobCcsid(): i_fromCcsid);
         endif;

         return hTranscoder;

      /END-FREE
     P                 E
      *
      *=====================================================================*
      *  Returns a Transcoder to convert from a
      *  given CCSID to the file field CCSID.
      *=====================================================================*
     P Transcoder_toFieldCcsid...
     P                 B                   export
     D                 PI                         like(hTranscoder_t )
     D  i_toCcsid                    10U 0 const
      *
      *  Return value
     D hTranscoder     S                   like(hTranscoder_t ) inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         hTranscoder = findTranscoder(i_toCcsid: getJobCcsid());
         if (Transcoder_isNull(hTranscoder));
            hTranscoder = createTranscoder(i_toccsid: getJobCcsid());
         endif;

         return hTranscoder;

      /END-FREE
     P                 E
      *
      *=====================================================================*
      *  Initializes character translation.
      *=====================================================================*
     P Transcoder_new...
     P                 B                   export
     D                 PI                         like(hTranscoder_t )
     D  i_toCcsid                    10U 0 const
     D  i_fromCcsid                  10U 0 const
      *
      *  Return value
     D hTranscoder     S                   like(hTranscoder_t ) inz
      *
      *  Helper fields
     D toCode          DS                  likeds(QtqCode_t   ) inz
     D fromCode        DS                  likeds(QtqCode_t   ) inz
     D hIconv          DS                  likeds(iconv_t     ) inz
      *
      *  Transcoder handle
     D transcoder      DS                  likeds(transcoder_t )
     D                                     based(pTranscoder)
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         clear fromCode;
         fromCode.ccsid         = i_fromCcsid;
         fromCode.conversionA   = 0;
         fromCode.substitutionA = 0;
         fromCode.shiftStateA   = 0;
         fromCode.inpLenOpt     = 0;
         fromCode.errOptMxdDta  = 1;
         fromCode.reserved      = *ALLx'00';

         clear toCode;
         toCode.ccsid         = i_toCcsid;
         toCode.conversionA   = 0;
         toCode.substitutionA = 0;
         toCode.shiftStateA   = 0;
         toCode.inpLenOpt     = 0;
         toCode.errOptMxdDta  = 0;
         toCode.reserved      =   *ALLx'00';

         hIconv = QtqIconv_open(toCode: fromCode);
         if (hIconv.return_value = -1);
            kill('Failed to initialize character: ' +
                  f_strerror(f_errno()));
         endif;

         pTranscoder = %alloc(%size(transcoder));

         clear transcoder;
         transcoder.class.name = CLASS_TRANSCODER;
         transcoder.class.size = %size(transcoder);

         transcoder.fromCcsid = i_fromCcsid;
         transcoder.toCcsid   = i_toCcsid;
         transcoder.hIconv    = hIconv;

         hTranscoder = pTranscoder;

         return hTranscoder;

      /END-FREE
     P                 E
      *
      *=====================================================================*
      *  Translate a given buffer using dynamic memory allocation.
      *=========================================================================
      *  Parameters:
      *   i_hTranscoder - Handle of the character transcoder.
      *   i_pInBuf      - Pointer to the input buffer.
      *   i_size        - Current size of the input buffer.
      *   o_pOutBuf     - Pointer to the translated output data.
      *   o_msg         - Optional. Error message.
      *
      *  Returns:
      *   rc            - Returns the new length of the buffer on
      *                   success, else -1.
      *=====================================================================*
     P Transcoder_xlateRaw...
     P                 B                   export
     D                 PI            10I 0 opdesc
     D  i_hTranscoder                      const  like(hTranscoder_t )
     D  i_pInBuf                       *   value
     D  i_size                       10I 0 const
     D  o_pOutBuf                      *
      *
      *  Return value
     D rc              S             10I 0 inz(cERROR)
      *
      *  Helper fields
     D tRc             S             10U 0 inz
     D pOutBuf         S               *   inz
      *
      *  Transcoder handle
     D transcoder      DS                  likeds(transcoder_t )
     D                                     based(i_hTranscoder)
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         o_pOutBuf = *NULL;
         pOutBuf   = *NULL;

         tRc = performTranslation(i_hTranscoder
                                  : i_pInBuf
                                  : i_size
                                  : pOutBuf
                                  : -1);

         if (tRc = cICONV_ERROR);
            rc = cERROR;
         else;
            rc = tRc;
            o_pOutBuf = pOutBuf;
         endif;

         return rc;

      /END-FREE
     P                 E
      *
      *=====================================================================*
      *  Translates a given buffer.
      *=========================================================================
      *  Parameters:
      *   i_hTranscoder - Handle of the character transcoder.
      *   i_pInBuf      - Pointer to the input buffer.
      *   i_size        - Current size of the input buffer.
      *   i_maxSize     - Optional. Maximum size of the input buffer.
      *   o_msg         - Optional. Error message.
      *
      *  Returns:
      *   rc            - Returns the new length of the buffer on
      *                   success, else -1.
      *=====================================================================*
     P Transcoder_xlateBuffer...
     P                 B                   export
     D                 PI            10I 0 opdesc
     D  i_hTranscoder                      const  like(hTranscoder_t )
     D  i_pInBuf                       *   value
     D  i_size                       10I 0 const
     D  i_maxSize                    10I 0 const  options(*nopass: *omit)
      *
      *  Return value
     D rc              S             10I 0 inz(cERROR)
      *
      *  Parameter positions
     D p_maxSize       C                   4
      *
      *  Fields for optional parameters
     D maxSize         S                   like(i_maxSize  ) inz
      *
      *  Helper fields
     D tRc             S             10U 0 inz
     D pOutBuf         S               *   inz
      *
      *  Transcoder handle
     D transcoder      DS                  likeds(transcoder_t )
     D                                     based(i_hTranscoder)
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         if (%parms() >= p_maxSize and %addr(i_maxSize) <> *NULL);
            maxSize = i_maxSize;
         else;
            maxSize = i_size;
         endif;

         pOutBuf = *NULL;

         tRc = performTranslation(i_hTranscoder
                                  : i_pInBuf
                                  : i_size
                                  : pOutBuf
                                  : maxSize);

         if (tRc = cICONV_ERROR);
            rc = cERROR;
         else;
            rc = tRc;
            memcpy(i_pInBuf: pOutBuf: rc);
         endif;

         if (pOutBuf <> *NULL);
            dealloc(N) pOutBuf;
         endif;

         return rc;

      /END-FREE
     P                 E
      *
      *=====================================================================*
      *  Translates a given varying string.
      *=========================================================================
      *  Parameters:
      *   i_hTranscoder - Handle of the character transcoder.
      *   i_string      - Varying field containing the input data.
      *   o_msg         - Optional. Error message.
      *
      *  Returns:
      *   string        - Varying field containing the translated data on
      *                   success, else an empty string.
      *=====================================================================*
     P Transcoder_xlateString...
     P                 B                   export
     D                 PI         32767A   opdesc varying
     D  i_hTranscoder                      const  like(hTranscoder_t )
     D  i_string                  32767A   const  varying options(*varsize)
      *
      *  Return value
     D rtn             DS                  qualified
     D  string                    32767A   varying
     D  len                    1      2I 0
     D  data                   3  32767A
      *
      *  Helper fields
     D tRc             S             10U 0 inz
     D pInBuf          S               *   inz
     D pOutBuf         S               *   inz
      *
      *  Transcoder handle
     D transcoder      DS                  likeds(transcoder_t )
     D                                     based(i_hTranscoder)
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         rtn.string = i_string;

         pInBuf  = %addr(rtn.data);
         pOutBuf = *NULL;

         tRc = performTranslation(i_hTranscoder
                                  : pInBuf
                                  : %len(i_string)
                                  : pOutBuf
                                  : %size(rtn.data));

         if (tRc = cICONV_ERROR);
            rtn.len = 0;
         else;
            rtn.len = tRc;
            memcpy(%addr(rtn.data): pOutBuf: rtn.len);
         endif;

         if (pOutBuf <> *NULL);
            dealloc(N) pOutBuf;
         endif;

         return rtn.string;

      /END-FREE
     P                 E
      *
      *=====================================================================*
      *  Returns the "from CCSID".
      *=========================================================================
      *  Parameters:
      *   i_hTranscoder - Handle of the character transcoder.
      *
      *  Returns:
      *   ccsid         - CCSID, a given buffer or string is translated from.
      *=====================================================================*
     P Transcoder_getFromCcsid...
     P                 B                   export
     D                 PI            10I 0
     D  i_hTranscoder                      const  like(hTranscoder_t )
      *
      *  Transcoder handle
     D transcoder      DS                  likeds(transcoder_t )
     D                                     based(i_hTranscoder)
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         return transcoder.fromCcsid;

      /END-FREE
     P                 E
      *
      *=====================================================================*
      *  Returns the "to CCSID".
      *=========================================================================
      *  Parameters:
      *   i_hTranscoder - Handle of the character transcoder.
      *
      *  Returns:
      *   ccsid         - CCSID, a given buffer or string is translated to.
      *=====================================================================*
     P Transcoder_getToCcsid...
     P                 B                   export
     D                 PI            10I 0
     D  i_hTranscoder                      const  like(hTranscoder_t )
      *
      *  Transcoder handle
     D transcoder      DS                  likeds(transcoder_t )
     D                                     based(i_hTranscoder)
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         return transcoder.toCcsid;

      /END-FREE
     P                 E
      *
      *=====================================================================*
      *  Terminates character translation.
      *=====================================================================*
     P Transcoder_delete...
     P                 B                   export
     D                 PI
     D  io_hTranscoder...
     D                                            like(hTranscoder_t )
      *
      *  Helper fields
      *
      *  Transcoder handle
     D transcoder      DS                  likeds(transcoder_t )
     D                                     based(io_hTranscoder)
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         iconv_close(transcoder.hIconv);
         clear transcoder;

         dealloc(N) io_hTranscoder;

         return;

      /END-FREE
     P                 E
      *
      *=====================================================================*
      *  Returns bTrue if a given Transcoder handle is NULL.
      *=====================================================================*
     P Transcoder_isNull...
     P                 B                   export
     D                 PI              N
     D  i_hTranscoder                      const  like(hTranscoder_t )
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         if (i_hTranscoder = Transcoder_null());
            return bTrue;
         else;
            return bFalse;
         endif;

      /END-FREE
     P                 E
      *
      *=====================================================================*
      *  Returns a Transcoder NULL-handle.
      *=====================================================================*
     P Transcoder_null...
     P                 B                   export
     D                 PI                         like(hTranscoder_t )
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         return *NULL;

      /END-FREE
     P                 E
      *
      *=====================================================================*
      *  *** private ***
      *  Performs charcater translation. Returns the length of the
      *  transcoded buffer.
      *=====================================================================*
     P performTranslation...
     P                 B
     D                 PI            10U 0
     D  i_hTranscoder                      const  like(hTranscoder_t )
     D  i_pInBuf                       *   value
     D  i_length                     10I 0 const
     D  o_pOutBuf                      *
     D  i_maxSize                    10I 0 const
      *
      *  Return value
     D length          S             10U 0 inz
      *
      *  Helper fields
     D rc              S             10U 0 inz
     D bytPrv          S             10U 0 inz
     D bytLeft         S             10U 0 inz
     D bufSize         S             10I 0 inz
     D pInBuf          S               *   inz
     D pOutBuf         S               *   inz
     D inpBuf          S          32767A   based(i_pInBuf)
     D extendSize      S             10I 0 inz
     D isMaxSize       S               N   inz(bFalse)
      *
      * No restriction of maximum buffer size
     D MAX_SIZE        C                   -1
      *
      *  Transcoder handle
     D transcoder      DS                  likeds(transcoder_t )
     D                                     based(i_hTranscoder)
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         bytPrv    = i_length;
         bytLeft   = i_length;
         bufSize   = i_length;
         pInBuf    = i_pInBuf;
         length    = 0;

         if (o_pOutBuf = *NULL);
            o_pOutBuf = %alloc(bufSize);
         endif;

         if (i_maxSize = -1);
            isMaxSize = bFalse;
         else;
            isMaxSize = bTrue;
         endif;

         p_clrErrno();
         dou (rc <> cICONV_ERROR) or (f_errno() <> E2BIG_C or
              (isMaxSize and bufSize >= i_maxSize));

            if (f_errno() = E2BIG_C);
               if (isMaxSize and bufSize >= i_maxSize);
                  leave;
               endif;
               extendSize = bytPrv * 2;
               if (MAX_SIZE > 0 and extendSize > MAX_SIZE);
                  extendSize = MAX_SIZE - bufSize;
               endif;
               if (isMaxSize and (bufSize + extendSize) > i_maxSize);
                  extendSize = i_maxSize - bufSize;
               endif;
               bufSize   = bufSize + extendSize;
               bytLeft   = bytLeft + extendSize;
               o_pOutBuf = %realloc(o_pOutBuf: bufSize);
            endif;

            pOutBuf = o_pOutBuf + length;
            rc = iconv(transcoder.hIconv: pInBuf: bytPrv: pOutBuf: bytLeft);
            length = pOutBuf - o_pOutBuf;

         enddo;

         if (rc = cICONV_ERROR);
            length = rc;
            if (f_errno() = E2BIG_C);
               kill('Target buffer too small to hold result.');
            else;
               kill('Failed to transcode characters: ' +
                    f_strerror(f_errno()));
            endif;
         endif;

         return length;

      /END-FREE
     P                 E
      *
      *=====================================================================*
      *  *** private ***
      *  Returns a transcoder that matches the specified "from CCSID"
      *  from the list of created transcoders.
      *=====================================================================*
     P findTranscoder...
     P                 B
     D                 PI                         like(hTranscoder_t )
     D  i_toCcsid                    10U 0 const
     D  i_fromCcsid                  10U 0 const
      *
     D x               S             10I 0 inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         for x = 1 to g_transcoders.numE;
            if (i_toCcsid = g_transcoders.item(x).toCcsid and
                i_fromCcsid = g_transcoders.item(x).fromCcsid);
               return g_transcoders.item(x).hTranscoder;
            endif;
         endfor;

         return Transcoder_null();

      /END-FREE
     P                 E
      *
      *=====================================================================*
      *  *** private ***
      *  Produces a transcoder to transcode character data from
      *  and to given CCSIDs.
      *=====================================================================*
     P createTranscoder...
     P                 B
     D                 PI                         like(hTranscoder_t )
     D  i_toCcsid                    10U 0 const
     D  i_fromCcsid                  10U 0 const
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         if (g_transcoders.numE = %elem(g_transcoders.item));
            kill('Maximum number of transcoders reached.');
            return Transcoder_null();
         endif;

         g_transcoders.numE = g_transcoders.numE + 1;

         g_transcoders.item(g_transcoders.numE).hTranscoder =
                  Transcoder_new(i_toCcsid: i_fromCcsid);
         g_transcoders.item(g_transcoders.numE).toCcsid =
                  i_toCcsid;
         g_transcoders.item(g_transcoders.numE).fromCcsid =
                  i_fromCcsid;

         return g_transcoders.item(g_transcoders.numE).hTranscoder;

      /END-FREE
     P                 E
      *
      *=====================================================================*
      *  *** private ***
      *  Returns the CCSID of the current job.
      *=====================================================================*
     P getJobCcsid...
     P                 B
     D                 PI            10I 0
      *
     D jobi0400        DS                  likeds(jobi0400_t)
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         if (g_jobCcsid > 0);
            return g_jobCcsid;
         endif;

         QUSRJOBI(jobi0400: %size(jobi0400): 'JOBI0400': '*': '');
         if (jobi0400.ccsid = 65535);
            g_jobCcsid = jobi0400.dftCcsid;
         else;
            g_jobCcsid = jobi0400.ccsid;
         endif;

         return g_jobCcsid;

      /END-FREE
     P                 E
      *
      *=====================================================================*
      *  *** private ***
      *  Kills utility with an ESCAPE message.
      *=====================================================================*
     P kill...
     P                 B
     D                 PI
     D  i_text                      128A   const  varying
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE


      /END-FREE
     P                 E
      *
