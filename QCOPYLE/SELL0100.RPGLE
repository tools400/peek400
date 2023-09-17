?     *===============================================================*                       RADDAT
?     *                                                               *                       RADDAT
?     *  Additional information about SELL0100:                       *                       RADDAT
?     *  SELECT/OMIT statements                                       *                       RADDAT
?     *                                                               *                       RADDAT
?     *===============================================================*                       RADDAT
?     *                                                                                       RADDAT
?     *  list API format SELL0100                                                             RADDAT
?     *  (data structure can be used within the calling program                               RADDAT
?     *  to splitt XData into its units.)                                                     RADDAT
     D SELL0100        DS           256                                                       RADDAT
     D  SORCEN                 1      1A                                        über API      RADDAT
     D  SORDAT                 2      7A                                        über API      RADDAT
     D  SORTIM                 8     13A                                        über API      RADDAT
     D  SOFILE                14     23A                                        über API      RADDAT
     D  SOLIB                 24     33A                                        über API      RADDAT
     D  SOFTYP                34     34A                                                      RADDAT
     D  SOFILA                35     38A                                        über API      RADDAT
     D  SOMXD                 39     41A                                                      RADDAT
     D  SOFATR                42     47A                                                      RADDAT
     D  SOSYSN                48     55A                                                      RADDAT
     D  SOASP                 56     57P 0                                                    RADDAT
     D  SORES                 58     61A                                                      RADDAT
?     *                                                                                       RADDAT
     D  SONRUL                62     64P 0                                      über API      RADDAT
     D  SORFMT                65     74A                                        über API      RADDAT
     D  SOFLD                 75     84A                                        über API      RADDAT
     D  SORULE                85     85A                                        über API      RADDAT
     D  SOCOMP                86     87A                                        über API      RADDAT
     D  SONVAL                88     89P 0                                      über API      RADDAT
     D  SOVALL                90     91P 0                                      über API      RADDAT
     D  SOVALU                92    123A                                        über API      RADDAT
     D  SODYNS               124    124A                                        über API      RADDAT
     D  SOFJVL               125    126P 0                                                    RADDAT
     D  SOPJVL               127    128P 0                                                    RADDAT
?     *                                                                                       RADDAT
