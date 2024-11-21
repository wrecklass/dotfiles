function Pro {code $PROFILE.CurrentUserCurrentHost}

function nviminit {nvim "C:\Users\smartin\AppData\Local\nvim\init.lua"}
Set-Alias -Name vinit -Value nviminit

# function vimrc {vim "C:\tools\vim\_vimrc"}
function vimrc {vim "C:\Users\smartin\.vimrc"}

function path {$env:Path | tr ';' '\n'}

function ^D {exit}
function ^L {Clear-Host}

function Get-CmdletAlias ($cmdletname) {
    Get-Alias |
        Where-Object -FilterScript {$_.Definition -like "$cmdletname"} |
            Format-Table -Property Definition, Name -AutoSize
} 

function mklnk ($target, $link) {
  New-Item -Path $link -ItemType SymbolicLink -Value $target
}

Set-Alias -Name winln -Value mklnk
Set-Alias -Name open -Value start
Set-Alias -Name which -Value Get-Command
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name vi -Value vim

$env:Path = $env:Path + ";C:\Program Files\Git\usr\bin"


# pip powershell completion start
if ((Test-Path Function:\TabExpansion) -and -not `
    (Test-Path Function:\_pip_completeBackup)) {
    Rename-Item Function:\TabExpansion _pip_completeBackup
}
function TabExpansion($line, $lastWord) {
    $lastBlock = [regex]::Split($line, '[|;]')[-1].TrimStart()
    if ($lastBlock.StartsWith("C:\Users\smartin\AppData\Local\Programs\Python\Python312\python.exe -m pip ")) {
        $Env:COMP_WORDS=$lastBlock
        $Env:COMP_CWORD=$lastBlock.Split().Length - 1
        $Env:PIP_AUTO_COMPLETE=1
        (& C:\Users\smartin\AppData\Local\Programs\Python\Python312\python.exe -m pip).Split()
        Remove-Item Env:COMP_WORDS
        Remove-Item Env:COMP_CWORD
        Remove-Item Env:PIP_AUTO_COMPLETE
    }
    elseif (Test-Path Function:\_pip_completeBackup) {
        # Fall back on existing tab expansion
        _pip_completeBackup $line $lastWord
    }
}
# pip powershell completion end


# function prompt {
#  $ps = Get-Process -id $pid
#  "PS PID:$pid PM(M):{0:N2} WS(M):{1:N2} VM(M):{2:N2} CPU(s):{3:N2}
# $($executionContext.SessionState.Path.CurrentLocation)$('>' * ` ($nestedPromptLevel + 1)) "`
# -f ($ps.PM/1MB), ($ps.ws/1MB), ($ps.vm/1MB), $ps.cpu
# }

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

$env:FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
$env:FZF_CTRL_T_COMMAND="$env:FZF_DEFAULT_COMMAND"
$env:FZF_COMPLETION_OPTS="70% --info=inline --border"
# Import-Module -ArgumentList 'Ctrl+t','Ctrl+r' PSFzf
Import-Module PSFzf
Import-Module PSFzfHistory
Import-Module z
Import-Module Terminal-Icons

Remove-PSReadLineKeyHandler 'Ctrl+r'
Remove-PSReadLineKeyHandler 'Ctrl+t'
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

oh-my-posh init pwsh --config "C:\cygwin64\home\smartin\src\dotfiles\config.omp.json" | Invoke-Expression

# Winget Tab Completion
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
        $Local:word = $wordToComplete.Replace('"', '""')
        $Local:ast = $commandAst.ToString().Replace('"', '""')
        winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}
#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58
