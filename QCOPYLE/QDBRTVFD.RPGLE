**FREE
/IF NOT DEFINED(QDBRTVFD)
/DEFINE QDBRTVFD
//
//  Retrieve Database File Description (QDBRTVFD) API
dcl-pr qdbrtvfd
       extpgm('QDBRTVFD');
  o_rcvvar        char(65535) options(*varsize);
  i_lenrcvvar     int(10) const;
  o_retfilename   char(20);
  i_format        char(8) const;
  i_qfile         char(20) const;
  i_rcdformat     char(10) const;
  i_override      char(1) const;
  i_system        char(10) const;
  i_formattype    char(10) const;
  io_errcode      char(65535) options(*varsize );
end-pr;
//
//  File Definition Header (Qdb_Qdbfh)
dcl-ds qdb_qdbfh_t qualified template;
  qdbfyret        int(10) pos(1);
  qdbfyavl        int(10) pos(5);
  qdbfhflg        uns(5) pos(9);
  qdbfhflgh       char(1) overlay(qdbfhflg:1);
  qdbfhflgl       char(1) overlay(qdbfhflg:2);
  reserved_7      char(4) pos(11);
  qdbflbnum       int(5) pos(15);
  qdbfknum        int(5) pos(17);
  qdbfkmxl        int(5) pos(19);
  qdbfkflg        char(1) pos(21);
  qdbfkfdm        char(1) pos(22);
  reserved_10     char(8) pos(23);
  qdbfhaut        char(10) pos(31);
  qdbfhupl        char(1) pos(41);
  qdbfhmxm        int(5) pos(42);
  qdbfwtfi        int(5) pos(44);
  qdbfhfrt        int(5) pos(46);
  qdbfhmnum       int(5) pos(48);
  qdbfapsize      int(5) pos(50);
  reserved_11     char(7) pos(52);
  qdbfbrwt        int(5) pos(59);
  qaaf            char(1) pos(61);
  qdbffmtnum      int(5) pos(62);
  qdbfhfl2        char(2) pos(64);
  qdbfvrm         int(5) pos(66);
  qaaf2           char(2) pos(68);
  qaaf2h          char(1) overlay(qaaf2: 1);
  qaaf2l          char(1) overlay(qaaf2: 2);
  qdbfhcrt        char(13) pos(70);
  reserved_18     char(2) pos(83);
  qdbfhtxt        char(50) pos(85);
  reserved_19     char(13) pos(135);
  qdbfsrcf        char(10) pos(148);
  qdbfsrcm        char(10) pos(158);
  qdbfsrcl        char(10) pos(168);
  qdbfkrcv        char(1) pos(178);
  reserved_20     char(23) pos(179);
  qdbftcid        int(5) pos(202);
  qdbfasp         int(5) pos(204);
  qdbfnbit        char(1) pos(206);
  qdbfmxfnum      int(5) pos(207);
  reserved_22     char(76) pos(209);
  qdbfodic        int(10) pos(285);
  reserved_23     char(14) pos(289);
  qdbffigl        int(5) pos(303);
  qdbfmxrl        int(5) pos(305);
  reserved_24     char(8) pos(307);
  qdbfgkct        int(5) pos(315);
  qdbfos          int(10) pos(317);
  reserved_25     char(8) pos(321);
  qdbfocs         int(10) pos(329);
  reserved_26     char(4) pos(333);
  qdbfpact        char(2) pos(337);
  qdbfhrls        char(6) pos(339);
  reserved_27     char(20) pos(345);
  qdbpfof         int(10) pos(365);
  qdblfof         int(10) pos(369);
  qdbfnlsb        char(1) pos(373);
  qdbflang        char(3) pos(374);
  qdbfcnty        char(2) pos(377);
  qdbfjorn        int(10) pos(379);
  qdbfevid        int(10) pos(383);
  reserved_28     char(14) pos(387);
end-ds;
//
//  Format Definition Header (Qdb_Qddfmt)
dcl-ds qdb_qddfmt_t qualified template;
  bytret          int(10);
  bytavl          int(10);
  reserved_62     char(24);
  qddfmtf         char(1);
  qddfxlto        int(10);
  qddfrcao        int(10);
  qddfdico        int(10);
  qddfrcid        int(5);
  qddfsrcd        int(5);
  qddfrtcd        int(5);
  qddfrlcd        int(5);
  reserved_64     char(7);
  qddftflgs       char(1);
  qddflgs         uns(3);
  reserved_67     char(4);
  qddfrlen        int(10);
  qddfname        char(10);
  qddfseq         char(13);
  qddftext        char(50);
  qddffldnum      int(5);
  qddf_identity_off
  int(10) pos(146);
end-ds;
// Qddffldx                    CHAR(*)   Start of field definition array (Qdb_Qddffld)
//
//  File Scope Array (Qdb_Qdbfb)
dcl-ds qdb_qdbfb_t qualified template;
  reserved_48     char(48);
  qdbfbf          char(10);
  qdbfbfl         char(10);
  qdbft           char(10);
  reserved_49     char(37);
  qdbfbgky        int(5);
  reserved_50     char(2);
  qdbfblky        int(5);
  reserved_51     char(2);
  qdbffogl        int(5);
  reserved_52     char(3);
  qdbfsoon        int(5);
  qdbfsoof        int(10);
  qdbfksof        int(10);
  qdbfkyct        int(5);
  qdbfgenf        int(5);
  qdbfodis        int(10);
  reserved_53     char(15) pos(146);
end-ds;
//
//  Key Specification Array (Qdb_Qdbfk)
dcl-ds qdb_qdbfk_t qualified template;
  qdbfkfld        char(10);
  reserved_59     char(3);
  qdbfksq         char(1);
  reserved_61     char(18);
end-ds;
//
//  Logical File Specific Attributes (Qdb_Qdbflogl)
dcl-ds qdb_qdbflogl_t qualified template;
  qdbfoj          int(10);
  qdbfscsn        int(5);
  qdbflxp         char(10);
  qdbflxl         char(10);
  qdbfovw         int(10);
  qlfa            char(1);
  qdbfjtyp        char(1);
  qdbfsrcd        int(5);
  qdbfwchk        char(1);
  reserved_38     char(13);
end-ds;
//
//  Select/Omit Specification Array (Qdb_Qdbfss)
dcl-ds qdb_qdbfss_t qualified template;
  reserved54      char(2);
  qdbfssso        char(1);
  qdbfssop        char(2);
  qdbfssfn        char(10);
  qdbfsspnum      int(5);
  qsosaf          char(2);
  qdbfssfj        int(5) pos(19);
  reserved56      char(8);
  qdbfsoso        int(10);
end-ds;
//
//  Select/Omit Parameters (Qdb_Qdbfsp)
dcl-ds qdb_qdbfsp_t qualified template;
  qdbfspno        int(10);
  qdbfspln        int(5);
  qdbfspin        char(1);
  qasopaf         char(1);
  qdbfsppj        int(5);
  reserved58      char(10);
  qdbfspvl        char(32);
end-ds;
//
/ENDIF
