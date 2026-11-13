### DbD_LoG (Dead by Daylight Loadout Generator) by @zckrfrk ###

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
$form.Text = "DbD_LoG (Dead by Daylight Loadout Generator) by @zckrfrk"
$form.Width = 820
$form.Height = 520
$form.StartPosition = "CenterScreen"

# Role Label
$roleLabel = New-Object Windows.Forms.Label
$roleLabel.Text = "Role"
$roleLabel.Top = 8
$roleLabel.Left = 20
$roleLabel.Width = 40
$form.Controls.Add($roleLabel)

# Role Dropdown
$roleDropdown = New-Object Windows.Forms.ComboBox
$roleDropdown.Items.AddRange(@("Survivor","Killer"))
$roleDropdown.SelectedIndex = 0
$roleDropdown.Top = 5
$roleDropdown.Left = 60
$roleDropdown.Width = 140
$form.Controls.Add($roleDropdown)

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

# Append Button
$appendButton = New-Object Windows.Forms.Button
$appendButton.Text="APPEND"
$appendButton.Top=35
$appendButton.Left=545
$appendButton.Width=80
$form.Controls.Add($appendButton)

# Coinflip Button
$flipCoinButton = New-Object Windows.Forms.Button
$flipCoinButton.Text="COINFLIP"
$flipCoinButton.Top=35
$flipCoinButton.Left=640
$flipCoinButton.Width=80
$form.Controls.Add($flipCoinButton)

# Options Panel
$optionsPanel = New-Object Windows.Forms.GroupBox
$optionsPanel.Text="Options"
$optionsPanel.Top=80
$optionsPanel.Left=12
$optionsPanel.Width=380
$optionsPanel.Height=345
$form.Controls.Add($optionsPanel)

$chk1=New-Object Windows.Forms.CheckBox
$chk2=New-Object Windows.Forms.CheckBox
$chk3=New-Object Windows.Forms.CheckBox
$chk4=New-Object Windows.Forms.CheckBox
$chk5=New-Object Windows.Forms.CheckBox
$chk6=New-Object Windows.Forms.CheckBox
$chk7=New-Object Windows.Forms.CheckBox

$chk1.Top=20; $chk2.Top=45; $chk3.Top=70; $chk4.Top=95; $chk5.Top=120
foreach ($c in @($chk1,$chk2,$chk3,$chk4,$chk5,$chk6)) { $c.Left=10; $c.Width=100; $optionsPanel.Controls.Add($c) }
$chk6.Left = 115; $chk6.Top = 95; $chk6.Width = 120
$chk7.Left = 10; $chk7.Top = 70; $chk7.Width = 100
$optionsPanel.Controls.Add($chk7)

# Aura & Generator Checkbox
$chkAura = New-Object Windows.Forms.CheckBox
$chkGenerator = New-Object Windows.Forms.CheckBox
$chkAura.Text = "extra Aura/Alert"; $chkAura.Left = 170; $chkAura.Top = 45; $chkAura.Width = 80; $chkAura.Visible = $false; $optionsPanel.Controls.Add($chkAura)
$chkGenerator.Text = "extra Generator"; $chkGenerator.Left = 250; $chkGenerator.Top = 45; $chkGenerator.Width = 80; $chkGenerator.Visible = $false; $optionsPanel.Controls.Add($chkGenerator)

# CharCountSlider (Survivor) + All Button for Chars Survivor
$charCountSliderS = New-Object Windows.Forms.NumericUpDown
$charCountSliderS.Minimum = 1
$charCountSliderS.Maximum = 44 # später dynamisch
$charCountSliderS.Value = 1
$charCountSliderS.Width = 42
$charCountSliderS.Left = 115
$charCountSliderS.Top = 18
$optionsPanel.Controls.Add($charCountSliderS)
$allCharsButtonS = New-Object Windows.Forms.Button
$allCharsButtonS.Text = "all"
$allCharsButtonS.Width = 35
$allCharsButtonS.Height = 20
$allCharsButtonS.Left = 160
$allCharsButtonS.Top = 18
$optionsPanel.Controls.Add($allCharsButtonS)

