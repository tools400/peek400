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

2. Die Sicherungsdatei `PEEKnnn.SAVF` aus dem
   [aktuellen Release](https://github.com/tools400/peek400/releases/latest) herunterladen (`nnn` ist
   die Version) und per FTP **im Binärmodus** übertragen:

   ```ftp
   binary
   put PEEKnnn.SAVF peekinst/peek
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

## Verwendung

Wie Sie mit Peek/400 arbeiten, beschreibt [USAGE.md](USAGE.md): Schnellstart, Tasten, Auswahlen
und Anpassungen. Das ausführliche Benutzerhandbuch gibt es auf [Deutsch](doc/Peek400g.pdf) und
[Englisch](doc/Peek400e.pdf).

## Entwicklung

Wie Peek/400 gebaut und getestet und wie ein Release erstellt wird, beschreibt
[DEVELOPMENT.md](DEVELOPMENT.md).

## Haftung

Diese Software ist kostenlos und wird ohne Gewähr bereitgestellt. Die Verwendung erfolgt auf
eigenes Risiko: Testen Sie sie zuerst mit unkritischen Daten und sichern Sie Ihre Daten, bevor Sie
sie einsetzen. Ergänzend gilt die [Lizenz](LICENSE).
