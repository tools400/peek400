<#
.SYNOPSIS
    Lädt die Sicherungsdateien von Peek/400 vom IBM i und veröffentlicht ein Release auf GitHub.

.DESCRIPTION
    download  Holt die Sicherungsdateien PEEK<vvv> (Produkt) und PEEK<vvv>P (Entwicklungs-
              bibliothek) per FTP aus der Bibliothek -SavfLib des IBM i in das Verzeichnis
              -ReleaseDir. <vvv> ist die Version ohne Punkte, z.B. 408 für 4.0.8.

    publish   Legt das Tag v<Version> an, pusht es nach GitHub und erstellt das Release mit der
              Sicherungsdatei PEEK<vvv> und den Handbüchern aus doc/. Die Entwicklungsbibliothek
              PEEK<vvv>P geht nicht ins Release. Den Text des Releases nimmt das Skript aus dem
              Abschnitt "Version <Version>" von QRPGLESRC/#035WHATS_NEW.TXT.

    help      Zeigt diese Hilfe, ebenso ein Aufruf ohne Parameter.

    Ohne -ReleaseDir landen alle Dateien in temp/ im Repository. Git ignoriert das Verzeichnis,
    und RDi blendet es aus, damit die Sicherungsdateien weder ins Repository noch auf das IBM i
    gelangen.

.PARAMETER Task
    download, publish oder help.

.PARAMETER Version
    Version von Peek/400, z.B. 4.0.8. Pflicht bei download und publish.

.EXAMPLE
    .\.github\release.ps1 download -Version 4.0.8

.EXAMPLE
    .\.github\release.ps1 publish -Version 4.0.8 -WhatIf

    Probelauf: prüft alles und zeigt Text und Dateien des Releases, ändert aber nichts.

.EXAMPLE
    .\.github\release.ps1 help

    Zeigt diese Hilfe. In der Eingabeaufforderung: .github\release help oder .github\release /?
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Position = 0)]
    [ValidateSet('download', 'publish', 'help')]
    [string] $Task,

    [ValidatePattern('^\d+\.\d+\.\d+$')]
    [string] $Version,

    # Verzeichnis für die Dateien des Releases. Standard: temp\ im Repository.
    [string] $ReleaseDir,

    # Anmeldung am IBM i. Ohne Angabe fragt das Skript danach.
    [pscredential] $Credential,

    [string] $FtpHost = 'ghentw.gfd.de',
    [string] $FtpUser = 'RADDATZ',
    [string] $SavfLib = 'RADDATZ',
    [string] $Repo = 'tools400/peek400'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptCall = '.\.github\release.ps1'                     # für Hinweise in Meldungen
if (-not $Task -or $Task -eq 'help') {
    Get-Help -Name $PSCommandPath -Detailed
    return
}
if (-not $Version) {
    throw "Für '$Task' fehlt -Version, z.B.: $ScriptCall $Task -Version 4.1.0. Hilfe: $ScriptCall help"
}

$RepoRoot = Split-Path -Parent $PSScriptRoot
if (-not $ReleaseDir) {
    $ReleaseDir = Join-Path $RepoRoot 'temp'
}
# Relativ zum aktuellen Verzeichnis des Aufrufers, bevor das Skript ins Repository wechselt.
$ReleaseDir = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($ReleaseDir)
$Tag = "v$Version"
$SavfName = 'PEEK' + ($Version -replace '\.', '')          # 4.0.8 -> PEEK408
$SavfFile = Join-Path $ReleaseDir "$SavfName.SAVF"          # Produkt, geht ins Release
$DevSavfName = "${SavfName}P"                               # Entwicklungsbibliothek, nur Download
$SavfFiles = [ordered]@{
    $SavfName    = $SavfFile
    $DevSavfName = Join-Path $ReleaseDir "$DevSavfName.SAVF"
}
$WhatsNewFile = Join-Path $RepoRoot 'QRPGLESRC\#035WHATS_NEW.TXT'

# Handbücher im Repository -> Namen im Release
$Manuals = [ordered]@{
    'doc\Peek400g.pdf' = 'Peek{0}g.pdf' -f ($Version -replace '\.', '')
    'doc\Peek400e.pdf' = 'Peek{0}e.pdf' -f ($Version -replace '\.', '')
}