# PerkCountSlider (Survivor)
$perkCountSliderS = New-Object Windows.Forms.NumericUpDown
$perkCountSliderS.Minimum = 1
$perkCountSliderS.Maximum = 16
$perkCountSliderS.Value = 4
$perkCountSliderS.Width = 42
$perkCountSliderS.Height = 15
$perkCountSliderS.Left = 115
$perkCountSliderS.Top = 45
$optionsPanel.Controls.Add($perkCountSliderS)

# itemCountSlider (Survivor)
$itemCountSlider = New-Object Windows.Forms.NumericUpDown
$itemCountSlider.Minimum = 1
$itemCountSlider.Maximum = 4
$itemCountSlider.Value = 1
$itemCountSlider.Width = 42
$itemCountSlider.Left = 115
$itemCountSlider.Top = 68
$itemCountSlider.Visible = $false
$optionsPanel.Controls.Add($itemCountSlider)

# CharCountSlider (Killer) + All Button for Chars Killer
$charCountSliderK = New-Object Windows.Forms.NumericUpDown
$charCountSliderK.Minimum = 1
$charCountSliderK.Maximum = 38 # später dynamisch
$charCountSliderK.Value = 1
$charCountSliderK.Width = 42
$charCountSliderK.Left = 115
$charCountSliderK.Top = 18
$charCountSliderK.Visible = $false
$optionsPanel.Controls.Add($charCountSliderK)
$allCharsButtonK = New-Object Windows.Forms.Button
$allCharsButtonK.Text = "all"
$allCharsButtonK.Width = 35
$allCharsButtonK.Height = 20
$allCharsButtonK.Left = 160
$allCharsButtonK.Top = 18
$allCharsButtonK.Visible = $false
$optionsPanel.Controls.Add($allCharsButtonK)

# Set max Values for Char Sliders &  All Buttons
 $survChars = Read-CsvSafe (Join-Path $PSScriptRoot "data\chars_Survivors.csv")
    if ($survChars.Count -gt 0) {
        $charCountSliderS.Maximum = $survChars.Count
    }
$killerChars = Read-CsvSafe (Join-Path $PSScriptRoot "data\chars_Killer.csv")
    if ($killerChars.Count -gt 0) {
        $charCountSliderK.Maximum = $killerChars.Count
    }
$allCharsButtonS.Add_Click({
    $charCountSliderS.Value = $charCountSliderS.Maximum
})
$allCharsButtonK.Add_Click({
    $charCountSliderK.Value = $charCountSliderK.Maximum
})

# PerkCountSlider (Killer)
$perkCountSliderK = New-Object Windows.Forms.NumericUpDown
$perkCountSliderK.Minimum = 1
$perkCountSliderK.Maximum = 4
$perkCountSliderK.Value = 4
$perkCountSliderK.Width = 42
$perkCountSliderK.Height = 15
$perkCountSliderK.Left = 115
$perkCountSliderK.Top = 45
$perkCountSliderK.Visible = $false
$optionsPanel.Controls.Add($perkCountSliderK)

# Switch Button
$outputBox = New-Object Windows.Forms.TextBox
$outputBox.Multiline=$true
$outputBox.ScrollBars="Vertical"
$outputBox.Width=420
$outputBox.Height=345
$outputBox.Top=80
$outputBox.Left=390
$outputBox.ReadOnly=$true
$form.Controls.Add($outputBox)

# Status Label (Copy/Export/Clear/Append/CoinFlip)
$outputStatus = New-Object Windows.Forms.Label
$outputStatus.Top = 35
$outputStatus.Left = 735
$outputStatus.Width = 80
$outputStatus.ForeColor = 'Green'
$form.Controls.Add($outputStatus)

