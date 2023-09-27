      *===============================================================*
      *                                                               *
      *  Additional information about SELL0100:                       *
      *  SELECT/OMIT statements                                       *
      *                                                               *
      *===============================================================*
      *
      *  list API format SELL0100
      *  (data structure can be used within the calling program
      *  to splitt XData into its units.)
     D SELL0100_t      DS           256    qualified template
     D  SORCEN                 1      1A                                        über API
     D  SORDAT                 2      7A                                        über API
     D  SORTIM                 8     13A                                        über API
     D  SOFILE                14     23A                                        über API
     D  SOLIB                 24     33A                                        über API
     D  SOFTYP                34     34A
     D  SOFILA                35     38A                                        über API
     D  SOMXD                 39     41A
     D  SOFATR                42     47A
     D  SOSYSN                48     55A
     D  SOASP                 56     57P 0
     D  SORES                 58     61A
      *
     D  SONRUL                62     64P 0                                      über API
     D  SORFMT                65     74A                                        über API
     D  SOFLD                 75     84A                                        über API
     D  SORULE                85     85A                                        über API
     D  SOCOMP                86     87A                                        über API
     D  SONVAL                88     89P 0                                      über API
     D  SOVALL                90     91P 0                                      über API
     D  SOVALU                92    123A                                        über API
     D  SODYNS               124    124A                                        über API
     D  SOFJVL               125    126P 0
     D  SOPJVL               127    128P 0
      *
