      *===============================================================*
      *                                                               *
      *  Additional information about KEYL0100:                       *
      *  My private API using DSPFD                                   *
      *                                                               *
      *===============================================================*
      *
      *  list API format KEYL0100
      *  (data structure can be used within the calling program
      *  to splitt XLIST into its units. See GETDBR_DMO)
     D KEYL0100_t      DS           256    qualified
     D  APRCEN                 1      1A
     D  APRDAT                 2      7A
     D  APRTIM                 8     13A
     D  APFILE                14     23A
     D  APLIB                 24     33A
     D  APFTYP                34     34A
     D  APFILA                35     38A
     D  APMXD                 39     41A
     D  APFATR                42     47A
     D  APSYSN                48     55A
     D  APASP                 56     57P 0
     D  APRES                 58     61A
     D  APMANT                62     62A
     D  APUNIQ                63     63A
     D  APKEYO                64     64A
     D  APSELO                65     65A
     D  APACCP                66     66A
     D  APNSCO                67     68P 0
     D  APBOF                 69     78A
     D  APBOL                 79     88A
     D  APBOLF                89     98A
     D  APNKYF                99    100P 0
     D  APKEYF               101    110A
     D  APKSEQ               111    111A
     D  APKSIN               112    112A
     D  APKZD                113    113A
     D  APKASQ               114    114A
     D  APKEYN               115    116P 0
     D  APJOIN               117    117A
     D  APACPJ               118    118A
     D  APRIKY               119    119A
      *