# INFO LABEL #
$infoLabel = New-Object System.Windows.Forms.Label
$infoLabel.AutoSize = $true
$infoLabel.Left = 10
$infoLabel.Top = 430
$infoLabel.Text = "DbD_LoG (Dead by Daylight Loadout Generator)`n© 2025-2026 Zckrfrk | Check the README for more info."
$form.Controls.Add($infoLabel)
# GitHub
$linkGitHub = New-Object System.Windows.Forms.LinkLabel
$linkGitHub.AutoSize = $true
$linkGitHub.Left = 10
$linkGitHub.Top = 460
$linkGitHub.Text = "► GitHub"
$form.Controls.Add($linkGitHub)
$linkGitHub.Add_LinkClicked({
    Start-Process "https://github.com/zckrfrk/DbD_LoG"
})
# Discord
$linkDiscord = New-Object System.Windows.Forms.LinkLabel
$linkDiscord.AutoSize = $true
$linkDiscord.Left = 60
$linkDiscord.Top = 460
$linkDiscord.Width = 100
$linkDiscord.Text = "► Discord (Updates/Feedback/BugReport)"
$form.Controls.Add($linkDiscord)
$linkDiscord.Add_LinkClicked({
    Start-Process "https://discord.gg/6XXCFcVzU3"
})
# Zckrfrk
$linkProfile = New-Object System.Windows.Forms.LinkLabel
$linkProfile.AutoSize = $true
$linkProfile.Left = 275
$linkProfile.Top = 460
$linkProfile.Text = "► Zckrfrk"
$form.Controls.Add($linkProfile)
$linkProfile.Add_LinkClicked({
    Start-Process "https://linktr.ee/zckrfrk"
})
# README
$linkReadMe = New-Object System.Windows.Forms.LinkLabel
$linkReadMe.AutoSize = $true
$linkReadMe.Left = 325
$linkReadMe.Top = 460
$linkReadMe.Text = "► README"
$form.Controls.Add($linkReadMe)
$linkReadMe.Add_LinkClicked({
    Start-Process "https://github.com/zckrfrk/DbD_LoG/blob/main/README.txt"
})


# --- Config load ---
$config = Load-Config $configPath
if (-not $config.Survivor.PerkCount) {
$config.Survivor | Add-Member -NotePropertyName PerkCount -NotePropertyValue 4 -Force
}
if (!$config) {
    $config=@{
        LastRole="Survivor"
        Survivor=@{Language="English";CharCount=1;PerkCount=4;ItemCount=1;Options=@{Char=$true;Perks=$true;Item=$true;Addons=$true;AddonColours=$false;Offering=$true}}
        Killer=@{Language="English";CharCount=1;PerkCount=4;Options=@{Killer=$true;Perks=$true;Addons=$false;AddonColours=$true;Offering=$true}}
    }
}

# Load Survivor Values from Config
if ($config.Survivor.CharCount) {
    $charCountSliderS.Value = [Math]::Min($config.Survivor.CharCount, $charCountSliderS.Maximum)
}

if ($config.Survivor.PerkCount) {
$perkCountSliderS.Value = [Math]::Min($config.Survivor.PerkCount, $perkCountSliderS.Maximum)
}

if ($config.Survivor.ItemCount) {
    $itemCountSlider.Value = [Math]::Min($config.Survivor.ItemCount, $itemCountSlider.Maximum)
}

# Load Killer Values from Config
if ($config.Killer.CharCount) {
    $charCountSliderK.Value = [Math]::Min($config.Killer.CharCount, $charCountSliderK.Maximum)
}

if ($config.Killer.PerkCount) {
    $perkCountSliderK.Value = [Math]::Min($config.Killer.PerkCount, $perkCountSliderK.Maximum)
}

# Load Role from Config
if ($config.LastRole -and $roleDropdown.Items.Contains($config.LastRole)) {
    $roleDropdown.SelectedItem = $config.LastRole
} else {
    # Fallback
    $roleDropdown.SelectedItem = "Survivor"
}

