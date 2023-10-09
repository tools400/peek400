       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 1.4.0                               *
       //  Programm : PEEK02                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 26.09.96  RADDATZ                                 *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Dokumentation:                                               *
       //                                                               *
       //  Abrufen einer Satzformatbeschreibung über API's              *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  INPUT-Parameter:                                             *
       //  ================                                             *
       //                                                               *
       //  xQFile  - Qualified file name                                *
       //             1 - 10:  file                                     *
       //            11 - 20:  library                                  *
       //                                                               *
       //  xRFmt   - Record format name                                 *
       //                                                               *
       //  xOption - control of modul function                          *
       //     *CREATE  - create list of database relations   CREATE     *
       //     *READ    - get next entry                      READ       *
       //     *DELETE  - delete list                         DELETE     *
       //                                                               *
       //  OUTPUT-Parameter:                                            *
       //  =================                                            *
       //                                                               *
       //  xAnz    - number of entry (depedencies)                      *
       //            parameter is supported using xOption=1 (create)    *
       //                                                               *
       //  xRcdFmtID - record format id                                 *
       //            parameter is supported using xOption=1 (create)    *
       //                                                               *
       //  xListE  - list entry                                         *
       //            parameter is supported using xOption=5 (read)      *
       //            (must be splitted using a data structure)          *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Typical call sequence:                                       *
       //                                                               *
       //      PEEK02 - Funktion (1)       create list                  *
       //                                                               *
       //  1   DO  xAnz                                                 *
       //      PEEK02 - Funktion (5)       read next entry              *
       //      ENDDO                                                    *
       //                                                               *
       //      PEEK02 - Funktion (4)       delete list (user space)     *
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
       ctl-opt main(peek02);
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,GENHEADER
      /COPY QCOPYLE,QUSCRTUS
      /COPY QCOPYLE,QUSPTRUS
      /COPY QCOPYLE,QUSLFLD

      /define internal_prototype
      /COPY QCOPYLE,PPEEK02
      /undefine internal_prototype

      /COPY QCOPYLE,PPEEK53
      /COPY QCOPYLE,PPEEK58

       dcl-ds qusrspc likeds(qobj_t) inz;
       dcl-s pspcptr         pointer;
       dcl-ds errcode likeds(errcode_t) inz;

       dcl-ds genheader likeds(genheader_t) based(pspcptr);

       dcl-s currliste       like(int4_t);
       dcl-s offsetliste     like(int4_t);
       dcl-s pliste          pointer;
       dcl-ds liste likeds(fldl0100_t) based(pliste);

       dcl-s msgid           like(msgid_t);
       dcl-s msgdta          like(msgdta_t);

       //*******************************************************************
       //           Main  Control block                                    *
       //*******************************************************************

       dcl-proc peek02;
       dcl-pi *N;
         i_qfile         const likeds(qobj_t);
       i_rcdfmt        const like(fmt_t);
       i_function      const like(function_t);
       o_nume          like(int4_t);
       o_fldl0100      likeds(fldl0100_t);
       o_rcdfmtid      like(fmtid_t);
       end-pi;

       //---------------------------------------------------*

       qusrspc.lib = usrspc_library;
       qusrspc.name = usrspc_name;

       monitor;

          select;
          when (i_function = '*CREATE');
             exsr create;
          when (i_function = '*DELETE');
             exsr delete;
          when (i_function = '*READ');
             exsr read;
          endsl;

       on-error;
          dump;
          o_nume = 0;
       endmon;

       //====================================================*
       //  Create --  create user space and get database rel.*
       //====================================================*

       begsr create;

          o_nume = *zeros;

          //  create user space
          if (not f_exist(
             qusrspc.name: qusrspc.lib: '*USRSPC'));
             quscrtus(qusrspc: 'TEMP': 32767: x'00'
                     : '*ALL': 'Peek/400 - Work Area');
          endif;

          //  get user space pointer
          qusptrus(qusrspc: pspcptr);

          //  get file fields
          quslfld(qusrspc: 'FLDL0100': i_qfile
                 : i_rcdfmt: '0': errcode);

          if (errcode.bytavl > 0);
             o_nume = 0;
             currliste = -1;
          else;
             o_nume = genheader.numlstent;
             currliste = 0;
          endif;

       endsr;

       //====================================================*
       //  Delete --  Delete user space                      *
       //====================================================*

       begsr delete;

          if (f_exist(
             qusrspc.name: qusrspc.lib: '*USRSPC'));

             f_execute('DLTUSRSPC USRSPC(' +
                        %trim(qusrspc.lib) + '/' +
                        %trim(qusrspc.name) +
                      ')': msgid: msgdta);
          endif;

       endsr;

       //====================================================*
       //  Read   --  Read next entry                        *
       //====================================================*

       begsr read;

          clear o_fldl0100;

          if (currliste < 0 or
             currliste >= genheader.numlstent);
             exsr seterror;
             leavesr;
          endif;

          currliste = currliste + 1;

          offsetliste =
           genheader.offsetlst +
           ((currliste - 1) * genheader.entrysize);

          pliste = pspcptr + offsetliste;

          o_fldl0100 = liste;

          o_nume = genheader.numlstent - currliste;

       endsr;

       //====================================================*
       //  Set error condition                               *
       //====================================================*

       begsr seterror;

          o_nume = 0;
          currliste = -1;

       endsr;

       end-proc;

