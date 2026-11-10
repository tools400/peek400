# Peek/400

Datenbankbrowser und -editor für IBM i (AS/400). Peek/400 zeigt die Datensätze einer
Datei in einer Subfile an. Man kann darin suchen und Datensätze ändern, einfügen,
kopieren, löschen und drucken.

## Funktionen

- Anzeige der Datensätze in einer Subfile, 80/132-Zeichen-Modus
- Sortierung nach Schlüsselfolge oder Satzfolge, Auswahl und Sortierung mit SQL `WHERE` und `ORDER BY`
- Pin-Funktion für Spalten (linker Rand) und Zeilen (oberer Rand)
- Suchfunktion, Anzeige der Datenbankrelationen, Layout und Farben einstellbar
- Ändern, Einfügen, Kopieren (auch in eine andere Datei), Löschen und Drucken von Datensätzen,
  mit Commit und Rollback
- Hex-Editor und Text-Editor auf Feldebene, auch für Felder mit nicht darstellbaren Zeichen
- Arbeitsumgebungen sichern und laden
- Frei belegbare Funktionstasten und Subfileauswahlen, Kurzbefehle wie im SEU
- Oberfläche in Deutsch, Englisch, Spanisch, Italienisch und Französisch, um eigene Sprachen erweiterbar
- Exit-Programme für Zugriffsrechte (`EXIT01`) und für Feldtexte und Spaltenüberschriften (`EXIT06`)

## Voraussetzungen

- IBM i ab V7R3M0
- ILE-RPG-Compiler: Peek/400 erstellt die Programme zum Ändern, Einfügen und Kopieren von
  Datensätzen zur Laufzeit für jede Datei. Ohne Compiler können Sie Datensätze weder einfügen
  noch ändern noch innerhalb der Datei kopieren.

## Installation

1. Bibliothek und Sicherungsdatei für die Installation anlegen:

   ```clle
   CRTLIB  LIB(PEEKINST)
   CRTSAVF FILE(PEEKINST/PEEK)
   ```

2. Die Sicherungsdatei `PEEK408.SAVF` aus dem
   [aktuellen Release](https://github.com/tools400/peek400/releases/latest) herunterladen und per FTP
   **im Binärmodus** übertragen:

   ```ftp
   binary
   put PEEK408.SAVF peekinst/peek
   ```

3. Programmbibliothek anlegen und die Objekte zurückspeichern:

   ```clle
   CRTLIB LIB(PEEK)
   RSTOBJ OBJ(*ALL) SAVLIB(PEEK) DEV(*SAVF) OBJTYPE(*ALL) SAVF(PEEKINST/PEEK) OUTPUT(*PRINT)
   ```

4. Danach können Sie die Bibliothek `PEEKINST` löschen. Bei Bedarf kopieren Sie den Befehl `PEEK`
   nach `QGPL`:

   ```clle
   CRTDUPOBJ OBJ(PEEK) FROMLIB(PEEK) OBJTYPE(*CMD) TOLIB(QGPL)
   ```

**Update:** Die alte Bibliothek `PEEK` umbenennen und Peek/400 neu installieren. Eigene Änderungen
an `PEEKSRC`, `PEEKUSR` oder `EXIT01PF` müssen Sie danach selbst in die neuen Dateien übernehmen.

**Sprache:** `PEEKINIT LANGUAGE(GER | ENG | SPA | ITA | FRA)` erstellt die Befehle `PEEK` und `TREE`
in der gewählten Sprache neu.

## Schnellstart

```clle
PEEK FILE(MYLIB/MYFILE)
```

Die wichtigsten Parameter:

| Parameter | Bedeutung |
|---|---|
| `FILE`, `MEMBER` | Datei und Teildatei |
| `ACCESS` | Zugriffsart: `*KEY` (Schlüsselfolge), `*RRN` (Satzfolge) oder `*SQL` |
| `WHERE`, `ORDERBY` | SQL-Auswahl und -Sortierung |
| `LANGUAGE` | Sprache der Bildschirme, z.B. `GER` oder `ENG` |
| `ALWCHGLIB`, `ALWCHGFILE`, `ALWCHGMBR`, `ALWCHGRCD` | Wechsel von Bibliothek, Datei und Teildatei bzw. Ändern der Datensätze erlauben |
| `ENVFILE`, `ENVMBR`, `ENVSAVE` | Arbeitsumgebung laden und beim Verlassen speichern |

Der erste Aufruf in einem Job dauert etwas länger, weil Peek/400 einmalig Vorbereitungen in
`QTEMP` trifft.

Standardbelegung der wichtigsten Tasten und Auswahlen:

| Taste | Funktion | Auswahl | Funktion |
|---|---|---|---|
| F1 | SQL-Auswahl | 2 | Ändern |
| F2 | Spalten pinnen | 3 | Kopieren |
| F3 | Beenden | 4 | Löschen |
| F5 | Aktualisieren | 5 | Anzeigen |
| F6 | Datensatz einfügen | 6 | Drucken |
| F9 | Datenbankrelationen | 9 | In externe Datei kopieren |
| F11 | Layout | P / U | Zeile pinnen / lösen |
| F16 | Suchen | S | Sortierung umschalten |
| F17 / F18 | Dateianfang / Dateiende | H | Hex-Anzeige umschalten |
| F23 / F24 | Weitere Auswahlen / Tasten | RB | Update-Programm neu erstellen |

Im Bildschirm „Datensatz ändern“ öffnet F9 den Hex-Editor und F10 den Text-Editor für das Feld
unter dem Cursor.

## Anpassen

- **Funktionstasten und Auswahlen:** Die Belegung ist pro Benutzer in einer Datei mit dem Namen des
  Benutzerprofils in der Programmbibliothek gespeichert. Neue Benutzer erhalten eine Kopie von
  `PEEKUSR`. Wenn Sie `PEEKUSR` ändern, ändern Sie damit die Standardbelegung für neue Benutzer.
- **Kurzbefehle:** Einträge der Section `*CMD`, z.B. `FD` → `DSPFD FILE(&L/&F)`. Peek/400 ersetzt
  `&L`, `&F` und `&N` durch Bibliothek, Datei und Teildatei, `&R` durch die Satznummer und
  `%Feldname` durch den Feldinhalt des aktuellen Datensatzes.
- **Eigene Sprache:** Die Nachrichtendatei `PEEKGER` kopieren, die Texte übersetzen und Peek/400 mit
  `LANGUAGE(...)` starten.
- **Exit-Programme:** Die Quellen von `EXIT01` und `EXIT06` liegen in `QEXAMPLE` und können
  angepasst werden.

## Dokumentation

Das ausführliche Benutzerhandbuch gibt es auf [Deutsch](doc/Peek400g.pdf) und
[Englisch](doc/Peek400e.pdf).

## Entwicklung

Wie Peek/400 gebaut und getestet und wie ein Release erstellt wird, beschreibt
[DEVELOPMENT.md](DEVELOPMENT.md).

## Haftung

Peek/400 ist Freeware und wird ohne Gewähr bereitgestellt. Testen Sie das Programm mit unkritischen
Daten. Für Schäden an Daten wird keine Haftung übernommen.