function ApplySurvivor {
    param($cfg)
        $optionsPanel.Text="Survivor Options"
    $chk1.Text="Survivor";      $chk1.Checked=$cfg.Survivor.Options.Char
    $chk2.Text="Perks";         $chk2.Checked=$cfg.Survivor.Options.Perks
    $chk3.Text="Item";          $chk3.Checked=$cfg.Survivor.Options.Item; $chk3.Left = 10; $chk3.Top = 70; $chk3.Width = 100
    $chk4.Text="Add-ons";       $chk4.Checked=$cfg.Survivor.Options.Addons
    $chk5.Text="Offering";      $chk5.Checked=$cfg.Survivor.Options.Offering
    $chk6.Text="Addon-Colours"; $chk6.Checked = $cfg.Survivor.Options.AddonColours
    $chk5.Visible=$true
    $chk6.Visible=$true
    $chk7.Visible = $false
    $charCountSliderS.Visible = $true
    $allCharsButtonS.Visible = $true
    $charCountSliderK.Visible = $false
    $allCharsButtonK.Visible = $false
    $perkCountSliderS.Visible = $true
    $perkCountSliderK.Visible = $false
    $chkAura.Visible = $false
    $chkGenerator.Visible = $false
    UpdateItemSliderVisibility
}
function ApplyKiller {
    param($cfg)
    $optionsPanel.Text="Killer Options"
    $chk1.Text="Killer"; $chk1.Checked=$cfg.Killer.Options.Killer
    $chk2.Text="Perks";  $chk2.Checked=$cfg.Killer.Options.Perks
    $chk3.Text="Addon-Colours"; $chk3.Checked=$cfg.Killer.Options.AddonColours; $chk3.Left = 115; $chk3.Top = 70; $chk3.Width = 120
    $chk4.Text="Offering"; $chk4.Checked=$cfg.Killer.Options.Offering
    $chk5.Visible=$false
    $chk6.Visible=$false
    $chk7.Visible = $true; $chk7.Text = "Add-ons"; $chk7.Checked = $cfg.Killer.Options.Addons
    $charCountSliderS.Visible = $false
    $allCharsButtonS.Visible = $false
    $charCountSliderK.Visible = $true
    $allCharsButtonK.Visible = $true
    $perkCountSliderS.Visible = $false
    $perkCountSliderK.Visible = $true
    $chkAura.Visible = $true
    $chkGenerator.Visible = $true
    UpdateKillerPerkSlider
    UpdateItemSliderVisibility
}

function UpdateItemSliderVisibility {
    $showSlider = ($roleDropdown.SelectedItem -eq "Survivor") -and $chk3.Checked -and $chk6.Checked -and (-not $chk4.Checked)
    $itemCountSlider.Visible = $showSlider
    if ($itemCountLabel) {
        $itemCountLabel.Visible = $showSlider
    }
}

function UpdateKillerPerkSlider { 
    $oldMax = $perkCountSliderK.Maximum
    $newMax = 4
    if ($chkAura.Checked) {
        $newMax--
    }
    if ($chkGenerator.Checked) {
        $newMax--
    }
    if ($newMax -lt 1) {
        $newMax = 1
    }
    $perkCountSliderK.Maximum = $newMax
    if ($newMax -gt $oldMax) {
        $perkCountSliderK.Value = [Math]::Min($perkCountSliderK.Value + ($newMax - $oldMax), $newMax)
    }
    if ($perkCountSliderK.Value -gt $newMax) {
        $perkCountSliderK.Value = $newMax
    }
}

if ($roleDropdown.SelectedItem -eq "Survivor") { ApplySurvivor $config } else { ApplyKiller $config }
$languageDropdown.SelectedItem = if ($roleDropdown.SelectedItem -eq "Survivor") { $config.Survivor.Language } else { $config.Killer.Language }

$script:CheckboxSync = $false
$chk4.Add_CheckedChanged({ 
    if ($script:CheckboxSync) { return }
    if ($chk4.Checked) {
       $script:CheckboxSync = $true
       $chk6.Checked = $false
       $script:CheckboxSync = $false
       }
       UpdateItemSliderVisibility
    })
