**free
/if not defined(QCAPCMD)
/define QCAPCMD

//  Process Commands (QCAPCMD) API
dcl-pr qcapcmd extpgm('QCAPCMD');
  i_cmd         char(32702) options(*varsize) const;
  i_cmdLen      int(10) const;
  i_ctrlBlk     char(32767) options(*varsize) const;
  i_ctrlBlkLen  int(10) const;
  i_ctrlBlkFmt  char(8) const;
  o_chgCmd      char(32702) options(*varsize);
  i_chgCmdLnPrv int(10) const;
  o_chgCmdLnAvl int(10);
  io_errorCode  char(32767) options(*varsize);
end-pr;

//  Option control block
dcl-ds cpop0100_t qualified template;
  typeCmdPrc   int(10);
  dbcs_data    char(1);
  prmtAction   char(1);
  cmdStrSyntax char(1);
  msgRtvKey    char(4);
  res_01       char(9);
end-ds;

//  Type of command processing.
//  The type of command processing to be performed by the system.
dcl-c cQCAPCMD_PRC_EXC_QCMDEXC 0;
dcl-c cQCAPCMD_PRC_CHK_QCMDCHK 1;
dcl-c cQCAPCMD_PRC_EXC_CMDLINE 2;
dcl-c cQCAPCMD_PRC_CHK_CMDLINE 3;
dcl-c cQCAPCMD_PRC_CHK_CL_STMT 4;
dcl-c cQCAPCMD_PRC_CHK_SEU_CL 5;
dcl-c cQCAPCMD_PRC_CHK_SEU_CMD 6;
dcl-c cQCAPCMD_PRC_CHK_SEU_BND 7;
dcl-c cQCAPCMD_PRC_CHK_UDO 8;
dcl-c cQCAPCMD_PRC_CHK_SEU_CLLE 9;

//  DBCS data handling.
//  Whether the command analyzer should handle the SO/SI
//  characters as DBCS delimiters.
dcl-c cQCAPCMD_DBCS_IGNORE '0';
dcl-c cQCAPCMD_DBCS_HANDLE '1';

//  Prompter action.
//  Indicates whether the prompter should be called on a command string.
dcl-c cQCAPCMD_PROMPT_NEVER '0';
dcl-c cQCAPCMD_PROMPT_ALWAYS '1';
dcl-c cQCAPCMD_PROMPT_SELECTIVE '2';
dcl-c cQCAPCMD_PROMPT_HELP '3';

//  Command string syntax.
//  Whether command processing should be done in i5/OS mode or System/38 mode.
dcl-c cQCAPCMD_SYNTAX_SYSTEM '0';
dcl-c cQCAPCMD_SYNTAX_SYSTEM38 '1';

//  CCSID of command string.
dcl-c cQCAPCMD_CCSID_JOB 0;
dcl-c cQCAPCMD_CCSID_UTF8 1208;
dcl-c cQCAPCMD_CCSID_UTF16 1200;

/endif
