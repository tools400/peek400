      /if not defined(QCAPCMD)
      /define QCAPCMD
      *
      *  Process Commands (QCAPCMD) API
     d QCAPCMD...
     d                 pr                         extpgm('QCAPCMD')
     d  i_cmd                     32702A   const  options(*varsize)
     d  i_cmdLen                     10i 0 const
     d  i_ctrlBlk                 32767A   const  options(*varsize)
     d  i_ctrlBlkLen                 10i 0 const
     d  i_ctrlBlkFmt                  8a   const
     d  o_chgCmd                  32702A          options(*varsize)
     d  i_chgCmdLnPrv                10i 0 const
     d  o_chgCmdLnAvl                10i 0
     d  io_errorCode              32767A          options(*varsize)
      *
      *  Option control block
     d cpop0100_t      ds                  qualified template
     d  typeCmdPrc             1      4I 0
     d  DBCS_data              5      5A
     d  prmtAction             6      6A
     d  cmdStrSyntax           7      7A
     d  msgRtvKey              8     11A
     d  res_01                12     20A
      *
      *  Type of command processing.
      *  The type of command processing to be performed by the system.
     d cQCAPCMD_PRC_EXC_QCMDEXC...
     d                 c                   0
     d cQCAPCMD_PRC_CHK_QCMDCHK...
     d                 c                   1
     d cQCAPCMD_PRC_EXC_CMDLINE...
     d                 c                   2
     d cQCAPCMD_PRC_CHK_CMDLINE...
     d                 c                   3
     d cQCAPCMD_PRC_CHK_CL_STMT...
     d                 c                   4
     d cQCAPCMD_PRC_CHK_SEU_CL...
     d                 c                   5
     d cQCAPCMD_PRC_CHK_SEU_CMD...
     d                 c                   6
     d cQCAPCMD_PRC_CHK_SEU_BND...
     d                 c                   7
     d cQCAPCMD_PRC_CHK_UDO...
     d                 c                   8
     d cQCAPCMD_PRC_CHK_SEU_CLLE...
     d                 c                   9
      *
      *  DBCS data handling.
      *  Whether the command analyzer should handle the SO/SI
      *  characters as DBCS delimiters.
     d cQCAPCMD_DBCS_IGNORE...
     d                 c                   '0'
     d cQCAPCMD_DBCS_HANDLE...
     d                 c                   '1'
      *
      *  Prompter action.
      *  Indicates whether the prompter should be called on a command string.
     d cQCAPCMD_PROMPT_NEVER...
     d                 c                   '0'
     d cQCAPCMD_PROMPT_ALWAYS...
     d                 c                   '1'
     d cQCAPCMD_PROMPT_SELECTIVE...
     d                 c                   '2'
     d cQCAPCMD_PROMPT_HELP...
     d                 c                   '3'
      *
      *  Command string syntax.
      *  Whether command processing should be done in i5/OS mode or System/38 mode.
     d cQCAPCMD_SYNTAX_SYSTEM...
     d                 c                   '0'
     d cQCAPCMD_SYNTAX_SYSTEM38...
     d                 c                   '1'
      *
      *  CCSID of command string.
     d cQCAPCMD_CCSID_JOB...
     d                 c                   0
     d cQCAPCMD_CCSID_UTF8...
     d                 c                   1208
     d cQCAPCMD_CCSID_UTF16...
     d                 c                   1200
      *
      /endif