$chk6.Add_CheckedChanged({
    if ($script:CheckboxSync) { return }
    if ($chk6.Checked) {
       $script:CheckboxSync = $true
       $chk4.Checked = $false
       $script:CheckboxSync = $false
    }
    UpdateItemSliderVisibility
})
$chkAura.Add_CheckedChanged({
    UpdateKillerPerkSlider
})
$chkGenerator.Add_CheckedChanged({
    UpdateKillerPerkSlider
})
$chk3.Add_CheckedChanged({
    if ($script:CheckboxSync) { return }
    if ($roleDropdown.SelectedItem -eq "Survivor" -and -not $chk3.Checked) {
        $script:CheckboxSync = $true
        $chk4.Checked = $false
        $chk6.Checked = $false
        $script:CheckboxSync = $false
    }
    if ($roleDropdown.SelectedItem -eq "Killer") {
        if ($script:CheckboxSync) { return }
        if ($chk3.Checked) {
            $script:CheckboxSync = $true
            $chk7.Checked = $false
            $script:CheckboxSync = $false
        }
    }
    UpdateItemSliderVisibility
})
$chk7.Add_CheckedChanged({
    if ($roleDropdown.SelectedItem -ne "Killer") {
        return
    }
    if ($script:CheckboxSync) {
        return
    }
    if ($chk7.Checked) {
        $script:CheckboxSync = $true
        $chk3.Checked = $false
        $script:CheckboxSync = $false
    }
})
$roleDropdown.Add_SelectedIndexChanged({
    if ($roleDropdown.SelectedItem -eq "Survivor") {
        ApplySurvivor $config
    } else {
        ApplyKiller $config
    }
    UpdateItemSliderVisibility
    $outputBox.Text=""
})
# Save Config #
$saveButton.Add_Click({
    $m=$roleDropdown.SelectedItem
    $config.LastRole = $m
    if ($m -eq "Survivor") {
        $config.Survivor.Language=$languageDropdown.SelectedItem
        $config.Survivor.CharCount = $charCountSliderS.Value
        $config.Survivor.PerkCount = $perkCountSliderS.Value
        $config.Survivor.ItemCount = $itemCountSlider.Value
        $config.Survivor.Options.Char=$chk1.Checked
        $config.Survivor.Options.Perks=$chk2.Checked
        $config.Survivor.Options.Item=$chk3.Checked
        $config.Survivor.Options.Addons=$chk4.Checked
        $config.Survivor.Options.Offering=$chk5.Checked
        $config.Survivor.Options.AddonColours = $chk6.Checked
    } else {
        $config.Killer.Language=$languageDropdown.SelectedItem
        $config.Killer.CharCount = $charCountSliderK.Value
        $config.Killer.PerkCount=$perkCountSliderK.Value
        $config.Killer.Options.Killer=$chk1.Checked
        $config.Killer.Options.Perks=$chk2.Checked
        $config.Killer.Options.AddonColours=$chk3.Checked
        $config.Killer.Options.Offering=$chk4.Checked
        $config.Killer.Options.Addons=$chk7.Checked
    }
    $outputBox.Text = if (Save-Config $configPath $config) {"Config Saved"} else {"Error saving"}
})

$copyButton.Add_Click({
    if ($outputBox.Text.Trim() -ne "") {
        [System.Windows.Forms.Clipboard]::SetText($outputBox.Text)
        $outputStatus.Text = "Copied!"
        Start-Sleep -Milliseconds 1000
        $outputStatus.Text = ""
    }
})

$exportButton.Add_Click({
    try {
        $exportFile = Join-Path $PSScriptRoot "export.txt"
        Set-Content -Path $exportFile -Value $outputBox.Text -Encoding UTF8
        $outputStatus.Text = "Exported!"
        Start-Sleep -Milliseconds 1000
        $outputStatus.Text = ""
    } catch {
        $outputStatus.Text = "Export failed!"
        Start-Sleep -Milliseconds 1000
        $outputStatus.Text = ""
    }
})

$clearButton.Add_Click({
    try {
        # Clear Output Field
        $outputBox.Text = ""

        # Clear Output File (export)
        $exportFile = Join-Path $PSScriptRoot "export.txt"
        if (Test-Path $exportFile) {
            Clear-Content -Path $exportFile -ErrorAction SilentlyContinue
        }

        # Show Label
        $outputStatus.Text = "Cleared!"
        Start-Sleep -Milliseconds 1000
        $outputStatus.Text = ""
    } catch {
        $outputStatus.Text = "Clear failed!"
        Start-Sleep -Milliseconds 1000
        $outputStatus.Text = ""
    }
})


$appendButton.Add_Click({
    $oldText = $outputBox.Text
    $script:IsAppending = $true
    $button.PerformClick()
    $script:IsAppending = $false
    # APPEND Label
    $outputStatus.Text = "Appended!"
    Start-Sleep -Milliseconds 1000
    $outputStatus.Text = ""
     
})

