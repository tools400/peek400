       //**************************************************************************************
       // PRGMTRR1: Progress meter
       // Copyright (C) 2001  Martin Rowe   <martin@dbg400.net>           Original  Version
       //               2001  Th. Raddatz   <thomas.raddatz@tools400.de>  Procedure Version

       // This program is free software; you can redistribute it and/or modify
       // it under the terms of the GNU General Public License as published by
       // the Free Software Foundation; either version 2 of the License, or
       // (at your option) any later version.

       // This program is distributed in the hope that it will be useful,
       // but WITHOUT ANY WARRANTY; without even the implied warranty of
       // MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
       // GNU General Public License for more details.

       // You should have received a copy of the GNU General Public License
       // along with this program; if not, write to the Free Software
       // Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
       //**************************************************************************************
       // >>PRE-COMPILER<<
       //   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +
       //                           OBJLIB(&LI) DEVLIB(&LI) +
       //                           SBMJOB(*NO) BNDDIR(PEEK) +
       //                           INSTALL(*NO);
       //   >>EXECUTE<<
       // >>END-PRE-COMPILER<<
       //**************************************************************************************
       ctl-opt debug nomain;
       ctl-opt option(*srcstmt : *nodebugio);
       ctl-opt decedit('0,') datedit(*dmy.);
       ctl-opt datfmt(*iso )  timfmt(*iso );
       ctl-opt expropts(*resdecpos);
       ctl-opt extbinint(*yes);
       //**************************************************************************************

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,QUSRJOBI
      /COPY QCOPYLE,QMHSNDPM

      /COPY QCOPYLE,PPEEK61

       //  Global fields
       dcl-s g_text          varchar(21);
       dcl-s g_maxvalue      int(10);
       dcl-s g_marker        char(1);
       dcl-s g_waitsec       int(10);
       dcl-s g_width         int(10);

       dcl-s g_jobtype       char(1);
       dcl-s g_showprgmtr    ind;
       dcl-s g_lastpercentage packed(3);
       dcl-s g_lasttmstmp    timestamp;

       dcl-c SCR_MODE_DS3     '*DS3';
       dcl-c SCR_MODE_DS4     '*DS4';

       dcl-c SCR_COLUMN_DS3   80;
       dcl-c SCR_COLUMN_DS4   132;

       //  Private Prototypes
       dcl-pr lf_getnumdspcol uns(10) extproc('lf_getnumdspcol');
       end-pr;

       dcl-pr lf_getscreenmode char(10) extproc('lf_getscreenmode');
       end-pr;

       //===============================================================*
       //  Initialize Progress Meter
       //===============================================================*

       dcl-proc p_inzprogressmeter export;
       dcl-pi *N;
         i_text          char(20) const;
         i_maxvalue      int(10) const;
         i_marker        char(1) const  options(*nopass);
         i_waitsec       int(10) const  options(*nopass);
         i_jobtype       char(10) const  options(*nopass);
         i_width         int(10) const  options(*nopass);
       end-pi;

       //  Optional parameter fields
       dcl-s marker          like(i_marker);
       dcl-s waitsec         like(i_waitsec);
       dcl-s jobtype         like(i_jobtype);
       dcl-s width           like(i_width);

       //  Local helper fields
       dcl-ds jobi0100 likeds(jobi0100_t) inz;
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       //  Process optional parameters ...
       //  ... i_marker
       if (%parms() >= %parmnum(i_marker));
          marker = i_marker;
       else;
          marker = cprgmtr_blue;
       endif;

       //  ... 'i_waitSec'
       if (%parms() >= %parmnum(i_waitsec));
          waitsec = i_waitsec;
       else;
          waitsec = 0;
       endif;

       //  ... 'i_jobType'
       if (%parms() >= %parmnum(i_jobtype));
          jobtype = i_jobtype;
       else;
          jobtype = cprgmtr_jobtype_all;
       endif;

       //  ... 'i_width'
       if (%parms() >= %parmnum(i_width));
          width = i_width;
       else;
          width = 0;
       endif;

       // Determine job type (interactive or batch)
       qusrjobi(jobi0100: %size(jobi0100)
               : 'JOBI0100': '*': '');

       // Set processing attributes ...
       // (only interactive jobs have a display, all other job types
       //  use the batch layout)
       if (jobi0100.type = 'I');
          g_jobtype = 'I';
       else;
          g_jobtype = 'B';
       endif;

       g_text        = %trimr(i_text) + ' ';
       g_maxvalue    = i_maxvalue;
       g_waitsec     = waitsec;

       g_lastpercentage = -1;
       g_lasttmstmp     = *loval;

       // ... if an attribute below x'20' (normal green) specified,
       //     swap for yellow reverse (safer)
       if (marker < x'20');
          g_marker = cprgmtr_yellow;
       else;
          g_marker = marker;
       endif;

       // ... change marker acording to job type
       if (g_jobtype = 'B') and (g_marker < ' ');
          g_marker = '#';
       endif;

       // ... set screen width
       if (g_jobtype = 'B');
          g_width = 50;
       else;
          if (width > 0);
             g_width = width;
          else;
             g_width = lf_getnumdspcol() -
                         %len(g_text) - 10;
          endif;
       endif;

       // ... at most the size of the progress field (128 characters,
       //     one of them for the closing attribute)
       if (g_width > 127);
          g_width = 127;
       endif;

       //  ... check whether the progress meter must be shown for jobs of type ...
       select;
          //      ... all Jobs
       when (jobtype = cprgmtr_jobtype_all);
          g_showprgmtr = bTrue;
          //      ... interactive jobs
       when (jobtype = cprgmtr_jobtype_dlg);
          if (g_jobtype <> 'B');
             g_showprgmtr = bTrue;
          else;
             g_showprgmtr = bFalse;
          endif;
          //      ... batch jobs
       when (jobtype = cprgmtr_jobtype_batch);
          if (g_jobtype = 'B');
             g_showprgmtr = bTrue;
          else;
             g_showprgmtr = bFalse;
          endif;
          //      ... others
       other;
          g_showprgmtr = bFalse;
       endsl;

       return;

       end-proc;

       //===============================================================*
       //  Show Progress Meter
       //===============================================================*

       dcl-proc p_showprogressmeter export;
       dcl-pi *N;
         i_currvalue     int(10) const;
       end-pi;

       //  Local helper fields
       dcl-s percentage      float(8) inz;
       dcl-s now             timestamp inz;
       dcl-s seconds         zoned(30) inz;

       dcl-s progress        varchar(128) inz;
       dcl-s complete        varchar(128) inz;
       dcl-s pointer         varchar(128) inz;
       dcl-s fraction        int(10) inz;

       dcl-ds qMsgFile qualified;
         name char(10) inz('QCPFMSG');
         lib  char(10) inz('*LIBL');
       end-ds;

       dcl-s msgDta    varchar(512);
       dcl-s msgType   char(10);
       dcl-s msgKey    char(4);

       dcl-ds errcode likeds(errcode_t) inz;
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       //  Check whether the progress meter must be shown
       //  (no maximum value: nothing to show, avoid dividing by zero)
       if (not g_showprgmtr or g_maxvalue <= 0);
          return;
       endif;

       //  Set size of fields depending on screen size
       %len(progress) = g_width;
       %len(complete) = %len(progress);
       %len(pointer ) = %len(progress);

       //  Compute new percentage, get current timestamp
       percentage = %int(100 * i_currvalue / g_maxvalue  );

       //  Compute elapsed time
       now = %timestamp();
       if (g_waitsec > 0);
          seconds = %diff(now:g_lasttmstmp:*s);
       else;
          seconds = *hival;
       endif;

       //  Check whether a new value must be shown
       if (percentage <> g_lastpercentage and
           (seconds >= g_waitsec or g_waitsec = 0));

          //  ... initialize message line with dots.
          progress = %xlate(' ': '.': progress);

          //  ... build completion overlay for marker values of *blank and above
          if (g_marker >= x'40');
             pointer = %xlate(' ': g_marker: pointer);
          endif;

          //  ... as we only have enough space for a line of X, adjust the percentage to fit
          fraction = (percentage/100) * %len(progress);

          //  ... make sure that fraction does not excedd %len(progress)
          if (fraction > %len(progress));
             fraction = %len(progress);
          endif;

          //  ... replace the the dots in the completed section with the requested marker
          %subst(progress: 1: fraction) = %subst(pointer: 1: fraction);

          //  ... format the message accoring to marker type -
          //      row of characters or solid reverse image
          if (g_marker >= x'40');
             msgDta = g_text + %editc(%dech(percentage: 3: 0):'Z') +
                      '% ' + progress;
          else;
             if fraction < %len(progress);
                %subst(progress : fraction + 1 : 1) = x'22';
             else;
                progress = progress + x'22';
             endif;
             msgDta = g_text + %editc(%dech(percentage: 3: 0):'Z') +
                         '%' + g_marker + progress;
          endif;

          //  Send message to this program's own queue if in batch (log in job log) ...
          if (g_jobtype = 'B');
             msgType = '*INFO';
          else;
             //  ... otherwise send status message for interactive request
             msgType = '*STATUS';
          endif;

          clear errcode;
          errcode.bytprv = %size(errcode);

          qmhsndpm ('CPDA0FF': qMsgFile: msgDta: %len(msgDta): msgType
                    : '*EXT': 0: msgKey: errcode);

          //  ... remember current values
          g_lastpercentage = percentage;
          g_lasttmstmp     = now;
       endif;

       return;

       end-proc;

       //===============================================================*
       //  Get number of display columns
       //===============================================================*

       dcl-proc lf_getnumdspcol;
       dcl-pi *N uns(10);
       end-pi;

       //  Definieren Funktionswert
       dcl-s numDspColumns uns(10) inz;
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       if (lf_getscreenmode() = SCR_MODE_DS3);
          numDspColumns = SCR_COLUMN_DS3;
       else;
          numDspColumns = SCR_COLUMN_DS4;
       endif;

       return numDspColumns;

       end-proc;

       //===============================================================*
       //  Get screen mode
       //===============================================================*

       dcl-proc lf_getscreenmode;
       dcl-pi *N              char(10);
       end-pi;

       //  Definieren Funktionswert
       dcl-s screenmode      char(10) inz;

       //  Retrieve Display Mode       Return value: Display Mode
       dcl-pr qsnrtvmod char(1) extproc('QsnRtvMod');
         o_dspmode       char(1) options(*omit);
         i_hlowlvlenv    int(10) const  options(*omit);
         io_errcode      char(32767) options(*omit: *varsize);
       end-pr;

       //  Definieren Arbeitsfelder
       dcl-s dspMode     char(1);
       dcl-ds errCode likeds(errcode_t) inz;
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       clear errCode;

       qsnrtvmod(dspMode: *omit: errCode);

       if (dspMode = '3');
          screenmode = SCR_MODE_DS3;
       else;
          screenmode = SCR_MODE_DS4;
       endif;

       return screenmode;

       end-proc;


