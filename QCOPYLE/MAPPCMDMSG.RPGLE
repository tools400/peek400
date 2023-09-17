      *
      *============================================================*
      *    Mappen:  Programmbefehl ==> Nachrichten-ID              *
      *============================================================*
      *
     C                   SELECT
     C     Data          WHENEQ    '*ENTER'
     C                   MOVEL (P) '0001'        wrk_MsgID
     C     Data          WHENEQ    '*EXIT'
     C                   MOVEL (P) '0002'        wrk_MsgID
     C     Data          WHENEQ    '*REFRESH'
     C                   MOVEL (P) '0003'        wrk_MsgID
     C     Data          WHENEQ    '*ADD'
     C                   MOVEL (P) '0004'        wrk_MsgID
     C     Data          WHENEQ    '*HEADLINE'
     C                   MOVEL (P) '0005'        wrk_MsgID
     C     Data          WHENEQ    '*TGLMRKCOL'
     C                   MOVEL (P) '0006'        wrk_MsgID
     C     Data          WHENEQ    '*MOVETOP'
     C                   MOVEL (P) '0007'        wrk_MsgID
     C     Data          WHENEQ    '*POSCSR'
     C                   MOVEL (P) '0008'        wrk_MsgID
     C     Data          WHENEQ    '*SEARCH'
     C                   MOVEL (P) '0009'        wrk_MsgID
     C     Data          WHENEQ    '*TOP'
     C                   MOVEL (P) '0010'        wrk_MsgID
     C     Data          WHENEQ    '*BOT'
     C                   MOVEL (P) '0011'        wrk_MsgID
     C     Data          WHENEQ    '*LEFT'
     C                   MOVEL (P) '0012'        wrk_MsgID
     C     Data          WHENEQ    '*RIGHT'
     C                   MOVEL (P) '0013'        wrk_MsgID
     C     Data          WHENEQ    '*CMDLINE'
     C                   MOVEL (P) '0014'        wrk_MsgID
     C     Data          WHENEQ    '*132/80'
     C                   MOVEL (P) '0015'        wrk_MsgID
     C     Data          WHENEQ    '*MOREKEYS'
     C                   MOVEL (P) '0016'        wrk_MsgID
     C     Data          WHENEQ    '*PAGEDOWN'
     C                   MOVEL (P) '0017'        wrk_MsgID
     C     Data          WHENEQ    '*PAGEUP'
     C                   MOVEL (P) '0018'        wrk_MsgID
     C     Data          WHENEQ    '*PINROW'
     C                   MOVEL (P) '0019'        wrk_MsgID
     C     Data          WHENEQ    '*UNPINROW'
     C                   MOVEL (P) '0020'        wrk_MsgID
     C     Data          WHENEQ    '*CHANGE'
     C                   MOVEL (P) '0021'        wrk_MsgID
     C     Data          WHENEQ    '*COPY'
     C                   MOVEL (P) '0022'        wrk_MsgID
     C     Data          WHENEQ    '*DELETE'
     C                   MOVEL (P) '0023'        wrk_MsgID
     C     Data          WHENEQ    '*DISPLAY'
     C                   MOVEL (P) '0024'        wrk_MsgID
     C     Data          WHENEQ    '*USERSETG'
     C                   MOVEL (P) '0025'        wrk_MsgID
     C     Data          WHENEQ    '*CANCEL'
     C                   MOVEL (P) '0026'        wrk_MsgID
     C     Data          WHENEQ    '*SAVE_EXIT'
     C                   MOVEL (P) '0027'        wrk_MsgID
     C     Data          WHENEQ    '*PINCOL'
     C                   MOVEL (P) '0028'        wrk_MsgID
     C     Data          WHENEQ    '*UNPINCOL'
     C                   MOVEL (P) '0029'        wrk_MsgID
     C     Data          WHENEQ    '*TGLPINCOL'
     C                   MOVEL (P) '0030'        wrk_MsgID
     C     Data          WHENEQ    '*TBLPAPON'
     C                   MOVEL (P) '0031'        wrk_MsgID
     C     Data          WHENEQ    '*TBLPAPOFF'
     C                   MOVEL (P) '0032'        wrk_MsgID
     C     Data          WHENEQ    '*TGLTBLPAP'
     C                   MOVEL (P) '0033'        wrk_MsgID
     C     Data          WHENEQ    '*YESTOALL'
     C                   MOVEL (P) '0034'        wrk_MsgID
     C     Data          WHENEQ    '*MOREOPT'
     C                   MOVEL (P) '0035'        wrk_MsgID
     C     Data          WHENEQ    '*COPYEXT'
     C                   MOVEL (P) '0036'        wrk_MsgID
     C     Data          WHENEQ    '*MRKCOL'
     C                   MOVEL (P) '0037'        wrk_MsgID
     C     Data          WHENEQ    '*UNMRKCOL'
     C                   MOVEL (P) '0038'        wrk_MsgID
     C     Data          WHENEQ    '*LOWERCASE'
     C                   MOVEL (P) '0039'        wrk_MsgID
     C     Data          WHENEQ    '*UPPERCASE'
     C                   MOVEL (P) '0040'        wrk_MsgID
     C     Data          WHENEQ    '*TGLLUCASE'
     C                   MOVEL (P) '0041'        wrk_MsgID
     C     Data          WHENEQ    '*SPLASHON'
     C                   MOVEL (P) '0042'        wrk_MsgID
     C     Data          WHENEQ    '*SPLASHOFF'
     C                   MOVEL (P) '0043'        wrk_MsgID
     C     Data          WHENEQ    '*PAGELEFT'
     C                   MOVEL (P) '0044'        wrk_MsgID
     C     Data          WHENEQ    '*PAGERIGHT'
     C                   MOVEL (P) '0045'        wrk_MsgID
     C     Data          WHENEQ    '*REPEAT'
     C                   MOVEL (P) '0046'        wrk_MsgID
     C     Data          WHENEQ    '*REBUILD'
     C                   MOVEL (P) '0047'        wrk_MsgID
     C     Data          WHENEQ    '*CLRPINROW'
     C                   MOVEL (P) '0048'        wrk_MsgID
     C     Data          WHENEQ    '*CLRPINCOL'
     C                   MOVEL (P) '0049'        wrk_MsgID
     C     Data          WHENEQ    '*LAYOUT'
     C                   MOVEL (P) '0050'        wrk_MsgID
     C     Data          WHENEQ    '*FLOATKEYS'
     C                   MOVEL (P) '0051'        wrk_MsgID
     C     Data          WHENEQ    '*SELECT'
     C                   MOVEL (P) '0052'        wrk_MsgID
     C     Data          WHENEQ    '*NEXTMARK'
     C                   MOVEL (P) '0053'        wrk_MsgID
     C     Data          WHENEQ    '*PREVMARK'
     C                   MOVEL (P) '0054'        wrk_MsgID
     C     Data          WHENEQ    '*DSPDBR'
     C                   MOVEL (P) '0055'        wrk_MsgID
     C     Data          WHENEQ    '*PROMPT'
     C                   MOVEL (P) '0056'        wrk_MsgID
     C     Data          WHENEQ    '*KEY'
     C                   MOVEL (P) '0057'        wrk_MsgID
     C     Data          WHENEQ    '*RRN'
     C                   MOVEL (P) '0058'        wrk_MsgID
     C     Data          WHENEQ    '*TGLACCESS'
     C                   MOVEL (P) '0059'        wrk_MsgID
     C     Data          WHENEQ    '*HEXEDIT'
     C                   MOVEL (P) '0060'        wrk_MsgID
     C     Data          WHENEQ    '*ABOUT'
     C                   MOVEL (P) '0061'        wrk_MsgID
     C     Data          WHENEQ    '*PINCOLDLG'
     C                   MOVEL (P) '0062'        wrk_MsgID
     C     Data          WHENEQ    '*CLRALL'
     C                   MOVEL (P) '0063'        wrk_MsgID
     C     Data          WHENEQ    '*DSPNRM'
     C                   MOVEL (P) '0064'        wrk_MsgID
     C     Data          WHENEQ    '*DSPHEX'
     C                   MOVEL (P) '0065'        wrk_MsgID
     C     Data          WHENEQ    '*TGLDSP'
     C                   MOVEL (P) '0066'        wrk_MsgID
     C     Data          WHENEQ    '*SQL'
     C                   MOVEL (P) '0067'        wrk_MsgID
     C     Data          WHENEQ    '*INSKEYFLD'
     C                   MOVEL (P) '0068'        wrk_MsgID
     C     Data          WHENEQ    '*SAVEENV'
     C                   MOVEL (P) '0069'        wrk_MsgID
     C     Data          WHENEQ    '*LOADENV'
     C                   MOVEL (P) '0070'        wrk_MsgID
     C     Data          WHENEQ    '*DELETEENV'
     C                   MOVEL (P) '0071'        wrk_MsgID
     C     Data          WHENEQ    '*TGLSORT'
     C                   MOVEL (P) '0072'        wrk_MsgID
     C     Data          WHENEQ    '*YES'
     C                   MOVEL (P) '0073'        wrk_MsgID
     C     Data          WHENEQ    '*NO'
     C                   MOVEL (P) '0074'        wrk_MsgID
     C     Data          WHENEQ    '*OK'
     C                   MOVEL (P) '0075'        wrk_MsgID
     C     Data          WHENEQ    '*FIRSTPOS'
     C                   MOVEL (P) '0076'        wrk_MsgID
     C     Data          WHENEQ    '*LASTPOS'
     C                   MOVEL (P) '0077'        wrk_MsgID
     C     Data          WHENEQ    '*SLCENV'
     C                   MOVEL (P) '0078'        wrk_MsgID
     C     Data          WHENEQ    '*SLCLAYOUT'
     C                   MOVEL (P) '0079'        wrk_MsgID
     C     Data          WHENEQ    '*TGLNULL'
     C                   MOVEL (P) '0080'        wrk_MsgID
     C     Data          WHENEQ    '*TGLINPUT'
     C                   MOVEL (P) '0081'        wrk_MsgID
     C     Data          WHENEQ    '*STREDIT'
     C                   MOVEL (P) '0082'        wrk_MsgID
     C     Data          WHENEQ    '*TGLRCDLCK'
     C                   MOVEL (P) '0083'        wrk_MsgID
     C     Data          WHENEQ    '*TGLKEYLUC'
     C                   MOVEL (P) '0084'        wrk_MsgID
     C     Data          WHENEQ    '*PRINT'
     C                   MOVEL (P) '0085'        wrk_MsgID
     C                   OTHER
     C                   MOVEL (P) *BLANKS       wrk_MsgID
     C                   MOVEL (P) Data          wrk_MsgTxt
     C                   ENDSL
      *
