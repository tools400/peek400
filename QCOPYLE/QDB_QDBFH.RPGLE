?     *===============================================================*                       RADDAT
?     *                                                               *                       RADDAT
?     *  File Definition Header: Qdb_Qdbfh                            *                       RADDAT
?     *                                                               *                       RADDAT
?     *                                                               *                       RADDAT
?     *===============================================================*                       RADDAT
?     *                                                                                       RADDAT
     D Qdb_Qdbfh       DS                  BASED(FDH_Ptr)                                     RADDAT
     D  Qdbfyret               1      4I 0                                                    RADDAT
     D  Qdbfyavl               5      8I 0                                                    RADDAT
?     *                                                                                       RADDAT
?     * Number of data members                                                                RADDAT
     D  Qdbflbnum             15     16I 0                                                    RADDAT
?     *                                                                                       RADDAT
?     * Offset to the file scope array                                                        RADDAT
     D  Qdbfos               317    320I 0                                                    RADDAT
?     *                                                                                       RADDAT
