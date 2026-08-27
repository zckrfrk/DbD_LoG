### DBD Loadout Generator - SurvCore Editon ###

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
Set-Location -Path $PSScriptRoot

# --- Safe helpers ---
function SafeValue {
    param($v)
    if ($null -eq $v) { return "" }
    $s = $v.ToString()
    if ($s.TrimStart().ToLower().StartsWith("if ")) { return "'"+$s }
    return $s
}
function SafeArray {
    param($arr)
    if ($null -eq $arr) { return @() }
    if ($arr -is [System.Array]) { return $arr }
    return ,$arr
}

# --- Config ---
$configPath = Join-Path $PSScriptRoot "config.json"
function Load-Config { param($p) if (Test-Path $p) { try { ConvertFrom-Json (Get-Content $p -Raw -Encoding UTF8) } catch { $null } } else { $null } }
function Save-Config { param($p,$o) try { Set-Content $p ($o | ConvertTo-Json -Depth 6) -Encoding UTF8; $true } catch { $false } }

# --- CSV helpers ---
function Detect-Delimiter {
    param($p)
    if (!(Test-Path $p)) { return "," }
    $f = Get-Content $p -TotalCount 1 -ErrorAction SilentlyContinue
    if ($f -match "`t") { return "`t" }
    if ($f -match ";") { return ";" }
    return ","
}
function Read-CsvSafe {
    param($p)
    if (!(Test-Path $p)) { return @() }
    try {
        $d = Detect-Delimiter $p
        $r = Import-Csv $p -Delimiter $d -Encoding UTF8 -ErrorAction Stop
        if ($null -eq $r) { return @() }
        if ($r -isnot [System.Array]) { $r = ,$r }
        return ($r | Where-Object { $_ -is [System.Management.Automation.PSObject] })
    } catch { return @() }
}
function NormalizeKey { param($s) if ($s) { $s.ToString().ToLowerInvariant().Trim() } else { $null } }

function Build-CategoryMap {
    param($dir)
    $map=@{}
    $rows = Read-CsvSafe (Join-Path $dir "items_Survivors.csv")
    foreach ($r in $rows) {
        if ($r.itemCategory) {
            if ($r.de_Name) {
                $n = NormalizeKey $r.de_Name
                if ($n -and !$map.ContainsKey($n)) { $map[$n]=$r.itemCategory }
            }
            if ($r.en_Name) {
                $n = NormalizeKey $r.en_Name
                if ($n -and !$map.ContainsKey($n)) { $map[$n]=$r.itemCategory }
            }
        }
    }
    return $map
}

function Get-DisplayName {
    param($row,$col)
    if ($null -eq $row) { return "" }
    if ($row -is [string]) { return SafeValue $row }
    if ($row.PSObject.Properties.Name -contains $col) { return SafeValue $row.$col }
    if ($row.en_Name) { return SafeValue $row.en_Name }
    return SafeValue $row.de_Name
}

function HeaderSuffix { param($l) if ($l -eq "Deutsch") {"DEUTSCH"} else {"ENGLISH"} }

# --- UI ---
$form = New-Object Windows.Forms.Form
$form.Text = "DBD Loadout Generator by @zckrfrk"
$form.Width = 820
$form.Height = 520
$form.StartPosition = "CenterScreen"

# Mode Label
$modeLabel = New-Object Windows.Forms.Label
$modeLabel.Text = "Mode"
$modeLabel.Top = 8
$modeLabel.Left = 20
$modeLabel.Width = 40
$form.Controls.Add($modeLabel)

# Mode Dropdown
$modeDropdown = New-Object Windows.Forms.ComboBox
$modeDropdown.Items.AddRange(@("Survivor","Killer"))
$modeDropdown.SelectedIndex = 0
$modeDropdown.Top = 5
$modeDropdown.Left = 60
$modeDropdown.Width = 140
$form.Controls.Add($modeDropdown)

# Language Label
$langLabel = New-Object Windows.Forms.Label
$langLabel.Text = "Language"
$langLabel.Top = 8
$langLabel.Left = 220
$langLabel.Width = 60
$form.Controls.Add($langLabel)

# Language Dropdown
$Languages=@("English","Deutsch")
$languageDropdown = New-Object Windows.Forms.ComboBox
$languageDropdown.Items.AddRange($Languages)
$languageDropdown.SelectedIndex=0
$languageDropdown.Top=5
$languageDropdown.Left=280
$languageDropdown.Width=120
$form.Controls.Add($languageDropdown)

# Switch Button
$switchButton = New-Object Windows.Forms.Button
$switchButton.Text="switch"
$switchButton.Top=35
$switchButton.Left=280
$switchButton.Width=60
$form.Controls.Add($switchButton)