$flipCoinButton.Add_Click({
    $randomRole = Get-Random @("Survivor", "Killer")
        # Role switch
    if ($roleDropdown.SelectedItem -ne $randomRole) {
        $roleDropdown.SelectedItem = $randomRole
    }
    $outputBox.Text = "Next Round as $randomRole"
    # FLIP COIN Label
    $outputStatus.Text = "Coin flipped!"
    Start-Sleep -Milliseconds 1000
    $outputStatus.Text = ""
})

###### RENDER - BLOCK ######

function Render-NoHeader {
    param($r,$lang)
    $text = Render $r $lang
    $lines = $text -split "`r?`n"
    if ($lines.Count -gt 1) {
        return (($lines | Select-Object -Skip 1) -join "`r`n")
    }
 return $text
}

function Render-History {
    param($history,$lang) 
    if (-not $history -or $history.Count -eq 0) {
        return ""
    }
    $out = @()
    for ($i = 0; $i -lt $history.Count; $i++) {
        $entry = $history[$i]
        if ($i -eq 0) {
            $out += Render $entry $lang
        } else {
            $out += "--------------------"
            $out += ""
            $out += (Render-NoHeader $entry $lang)
            }
    }
    return ($out -join "`r`n")
}

function Render {
    param($r,$lang)
    $col = if ($lang -eq "Deutsch") {"de_Name"} else {"en_Name"}
    $suf = HeaderSuffix $lang
    $o=@()
    if ($r.role -eq "Survivor") {
        $o+="SURVIVOR - $suf"
        if ($r.options.Char) { $o += "Survivor: " + (($r.charRows | ForEach-Object { Get-DisplayName $_ $col}) -join " / ") }
        if ($r.options.Perks) { $o+="Perks: " + (($r.perkRows | ForEach-Object {Get-DisplayName $_ $col}) -join " / ") }
        # Items & Add-ons and Addon-Colours
        if ($r.options.Item) {
            if ($r.itemColourRows -and $r.itemColourRows.Count -gt 0) {
                $idx = 1
                foreach ($entry in $r.itemColourRows) {
                    $itemName = Get-DisplayName $entry.Item $col
                    $comboName = Get-DisplayName $entry.Combo $col
                    $o += "Item ${idx}: $itemName [Addons: $comboName]"
                    $idx++
                }
            } else {
                $itemText = "Item: $(Get-DisplayName $r.itemRow $col)"
                if ($r.addonsSelected.Count -gt 0 -and $r.addonsSelected[0] -ne "none") {
                    $itemText += " [Addons: " + (($r.addonsSelected | ForEach-Object {
                        Get-DisplayName $_ $col}) -join " / ") + "]"
                    }
                    $o += $itemText
                }
            }
        if ($r.options.Addons) { if ($r.addonsSelected.Count -eq 1 -and $r.addonsSelected[0] -eq "none") { $o+="Add-ons: none"
            } else {
                $o+="Add-ons: " + (($r.addonsSelected | ForEach-Object { Get-DisplayName $_ $col}) -join " / ")}}
        if ($r.options.Offering) { $o+="Offering: $(Get-DisplayName $r.offRow $col)"}
            } else { # here starts the Killer Block
               $o+="KILLER - $suf"
        if ($r.options.Killer) { $o += "Killer: " + (($r.charRows | ForEach-Object {Get-DisplayName $_ $col}) -join " / ")}
        if ($r.options.Perks) { $o+="Perks: " + (($r.perkRows | ForEach-Object {Get-DisplayName $_ $col}) -join " / ")}
        if ($r.options.Addons) { $o += "Add-ons: " + (($r.addonRows | ForEach-Object { Get-DisplayName $_ $col}) -join " / ")}
        if ($r.options.AddonColours) {  $o += "Addon-Colours: $(Get-DisplayName $r.addonComboRow $col)"}
        if ($r.options.Offering) { $o+="Offering: $(Get-DisplayName $r.offRow $col)"
        }
    } return ($o -join "`r`n")
}

$script:lastResult=$null
$script:ResultHistory = @()
$script:IsAppending = $false