function Invoke-Tool {
    # Ruft ein Programm auf, gibt seine Ausgabe zurück und bricht bei einem Fehler ab.
    param(
        [Parameter(Mandatory)] [string] $FilePath,
        [string[]] $ArgumentList = @(),
        [switch] $AllowFailure
    )
    # Meldungen auf stderr (z.B. Fortschritt von git) sind keine Fehler.
    $ErrorActionPreference = 'Continue'
    $output = & $FilePath @ArgumentList
    if ($LASTEXITCODE -ne 0 -and -not $AllowFailure) {
        throw "'$FilePath $($ArgumentList -join ' ')' ist mit Rückgabewert $LASTEXITCODE fehlgeschlagen."
    }
    $output
}

function ConvertTo-CurlString {
    # Maskiert einen Wert für eine Zeichenkette in Anführungszeichen in einer curl-Konfiguration.
    param([string] $Value)
    $Value.Replace('\', '\\').Replace('"', '\"')
}

function Invoke-Curl {
    # Startet curl und übergibt ihm die Konfiguration über die Standardeingabe. So steht das
    # Kennwort weder auf der Befehlszeile noch in einer Datei.
    # .NET schreibt die Standardeingabe mit [Console]::InputEncoding und stellt bei UTF-8 ein
    # BOM voran, das curl nicht versteht. Deshalb gilt für den Start ISO-8859-1. Das hat kein
    # BOM und erhält Umlaute im Kennwort.
    param([string] $Config, [string[]] $ArgumentList)
    $startInfo = New-Object Diagnostics.ProcessStartInfo
    $startInfo.FileName = (Get-Command curl.exe -CommandType Application | Select-Object -First 1).Source
    $startInfo.Arguments = ($ArgumentList | ForEach-Object { '"{0}"' -f $_ }) -join ' '
    $startInfo.UseShellExecute = $false
    $startInfo.RedirectStandardInput = $true
    $savedEncoding = [Console]::InputEncoding
    [Console]::InputEncoding = [Text.Encoding]::GetEncoding('iso-8859-1')
    try {
        $process = [Diagnostics.Process]::Start($startInfo)
    }
    finally {
        [Console]::InputEncoding = $savedEncoding
    }
    try {
        $process.StandardInput.Write($Config + "`n")
        $process.StandardInput.Close()
        $process.WaitForExit()
        $process.ExitCode
    }
    finally {
        $process.Dispose()
    }
}

function Invoke-Download {
    $names = @()
    foreach ($name in $SavfFiles.Keys) {
        if ($PSCmdlet.ShouldProcess("ftp://$FtpHost/$SavfLib/$name -> $($SavfFiles[$name])", 'Sicherungsdatei herunterladen')) {
            $names += $name
        }
    }
    if ($names.Count -eq 0) { return }

    $cred = $Credential
    if (-not $cred) {
        $cred = Get-Credential -UserName $FtpUser -Message "Anmeldung am IBM i $FtpHost"
        if (-not $cred) { throw 'Keine Anmeldedaten eingegeben.' }
    }
    $net = $cred.GetNetworkCredential()
    $config = 'user = "{0}:{1}"' -f (ConvertTo-CurlString $net.UserName), (ConvertTo-CurlString $net.Password)

    $null = New-Item -ItemType Directory -Path $ReleaseDir -Force
    foreach ($name in $names) {
        $url = "ftp://$FtpHost/$SavfLib/$name"
        $file = $SavfFiles[$name]
        $partFile = "$file.part"

        # NAMEFMT 0: Pfade im Format Bibliothek/Datei.
        # nocwd: curl übergibt RETR den ganzen Pfad, statt mit CWD in die Bibliothek zu wechseln.
        # Binär ist bei curl die Voreinstellung (TYPE I).
        Write-Host "Lade $url ..."
        $exitCode = Invoke-Curl -Config $config -ArgumentList @('--config', '-', '--ftp-method', 'nocwd',
            '--quote', 'SITE NAMEFMT 0', '--progress-bar', '--output', $partFile, $url)
        if ($exitCode -ne 0) {
            Remove-Item -LiteralPath $partFile -Force -ErrorAction SilentlyContinue
            throw "Download von $url fehlgeschlagen (curl-Rückgabewert $exitCode)."
        }
        Move-Item -LiteralPath $partFile -Destination $file -Force
        Write-Host ("Gespeichert: {0} ({1:N0} Byte)" -f $file, (Get-Item -LiteralPath $file).Length)
    }
}

function Get-GitHubRemote {
    $pattern = 'github\.com[:/]' + [regex]::Escape($Repo) + '(\.git)?/?$'
    foreach ($name in @(Invoke-Tool git @('remote'))) {
        $url = Invoke-Tool git @('config', '--get', "remote.$name.url") -AllowFailure
        if ($url -match $pattern) { return $name }
    }
    throw ("Kein Remote für github.com/$Repo gefunden. Anlegen und pushen mit:`n" +
        "  git remote add github git@github.com:$Repo.git`n" +
        "  git push github master")
}

function Get-ReleaseNotes {
    if (-not (Test-Path -LiteralPath $WhatsNewFile)) {
        throw "'$WhatsNewFile' nicht gefunden."
    }
    $lines = @(Get-Content -LiteralPath $WhatsNewFile -Encoding UTF8)
    $heading = '^\s*Version\s+(\d+\.\d+\.\d+)\s*$'
    $start = -1
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match $heading -and $Matches[1] -eq $Version) { $start = $i; break }
    }
    if ($start -lt 0) {
        throw "Kein Abschnitt 'Version $Version' in '$WhatsNewFile'."
    }
    $end = $lines.Count
    for ($i = $start + 1; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match $heading) { $end = $i; break }
    }

    # Überschrift, Unterstreichung und Leerzeilen am Anfang und Ende weglassen.
    $body = @($lines[($start + 1)..($end - 1)] | Where-Object { $_ -notmatch '^\s*=+\s*$' })
    while ($body.Count -gt 0 -and $body[0].Trim() -eq '') { $body = @($body | Select-Object -Skip 1) }
    while ($body.Count -gt 0 -and $body[-1].Trim() -eq '') { $body = @($body | Select-Object -SkipLast 1) }
    if ($body.Count -eq 0) {
        throw "Der Abschnitt 'Version $Version' in '$WhatsNewFile' ist leer."
    }

    # Gemeinsame Einrückung entfernen.
    $indent = ($body | Where-Object { $_.Trim() } | ForEach-Object { $_.Length - $_.TrimStart().Length } |
        Measure-Object -Minimum).Minimum
    $body = $body | ForEach-Object { if ($_.Length -ge $indent) { $_.Substring($indent) } else { $_.TrimStart() } }

    @(
        "Änderungen in Peek/400 ${Version}:"
        ''
        '```text'
        $body
        '```'
        ''
        "Installation: siehe [README](https://github.com/$Repo#installation)."
    ) -join "`n"
}

