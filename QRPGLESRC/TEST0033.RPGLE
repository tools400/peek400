**free
//===============================================================*
//  bitand(), V5R1 and below.                                    *
//===============================================================*
// >>PRE-COMPILER<<                                              *
//   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                   *
//                           SRCFILE(&SL/&SF) +                  *
//                           SRCMBR(&SM);                        *
//   >>COMPILE<<                                                 *
//     >>PARM<< TRUNCNBR(*NO);                                   *
//     >>PARM<< DBGVIEW(*LIST);                                  *
//   >>END-COMPILE<<                                             *
//   >>EXECUTE<<                                                 *
//   >>CMD<<    CRTPGM       PGM(&LI/&OB) +                      *
//                           MODULE(&LI/&OB) +                   *
//                           BNDDIR(*LIBL/QC2LE) +               *
//                           DETAIL(*BASIC) +                    *
//                           ACTGRP(*NEW);                       *
// >>END-PRE-COMPILER<<                                          *
//===============================================================*
ctl-opt debug option(*srcstmt: *nodebugio);
ctl-opt decedit('0,') datedit(*DMY.);
ctl-opt datfmt(*iso) timfmt(*iso);
ctl-opt expropts(*resdecpos);
ctl-opt extbinint(*yes);
//===============================================================*
//
// ------------------------------------
//  Prototypes
// ------------------------------------

dcl-pr PGM_ENTRY_POINT extpgm('TEST0033');
end-pr;

dcl-pr main extproc('main');
end-pr;

dcl-pr kill extproc('kill');
  i_text varchar(128) value;
end-pr;

//  bitand() for V5R1 and below.
dcl-pr bitand uns(10) extproc('bitand');
  i_arg1 uns(10) value;
  i_arg2 uns(10) value;
end-pr;

//===============================================================*
//  Program Entry Point
//===============================================================*
dcl-pi PGM_ENTRY_POINT;
end-pi;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main();

*inlr = *on;

return;


//===============================================================*
//  Main procedure
//===============================================================*
dcl-proc main;
  dcl-pi *n;
  end-pi;

  dcl-s arg1 uns(10);
  dcl-s arg2 uns(10);
  dcl-s result uns(10);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  arg1 = x'00110011';
  arg2 = x'00100010';
  result = bitand(arg1: arg2);

  if (result <> x'00100010');
    kill('Invalid return value: ' + %char(result));
  endif;

  arg1 = x'00100010';
  arg2 = x'11001110';
  result = bitand(arg1: arg2);

  if (result <> x'00000010');
    kill('Invalid return value: ' + %char(result));
  endif;

  return;


end-proc main;

//===============================================================*
//  Kills the application with an ESCAPE message.
//===============================================================*
dcl-proc kill;
  dcl-pi *n;
    i_text varchar(128) value;
  end-pi;

  //  Return value
  dcl-s pBuffer pointer inz;

  //  Local fields
  dcl-s msgKey char(4) inz;

  dcl-ds qMsgF qualified inz;
    name char(10);
    lib  char(10);
  end-ds;

  dcl-ds errCode qualified inz;
    bytPrv   int(10);
    bytAvl   int(10);
    excID    char(7);
    reserved char(1);
    excDta   char(256);
  end-ds;

  //  Send Program Message (QMHSNDPM) API
  dcl-pr QMHSNDPM extpgm('QMHSNDPM');
    i_msgID      char(7) const;
    i_qMsgF      char(20) const;
    i_msgData    char(32767) options(*varsize) const;
    i_length     int(10) const;
    i_msgType    char(10) const;
    i_callStkE   char(32767) options(*varsize) const;
    i_callStkC   int(10) const;
    o_msgKey     char(4);
    io_errCode   char(32767) options(*varsize);
    i_lenStkE    int(10) options(*nopass) const;
    i_callStkEQ  char(20) options(*nopass) const;
    i_wait       int(10) options(*nopass) const;
    i_callStkEDT char(10) options(*nopass) const;
    i_ccsid      int(10) options(*nopass) const;
  end-pr;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  clear qMsgF;
  qMsgF.name = 'QCPFMSG';
  qMsgF.lib  = '*LIBL';

  clear errCode;
  errCode.bytPrv = %size(errCode);

  QMHSNDPM('CPF9898': qMsgF: i_text: %len(i_text): '*ESCAPE'
           : '*CTLBDY': 1
           : msgKey: errCode);

  return;


end-proc;

//===============================================================*
//  bitand() for V5R1 and below.
//===============================================================*
dcl-proc bitand;
  dcl-pi *n uns(10);
    i_arg1 uns(10) value;
    i_arg2 uns(10) value;
  end-pi;

  dcl-s result uns(10);

  //  AND String (ANDSTR) - MI Instruction
  //  (http://publib.boulder.ibm.com/iseries/v5r1/ic2924/tstudio/tech_ref/mi/topics.htm)
  dcl-pr ANDSTR extproc('_ANDSTR');
    i_pReceiver  pointer value;
    i_pFirstSrc  pointer value;
    i_pSecondSrc pointer value;
    i_length     uns(10) value;
  end-pr;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  ANDSTR(%addr(result): %addr(i_arg1): %addr(i_arg2): %len(result));

  return result;


end-proc;

