      *===============================================================*
      *  bitand(), V5R1 and below.                                    *
      *===============================================================*
      * >>PRE-COMPILER<<                                              *
      *   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                   *
      *                           SRCFILE(&SL/&SF) +                  *
      *                           SRCMBR(&SM);                        *
      *   >>COMPILE<<                                                 *
      *     >>PARM<< TRUNCNBR(*NO);                                   *
      *     >>PARM<< DBGVIEW(*LIST);                                  *
      *   >>END-COMPILE<<                                             *
      *   >>EXECUTE<<                                                 *
      *   >>CMD<<    CRTPGM       PGM(&LI/&OB) +                      *
      *                           MODULE(&LI/&OB) +                   *
      *                           BNDDIR(*LIBL/QC2LE) +               *
      *                           DETAIL(*BASIC) +                    *
      *                           ACTGRP(*NEW);                       *
      * >>END-PRE-COMPILER<<                                          *
      *===============================================================*
     H DEBUG
     H OPTION(*SRCSTMT : *NODEBUGIO)
     H DECEDIT('0,') DATEDIT(*DMY.)
     H DATFMT(*ISO )  TIMFMT(*ISO )
     H EXPROPTS(*RESDECPOS)
     H EXTBININT(*YES)
      *===============================================================*
      *
      * ------------------------------------
      *  Prototypes
      * ------------------------------------
      *
     D PGM_ENTRY_POINT...
     D                 PR                  extpgm('TEST0033')
      *
     D main...
     D                 PR                         extproc('main')
      *
     D kill...
     D                 PR                         extproc('kill')
     D  i_text                      128A   value  varying
      *
      *  bitand() for V5R1 and below.
     D bitand...
     D                 PR            10U 0 extproc('bitand')
     D  i_arg1                       10U 0 value
     D  i_arg2                       10U 0 value
      *
      *===============================================================*
      *  Program Entry Point
      *===============================================================*
     D PGM_ENTRY_POINT...
     D                 PI
      *
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         main();

         *inlr = *on;

         return;

      /END-FREE
      *
      *===============================================================*
      *  Main procedure
      *===============================================================*
     P main...
     P                 B
      *
     D main...
     D                 PI
      *
     D arg1            S             10U 0
     D arg2            S             10U 0
     D result          S             10U 0
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

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

      /END-FREE
      *
     P main...
     P                 E
      *
      *===============================================================*
      *  Kills the application with an ESCAPE message.
      *===============================================================*
     P kill...
     P                 B
      *
     D kill...
     D                 PI
     D  i_text                      128A   value  varying
      *
      *  Return value
     D pBuffer         S               *   inz
      *
      *  Local fields
     D msgKey          S              4A                        inz
      *
     D qMsgF           DS                  qualified            inz
     D  name                         10A
     D  lib                          10A
      *
     D errCode         DS                  qualified            inz
     D  bytPrv                       10I 0
     D  bytAvl                       10I 0
     D  excID                         7A
     D  reserved                      1A
     D  excDta                      256A
      *
      *  Send Program Message (QMHSNDPM) API
     D QMHSNDPM        PR                         extpgm('QMHSNDPM')
     D   i_msgID                      7A   const
     D   i_qMsgF                     20A   const
     D   i_msgData                32767A   const  options(*varsize )
     D   i_length                    10I 0 const
     D   i_msgType                   10A   const
     D   i_callStkE               32767A   const  options(*varsize )
     D   i_callStkC                  10I 0 const
     D   o_msgKey                     4A
     D   io_ErrCode               32767A          options(*varsize )
     D   i_lenStkE                   10I 0 const  options(*nopass  )
     D   i_callStkEQ                 20A   const  options(*nopass  )
     D   i_wait                      10I 0 const  options(*nopass  )
     D   i_callStkEDT                10A   const  options(*nopass  )
     D   i_ccsid                     10I 0 const  options(*nopass  )
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         clear qMsgF;
         qMsgF.name = 'QCPFMSG';
         qMsgF.lib  = '*LIBL';

         clear errCode;
         errCode.bytPrv = %size(errCode);

         QMHSNDPM('CPF9898': qMsgF: i_text: %len(i_text): '*ESCAPE'
                  : '*CTLBDY': 1
                  : msgKey: errCode);

         return;

      /END-FREE
      *
     P kill...
     P                 E
      *
      *===============================================================*
      *  bitand() for V5R1 and below.
      *===============================================================*
     P bitand...
     P                 B
      *
     D bitand...
     D                 PI            10U 0
     D  i_arg1                       10U 0 value
     D  i_arg2                       10U 0 value
      *
     D result          S             10U 0
      *
      *  AND String (ANDSTR) - MI Instruction
      *  (http://publib.boulder.ibm.com/iseries/v5r1/ic2924/tstudio/tech_ref/mi/topics.htm)
     D ANDSTR...
     D                 PR                  extproc('_ANDSTR')
     D  i_pReceiver                    *   value
     D  i_pFirstSrc                    *   value
     D  i_pSecondSrc                   *   value
     D  i_length                     10U 0 value
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         ANDSTR(%addr(result): %addr(i_arg1): %addr(i_arg2): %len(result));

         return result;

      /END-FREE
      *
     P bitand...
     P                 E
      *
