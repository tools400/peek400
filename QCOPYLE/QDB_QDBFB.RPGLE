?     *===============================================================*                       RADDAT
?     *                                                               *                       RADDAT
?     *  File Scope Array: Qdb_Qdbfb                                  *                       RADDAT
?     *                                                               *                       RADDAT
?     *                                                               *                       RADDAT
?     *===============================================================*                       RADDAT
?     *                                                                                       RADDAT
     D Qdb_Qdbfb       DS                                                                     RADDAT
?     *                                                                                       RADDAT
?     * Based on physical file/library                                                        RADDAT
     D  Qdbfbf                49     58A                                                      RADDAT
     D  Qdbfbfl               59     68A                                                      RADDAT
?     *                                                                                       RADDAT
?     * Record format name                                                                    RADDAT
     D  Qdbft                 69     78A                                                      RADDAT
?     *                                                                                       RADDAT
?     * Bbr of select/omit statements                                                         RADDAT
     D  Qdbfsoon             129    130I 0                                                    RADDAT
?     *                                                                                       RADDAT
?     * Offset to the select/omit specification array                                         RADDAT
     D  Qdbfsoof             131    134I 0                                                    RADDAT
?     *                                                                                       RADDAT
?     * Offset to the key specification array                                                 RADDAT
     D  Qdbfksof             135    138I 0                                                    RADDAT
?     *                                                                                       RADDAT
?     * Record format full  key field count                                                   RADDAT
     D  Qdbfksof             139    140I 0                                                    RADDAT
?     *                                                                                       RADDAT
