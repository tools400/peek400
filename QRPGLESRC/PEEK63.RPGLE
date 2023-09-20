      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 3.0.0                               *
      *  Programm : PEEK63                                            *
      *  Typ      : RPGLE                                             *
      *                                                               *
      *  erstellt : 25.01.07  Raddatz                                 *
      *  geändert :                                                   *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Peek/400 - Dateizugriffsroutinen                             *
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
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,D_CLib
      /COPY QCOPYLE,D_CLib2
      *----------------------------------------------------*
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK63
      *
      *---Nachrichten--------------------------------------*
      /COPY QCOPYLE,API_ERROR
      /COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR9994
      *----------------------------------------------------*
      *
      *---Konstanten---------------------------------------*
     D cOPER_OPEN      C                   const('*OPEN')
     D cOPER_CHAIN_RRN...
     D                 C                   const('*CHAIN_RRN')
     D cOPER_CHAIN_KEY...
     D                 C                   const('*CHAIN_KEY')
     D cOPER_SETLL_RRN...
     D                 C                   const('*SETLL_RRN')
     D cOPER_SETLL_KEY...
     D                 C                   const('*SETLL_KEY')
     D cOPER_SETGT_RRN...
     D                 C                   const('*SETGT_RRN')
     D cOPER_SETGT_KEY...
     D                 C                   const('*SETGT_KEY')
     D cOPER_READ      C                   const('*READ')
     D cOPER_READP     C                   const('*READP')
     D cOPER_CLOSE     C                   const('*CLOSE')
     D cOPER_DELETE    C                   const('*DELETE')
     D cOPER_UNLOCK    C                   const('*UNLOCK')
      *
     D cERROR_RRN      C                   const(-1)
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
     D clearErrorMsg...
     D                 PR
     D  io_hFile                                  likeds(r§hFile )
      *
     D clearBufferAndNullMap...
     D                 PR
     D  i_RFILE                            const  likeds(RFILE_t )
     D  io_rcdBuffer                              like(r§rcdBuf   )
     D  io_nullMap                                like(r§nullMap  )
     D                                            dim(§nullMapSize)
      *
     D copyInNullMap...
     D                 PR
     D  i_RFILE                            const  likeds(RFILE_t )
     D  io_nullMap                                like(r§nullMap  )
     D                                            dim(§nullMapSize)
      *
      *  Returns the value of the specified mode parameter.
     D getMode...
     D                 PR            16A          varying
     D  i_mode                      512A   value  varying
     D  i_parm                       16A   value  varying
     D  i_default                    16A   value  varying
      *
     D setEOF...
     D                 PR
     D  io_hFile                                  likeds(r§hFile )
     D  i_operation                  10A   value
      *
      *===================================================================*
      *  Opens a given file.                                   (Body)     *
      *===================================================================*
      *
     P CIO_open...
     P                 B                   Export
     D                 PI                         like(r§bool    )
     D  o_hFile                                   likeds(r§hFile )
     D  i_file                             const  like(r§file    )
     D  i_lib                              const  like(r§lib     )
     D  i_mbr                              const  like(r§mbr     )
     D  i_rcdFormat                  10A   const
     D  i_mode                         *   const  options(*string)
      *
     D fd              S               *   inz
      *
     D RFILE           DS                  likeds(RFILE_t  )
     D                                     based(fd)
     D RIOFB           DS                  likeds(RIOFB_t  )
     D                                     based(pRIOFB)
      * ------------------------------------------------------------------------
      /FREE

         p_clrErrno();

         clear o_hFile;

         monitor;
            fd = Ropen(%trim(i_lib ) + '/' +
                       %trim(i_file) + '(' +
                       %trim(i_mbr) + ')'
                       : i_mode);
            if (fd <> *NULL and i_rcdFormat <> '' and i_rcdFormat <> '*FIRST');
               Rformat(fd: %trim(i_rcdFormat));
            endif;
         on-error;
            fd = *NULL;
         endmon;

         if fd = *NULL;
            o_hFile.errno = f_errno();
            return bFalse;
         endif;

         o_hFile.fd        = fd;
         o_hFile.isOpen    = bTrue;
         o_hFile.name      = i_file;
         o_hFile.lib       = i_lib;
         o_hFile.mbr       = i_mbr;
         o_hFile.rcdFormat = i_rcdFormat;
         o_hFile.errno     = 0;
         o_hFile.lastOper  = cOPER_OPEN;
         o_hFile.arrseq    = getMode(%str(i_mode): 'arrseq': 'N');
         o_hFile.msgID     = '';
         o_hFile.msgDta    = '';

         return bTrue;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Checks whether the file identified by i_hFile is open or not.
      *===================================================================*
      *
     P CIO_isOpen...
     P                 B                   Export
     D                 PI                         like(r§bool    )
     D  i_hFile                            const  likeds(r§hFile )
      * ------------------------------------------------------------------------
      /FREE

         if i_hFile.fd = *NULL;
            return bFalse;
         endif;

         return i_hFile.isOpen;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Returns the name of the file identified by i_hFile.
      *===================================================================*
      *
     P CIO_getFile...
     P                 B                   Export
     D                 PI                         like(r§file    )
     D  i_hFile                            const  likeds(r§hFile )
      * ------------------------------------------------------------------------
      /FREE

         if CIO_isOpen(i_hFile) = bFalse;
            return '';
         endif;

         return i_hFile.name;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Returns the name of the library that contains the file
      *  identified by i_hFile.
      *===================================================================*
      *
     P CIO_getLibrary...
     P                 B                   Export
     D                 PI                         like(r§lib     )
     D  i_hFile                            const  likeds(r§hFile )
      * ------------------------------------------------------------------------
      /FREE

         if CIO_isOpen(i_hFile) = bFalse;
            return '';
         endif;

         return i_hFile.lib;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Returns the name of the member of the file identified by i_hFile.
      *===================================================================*
      *
     P CIO_getMember...
     P                 B                   Export
     D                 PI                         like(r§lib     )
     D  i_hFile                            const  likeds(r§hFile )
      * ------------------------------------------------------------------------
      /FREE

         if CIO_isOpen(i_hFile) = bFalse;
            return '';
         endif;

         return i_hFile.mbr;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Returns the name of the record format of the file identified
      *  by i_hFile.
      *===================================================================*
      *
     P CIO_getRecordFormat...
     P                 B                   Export
     D                 PI            10A
     D  i_hFile                            const  likeds(r§hFile )
      * ------------------------------------------------------------------------
      /FREE

         if CIO_isOpen(i_hFile) = bFalse;
            return '';
         endif;

         return i_hFile.rcdFormat;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Returns the record length of the file identified by i_hFile.
      *===================================================================*
      *
     P CIO_getRecordLength...
     P                 B                   Export
     D                 PI            10I 0
     D  i_hFile                            const  likeds(r§hFile )
      *
     D RFILE           DS                  likeds(RFILE_t  )
     D                                     based(i_hFile.fd)
      * ------------------------------------------------------------------------
      /FREE

         if CIO_isOpen(i_hFile) = bFalse;
            return -1;
         endif;

         return RFILE.bufLen;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Returns the record number of the current record of the file
      *  identified by i_hFile.
      *===================================================================*
      *
     P CIO_getRRN...
     P                 B                   Export
     D                 PI            10I 0
     D  i_hFile                            const  likeds(r§hFile )
      *
     D RFILE           DS                  likeds(RFILE_t  )
     D                                     based(i_hFile.fd)
     D RIOFB           DS                  likeds(RIOFB_t  )
     D                                     based(pRIOFB)
      * ------------------------------------------------------------------------
      /FREE

         if CIO_isOpen(i_hFile) = bFalse;
            return -1;
         endif;

         pRIOFB = %addr(RFILE.riofb);

         return RIOFB.rrn;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Returns the record number of the current record of the file
      *  identified by i_hFile.
      *===================================================================*
      *
     P CIO_getMbrNbr...
     P                 B                   Export
     D                 PI            10I 0
     D  i_hFile                            const  likeds(r§hFile )
      *
     D XXIOFB          DS                  likeds(XXIOFB_t )
     D                                     based(pXXIOFB)
     D XXIOFB_DB       DS                  likeds(XXIOFB_DB_t)
     D                                     based(pXXIOFB_DB)
      * ------------------------------------------------------------------------
      /FREE

         if CIO_isOpen(i_hFile) = bFalse;
            return -1;
         endif;

         pXXIOFB = Riofbk(i_hFile.fd);
         pXXIOFB_DB = pXXIOFB + %size(XXIOFB);

         return XXIOFB_DB.data_mbr_num;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Returns the file information data structure of the file
      *  identified by i_hFile.
      *===================================================================*
      *
     P CIO_getInfDS...
     P                 B                   Export
     D                 PI                         likeds(r§infds )
     D  i_hFile                            const  likeds(r§hFile )
      *
      *  Funktionswert
     D infDS           DS                  likeds(r§infds ) inz
      * ------------------------------------------------------------------------
      /FREE

         clear infDS;
         infds.open    = CIO_isOpen(i_hFile);
         infds.file    = CIO_getFile(i_hFile);
         infds.library = CIO_getLibrary(i_hFile);
         infds.rcdLen  = CIO_getRecordLength(i_hFile);
         infds.member  = CIO_getMember(i_hFile);
         infds.rcdFmt  = CIO_getRecordFormat(i_hFile);
         infds.MbrNbr  = CIO_getMbrNbr(i_hFile);
         infds.rcdNbr  = CIO_getRRN(i_hFile);

         return infDS;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Returns TRUE if the file is in error.
      *===================================================================*
      *
     P CIO_isError...
     P                 B                   Export
     D                 PI                         like(r§bool    )
     D  i_hFile                            const  likeds(r§hFile )
      * ------------------------------------------------------------------------
      /FREE

         if (i_hFile.errno <> 0 or i_hFile.msgID <> '');
            return bTrue;
         else;
            return bFalse;
         endif;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Sets an error.
      *===================================================================*
      *
     P CIO_setErrorMsg...
     P                 B                   Export
     D                 PI
     D  io_hFile                                  likeds(r§hFile )
     D  i_msgID                            const  like(r§msgID   )
     D  i_msgDta                           const  like(r§msgDta  )
      * ------------------------------------------------------------------------
      /FREE

         io_hFile.errno  = -1;
         io_hFile.msgID  = i_msgID;
         io_hFile.msgDta = i_msgDta;

         return;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Gets the current error message.
      *===================================================================*
      *
     P CIO_getErrorMsg...
     P                 B                   Export
     D                 PI
     D  i_hFile                            const  likeds(r§hFile )
     D  o_msgID                                   like(r§msgID   )
     D  o_msgDta                                  like(r§msgDta  )
      *
      /COPY QCOPYLE,USR0012                      ?
      * ------------------------------------------------------------------------
      /FREE

         if (i_hFile.msgID <> '');
            o_msgID  = i_hFile.msgID;
            o_msgDta = i_hFile.msgDta;
         else;
            clear USR0012;
            USR00121 = CIO_getErrorText(i_hFile);
            USR00122 = CIO_getError(i_hFile);
            o_msgID  = 'USR0012';
            o_msgDta = USR0012;
         endif;

         return;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Returns the latest error number associated to file i_hFile.
      *===================================================================*
      *
     P CIO_getError...
     P                 B                   Export
     D                 PI            10I 0
     D  i_hFile                            const  likeds(r§hFile )
      * ------------------------------------------------------------------------
      /FREE

         return i_hFile.errno;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Returns the latest error text associated to file i_hFile.
      *===================================================================*
      *
     P CIO_getErrorText...
     P                 B                   Export
     D                 PI           512A          varying
     D  i_hFile                            const  likeds(r§hFile )
      * ------------------------------------------------------------------------
      /FREE

         if (i_hFile.msgID <> '');
            return f_msgText(i_hFile.msgID: i_hFile.msgDta);
         else;
            return %trimR(f_strError(i_hFile.errno));
         endif;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Reads the record identified by i_rrn from a given file.
      *===================================================================*
      *
     P CIO_chainWithRRN...
     P                 B                   Export
     D                 PI                         like(r§bool     )
     D  io_hFile                                  likeds(r§hFile  )
     D  i_rrn                              const  like(r§rcdNbr   )
     D  i_doLock                           const  like(r§bool     )
     D  io_rcdBuffer                              like(r§rcdBuf   )
     D  io_nullMap                                like(r§nullMap  )
     D                                            dim(§nullMapSize)
      *
     D options         S             10I 0 inz(DFT)
      *
     D RFILE           DS                  likeds(RFILE_t  )
     D                                     based(io_hFile.fd)
      *
     D RIOFB           DS                  likeds(RIOFB_t  )
     D                                     based(pRIOFB)
      * ------------------------------------------------------------------------
      /FREE

         p_clrErrno();
         clearErrorMsg(io_hFile);

         clearBufferAndNullMap(RFILE: io_rcdBuffer: io_nullMap);

         if i_doLock = bTrue;
            options = DFT;
         else;
            options = NO_LOCK;
         endif;

         pRIOFB = Rreadd(io_hFile.fd
                         : %addr(io_rcdBuffer): %size(io_rcdBuffer)
                         : options: i_rrn);
         if RIOFB.numByt <> RFILE.bufLen;
            io_hFile.errno = f_errno();
            return bFalse;
         endif;

         copyInNullMap(RFILE: io_nullMap);

         io_hFile.lastOper = cOPER_CHAIN_RRN;
         io_hFile.errno = 0;

         return bTrue;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Reads the record identified by i_key from a given file.
      *===================================================================*
      *
     P CIO_chainWithKey...
     P                 B                   Export
     D                 PI                         like(r§bool     )
     D  io_hFile                                  likeds(r§hFile  )
     D  i_key                              const  like(r§keyBuf   )
     D  i_doLock                           const  like(r§bool     )
     D  io_rcdBuffer                              like(r§rcdBuf   )
     D  io_nullMap                                like(r§nullMap  )
     D                                            dim(§nullMapSize)
      *
     D options         S             10I 0 inz(DFT)
     D key             S                   like(i_key      ) inz
     D keyLen          S             10I 0                   inz
      *
     D RFILE           DS                  likeds(RFILE_t  )
     D                                     based(io_hFile.fd)
      *
     D RIOFB           DS                  likeds(RIOFB_t  )
     D                                     based(pRIOFB)
      * ------------------------------------------------------------------------
      /FREE

         p_clrErrno();
         clearErrorMsg(io_hFile);

         clearBufferAndNullMap(RFILE: io_rcdBuffer: io_nullMap);

         if i_doLock = bTrue;
            options = f_bitor(DFT: KEY_EQ);
         else;
            options = f_bitor(NO_LOCK: KEY_EQ);
         endif;

         key    = i_key;
         keyLen = %len(key);

         pRIOFB = Rreadk(io_hFile.fd
                         : %addr(io_rcdBuffer): %size(io_rcdBuffer)
                         : options: %addr(key): keyLen);
         if (RIOFB.numByt <> RFILE.bufLen) or (RIOFB.numByt = EOF);
            io_hFile.errno = f_errno();
            return bFalse;
         endif;

         copyInNullMap(RFILE: io_nullMap);

         io_hFile.lastOper = cOPER_CHAIN_KEY;
         io_hFile.errno = 0;

         return bTrue;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Positions the file right before the record identifed by i_rrn.
      *===================================================================*
      *
     P CIO_setllWithRRN...
     P                 B                   Export
     D                 PI                         like(r§bool     )
     D  io_hFile                                  likeds(r§hFile  )
     D  i_rrn                              const  like(r§rcdNbr   )
      *
     D errorNbr        S             10I 0 inz
     D options         S             10U 0 inz
      *
     D RFILE           DS                  likeds(RFILE_t  )
     D                                     based(io_hFile.fd)
      *
     D RIOFB           DS                  likeds(RIOFB_t  )
     D                                     based(pRIOFB)
      * ------------------------------------------------------------------------
      /FREE

         clearErrorMsg(io_hFile);

         //?Setzen Datenzeiger auf angegebene Satznummer
         //?(auch auf gelöschte Datensatze)
         options = f_bitor(RRN_EQ: NO_LOCK);

         p_clrErrno();
         pRIOFB = Rlocate(io_hFile.fd: *NULL: i_rrn: options);

         select;
         when RIOFB.numByt = 0;   //?Datensatz nicht vorhanden
            p_clrErrno();
            pRIOFB = Rreadn(io_hFile.fd : *NULL: 0: NO_LOCK);
            errorNbr = f_errno();
         when RIOFB.numByt = 1;   //?Datensatz vorhanden
            p_clrErrno();
            pRIOFB = Rreads(io_hFile.fd : *NULL: 0: NO_LOCK);
            errorNbr = f_errno();
            if RIOFB.numByt = 0 and errorNbr = EIORECERR_C;   //?wahrscheinlich ein
                                                              //?gelöschter Datensatz
               p_clrErrno();
               pRIOFB = Rreadn(io_hFile.fd : *NULL: 0: NO_LOCK);
            endif;
         endsl;

         //?Datensatz nicht vorhanden, also ans Ende der Datei positionieren
         if RIOFB.numByt = 0;
            options = f_bitor(END  : NO_LOCK);
            p_clrErrno();
            pRIOFB = Rlocate(io_hFile.fd: *NULL: i_rrn: options);
         endif;

         if RIOFB.numByt = EOF;
            io_hFile.errno = f_errno();   //?"End of File" erreicht
            return bFalse;
         endif;

         if RIOFB.numByt <> RFILE.bufLen;
            io_hFile.errno = f_errno();
            return bFalse;
         endif;

         io_hFile.lastOper = cOPER_SETLL_RRN;
         io_hFile.errno = 0;

         return bTrue;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Positions the file right before the record identifed by i_key.
      *===================================================================*
      *
     P CIO_setllWithKey...
     P                 B                   Export
     D                 PI                         like(r§bool     )
     D  io_hFile                                  likeds(r§hFile  )
     D  i_key                              const  like(r§keyBuf   )
      *
     D options         S             10U 0 inz
     D key             S                   like(i_key      ) inz
     D keyLen          S             10I 0                   inz
      *
     D RFILE           DS                  likeds(RFILE_t  )
     D                                     based(io_hFile.fd)
      *
     D RIOFB           DS                  likeds(RIOFB_t  )
     D                                     based(pRIOFB)
      * ------------------------------------------------------------------------
      /FREE

         p_clrErrno();
         clearErrorMsg(io_hFile);

         //?Setzen Datenzeiger auf angegebenen Schlüssel
         key    = i_key;
         keyLen = %len(key);

         options = f_bitor(KEY_GE: PRIOR: DATA_ONLY);

         pRIOFB = Rlocate(io_hFile.fd: %addr(key): keyLen: options);
         if (RIOFB.numByt = 0) or (RIOFB.numByt = EOF);
            options = f_bitor(START: DATA_ONLY);
            pRIOFB = Rlocate(io_hFile.fd: %addr(key): keyLen: options);
         endif;

         if (RIOFB.numByt = 0); //? or (RIOFB.numByt = EOF);
            io_hFile.errno = f_errno();   //?Fehler bei _Rlocate() aufgetreten
            return bFalse;
         endif;

         io_hFile.lastOper = cOPER_SETLL_KEY;
         io_hFile.errno = 0;

         return bTrue;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Positions the file right after the record identifed by i_rrn.
      *===================================================================*
      *
     P CIO_setgtWithRRN...
     P                 B                   Export
     D                 PI                         like(r§bool     )
     D  io_hFile                                  likeds(r§hFile  )
     D  i_rrn                              const  like(r§rcdNbr   )
      *
     D options         S             10U 0 inz
      *
     D RFILE           DS                  likeds(RFILE_t  )
     D                                     based(io_hFile.fd)
      *
     D RIOFB           DS                  likeds(RIOFB_t  )
     D                                     based(pRIOFB)
      * ------------------------------------------------------------------------
      /FREE

         p_clrErrno();
         clearErrorMsg(io_hFile);

         //?Setzen Datenzeiger auf angegebene Satznummer
         //?(auch auf gelöschte Datensatze)
         options = f_bitor(RRN_EQ: NO_LOCK);

         pRIOFB = Rlocate(io_hFile.fd: *NULL: i_rrn: options);
         if RIOFB.numByt = 0;
            options = f_bitor(END: NO_LOCK);
            pRIOFB = Rlocate(io_hFile.fd: *NULL: i_rrn: options);
         endif;

         if RIOFB.numByt = 0;
            io_hFile.errno = f_errno();   //?Fehler bei _Rlocate() aufgetreten
            return bFalse;
         endif;

         if RIOFB.numByt = EOF;
            io_hFile.errno = f_errno();   //?"End of File" erreicht
            return bFalse;
         endif;

         //?Einlesen Datensatz
         pRIOFB = Rreads(io_hFile.fd : *NULL: 0: NO_LOCK);
         if RIOFB.numByt = 0 and f_errno() = EIORECERR_C;   //?wahrscheinlich ein
                                                            //?gelöschter Datensatz
            pRIOFB = Rreadn(io_hFile.fd : *NULL: 0: NO_LOCK);
         endif;

         if RIOFB.numByt <> RFILE.bufLen;
            io_hFile.errno = f_errno();
            return bFalse;
         endif;

         io_hFile.lastOper = cOPER_SETGT_RRN;
         io_hFile.errno = 0;

         return bTrue;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Positions the file right after the record identifed by i_key.
      *===================================================================*
      *
     P CIO_setgtWithKey...
     P                 B                   Export
     D                 PI                         like(r§bool     )
     D  io_hFile                                  likeds(r§hFile  )
     D  i_key                              const  like(r§keyBuf   )
      *
     D options         S             10U 0 inz
     D key             S                   like(i_key      ) inz
     D keyLen          S             10I 0                   inz
      *
     D RFILE           DS                  likeds(RFILE_t  )
     D                                     based(io_hFile.fd)
      *
     D RIOFB           DS                  likeds(RIOFB_t  )
     D                                     based(pRIOFB)
      * ------------------------------------------------------------------------
      /FREE

         p_clrErrno();
         clearErrorMsg(io_hFile);

         //?Setzen Datenzeiger auf angegebenen Schlüssel
         key    = i_key;
         keyLen = %len(key);

         options = f_bitor(KEY_GT: PRIOR: DATA_ONLY);

         pRIOFB = Rlocate(io_hFile.fd: %addr(key): keyLen: options);
         if (RIOFB.numByt = 0) or (RIOFB.numByt = EOF);
            options = f_bitor(END: DATA_ONLY);
            pRIOFB = Rlocate(io_hFile.fd: %addr(key): keyLen: options);
         endif;

         if (RIOFB.numByt = 0); //? or (RIOFB.numByt = EOF);
            io_hFile.errno = f_errno();   //?Fehler bei _Rlocate() aufgetreten
            return bFalse;
         endif;

         io_hFile.lastOper = cOPER_SETGT_KEY;
         io_hFile.errno = 0;

         return bTrue;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Returns the next record from the file.
      *===================================================================*
      *
     P CIO_read...
     P                 B                   Export
     D                 PI                         like(r§bool     )
     D  io_hFile                                  likeds(r§hFile  )
     D  i_doLock                           const  like(r§bool     )
     D  io_rcdBuffer                              like(r§rcdBuf   )
     D  io_nullMap                                like(r§nullMap  )
     D                                            dim(§nullMapSize)
      *
     D options         S             10I 0 inz(DFT)
     D function        S             32A   varying           inz
     D msgID           S                   like(r§msgID    ) inz
     D msgDta          S                   like(r§msgDta   ) inz
      *
     D RFILE           DS                  likeds(RFILE_t  )
     D                                     based(io_hFile.fd)
      *
     D RIOFB           DS                  likeds(RIOFB_t  )
     D                                     based(pRIOFB)
      * ------------------------------------------------------------------------
      /FREE

         p_clrErrno();
         clearErrorMsg(io_hFile);

         clearBufferAndNullMap(RFILE: io_rcdBuffer: io_nullMap);

         if i_doLock = bTrue;
            options = DFT;
         else;
            options = NO_LOCK;
         endif;

         if (io_hFile.lastOper = cOPER_SETLL_RRN) or
            (io_hFile.lastOper = cOPER_SETGT_RRN);
            //?(io_hFile.lastOper = cOPER_SETLL_KEY) or
            //?(io_hFile.lastOper = cOPER_SETGT_KEY);
            function = '_Rreads';
            pRIOFB = Rreads(io_hFile.fd
                            : %addr(io_rcdBuffer): %size(io_rcdBuffer)
                            : options);
         else;
            function = '_Rreadn';
            pRIOFB = Rreadn(io_hFile.fd
                            : %addr(io_rcdBuffer): %size(io_rcdBuffer)
                            : options);
         endif;

         io_hFile.errno = f_errno();

         if (io_hFile.errno <> 0);
            clear USR9994;
            USR99941 = f_errno();
            USR99942 = function;
            USR99943 = f_strerror(f_errno());
            msgID  = 'USR9994';
            msgDta = USR9994;
            p_sndPgmMg(msgID: msgDta: '*': §TypDiag);
            return bTrue;   // Return "EOF" to caller
         endif;

         select;
         when RIOFB.numByt = EOF;
            io_hFile.lastOper = cOPER_READ;
            io_hFile.errno = 0;
            return bTrue;   // Return "EOF" to caller
         endsl;

         copyInNullMap(RFILE: io_nullMap);
         io_hFile.lastOper = cOPER_READ;
         io_hFile.errno = 0;

         return bFalse;  // Return "found" to caller

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Returns the previous record from the file.
      *===================================================================*
      *
     P CIO_readp...
     P                 B                   Export
     D                 PI                         like(r§bool     )
     D  io_hFile                                  likeds(r§hFile  )
     D  i_doLock                           const  like(r§bool     )
     D  io_rcdBuffer                              like(r§rcdBuf   )
     D  io_nullMap                                like(r§nullMap  )
     D                                            dim(§nullMapSize)
      *
     D options         S             10I 0 inz(DFT)
     D function        S             32A   varying           inz
     D msgID           S                   like(r§msgID    ) inz
     D msgDta          S                   like(r§msgDta   ) inz
      *
     D RFILE           DS                  likeds(RFILE_t  )
     D                                     based(io_hFile.fd)
      *
     D RIOFB           DS                  likeds(RIOFB_t  )
     D                                     based(pRIOFB)
      * ------------------------------------------------------------------------
      /FREE

         p_clrErrno();
         clearErrorMsg(io_hFile);

         clearBufferAndNullMap(RFILE: io_rcdBuffer: io_nullMap);

         if i_doLock = bTrue;
            options = DFT;
         else;
            options = NO_LOCK;
         endif;

         if (io_hFile.lastOper = cOPER_SETLL_RRN) or
            (io_hFile.lastOper = cOPER_SETGT_RRN);
            //?(io_hFile.lastOper = cOPER_SETLL_KEY) or
            //?(io_hFile.lastOper = cOPER_SETGT_KEY);
            function = '_Rreads';
            pRIOFB = Rreads(io_hFile.fd
                            : %addr(io_rcdBuffer): %size(io_rcdBuffer)
                            : options);
         else;
            function = '_Rreadp';
            pRIOFB = Rreadp(io_hFile.fd
                            : %addr(io_rcdBuffer): %size(io_rcdBuffer)
                            : options);
         endif;

         io_hFile.errno = f_errno();

         if (io_hFile.errno <> 0);
            clear USR9994;
            USR99941 = f_errno();
            USR99942 = function;
            USR99943 = f_strerror(f_errno());
            msgID  = 'USR9994';
            msgDta = USR9994;
            p_sndPgmMg(msgID: msgDta: '*': §TypDiag);
            return bTRUE;   // Return "EOF" to caller
         endif;


         select;
         when RIOFB.numByt = EOF;
            io_hFile.lastOper = cOPER_READP;
            io_hFile.errno = 0;
            return bTrue;   // Return "EOF" to caller
         endsl;

         copyInNullMap(RFILE: io_nullMap);
         io_hFile.lastOper = cOPER_READP;
         io_hFile.errno = 0;

         return bFalse;  // Return "found" to caller

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Deletes the record that is currently locked for update.
      *===================================================================*
      *
     P CIO_delete...
     P                 B                   Export
     D                 PI                         like(r§bool     )
     D  io_hFile                                  likeds(r§hFile  )
      *
     D RFILE           DS                  likeds(RFILE_t  )
     D                                     based(io_hFile.fd)
      *
     D RIOFB           DS                  likeds(RIOFB_t  )
     D                                     based(pRIOFB)
      * ------------------------------------------------------------------------
      /FREE

         p_clrErrno();
         clearErrorMsg(io_hFile);

         pRIOFB = Rdelete(io_hFile.fd);
         if RIOFB.numByt = 0;
            io_hFile.errno = f_errno();
            return bFalse;
         endif;

         io_hFile.lastOper = cOPER_DELETE;
         io_hFile.errno = 0;

         return bTrue;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Releases the lock on the currently locked record.
      *===================================================================*
      *
     P CIO_unlock...
     P                 B                   Export
     D                 PI                         like(r§bool     )
     D  io_hFile                                  likeds(r§hFile  )
      *
     D RFILE           DS                  likeds(RFILE_t  )
     D                                     based(io_hFile.fd)
      *
     D rc              S             10I 0 inz
      * ------------------------------------------------------------------------
      /FREE

         p_clrErrno();
         clearErrorMsg(io_hFile);

         rc = Rrlslck(io_hFile.fd);
         if (rc = 0);
            io_hFile.errno = f_errno();
            return bFalse;
         endif;

         io_hFile.lastOper = cOPER_UNLOCK;
         io_hFile.errno = 0;

         return bTrue;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Closes the file identifed by io_hFile.
      *===================================================================*
      *
     P CIO_close...
     P                 B                   Export
     D                 PI                         like(r§bool    )
     D  io_hFile                                  likeds(r§hFile )
      * ------------------------------------------------------------------------
      /FREE

         p_clrErrno();
         clearErrorMsg(io_hFile);

         if Rclose(io_hFile.fd) <> 0;
            io_hFile.errno = f_errno();
            return bFalse;
         endif;

         clear io_hFile;
         io_hFile.isOpen = bFalse;
         io_hFile.lastOper = cOPER_CLOSE;
         io_hFile.errno = 0;

         return bTrue;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Sets the EOF indicator for a READ operation.
      *  === Used by SQL_nextRow() ===
      *===================================================================*
      *
     P CIO_setEOF_read...
     P                 B                   Export
     D                 PI
     D  io_hFile                                  likeds(r§hFile )
      * ------------------------------------------------------------------------
      /FREE

         setEOF(io_hFile: cOPER_READ);

         return;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Sets the EOF indicator for a READP operation.
      *  === Used by SQL_previousRow() ===
      *===================================================================*
      *
     P CIO_setEOF_readp...
     P                 B                   Export
     D                 PI
     D  io_hFile                                  likeds(r§hFile )
      * ------------------------------------------------------------------------
      /FREE

         setEOF(io_hFile: cOPER_READP);

         return;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  *** private ***
      *  Sets the EOF indicator for a READ or READP operation.
      *===================================================================*
      *
     P setEOF...
     P                 B
     D                 PI
     D  io_hFile                                  likeds(r§hFile )
     D  i_operation                  10A   value
      *
     D RFILE           DS                  likeds(RFILE_t  )
     D                                     based(io_hFile.fd)
      *
     D RIOFB           DS                  likeds(RIOFB_t  )
     D                                     based(pRIOFB)
      * ------------------------------------------------------------------------
      /FREE

         pRIOFB = %addr(RFILE.RIOFB);

         io_hFile.lastOper = i_operation;
         io_hFile.errno = 0;

         RIOFB.rrn    = 0;
         RIOFB.numByt = EOF;

         return;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  *** private ***
      *  Clears the error information.
      *===================================================================*
      *
     P clearErrorMsg...
     P                 B
     D                 PI
     D  io_hFile                                  likeds(r§hFile )
      * ------------------------------------------------------------------------
      /FREE

         io_hFile.errno  = 0;
         io_hFile.msgID  = '';
         io_hFile.msgDta = '';

         return;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  *** private ***
      *  Clears the file IO-buffer and NULL-map.
      *===================================================================*
      *
     P clearBufferAndNullMap...
     P                 B
     D                 PI
     D  i_RFILE                            const  likeds(RFILE_t )
     D  io_rcdBuffer                              like(r§rcdBuf   )
     D  io_nullMap                                like(r§nullMap  )
     D                                            dim(§nullMapSize)
      *
     D X               S             10I 0 inz
      * ------------------------------------------------------------------------
      /FREE

         %subst(io_rcdBuffer: 1: i_RFILE.bufLen) = '';

         for x = 1 to i_RFILE.nMapLen;
            io_nullMap(x) = 0;   //?setzen auf "nicht NULL"
         endfor;

         return;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  *** private ***
      *  Copies the file IN-NULL-map.
      *===================================================================*
      *
     P copyInNullMap...
     P                 B
     D                 PI
     D  i_RFILE                            const  likeds(RFILE_t )
     D  io_nullMap                                like(r§nullMap  )
     D                                            dim(§nullMapSize)
      *
     D X               S             10I 0 inz
     D inNullMap       S              1S 0 dim(§nullMapSize)
     D                                     based(i_RFILE.pInNull)
      * ------------------------------------------------------------------------
      /FREE

         for x = 1 to i_RFILE.nMapLen;
            io_nullMap(x) = inNullMap(x);
         endfor;

         return;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  *** private ***
      *  Returns the value of the specified mode parameter.
      *===================================================================*
      *
     P getMode...
     P                 B
     D                 PI            16A          varying
     D  i_mode                      512A   value  varying
     D  i_parm                       16A   value  varying
     D  i_default                    16A   value  varying
      *
      *  Local fields
     D x               S             10I 0 inz
     D y               S             10I 0 inz
      * ------------------------------------------------------------------------
      /FREE

         i_mode    = %trim(i_mode   );
         i_parm    = %trim(i_parm   );
         i_default = %trim(i_default);

         x = %scan(i_parm + '=': i_mode);
         if x = 0;
            return i_default;
         endif;

         x = x + %len(i_parm) + 1;

         y = %scan(' ': i_mode: x);
         if y = 0;
            return %subst(i_mode: x);
         endif;

         return %subst(i_mode: x: y-1-x);

      /END-FREE
     P                 E
      *
