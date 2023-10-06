       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 1.4.0                               *
       //  Programm : PEEK46                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 11.12.98  RADDATZ                                 *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Dokumentation:                                               *
       //                                                               *
       //  Peek/400 - Ermitteln Teildateiliste                          *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  INPUT-Parameter:                                             *
       //  ================                                             *
       //                                                               *
       //  XQFILE  - Qualified file name                                *
       //             1 - 10:  file                                     *
       //            11 - 20:  library                                  *
       //                                                               *
       //  XRFMT   - Record format name                                 *
       //                                                               *
       //  XFUNK   - control of modul function                          *
       //     *CREATE  - create list of database relations   CREATE     *
       //     *READ    - get next entry                      READ       *
       //     *DELETE  - delete list                         DELETE     *
       //                                                               *
       //  OUTPUT-Parameter:                                            *
       //  =================                                            *
       //                                                               *
       //  XANZ    - number of entry (depedencies)                      *
       //            parameter is supported using XFUNK=1   (create)    *
       //                                                               *
       //  XLIST   - entry                                              *
       //            parameter is supported using XFUNK=5   (read)      *
       //            (must be splitted using a data structure)          *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Typical call sequence:                                       *
       //                                                               *
       //      PEEK46 - Funktion (*CREATE) create list                  *
       //                                                               *
       //  1   DO  XANZ                                                 *
       //      PEEK46 - Funktion (*READ)   read next entry              *
       //      ENDDO                                                    *
       //                                                               *
       //      PEEK46 - Funktion (*DELETE) delete list (user space)     *
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
       ctl-opt main(peek46);
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,MBRL0200
      /COPY QCOPYLE,GENHEADER
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,QUSLMBR
      /COPY QCOPYLE,QUSCRTUS
      /COPY QCOPYLE,QUSPTRUS

      /define internal_prototype
      /COPY QCOPYLE,PPEEK46
      /undefine internal_prototype

      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58

       dcl-ds qusrspc likeds(qobj_t);
       dcl-s pspcptr  pointer;
       dcl-ds errcode likeds(errcode_t) inz;

       //  Organisation of generic header
       dcl-ds genheader likeds(genheader_t) based(pspcptr);

       //  List data
       dcl-s currliste       like(int4_t);
       dcl-s offsetliste     like(int4_t);
       dcl-s pliste          pointer;
       dcl-ds liste likeds(mbrl0200_t) based(pliste);

       dcl-s msgid           like(msgid_t);
       dcl-s msgdta          like(msgdta_t);

       //*******************************************************************
       //           Main  Control block                                    *
       //*******************************************************************

       dcl-proc peek46;
       dcl-pi *N;
         i_qfile         const likeds(qobj_t);
         i_mbr           const like(mbr_t);
         i_function      const like(function_t);
         o_nume          like(int4_t);
         o_mbrl0200      likeds(mbrl0200_t);
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

          //  get file member list
          quslmbr(qusrspc: 'MBRL0200'
                 : i_qfile: i_mbr: '0': errcode);

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

          if (f_exist(qusrspc.name: qusrspc.lib: '*USRSPC'));
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

          clear o_mbrl0200;

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

          o_mbrl0200 = liste;

          o_nume = genheader.numlstent - currliste;

       endsr;

       //====================================================*
       //  Set error condition                               *
       //====================================================*

       begsr seterror;

          o_nume = 0;

       endsr;

       end-proc;

