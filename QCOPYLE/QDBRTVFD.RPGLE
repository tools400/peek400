      /IF NOT DEFINED(QDBRTVFD)
      /DEFINE QDBRTVFD
      *
      *  Retrieve Database File Description (QDBRTVFD) API
     D QDBRTVFD...
     D                 PR                  extpgm('QDBRTVFD')
     D  o_rcvVar                  65535A         options(*varsize)
     D  i_lenRcvVar                  10I 0 const
     D  o_retFileName                20A
     D  i_format                      8A   const
     D  i_qFile                      20A   const
     D  i_rcdFormat                  10A   const
     D  i_override                    1A   const
     D  i_system                     10A   const
     D  i_formatType                 10A   const
     D  io_errCode                65535A          options(*varsize )
      *
      *  File Definition Header (Qdb_Qdbfh)
     D Qdb_Qdbfh_t     DS                  qualified template
     D  Qdbfyret               1      4I 0
     D  Qdbfyavl               5      8I 0
     D  Qdbfhflg               9     10U 0
     D   QdbfhflgH                    1A   OVERLAY(Qdbfhflg:1)
     D   QdbfhflgL                    1A   OVERLAY(Qdbfhflg:2)
     D  Reserved_7            11     14A
     D  Qdbflbnum             15     16I 0
     D  Qdbfknum              17     18I 0
     D  Qdbfkmxl              19     20I 0
     D  Qdbfkflg              21     21A
     D  Qdbfkfdm              22     22A
     D  Reserved_10           23     30A
     D  Qdbfhaut              31     40A
     D  Qdbfhupl              41     41A
     D  Qdbfhmxm              42     43I 0
     D  Qdbfwtfi              44     45I 0
     D  Qdbfhfrt              46     47I 0
     D  Qdbfhmnum             48     49I 0
     D  Qdbfapsize            50     51I 0
     D  Reserved_11           52     58A
     D  Qdbfbrwt              59     60I 0
     D  Qaaf                  61     61A
     D  Qdbffmtnum            62     63I 0
     D  Qdbfhfl2              64     65A
     D  Qdbfvrm               66     67I 0
     D  Qaaf2                 68     69A
     D   Qaaf2H                       1A   overlay(Qaaf2: 1)
     D   Qaaf2L                       1A   overlay(Qaaf2: 2)
     D  Qdbfhcrt              70     82A
     D  Reserved_18           83     84A
     D  Qdbfhtxt              85    134A
     D  Reserved_19          135    147A
     D  Qdbfsrcf             148    157A
     D  Qdbfsrcm             158    167A
     D  Qdbfsrcl             168    177A
     D  Qdbfkrcv             178    178A
     D  Reserved_20          179    201A
     D  Qdbftcid             202    203I 0
     D  Qdbfasp              204    205I 0
     D  Qdbfnbit             206    206A
     D  Qdbfmxfnum           207    208I 0
     D  Reserved_22          209    284A
     D  Qdbfodic             285    288I 0
     D  Reserved_23          289    302A
     D  Qdbffigl             303    304I 0
     D  Qdbfmxrl             305    306I 0
     D  Reserved_24          307    314A
     D  Qdbfgkct             315    316I 0
     D  Qdbfos               317    320I 0
     D  Reserved_25          321    328A
     D  Qdbfocs              329    332I 0
     D  Reserved_26          333    336A
     D  Qdbfpact             337    338A
     D  Qdbfhrls             339    344A
     D  Reserved_27          345    364A
     D  Qdbpfof              365    368I 0
     D  Qdblfof              369    372I 0
     D  Qdbfnlsb             373    373A
     D  Qdbflang             374    376A
     D  Qdbfcnty             377    378A
     D  Qdbfjorn             379    382I 0
     D  Qdbfevid             383    386I 0
     D  Reserved_28          387    400A
      *
      *  Format Definition Header (Qdb_Qddfmt)
     D Qdb_Qddfmt_t    DS                  qualified template
     D  bytRet                 1      4I 0
     D  bytAvl                 5      8I 0
     D  Reserved_62            9     32A
     D  Qddfmtf               33     33A
     D  Qddfxlto              34     37I 0
     D  Qddfrcao              38     41I 0
     D  Qddfdico              42     45I 0
     D  Qddfrcid              46     47I 0
     D  Qddfsrcd              48     49I 0
     D  Qddfrtcd              50     51I 0
     D  Qddfrlcd              52     53I 0
     D  Reserved_64           54     60A
     D  Qddftflgs             61     61A
     D  Qddflgs               62     62U 0
     D  Reserved_67           63     66A
     D  Qddfrlen              67     70I 0
     D  Qddfname              71     80A
     D  Qddfseq               81     93A
     D  Qddftext              94    143A
     D  Qddffldnum           144    145I 0
     D  Qddf_Identity_Off...
     D                       146    149I 0
      * Qddffldx                    CHAR(*)   Start of field definition array (Qdb_Qddffld)
      *
      *  File Scope Array (Qdb_Qdbfb)
     D Qdb_Qdbfb_t     DS                  qualified template
     D  Reserved_48            1     48A
     D  Qdbfbf                49     58A
     D  Qdbfbfl               59     68A
     D  Qdbft                 69     78A
     D  Reserved_49           79    115A
     D  Qdbfbgky             116    117I 0
     D  Reserved_50          118    119A
     D  Qdbfblky             120    121I 0
     D  Reserved_51          122    123A
     D  Qdbffogl             124    125I 0
     D  Reserved_52          126    128A
     D  Qdbfsoon             129    130I 0
     D  Qdbfsoof             131    134I 0
     D  Qdbfksof             135    138I 0
     D  Qdbfkyct             139    140I 0
     D  Qdbfgenf             141    142I 0
     D  Qdbfodis             143    146I 0
     D  Reserved_53          146    160A
      *
      *  Key Specification Array (Qdb_Qdbfk)
     D Qdb_Qdbfk_t     DS                  qualified template
     D  Qdbfkfld               1     10A
     D  Reserved_59           11     13A
     D  Qdbfksq               14     14A
     D  Reserved_61           15     32A
      *
      *  Logical File Specific Attributes (Qdb_Qdbflogl)
     D Qdb_Qdbflogl_t  DS                  qualified template
     D  Qdbfoj                 1      4I 0
     D  Qdbfscsn               5      6I 0
     D  Qdbflxp                7     16A
     D  Qdbflxl               17     26A
     D  Qdbfovw               27     30I 0
     D  Qlfa                  31     31A
     D  Qdbfjtyp              32     32A
     D  Qdbfsrcd              33     34I 0
     D  Qdbfwchk              35     35A
     D  Reserved_38           36     48A
      *
      *  Select/Omit Specification Array (Qdb_Qdbfss)
     D Qdb_Qdbfss_t    DS                  qualified template
     D  Reserved54             1      2A
     D  Qdbfssso               3      3A
     D  Qdbfssop               4      5A
     D  Qdbfssfn               6     15A
     D  Qdbfsspnum            16     17I 0
     D  Qsosaf                18     19A
     D  Qdbfssfj              19     20I 0
     D  Reserved56            21     28A
     D  Qdbfsoso              29     32I 0
      *
      *  Select/Omit Parameters (Qdb_Qdbfsp)
     D Qdb_Qdbfsp_t    DS                  qualified template
     D  Qdbfspno               1      4I 0
     D  Qdbfspln               5      6I 0
     D  Qdbfspin               7      7A
     D  Qasopaf                8      8A
     D  Qdbfsppj               9     10I 0
     D  Reserved58            11     20A
     D  Qdbfspvl              21     52A
      *
      /ENDIF