# Both Button
$bothButton = New-Object Windows.Forms.Button
$bothButton.Text="both"
$bothButton.Top=35
$bothButton.Left=345
$bothButton.Width=60
$form.Controls.Add($bothButton)

# Go Button
$button = New-Object Windows.Forms.Button
$button.Text="GO"
$button.Top=5
$button.Left=420
$button.Width=110
$button.height=40
$form.Controls.Add($button)

# Copy Button
$copyButton = New-Object Windows.Forms.Button
$copyButton.Text="COPY"
$copyButton.Top=5
$copyButton.Left=545
$copyButton.Width=80
$form.Controls.Add($copyButton)

# Export Button
$exportButton = New-Object Windows.Forms.Button
$exportButton.Text="EXPORT"
$exportButton.Top=5
$exportButton.Left=640
$exportButton.Width=80
$form.Controls.Add($exportButton)

# Clear Button
$clearButton = New-Object Windows.Forms.Button
$clearButton.Text="CLEAR"
$clearButton.Top=5
$clearButton.Left=735
$clearButton.Width=50
$form.Controls.Add($clearButton)

# Save Button
$saveButton = New-Object Windows.Forms.Button
$saveButton.Text="Save Config"
$saveButton.Top=35
$saveButton.Left=12
$saveButton.Width=260
$form.Controls.Add($saveButton)

# Options Panel
$optionsPanel = New-Object Windows.Forms.GroupBox
$optionsPanel.Text="Options"
$optionsPanel.Top=80
$optionsPanel.Left=12
$optionsPanel.Width=360
$optionsPanel.Height=360
$form.Controls.Add($optionsPanel)

$chk1=New-Object Windows.Forms.CheckBox
$chk2=New-Object Windows.Forms.CheckBox
$chk3=New-Object Windows.Forms.CheckBox
$chk4=New-Object Windows.Forms.CheckBox
$chk5=New-Object Windows.Forms.CheckBox

$chk1.Top=20; $chk2.Top=45; $chk3.Top=70; $chk4.Top=95; $chk5.Top=120
foreach ($c in @($chk1,$chk2,$chk3,$chk4,$chk5)) { $c.Left=10; $c.Width=320; $optionsPanel.Controls.Add($c) }

# Switch Button
$outputBox = New-Object Windows.Forms.TextBox
$outputBox.Multiline=$true
$outputBox.ScrollBars="Vertical"
$outputBox.Width=420
$outputBox.Height=360
$outputBox.Top=80
$outputBox.Left=390
$outputBox.ReadOnly=$true
$form.Controls.Add($outputBox)

# Copy Label ("Copied!")
$outputCopy = New-Object Windows.Forms.Label
$outputCopy.Top=35
$outputCopy.Left=565
$outputCopy.Width=80
$outputCopy.ForeColor='Green'
$form.Controls.Add($outputCopy)

# Export Label ("Exported!")
$outputExport = New-Object Windows.Forms.Label
$outputExport.Top=35
$outputExport.Left=655
$outputExport.Width=80
$outputExport.ForeColor='Green'
$form.Controls.Add($outputExport)

# Clear Label ("Cleared!")
$outputClear = New-Object Windows.Forms.Label
$outputClear.Top=35
$outputClear.Left=740
$outputClear.Width=50 
$outputClear.ForeColor='Green'
$form.Controls.Add($outputClear)

# --- Config load ---
$config = Load-Config $configPath
if (!$config) {
    $config=@{
        Survivor=@{Language="English";Options=@{Char=$true;Perks=$true;Item=$true;Addons=$true;Offering=$true}}
        Killer=@{Language="English";Options=@{Killer=$true;Perks=$true;AddonColours=$true;Offering=$true}}
    }
}

function ApplySurvivor {
    param($cfg)
    $optionsPanel.Text="Survivor Options"
    $chk1.Text="Survivor"; $chk1.Checked=$cfg.Survivor.Options.Char
    $chk2.Text="Perks";    $chk2.Checked=$cfg.Survivor.Options.Perks
    $chk3.Text="Item";     $chk3.Checked=$cfg.Survivor.Options.Item
    $chk4.Text="Add-ons";  $chk4.Checked=$cfg.Survivor.Options.Addons
    $chk5.Text="Offering"; $chk5.Checked=$cfg.Survivor.Options.Offering
}
function ApplyKiller {
    param($cfg)
    $optionsPanel.Text="Killer Options"
    $chk1.Text="Killer"; $chk1.Checked=$cfg.Killer.Options.Killer
    $chk2.Text="Perks";  $chk2.Checked=$cfg.Killer.Options.Perks
    $chk3.Text="Addon-Farben"; $chk3.Checked=$cfg.Killer.Options.AddonColours
    $chk4.Text="Offering"; $chk4.Checked=$cfg.Killer.Options.Offering
    $chk5.Visible=$false
}

