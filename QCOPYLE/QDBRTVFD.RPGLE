      /IF NOT DEFINED(QDBRTVFD)                                                               RADDAT
      /DEFINE QDBRTVFD                                                                        RADDAT
?     *                                                                                       RADDAT
?     *  Retrieve Database File Description (QDBRTVFD) API                                    RADDAT
     D QDBRTVFD...                                                                            RADDAT
     D                 PR                  extpgm('QDBRTVFD')                                 RADDAT
     D  o_rcvVar                  65535A         options(*varsize)                            RADDAT
     D  i_lenRcvVar                  10I 0 const                                              RADDAT
     D  o_retFileName                20A                                                      RADDAT
     D  i_format                      8A   const                                              RADDAT
     D  i_qFile                      20A   const                                              RADDAT
     D  i_rcdFormat                  10A   const                                              RADDAT
     D  i_override                    1A   const                                              RADDAT
     D  i_system                     10A   const                                              RADDAT
     D  i_formatType                 10A   const                                              RADDAT
     D  io_errCode                65535A          options(*varsize )                          RADDAT
?     *                                                                                       RADDAT
?     *  File Definition Header (Qdb_Qdbfh)                                                   RADDAT
     D Qdb_Qdbfh_t     DS                  qualified               based(pDummy)              RADDAT
     D  Qdbfyret               1      4I 0                                                    RADDAT
     D  Qdbfyavl               5      8I 0                                                    RADDAT
     D  Qdbfhflg               9     10U 0                                                    RADDAT
     D  Reserved_7            11     14A                                                      RADDAT
     D  Qdbflbnum             15     16I 0                                                    RADDAT
     D  Qdbfknum              17     18I 0                                                    RADDAT
     D  Qdbfkmxl              19     20I 0                                                    RADDAT
     D  Qdbfkflg              21     21A                                                      RADDAT
     D  Qdbfkfdm              22     22A                                                      RADDAT
     D  Reserved_10           23     30A                                                      RADDAT
     D  Qdbfhaut              31     40A                                                      RADDAT
     D  Qdbfhupl              41     41A                                                      RADDAT
     D  Qdbfhmxm              42     43I 0                                                    RADDAT
     D  Qdbfwtfi              44     45I 0                                                    RADDAT
     D  Qdbfhfrt              46     47I 0                                                    RADDAT
     D  Qdbfhmnum             48     49I 0                                                    RADDAT
     D  Qdbfapsize            50     51I 0                                                    RADDAT
     D  Reserved_11           52     58A                                                      RADDAT
     D  Qdbfbrwt              59     60I 0                                                    RADDAT
     D  Qaaf                  61     61A                                                      RADDAT
     D  Qdbffmtnum            62     63I 0                                                    RADDAT
     D  Qdbfhfl2              64     65A                                                      RADDAT
     D  Qdbfvrm               66     67I 0                                                    RADDAT
     D  Qaaf2                 68     69A                                                      RADDAT
     D  Qdbfhcrt              70     82A                                                      RADDAT
     D  Reserved_18           83     84A                                                      RADDAT
     D  Qdbfhtxt              85    134A                                                      RADDAT
     D  Reserved_19          135    147A                                                      RADDAT
     D  Qdbfsrcf             148    157A                                                      RADDAT
     D  Qdbfsrcm             158    167A                                                      RADDAT
     D  Qdbfsrcl             168    177A                                                      RADDAT
     D  Qdbfkrcv             178    178A                                                      RADDAT
     D  Reserved_20          179    201A                                                      RADDAT
     D  Qdbftcid             202    203I 0                                                    RADDAT
     D  Qdbfasp              204    205I 0                                                    RADDAT
     D  Qdbfnbit             206    206A                                                      RADDAT
     D  Qdbfmxfnum           207    208I 0                                                    RADDAT
     D  Reserved_22          209    284A                                                      RADDAT
     D  Qdbfodic             285    288I 0                                                    RADDAT
     D  Reserved_23          289    302A                                                      RADDAT
     D  Qdbffigl             303    304I 0                                                    RADDAT
     D  Qdbfmxrl             305    306I 0                                                    RADDAT
     D  Reserved_24          307    314A                                                      RADDAT
     D  Qdbfgkct             315    316I 0                                                    RADDAT
     D  Qdbfos               317    320I 0                                                    RADDAT
     D  Reserved_25          321    328A                                                      RADDAT
     D  Qdbfocs              329    332I 0                                                    RADDAT
     D  Reserved_26          333    336A                                                      RADDAT
     D  Qdbfpact             337    338A                                                      RADDAT
     D  Qdbfhrls             339    344A                                                      RADDAT
     D  Reserved_27          345    364A                                                      RADDAT
     D  Qdbpfof              365    368I 0                                                    RADDAT
     D  Qdblfof              369    372I 0                                                    RADDAT
     D  Qdbfnlsb             373    373A                                                      RADDAT
     D  Qdbflang             374    376A                                                      RADDAT
     D  Qdbfcnty             377    378A                                                      RADDAT
     D  Qdbfjorn             379    382I 0                                                    RADDAT
     D  Qdbfevid             383    386I 0                                                    RADDAT
     D  Reserved_28          387    400A                                                      RADDAT