function Invoke-Publish {
    $null = Invoke-Tool gh @('auth', 'status')
    $remote = Get-GitHubRemote

    # Arbeitsbaum sauber und HEAD auf GitHub
    $dirty = @(Invoke-Tool git @('status', '--porcelain', '--untracked-files=no'))
    if ($dirty.Count -gt 0) {
        throw "Der Arbeitsbaum enthält nicht committete Änderungen:`n$($dirty -join "`n")"
    }
    Invoke-Tool git @('fetch', '--quiet', $remote) | Out-Null
    $head = Invoke-Tool git @('rev-parse', 'HEAD')
    $null = Invoke-Tool git @('rev-parse', '--verify', '--quiet', "refs/remotes/$remote/master") -AllowFailure
    if ($LASTEXITCODE -ne 0) {
        throw "Auf '$remote' gibt es noch keinen Branch master. Zuerst: git push $remote master"
    }
    $null = Invoke-Tool git @('merge-base', '--is-ancestor', $head, "$remote/master") -AllowFailure
    if ($LASTEXITCODE -ne 0) {
        throw "HEAD ($head) ist nicht in $remote/master enthalten. Zuerst: git push $remote master"
    }

    # Tag: neu anlegen, oder ein früherer, abgebrochener Lauf hat es schon für HEAD angelegt.
    $localTag = Invoke-Tool git @('rev-parse', '--verify', '--quiet', "refs/tags/$Tag") -AllowFailure
    $remoteTag = @(Invoke-Tool git @('ls-remote', '--tags', $remote, "refs/tags/$Tag")) |
        Where-Object { $_ -match "\srefs/tags/$([regex]::Escape($Tag))$" } |
        ForEach-Object { ($_ -split '\s+')[0] }
    if ($localTag) {
        $tagCommit = Invoke-Tool git @('rev-parse', "$Tag^{commit}")
        if ($tagCommit -ne $head) {
            throw "Das Tag $Tag gibt es schon für Commit $tagCommit, HEAD ist aber $head."
        }
    }
    if ($remoteTag -and $remoteTag -ne $localTag) {
        throw "Das Tag $Tag gibt es auf '$remote' schon, aber nicht als dasselbe Tag wie lokal."
    }

    $releases = @(Invoke-Tool gh @('api', '--paginate', "repos/$Repo/releases", '--jq', '.[].tag_name'))
    if ($releases -contains $Tag) {
        throw "Das Release $Tag gibt es auf GitHub schon: https://github.com/$Repo/releases/tag/$Tag"
    }

    # Sicherungsdatei
    if (-not (Test-Path -LiteralPath $SavfFile)) {
        throw "'$SavfFile' nicht gefunden. Zuerst: $ScriptCall download -Version $Version"
    }
    $commitTime = [datetime] (Invoke-Tool git @('log', '-1', '--format=%cI'))
    $savfTime = (Get-Item -LiteralPath $SavfFile).LastWriteTime
    if ($savfTime -lt $commitTime) {
        throw ("'{0}' ({1:dd.MM.yyyy HH:mm}) ist älter als der letzte Commit ({2:dd.MM.yyyy HH:mm}). " +
            "Laden Sie die Sicherungsdatei neu: {3} download -Version {4}") -f
            $SavfFile, $savfTime, $commitTime, $ScriptCall, $Version
    }

    # Handbücher
    foreach ($manual in $Manuals.Keys) {
        if (-not (Invoke-Tool git @('ls-files', '--', ($manual -replace '\\', '/')))) {
            throw "'$manual' ist nicht im Repository."
        }
    }

    $notes = Get-ReleaseNotes
    $assets = @($SavfFile) + @($Manuals.Values | ForEach-Object { Join-Path $ReleaseDir $_ })

    Write-Host "Release $Tag für github.com/$Repo"
    Write-Host "  Commit:  $head"
    Write-Host "  Remote:  $remote"
    Write-Host '  Dateien:'
    $assets | ForEach-Object { Write-Host "    $_" }
    Write-Host '  Text:'
    $notes -split "`n" | ForEach-Object { Write-Host "    $_" }
    Write-Host ''

    if (-not $localTag -and $PSCmdlet.ShouldProcess("$Tag auf $head", 'Tag anlegen')) {
        Invoke-Tool git @('tag', '--annotate', $Tag, '--message', "Peek/400 $Version", $head) | Out-Null
    }
    if (-not $remoteTag -and $PSCmdlet.ShouldProcess("$Tag nach $remote", 'Tag pushen')) {
        Invoke-Tool git @('push', $remote, "refs/tags/$Tag") | Out-Null
    }
    if ($PSCmdlet.ShouldProcess("github.com/$Repo", "Release $Tag erstellen")) {
        foreach ($manual in $Manuals.Keys) {
            Copy-Item -LiteralPath (Join-Path $RepoRoot $manual) -Destination (Join-Path $ReleaseDir $Manuals[$manual]) -Force
        }
        $notesFile = Join-Path $ReleaseDir 'RELEASE_NOTES.md'
        [IO.File]::WriteAllText($notesFile, $notes, (New-Object Text.UTF8Encoding $false))
        $url = Invoke-Tool gh (@('release', 'create', $Tag, '--repo', $Repo, '--title', "Peek/400 $Version",
                '--notes-file', $notesFile, '--verify-tag') + $assets)
        Write-Host "Release erstellt: $url"
    }
}

Push-Location -LiteralPath $RepoRoot
try {
    switch ($Task) {
        'download' { Invoke-Download }
        'publish' { Invoke-Publish }
    }
}
finally {
    Pop-Location
}
