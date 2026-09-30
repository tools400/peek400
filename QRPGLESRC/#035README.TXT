Peek/400 Development Instructions
=================================

This readme file provides information how to build the Peek/400
objects and what the PEEK9* helper programs are used for.


Compiling a Peek/400 Object
---------------------------

Peek/400 objects are compiled by command CRTPEEKOBJ. The easiest
way to compile an object is to use a user defined option with the
following command:

  CRTPEEKOBJ SRCFILE(&L/&F) SRCMBR(&N) OBJLIB(&L) DEVLIB(&L)
    SBMJOB(*NO) BNDDIR(PEEK) INSTALL(*NO)


Creating a Peek/400 Distribution Library
----------------------------------------

Prepare to Create Library:

PEEK33 has to be changed to update existing user settings
files with the new version number.

Entry '*VERSION' of file PEEKUSR must be changed to contain
the new version number:

  USER       SECTION    KEY        DATA
  *NONE      *PGM       *VERSION   V03R05M00

Constants 'CopyRight', 'Release' and 'Version' of program PEEK05
must be changed to reflect the current version number and date.

Create Library:

A Peek/400 distribution library is created by PEEK96:

  CALL PGM(PEEK96) PARM('peekDevLib' ['dbgView')

  peekDevLib - Name of the Peek/400 development library.
  dbgView    - Optional. Debug view *ALL or *NONE.
               Default value is *NONE.

The name of the Peek/400 distribution library is always 'PEEK'.
Library PEEK must not exist when calling PEEK96.
First PEEK96 interactively creates a couple of objects and then
submits a bunch of objects to batch. Today it uses job queue
'RADDATZ' which needs to be changed on other systems. The job
queue should be single threaded.
The last objected that is created is 'PEEK00'.


Save Peek/400 to Save File
--------------------------

The Peek/400 distribution and development libraries are save
to save files by PEEK95:

  CALL PGM(PEEK95) PARM('peekDevLib')

  peekDevLib - Name of the Peek/400 development library.

The names of the save files are:

  PEEKnnn    - Peek/400 distribution library.
  PEEKnnnP   - Peek/400 development library.

'nnn' is replaced by the Peek/400 version number as retrieved
from the name of the Peek/400 development library.

PEEK96 must have finished before PEEK95 can be called.
Existing save files are overridden.


Deleting Peek/400 Update Programs
---------------------------------

Program PEEK94 deletes all generated Peek/400 update programs
and display files of a given library. The object description
must contain *UPDPGM in order to mark an object as 'generated
by Peek/400'.

  CALL PGM(PEEK94) PARM('libName')

  libName    - Name of the library that contains generated
               programs and display files that shall be deleted.


Creating message desription copy books
--------------------------------------

Program PEEK97 creates the following items for each message
description of a given Peek/400 development library:

  - Copy books with a data structure of the replacement
    variables (generated from PEEKGER).
  - CL program to create the German message file. (PEEKGER)
  - CL program to create the English message file. (PEEKENG)
  - CL program to create the Spanish message file. (PEEKSPA)
  - CL program to create the Italian message file. (PEEKITA)

So far PEEKGER ist the master message file containing all
messages and text constants. It can be overridden by another
language specific message file to change the user interface
to a language different from German.

Important: PEEK97 requires utility CRTMSGDS, which is available
           at http://www.tools400.de