?     *                                                                                       RADDAT
?     *  Format Definition Header (Qdb_Qddfmt)                                                RADDAT
     D Qdb_Qddfmt_t    DS                  qualified               based(pDummy)              RADDAT
     D  bytRet                 1      4I 0                                                    RADDAT
     D  bytAvl                 5      8I 0                                                    RADDAT
     D  Reserved_62            9     32A                                                      RADDAT
     D  Qddfmtf               33     33A                                                      RADDAT
     D  Qddfxlto              34     37I 0                                                    RADDAT
     D  Qddfrcao              38     41I 0                                                    RADDAT
     D  Qddfdico              42     45I 0                                                    RADDAT
     D  Qddfrcid              46     47I 0                                                    RADDAT
     D  Qddfsrcd              48     49I 0                                                    RADDAT
     D  Qddfrtcd              50     51I 0                                                    RADDAT
     D  Qddfrlcd              52     53I 0                                                    RADDAT
     D  Reserved_64           54     60A                                                      RADDAT
     D  Qddftflgs             61     61A                                                      RADDAT
     D  Qddflgs               62     62U 0                                                    RADDAT
     D  Reserved_67           63     66A                                                      RADDAT
     D  Qddfrlen              67     70I 0                                                    RADDAT
     D  Qddfname              71     80A                                                      RADDAT
     D  Qddfseq               81     93A                                                      RADDAT
     D  Qddftext              94    143A                                                      RADDAT
     D  Qddffldnum           144    145I 0                                                    RADDAT
     D  Qddf_Identity_Off...                                                                  RADDAT
     D                       146    149I 0                                                    RADDAT
?     * Qddffldx                    CHAR(*)   Start of field definition array (Qdb_Qddffld)   RADDAT
?     *                                                                                       RADDAT
?     *  File Scope Array (Qdb_Qdbfb)                                                         RADDAT
     D Qdb_Qdbfb_t     DS                  qualified               based(pDummy)              RADDAT
     D  Reserved_48            1     48A                                                      RADDAT
     D  Qdbfbf                49     58A                                                      RADDAT
     D  Qdbfbfl               59     68A                                                      RADDAT
     D  Qdbft                 69     78A                                                      RADDAT
     D  Reserved_49           79    115A                                                      RADDAT
     D  Qdbfbgky             116    117I 0                                                    RADDAT
     D  Reserved_50          118    119A                                                      RADDAT
     D  Qdbfblky             120    121I 0                                                    RADDAT
     D  Reserved_51          122    123A                                                      RADDAT
     D  Qdbffogl             124    125I 0                                                    RADDAT
     D  Reserved_52          126    128A                                                      RADDAT
     D  Qdbfsoon             129    130I 0                                                    RADDAT
     D  Qdbfsoof             131    134I 0                                                    RADDAT
     D  Qdbfksof             135    138I 0                                                    RADDAT
     D  Qdbfkyct             139    140I 0                                                    RADDAT
     D  Qdbfgenf             141    142I 0                                                    RADDAT
     D  Qdbfodis             143    146I 0                                                    RADDAT
     D  Reserved_53          146    160A                                                      RADDAT
?     *                                                                                       RADDAT
?     *  Key Specification Array (Qdb_Qdbfk)                                                  RADDAT
     D Qdb_Qdbfk_t     DS                  qualified               based(pDummy)              RADDAT
     D  Qdbfkfld               1     10A                                                      RADDAT
     D  Reserved_59           11     13A                                                      RADDAT
     D  Qdbfksq               14     14A                                                      RADDAT
     D  Reserved_61           15     32A                                                      RADDAT
?     *                                                                                       RADDAT
      /ENDIF                                                                                  RADDAT
