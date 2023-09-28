      *
     C                   MOVEL (P) 佝ILE         佝ILE            10
     C                   MOVEL (P) 兵IB          兵IB             10
     C                   MOVEL (P) 冶BR          冶BR             10
      *
     C                   MOVEL (P) 兌N99         兌N99             1
      *
     C                   MOVEL (P) 刪ETURN       刪ETURN           1
     C                   MOVEL (P) 利CMD         利CMD           256
     C                   Z-ADD     利CMDL        利CMDL           15 5
      *
      *  L飉chen Teildatei ...
      *     CLRPFM
     C                   MOVEL (P) 'CLRPFM'      利CMD
      *     Datei
     C                   CAT       'FILE(':1     利CMD
      *     - Bibliothek
     C     兵IB          IFNE      *BLANKS
     C                   CAT       兵IB:0        利CMD
     C                   ELSE
     C                   CAT       '*LIBL':0     利CMD
     C                   ENDIF
     C                   CAT       '/':0         利CMD
     C                   CAT       佝ILE:0       利CMD
     C                   CAT       ')':0         利CMD
      *     Member
     C                   CAT       'MBR(':1      利CMD
     C     冶BR          IFNE      *BLANKS
     C                   CAT       冶BR:0        利CMD
     C                   ELSE
     C                   CAT       '*NONE'       利CMD
     C                   ENDIF
     C                   CAT       ')':0         利CMD
      *
      *     Pr�fung durchf�hren ...
     C                   MOVEL(P)  *IN99         兌N99
      *
     C                   Z-ADD     256           利CMDL
     C                   CALL      'QCMDEXC'                            99
     C                   PARM                    利CMD
     C                   PARM                    利CMDL
      *
     C                   MOVEL(P)  *IN99         刪ETURN
      *
     C                   MOVEL(P)  兌N99         *IN99
      *
