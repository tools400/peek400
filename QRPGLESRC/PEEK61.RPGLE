      ***************************************************************************************
      * PRGMTRR1: Progress meter
      * Copyright (C) 2001  Martin Rowe   <martin@dbg400.net>           Original  Version
      *               2001  Th. Raddatz   <thomas.raddatz@tools400.de>  Procedure Version
      *
      * This program is free software; you can redistribute it and/or modify
      * it under the terms of the GNU General Public License as published by
      * the Free Software Foundation; either version 2 of the License, or
      * (at your option) any later version.
      *
      * This program is distributed in the hope that it will be useful,
      * but WITHOUT ANY WARRANTY; without even the implied warranty of
      * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      * GNU General Public License for more details.
      *
      * You should have received a copy of the GNU General Public License
      * along with this program; if not, write to the Free Software
      * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
      ***************************************************************************************
      * >>PRE-COMPILER<<
      *   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +
      *                           OBJLIB(&LI) DEVLIB(&LI) +
      *                           SBMJOB(*NO) BNDDIR(PEEK) +
      *                           INSTALL(*NO);
      *   >>EXECUTE<<
      * >>END-PRE-COMPILER<<
      ***************************************************************************************
     H DEBUG
     H NOMAIN
     H OPTION(*SRCSTMT : *NODEBUGIO)
     H DECEDIT('0,') DATEDIT(*DMY.)
     H DATFMT(*ISO )  TIMFMT(*ISO )
     H EXPROPTS(*RESDECPOS)
     H EXTBININT(*YES)
      ***************************************************************************************
      *
      *  Global fields
     D g_text          S             21A   inz varying
     D g_maxValue      S             10I 0 inz
     D g_marker        S              1A   inz
     D g_waitSec       S             10I 0 inz
     D g_width         S             10I 0 inz
      *
     D g_jobtype       S              1A   inz
     D g_showPrgMtr    S               N   inz
     D g_lastPercentage...
     D                 S              3P 0 inz
     D g_lastTmStmp    S               Z   inz
      *
     D cTrue           C                   const(*on )
     D cFalse          C                   const(*on )
      *
     D cSCR_MODE_DS3   C                   const('*DS3')
     D cSCR_MODE_DS4   C                   const('*DS4')
      *
     D cSCR_COLUMN_DS3...
     D                 C                   const(80)
     D cSCR_COLUMN_DS4...
     D                 C                   const(132)
      *
      *  Type definitions
     D errCode_t       DS                  qualified   based(pDummy)
     D  bytPrv                       10I 0
     D  bytAvl                       10I 0
     D  excId                         7A
     D  res01                         1A
     D  excData                     256A
      *
      *  Exported procedures
      /COPY QCOPYLE,F_PEEK61
      *
      *  Imported procedures
      /COPY QCOPYLE,QUSRJOBI
      *
      *  Private Prototypes
     D lf_getNumDspCol...
     D                 PR            10U 0
      *
     D lf_getScreenMode...
     D                 PR            10A
      *
      *===============================================================*
      *  Initialize Progress Meter
      *===============================================================*
      *
     P p_inzProgressMeter...
     P                 B                   export
      *
     D p_inzProgressMeter...
     D                 PI
     D  i_text                       20A   const
     D  i_maxValue                   10I 0 const
     D  i_marker                      1A   const  options(*nopass)
     D  i_waitSec                    10I 0 const  options(*nopass)
     D  i_jobType                    10A   const  options(*nopass)
     D  i_width                      10I 0 const  options(*nopass)
      *
      *  Optional parameter positions
     D p_marker        C                   const(3)
     D p_waitSec       C                   const(4)
     D p_jobType       C                   const(5)
     D p_width         C                   const(6)
      *
      *  Optional parameter fields
     D marker          S                   like(i_marker  ) inz
     D waitSec         S                   like(i_waitSec ) inz
     D jobType         S                   like(i_jobType ) inz
     D width           S                   like(i_width   ) inz
      *
      *  Local helper fields
     D jobi0100        DS                  likeds(jobi0100_t) inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      *
      *  Process optional parameters ...
      *  ... i_marker
     C                   If        %parms >= p_marker
     C                   Eval      marker = i_marker
     C                   Else
     C                   Eval      marker = cPrgMtr_Blue
     C                   Endif
      *
      *  ... 'i_waitSec'
     C                   If        %parms >= p_waitSec
     C                   Eval      waitSec = i_waitSec
     C                   Else
     C                   Eval      waitSec = 0
     C                   Endif
      *
      *  ... 'i_jobType'
     C                   If        %parms >= p_jobType
     C                   Eval      jobType = i_jobType
     C                   Else
     C                   Eval      jobType = cPrgMtr_JobType_All
     C                   Endif
      *
      *  ... 'i_width'
     C                   If        %parms >= p_width
     C                   Eval      width = i_width
     C                   Else
     C                   Eval      width = 0
     C                   Endif
      *
      * Determine job type (interactive or batch)
     C                   Callp     QUSRJOBI(jobi0100: %size(jobi0100)
     C                                      : 'JOBI0100': '*': '')
      *
      * Set processing attributes ...
     C                   Eval      g_jobType = jobi0100.type
      *
     C                   Eval      g_text        = %trimR(i_text) + ' '
     C                   Eval      g_maxValue    = i_maxValue
     C                   Eval      g_waitSec     = waitSec
      *
     C                   Eval      g_lastPercentage = -1
     C                   Eval      g_lastTmStmp     = *LOVAL
      *
      * ... if an attribute below x'20' (normal green) specified,
      *     swap for yellow reverse (safer)
     C                   If        marker < X'20'
     C                   Eval      g_Marker = cPrgMtr_Yellow
     C                   Else
     C                   Eval      g_marker = marker
     C                   Endif
      *
      * ... change marker acording to job type
     C                   If        (g_jobType = 'B') and (g_marker < ' ')
     C                   Eval      g_marker = '#'
     C                   Endif
      *
      * ... set screen width
     C                   If        g_jobType = 'B'
     C                   Eval      g_width = 50
     C                   Else
     C                   If        width > 0
     C                   Eval      g_width = width
     C                   Else
     C                   Eval      g_width = lf_getNumDspCol() -
     C                                          %len(g_text) - 10
     C                   Endif
     C                   Endif
      *
      *  ... check whether the progress meter must be shown for jobs of type ...
     C                   Select
      *      ... all Jobs
     C                   When      jobType = cPrgMtr_JobType_All
     C                   Eval      g_showPrgMtr = cTrue
      *      ... interactive jobs
     C                   When      jobType = cPrgMtr_JobType_Dlg
     C                   If        g_jobType <> 'B'
     C                   Eval      g_showPrgMtr = cTrue
     C                   Else
     C                   Eval      g_showPrgMtr = cFalse
     C                   Endif
      *      ... batch jobs
     C                   When      jobType = cPrgMtr_JobType_Batch
     C                   If        g_jobType = 'B'
     C                   Eval      g_showPrgMtr = cTrue
     C                   Else
     C                   Eval      g_showPrgMtr = cFalse
     C                   Endif
      *      ... others
     C                   Other
     C                   Eval      g_showPrgMtr = cFalse
     C                   Endsl
      *
     C                   Return
      *
     P p_inzProgressMeter...
     P                 E
      *
      *===============================================================*
      *  Show Progress Meter
      *===============================================================*
      *
     P p_showProgressMeter...
     P                 B                   export
      *
     D p_showProgressMeter...
     D                 PI
     D  i_currValue                  10I 0 const
      *
      *  Local helper fields
     D percentage      S              8F   inz
     D tmStmp          S               Z   inz
     D seconds         S             30S 0 inz
      *
     D progress        S            128A   inz  varying
     D complete        S            128A   inz  varying
     D pointer         S            128A   inz  varying
     D fraction        S             10I 0 inz
      *
      *  QMHSNDPM API
     D p_msgID         S              7A   inz('CPDA0FF')
     D p_msgFile       DS
     D  p_msgFile_name...
     D                               10A   inz('QCPFMSG')
     D  p_msgFile_lib...
     D                               10A   inz('*LIBL')
     D p_msgData       S            512A   inz
     D p_dataLength    S             10I 0 inz
     D p_msgType       S             10A   inz
     D p_pgmQueue      S             10A   inz
     D p_pgmStack      S             10I 0 inz
     D p_msgKey        S              4A   inz
     D p_error         DS
     D p_errCode       DS                  likeds(errCode_t) inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      *
      *  Check whether the progress meter must be shown
     C                   If        not g_showPrgMtr
     C                   Return
     C                   Endif
      *
      *  Set size of fields depending on screen size
     C                   Eval      %len(progress) = g_width
     C                   Eval      %len(complete) = %len(progress)
     C                   Eval      %len(pointer ) = %len(progress)
      *
      *  Compute new percentage, get current timestamp
     C                   Eval      percentage = %int(100 * i_currValue
     C                                                   / g_maxValue  )
     C                   Time                    tmStmp
      *
      *  Compute elapsed time
     C                   If        g_waitSec > 0
     C     tmStmp        Subdur    g_lastTmStmp  seconds:*s
     C                   Else
     C                   Eval      seconds = *hival
     C                   Endif
      *
      *  Check whether a new value must be shown
     C                   If        (percentage <> g_lastPercentage)  and
     C                             ((seconds >= g_waitSec) or (g_waitSec = 0))
      *
      *  ... initialize message line with dots.
     C                   EVAL      progress = %xlate(' ': '.': progress)
      *
      *  ... build completion overlay for marker values of *blank and above
     C                   If        g_marker >= x'40'
     C                   EVAL      pointer = %xlate(' ': g_marker: pointer)
     C                   Endif
      *
      *  ... as we only have enough space for a line of X, adjust the percentage to fit
     C                   Eval      fraction = (percentage/100) * %len(progress)
      *
      *  ... make sure that fraction does not excedd %len(progress)
     C                   If        fraction > %len(progress)
     C                   Eval      fraction = %len(progress)
     C                   Endif
      *
      *  ... replace the the dots in the completed section with the requested marker
     C                   Eval      %subst(progress : 1 : fraction) =
     C                             %subst(pointer  : 1 : fraction)
      *
      *  ... format the message accoring to marker type -
      *      row of characters or solid reverse image
     C                   If        g_marker >= x'40'
     C                   Eval      p_msgData = g_text +
     C                             %editc(%dech(percentage: 3: 0):'Z') +
     C                             '% ' + progress
     C                   Else
     C                   If        fraction < %len(progress)
     C                   Eval      %subst(progress : fraction + 1 : 1) = x'22'
     C                   Else
     C                   Eval      progress = progress + x'22'
     C                   Endif
     C                   Eval      p_msgData = g_Text +
     C                             %editc(%dech(percentage: 3: 0):'Z') +
     C                             '%' + g_marker + progress
     C                   Endif
      *
     C                   EVAL      p_DataLength = %len(%trimL(p_msgData))
     C                   EVAL      p_PgmStack = 0
     C                   EVAL      p_PgmQueue = '*EXT'
      *
      *  Send message to this program's own queue if in batch (log in job log) ...
     C                   If        g_jobType = 'B'
     C                   Eval      p_msgType = '*INFO'
     C                   Else
      *  ... otherwise send status message for interactive request
     C                   Eval      p_msgType = '*STATUS'
     C                   Endif
      *
     C                   Clear                   p_errCode
     C                   Eval      p_errCode.bytPrv = %size(p_errCode)
      *
     C                   Call (E)  'QMHSNDPM'
     C                   Parm                    p_msgID
     C                   Parm                    p_msgFile
     C                   Parm                    p_msgData
     C                   Parm                    p_dataLength
     C                   Parm                    p_msgType
     C                   Parm                    p_pgmQueue
     C                   Parm                    p_pgmStack
     C                   Parm                    p_msgKey
     C                   Parm                    p_error
      *
      *  ... remember current values
     C                   Eval      g_lastPercentage = percentage
     C                   Eval      g_lastTmStmp     = tmStmp
     C                   Endif
      *
     C                   Return
      *
     P p_showProgressMeter...
     P                 E
      *
      *===============================================================*
      *  Get number of display columns
      *===============================================================*
      *
     P lf_getNumDspCol...
     P                 B
      *
     D lf_getNumDspCol...
     D                 PI            10U 0
      *
      *  Definieren Funktionswert
     D numDspCol       S             10U 0 inz
      *
      *  Definieren Arbeitsfelder
     D rows            S             10I 0 inz
     D columns         S             10I 0 inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      *
     C                   If        lf_getScreenMode() = cSCR_MODE_DS3
     C                   Eval      numDspCol = cSCR_COLUMN_DS3
     C                   Else
     C                   Eval      numDspCol = cSCR_COLUMN_DS4
     C                   Endif
      *
     C                   Return    numDspCol
      *
     P lf_getNumDspCol...
     P                 E
      *
      *===============================================================*
      *  Get screen mode
      *===============================================================*
      *
     P lf_getScreenMode...
     P                 B
      *
     D lf_getScreenMode...
     D                 PI            10A
      *
      *  Definieren Funktionswert
     D screenMode      S             10A   inz
      *
      *  Retrieve Display Mode       Return value: Display Mode
     D QsnRtvMod...
     D                 PR             1A          extproc('QsnRtvMod')
     D  o_dspMode                     1A          options(*omit   )
     D  i_hLowLvlEnv                 10I 0 const  options(*omit   )
     D  io_errCode                32767A          options(*omit   :
     D                                                    *varsize)
      *
      *  Definieren Arbeitsfelder
     D p_mode          S              1A                     inz
     D p_errCode       DS                  likeds(errCode_t) inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      *
     C                   Clear                   p_errCode
      *
     C                   Callp     QsnRtvMod(p_mode: *omit: p_errCode)
      *
     C                   If        p_mode = '3'
     C                   Eval      screenMode = cSCR_MODE_DS3
     C                   Else
     C                   Eval      screenMode = cSCR_MODE_DS4
     C                   endif
      *
     C                   Return    screenMode
      *
     P lf_getScreenMode...
     P                 E
      *