# GO Button
$button.Add_Click({
    $role=$roleDropdown.SelectedItem
    $lang=$languageDropdown.SelectedItem
    $col = if ($lang -eq "Deutsch") {"de_Name"} else {"en_Name"}
    $dir = Join-Path $PSScriptRoot "data"

    try {
        if ($role -eq "Survivor") {
            $chars=SafeArray (Read-CsvSafe (Join-Path $dir "chars_Survivors.csv"))
            $perks=SafeArray (Read-CsvSafe (Join-Path $dir "perks_Survivors.csv"))
            $offer=SafeArray (Read-CsvSafe (Join-Path $dir "offerings_Survivors.csv"))
            $items=SafeArray (Read-CsvSafe (Join-Path $dir "items_Survivors.csv"))

            if ($chars.Count -eq 0 -or $perks.Count -eq 0 -or $items.Count -eq 0) { throw "Missing CSV data" }

            $map=Build-CategoryMap $dir
            #Char
            $charCount = [Math]::Min($charCountSliderS.Value, $chars.Count)
            $charRows = Get-Random $chars -Count $charCount
            $desiredPerks = $perkCountSliderS.Value
            $perkCount = [Math]::Min($desiredPerks, $perks.Count)
            $perkRows = if ($perkCount -gt 0) { Get-Random $perks -Count $perkCount } else { @() }
            $off = if ($offer.Count -gt 0) { Get-Random $offer } else { $null }
            #Items-Addons-AddonColours
            $item = Get-Random $items
            $iname = Get-DisplayName $item $col
            $norm = NormalizeKey $iname
            $code = if ($norm -and $map.ContainsKey($norm)) { $map[$norm] } else { "none" }
            $addons = @("none")
            $selectedItems = @()
            if ($chk6.Checked) {
                $itemCount = $itemCountSlider.Value
                $allColours = SafeArray (Read-CsvSafe (Join-Path $dir "addonsColours_Both.csv"))
                for ($i = 0; $i -lt $itemCount; $i++) {
                    $randomItem = Get-Random $items
                    $colourRow = Get-Random $allColours
                    $selectedItems += [PSCustomObject]@{
                        Item = $randomItem
                        Combo = $colourRow
                    }
                }
 
            } else {
                if ($code -ne "none") {
                    $all = SafeArray (Read-CsvSafe (Join-Path $dir "addons_Survivors.csv"))
                    $valid = $all | Where-Object {
                        $_.itemCategory -eq $code
                    }
                    if ($valid.Count -gt 0) {
                        $cnt = Get-Random -Minimum 0 -Maximum 3
                        if ($cnt -gt 0) {
                            $addons = SafeArray (Get-Random $valid -Count ([Math]::Min($cnt,$valid.Count)))
                        }
                    }
                }
            }
            $addons=@("none")
 
        if ($chk6.Checked) {
            # Addon-Colours Mode
            if ($code -ne "X") { 
                $all = SafeArray (Read-CsvSafe (Join-Path $dir "addonsColours_Both.csv")) 
                if ($all.Count -gt 0) {
                    $addons = @(Get-Random $all) 
                }
            }
        } else {
                # Normal Addons
                if ($code -ne "none") {
                    $all = SafeArray (Read-CsvSafe (Join-Path $dir "addons_Survivors.csv")) 
                    $valid = $all | Where-Object {
                        $_.itemCategory -eq $code
                    }
                if ($valid.Count -gt 0) {
                    $cnt=Get-Random -Minimum 0 -Maximum 3
                    if ($cnt -gt 0) {
                        $addons = SafeArray (Get-Random $valid -Count ([Math]::Min($cnt,$valid.Count)))
                    }
                }
            }
        }
            $script:lastResult=@{
                role="Survivor"; charRows=$charRows; perkRows=$perkRows; itemRow=$item; itemCode=$code; addonsSelected=$addons; itemColourRows=$selectedItems; offRow=$off;
                options=@{Char=$chk1.Checked;Perks=$chk2.Checked;Item=$chk3.Checked;Addons=$chk4.Checked;Offering=$chk5.Checked}
            }
            if ($script:IsAppending) {
                $script:ResultHistory += $script:lastResult
                $outputBox.Text = Render-History $script:ResultHistory $lang
            } else {
                    $script:ResultHistory = @($script:lastResult)
                    $outputBox.Text = Render $script:lastResult $lang
            }
        } else {
            $chars=SafeArray (Read-CsvSafe (Join-Path $dir "chars_Killer.csv"))
            $perks=SafeArray (Read-CsvSafe (Join-Path $dir "perks_Killer.csv"))
            $auraPerks = SafeArray (Read-CsvSafe (Join-Path $dir "perks_Killer_AuraAlert.csv"))
            $generatorPerks = SafeArray (Read-CsvSafe (Join-Path $dir "perks_Killer_Generator.csv"))
            $offer=SafeArray (Read-CsvSafe (Join-Path $dir "offerings_Killer.csv"))
            $addons=SafeArray (Read-CsvSafe (Join-Path $dir "addonsColours_Both.csv")) #Addon-Colours
            $killerAddons = SafeArray (Read-CsvSafe (Join-Path $dir "addons_Killer.csv"))
            if ($chars.Count -eq 0 -or $perks.Count -eq 0) { throw "Missing CSV data" }
            # Chars
            $charCount = [Math]::Min($charCountSliderK.Value,$chars.Count) 
            $charRows = Get-Random $chars -Count $charCount
            # Perks
            $perkRows = @()
            $desiredPerks = $perkCountSliderK.Value
            if ($desiredPerks -gt 0) {
                $perkRows += SafeArray(Get-Random $perks -Count ([Math]::Min($desiredPerks, $perks.Count)))
            }
            if ($chkAura.Checked -and $auraPerks.Count -gt 0) { 
                $availableAura = $auraPerks | Where-Object {
                    $_.en_Name -notin $perkRows.en_Name
                }
                if ($availableAura.Count -gt 0) {
                    $perkRows += Get-Random $availableAura
                }
            }
            if ($chkGenerator.Checked -and $generatorPerks.Count -gt 0) { 
                $availableGenerator = $generatorPerks | Where-Object {
                   $_.en_Name -notin $perkRows.en_Name
                }
                if ($availableGenerator.Count -gt 0) {
                    $perkRows += Get-Random $availableGenerator
                }
            }
            $addonRows = @()
            if ($killerAddons.Count -gt 0) {
                $addonRows = SafeArray (Get-Random $killerAddons -Count ([Math]::Min(2,$killerAddons.Count)
        )
    )
}
            $off = if ($offer.Count -gt 0) { Get-Random $offer } else { $null }
            $addon = if ($addons.Count -gt 0) { Get-Random $addons } else { $null }

            $script:lastResult=@{
                role="Killer"; charRows=$charRows; perkRows=$perkRows; addonRows=$addonRows; addonComboRow=$addon; offRow=$off;
                options=@{Killer=$chk1.Checked;Perks=$chk2.Checked;Addons=$chk7.Checked;AddonColours=$chk3.Checked;Offering=$chk4.Checked}
            }
            if ($script:IsAppending) { 
                $script:ResultHistory += $script:lastResult
                $outputBox.Text = Render-History $script:ResultHistory $lang
                } else { 
                    $script:ResultHistory = @($script:lastResult)
                    $outputBox.Text = Render $script:lastResult $lang
                }
        }
    } catch {
        $outputBox.Text="Error loading data: $($_.Exception.Message)"
    }
})

$switchButton.Add_Click({
    if ($script:ResultHistory.Count -gt 0) {
        $cur = $languageDropdown.SelectedItem
        $other = if ($cur -eq "Deutsch") { "English" } else { "Deutsch" }
        $languageDropdown.SelectedItem = $other
        $outputBox.Text = Render-History $script:ResultHistory $other
    }
})

$bothButton.Add_Click({
    if ($script:ResultHistory.Count -gt 0) {
        $cur = $languageDropdown.SelectedItem
        $other = if ($cur -eq "Deutsch") { "English" } else { "Deutsch" }
        $outputBox.Text = (Render-History $script:ResultHistory $cur) + "`r`n`r`n====================`r`n`r`n" + (Render-History $script:ResultHistory $other)
    }
})

$form.ShowDialog()
