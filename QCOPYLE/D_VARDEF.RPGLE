**FREE
/IF NOT DEFINED(D_VARDEF)
/DEFINE D_VARDEF
//===============================================================*
//    Deklaration von Variablengrundtypen & Konstanten           *
//===============================================================*

//  Referenzfelder:
dcl-s release_t       char(17) template;
dcl-s version_t       char(9) template;
dcl-s commitlvl_t     char(9) template;
dcl-s choice_t        char(75) template;
dcl-s headertype_t    char(10) template;
dcl-s attr_t          char(10) template;
dcl-s attrtype_t      char(1) template;
dcl-s attrvalue_t     char(512) template;
dcl-s datatype_t      char(1) template;
dcl-s accmode_t       char(1) template;
dcl-s bool_t          ind template;
dcl-s cmdbuffer_t     char(32702) template;
dcl-s copyrght_t      like(msgdta_t) template;
dcl-s dsp80_t         like(bool_t) template;
dcl-s fieldnme_t      char(10) template;
dcl-s file_t          char(10) template;
dcl-s fkeydsp_t       char(18) template;
dcl-s fmt_t           char(10) template;
dcl-s fmtid_t         char(13) template;
dcl-s headtyp_t       char(10) template;

dcl-s hexbuf_t        char(65532) template;

dcl-s keybuf_t        char(2000) template;
dcl-c KEY_BUFF_LEN    const(2000);

dcl-s lib_t           char(10) template;
dcl-s mbr_t           char(10) template;
dcl-s mbrnbr_t        int(10) template;
dcl-s rcdfmt_t        char(10) template;
dcl-s text_t          char(50) template;
dcl-s colheading_t    varchar(128) template;

dcl-ds rcdfmtinf_t qualified template;
  name            like(rcdfmt_t);
  id              like(fmtid_t);
end-ds;

dcl-s mod_t           char(10) template;
dcl-s msgdta_t        char(512) template;
dcl-s msgid_t         char(7) template;
dcl-s msgtype_t       char(10) template;

dcl-s function_t      char(10) template;
dcl-s option_t        char(10) template;
dcl-s mode_t          char(10) template;
dcl-s type_t          char(10) template;
dcl-s operation_t     char(10) template;
dcl-s argument_t      char(63) template;
dcl-s sign_t          char(1) template;
dcl-s srchnbrs_t      packed(10) template;
dcl-s format_t        char(10) template;
dcl-s color_t         char(1) template;
dcl-s language_t      char(10) template;
dcl-s prefix_t        char(10) template;
dcl-s buffer_t        char(1024) template;
dcl-s smallbuffer_t   char(128) template;
dcl-s keys_t          char(3) template;
dcl-s sfpau_t         char(2) template;

dcl-s pgm_t           char(10) template;
dcl-s pgmcalln_t      char(21) template;
dcl-s pgmcmd_t        char(10) template;
dcl-s pgmcmddt_t      char(256) template;
dcl-s proc_t          char(256) template;
dcl-s rcdbuf_t        char(32766) template;
dcl-s rcdbufucs2_t    ucs2(16383) template;
dcl-s string_t        char(32767) template;
dcl-s varString_t     varchar(2048) template;

dcl-ds rcdbuffer_t qualified template;
  sbcs            char(32766);
  ucs2            ucs2(16383) overlay(sbcs);
end-ds;
dcl-c RCD_BUFF_LEN const(32766);

dcl-s rcdnbr_t        int(10) template;
dcl-s nullmap_t       zoned(1) dim(NULL_MAP_SIZE);
dcl-c NULL_MAP_SIZE   const(8000);

dcl-s scnaid_t        char(10) template;
dcl-s sqlSelect_t     char(512) template;
dcl-s sqlOrder_t      char(512) template;
dcl-s sqlWhere_t      char(512) template;
dcl-s sqlStmt_t       char(2000) template;
dcl-s user_t          char(10) template;

dcl-ds qobj_t qualified template;
  name            char(10);
  lib             char(10);
end-ds;

dcl-ds errcode_t qualified template;
  bytprv          int(10);
  bytavl          int(10);
  excid           char(7);
  errres_01       char(1);
  excdta          char(256);
end-ds;

//  Feldinhalt für Text-/Hex-Editor
dcl-ds fldinhalt_t qualified template;
  sbcs            like(rcdbuf_t);
  ucs2            like(rcdbufucs2_t) overlay(sbcs);
end-ds;

//  Verwaltung gepinnter Datensätze
dcl-ds pintabr_t qualified template;
  rcdnbr              int(10);
  file                char(10);
  lib                 char(10);
  mbr                 char(10);
  rcdfmt              char(10);
  mbrnbr              int(10);
end-ds;

//  Integer & Binärwerte:
dcl-s int1_t          int(3) template;
dcl-s int2_t          int(5) template;
dcl-s int4_t          int(10) template;
dcl-s uint4_t         uns(10) template;

//  Lower/Upper case:
dcl-c C_LOWER          'abcdefghijklmnopqrstuvwxyzäöüß';
dcl-c C_UPPER          'ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜß';

dcl-c NUMERIC_DIGITS  '1234567890';

//  Grenzen für relative Satznummer
dcl-c LOW_RCD_NBR     1;
dcl-c HIGH_RCD_NBR    2147483647;

//  Access mode:
dcl-s accessmode_t    char(1) template;

dcl-c RRN_SEQ         '0';
dcl-c KEY_SEQ         '1';
dcl-c SQL_SEQ         '2';

//  Key-Input-Mode:
dcl-c KEY_MODE_LOWER  '1';
dcl-c KEY_MODE_UPPER  '0';

//  Update-Mode:
dcl-c UPD_M_DFT       '*';
dcl-c UPD_M_YES       '1';
dcl-c UPD_M_NOKEY     '2';
dcl-c UPD_M_NO        '0';

//  Boolsche Werte:
dcl-c bTrue           *on;
dcl-c bFalse          *off;
dcl-c bNotDef         '-';
dcl-c bEOF            *on;

//  Zustellarten von Nachrichten:
dcl-c MSG_T_INFO      '*INFO';
dcl-c MSG_T_INQ       '*INQ';
dcl-c MSG_T_RQS       '*RQS';
dcl-c MSG_T_COMP      '*COMP';
dcl-c MSG_T_DIAG      '*DIAG';
dcl-c MSG_T_NOTIFY    '*NOTIFY';
dcl-c MSG_T_ESCAPE    '*ESCAPE';
dcl-c MSG_T_STATUS    '*STATUS';

//  Modus:
dcl-c MODE_BATCH      '*BATCH';
dcl-c MODE_INTER      '*INTER';

dcl-c USRSPC_NAME        '§PEEK§';
dcl-c USRSPC_LIBRARY     'QTEMP';

dcl-c WORK_FILE_NAME     'PEEKWRK';
dcl-c WORK_FILE_LIBRARY  'QTEMP';
dcl-c WORK_FILE_MEMBER   '*FIRST';

/ENDIF