if ($modeDropdown.SelectedItem -eq "Survivor") { ApplySurvivor $config } else { ApplyKiller $config }
$languageDropdown.SelectedItem = if ($modeDropdown.SelectedItem -eq "Survivor") { $config.Survivor.Language } else { $config.Killer.Language }

$modeDropdown.Add_SelectedIndexChanged({
    if ($modeDropdown.SelectedItem -eq "Survivor") {
        ApplySurvivor $config
        $languageDropdown.SelectedItem=$config.Survivor.Language
    } else {
        ApplyKiller $config
        $languageDropdown.SelectedItem=$config.Killer.Language
    }
    $outputBox.Text=""
})

$saveButton.Add_Click({
    $m=$modeDropdown.SelectedItem
    if ($m -eq "Survivor") {
        $config.Survivor.Language=$languageDropdown.SelectedItem
        $config.Survivor.Options.Char=$chk1.Checked
        $config.Survivor.Options.Perks=$chk2.Checked
        $config.Survivor.Options.Item=$chk3.Checked
        $config.Survivor.Options.Addons=$chk4.Checked
        $config.Survivor.Options.Offering=$chk5.Checked
    } else {
        $config.Killer.Language=$languageDropdown.SelectedItem
        $config.Killer.Options.Killer=$chk1.Checked
        $config.Killer.Options.Perks=$chk2.Checked
        $config.Killer.Options.AddonColours=$chk3.Checked
        $config.Killer.Options.Offering=$chk4.Checked
    }
    $outputBox.Text = if (Save-Config $configPath $config) {"Config Saved"} else {"Error saving"}
})

$copyButton.Add_Click({
    if ($outputBox.Text.Trim() -ne "") {
        [System.Windows.Forms.Clipboard]::SetText($outputBox.Text)
        $outputCopy.Text="Copied!"
        Start-Sleep -Milliseconds 900
        $outputCopy.Text=""
    }
})

$exportButton.Add_Click({
    try {
        $exportFile = Join-Path $PSScriptRoot "export.txt"
        Set-Content -Path $exportFile -Value $outputBox.Text -Encoding UTF8
        $outputExport.Text = "Exported!"
        Start-Sleep -Milliseconds 900
        $outputExport.Text = ""
    } catch {
        $outputExport.Text = "Export failed!"
        Start-Sleep -Milliseconds 900
        $outputExport.Text = ""
    }
})

$clearButton.Add_Click({
    try {
        # Output-Feld leeren
        $outputBox.Text = ""

        # export.txt leeren
        $exportFile = Join-Path $PSScriptRoot "export.txt"
        if (Test-Path $exportFile) {
            Clear-Content -Path $exportFile -ErrorAction SilentlyContinue
        }

        # Label anzeigen
        $outputClear.Text = "Cleared!"
        Start-Sleep -Milliseconds 900
        $outputClear.Text = ""
    } catch {
        $outputClear.Text = "Clear failed!"
        Start-Sleep -Milliseconds 900
        $outputClear.Text = ""
    }
})


function Render {
    param($r,$lang)
    $col = if ($lang -eq "Deutsch") {"de_Name"} else {"en_Name"}
    $suf = HeaderSuffix $lang
    $o=@()
    if ($r.mode -eq "Survivor") {
        $o+="SURVIVOR - $suf"
        if ($r.options.Char) { $o+="Survivor: $(Get-DisplayName $r.charRow $col)" }
        if ($r.options.Perks) { $o+="Perks: " + (($r.perkRows | ForEach-Object {Get-DisplayName $_ $col}) -join " / ") }
        if ($r.options.Item) { $o+="Item: $(Get-DisplayName $r.itemRow $col)" }
        if ($r.options.Addons) {
            if ($r.addonsSelected.Count -eq 1 -and $r.addonsSelected[0] -eq "none") {
                $o+="Add-ons: none"
            } else {
                $o+="Add-ons: " + (($r.addonsSelected | ForEach-Object {Get-DisplayName $_ $col}) -join " / ")
            }
        }
        if ($r.options.Offering) { $o+="Offering: $(Get-DisplayName $r.offRow $col)" }
    } else {
        $o+="KILLER - $suf"
        if ($r.options.Killer) { $o+="Killer: $(Get-DisplayName $r.charRow $col)" }
        if ($r.options.Perks) { $o+="Perks: " + (($r.perkRows | ForEach-Object {Get-DisplayName $_ $col}) -join " / ") }
        if ($r.options.AddonColours) { $o+="Add-ons: $(Get-DisplayName $r.addonComboRow $col)" }
        if ($r.options.Offering) { $o+="Offering: $(Get-DisplayName $r.offRow $col)" }
    }
    return ($o -join "`r`n")
}

