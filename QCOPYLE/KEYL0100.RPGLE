?     *===============================================================*                       RADDAT
?     *                                                               *                       RADDAT
?     *  Additional information about KEYL0100:                       *                       RADDAT
?     *  My private API using DSPFD                                   *                       RADDAT
?     *                                                               *                       RADDAT
?     *===============================================================*                       RADDAT
?     *                                                                                       RADDAT
?     *  list API format KEYL0100                                                             RADDAT
?     *  (data structure can be used within the calling program                               RADDAT
?     *  to splitt XLIST into its units. See GETDBR_DMO)                                      RADDAT
     D KEYL0100        DS           256                                                       RADDAT
     D  APRCEN                 1      1A                                        über API      RADDAT
     D  APRDAT                 2      7A                                        über API      RADDAT
     D  APRTIM                 8     13A                                        über API      RADDAT
     D  APFILE                14     23A                                        über API      RADDAT
     D  APLIB                 24     33A                                        über API      RADDAT
     D  APFTYP                34     34A                                                      RADDAT
     D  APFILA                35     38A                                        über API      RADDAT
     D  APMXD                 39     41A                                                      RADDAT
     D  APFATR                42     47A                                                      RADDAT
     D  APSYSN                48     55A                                                      RADDAT
     D  APASP                 56     57P 0                                                    RADDAT
     D  APRES                 58     61A                                                      RADDAT
     D  APMANT                62     62A                                        über API      RADDAT
     D  APUNIQ                63     63A                                        über API      RADDAT
     D  APKEYO                64     64A                                        über API      RADDAT
     D  APSELO                65     65A                                                      RADDAT
     D  APACCP                66     66A                                                      RADDAT
     D  APNSCO                67     68P 0                                                    RADDAT
     D  APBOF                 69     78A                                                      RADDAT
     D  APBOL                 79     88A                                                      RADDAT
     D  APBOLF                89     98A                                                      RADDAT
     D  APNKYF                99    100P 0                                      über API      RADDAT
     D  APKEYF               101    110A                                        über API      RADDAT
     D  APKSEQ               111    111A                                        über API      RADDAT
     D  APKSIN               112    112A                                        über API      RADDAT
     D  APKZD                113    113A                                        über API      RADDAT
     D  APKASQ               114    114A                                        über API      RADDAT
     D  APKEYN               115    116P 0                                      über API      RADDAT
     D  APJOIN               117    117A                                                      RADDAT
     D  APACPJ               118    118A                                                      RADDAT
     D  APRIKY               119    119A                                        über API      RADDAT
?     *                                                                                       RADDAT
