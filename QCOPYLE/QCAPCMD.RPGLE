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
dcl-c cQCAPCMD_prc_exc_qcmdexc 0;
dcl-c cQCAPCMD_prc_chk_qcmdchk 1;
dcl-c cQCAPCMD_prc_exc_cmdline 2;
dcl-c cQCAPCMD_prc_chk_cmdline 3;
dcl-c cQCAPCMD_prc_chk_cl_stmt 4;
dcl-c cQCAPCMD_prc_chk_seu_cl 5;
dcl-c cQCAPCMD_prc_chk_seu_cmd 6;
dcl-c cQCAPCMD_prc_chk_seu_bnd 7;
dcl-c cQCAPCMD_prc_chk_udo 8;
dcl-c cQCAPCMD_prc_chk_seu_clle 9;

//  DBCS data handling.
//  Whether the command analyzer should handle the SO/SI
//  characters as DBCS delimiters.
dcl-c cQCAPCMD_dbcs_ignore '0';
dcl-c cQCAPCMD_dbcs_handle '1';

//  Prompter action.
//  Indicates whether the prompter should be called on a command string.
dcl-c cQCAPCMD_prompt_never '0';
dcl-c cQCAPCMD_prompt_always '1';
dcl-c cQCAPCMD_prompt_selective '2';
dcl-c cQCAPCMD_prompt_help '3';

//  Command string syntax.
//  Whether command processing should be done in i5/OS mode or System/38 mode.
dcl-c cQCAPCMD_syntax_system '0';
dcl-c cQCAPCMD_syntax_system38 '1';

//  CCSID of command string.
dcl-c cQCAPCMD_ccsid_job 0;
dcl-c cQCAPCMD_ccsid_utf8 1208;
dcl-c cQCAPCMD_ccsid_utf16 1200;

/endif