$script:lastResult=$null

$button.Add_Click({
    $mode=$modeDropdown.SelectedItem
    $lang=$languageDropdown.SelectedItem
    $col = if ($lang -eq "Deutsch") {"de_Name"} else {"en_Name"}
    $dir = Join-Path $PSScriptRoot "data"

    try {
        if ($mode -eq "Survivor") {
            $chars=SafeArray (Read-CsvSafe (Join-Path $dir "chars_Survivors.csv"))
            $perks=SafeArray (Read-CsvSafe (Join-Path $dir "perks_Survivors.csv"))
            $offer=SafeArray (Read-CsvSafe (Join-Path $dir "offerings_Survivors.csv"))
            $items=SafeArray (Read-CsvSafe (Join-Path $dir "items_Survivors.csv"))

            if ($chars.Count -eq 0 -or $perks.Count -eq 0 -or $items.Count -eq 0) { throw "Missing CSV data" }

            $map=Build-CategoryMap $dir

            $char=Get-Random $chars
            $perkCount = if ($perks.Count -ge 4) {4} else {$perks.Count}
            $perkRows = if ($perkCount -gt 0) { Get-Random $perks -Count $perkCount } else { @() }
            $off = if ($offer.Count -gt 0) { Get-Random $offer } else { $null }
            $item = Get-Random $items

            $iname = Get-DisplayName $item $col
            $norm = NormalizeKey $iname
            $code = if ($norm -and $map.ContainsKey($norm)) { $map[$norm] } else { "none" }

            $addons=@("none")
            if ($code -ne "none") {
                $all=SafeArray (Read-CsvSafe (Join-Path $dir "addons_Survivors.csv"))
                $valid = $all | Where-Object { $_.itemCategory -eq $code }
                if ($valid.Count -gt 0) {
                    $cnt=Get-Random -Minimum 0 -Maximum 3
                    if ($cnt -gt 0) { $addons = SafeArray (Get-Random $valid -Count ([Math]::Min($cnt,$valid.Count))) }
                }
            }

            $script:lastResult=@{
                mode="Survivor"; charRow=$char; perkRows=$perkRows; itemRow=$item; itemCode=$code; addonsSelected=$addons; offRow=$off;
                options=@{Char=$chk1.Checked;Perks=$chk2.Checked;Item=$chk3.Checked;Addons=$chk4.Checked;Offering=$chk5.Checked}
            }
            $outputBox.Text = Render $script:lastResult $lang

        } else {
            $chars=SafeArray (Read-CsvSafe (Join-Path $dir "chars_Killer.csv"))
            $perks=SafeArray (Read-CsvSafe (Join-Path $dir "perks_Killer.csv"))
            $offer=SafeArray (Read-CsvSafe (Join-Path $dir "offerings_Killer.csv"))
            $addons=SafeArray (Read-CsvSafe (Join-Path $dir "addonsColours_Killer.csv"))

            if ($chars.Count -eq 0 -or $perks.Count -eq 0) { throw "Missing CSV data" }

            $char=Get-Random $chars
            $perkCount = if ($perks.Count -ge 4) {4} else {$perks.Count}
            $perkRows = if ($perkCount -gt 0) { Get-Random $perks -Count $perkCount } else { @() }
            $off = if ($offer.Count -gt 0) { Get-Random $offer } else { $null }
            $addon = if ($addons.Count -gt 0) { Get-Random $addons } else { $null }

            $script:lastResult=@{
                mode="Killer"; charRow=$char; perkRows=$perkRows; addonComboRow=$addon; offRow=$off;
                options=@{Killer=$chk1.Checked;Perks=$chk2.Checked;AddonColours=$chk3.Checked;Offering=$chk4.Checked}
            }
            $outputBox.Text = Render $script:lastResult $lang
        }
    } catch {
        $outputBox.Text="Error loading data: $($_.Exception.Message)"
    }
})

$switchButton.Add_Click({
    if ($script:lastResult) {
        $cur=$languageDropdown.SelectedItem
        $other=if ($cur -eq "Deutsch") {"English"} else {"Deutsch"}
        $languageDropdown.SelectedItem=$other
        $outputBox.Text = Render $script:lastResult $other
    }
})

$bothButton.Add_Click({
    if ($script:lastResult) {
        $cur=$languageDropdown.SelectedItem
        $other=if ($cur -eq "Deutsch") {"English"} else {"Deutsch"}
        $outputBox.Text = (Render $script:lastResult $cur) + "`r`n`r`n" + (Render $script:lastResult $other)
    }
})

$form.ShowDialog()
