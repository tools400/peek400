000100000000CRTMSGDS - A Tools/400 Utility
000200000000------------------------------
000300000000
000400000000CRTMSGDS is a utility that was first developed for generating RPG data
000500000000structures for the parameters of IBM i message descriptions. Meanwhile
000600000000it has been enhanced to also generate CL source members with ADDMSGD
000700000000commands.
000800000000
000900000000Dependencies: *NONE
001000000000
001100000000Compile members with the following PDM option:
001200000000
001300000000   STRPREPRC USESRCFILE(&L/&F) USESRCMBR(&N) OPTION(*EVENTF) CHGOBJD(*NO)
001400000000     LIB(&O) OBJ(&N) SRCLIB(&L) SRCFILE(&F) SRCMBR(&N) USER0(&X)
001500000000     USER1(*LIST) USER2(*FULL)
001600000000
001700000000Members of type MAKPGM or BND are used for linking programs (MAKPGM)
001800000000and service programs (BND).
001900000000
0020000000002018, Thomas Raddatz
