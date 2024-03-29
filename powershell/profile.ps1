# Aliases
New-Alias vim nvim
New-Alias vi nvim
New-Alias l Get-ChildItem
New-Alias grep rg

# Functions
function cd... {
    cd ..
    cd ..
}

function la {
    Get-ChildItem -Force $Args[0]
}

function lr {
    Get-ChildItem -Recurse $Args[0]
}

function update {
    if ($Args.count) {
        Update-Module $Args
    }
    else {
        Update-Module -Confirm
    }
}

function mkd {
    mkdir $Args[0]
    cd $Args[0]
}

# PSReadLine
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle InlineView

# Git integration
Import-Module posh-git

# Oh My Posh
oh-my-posh init pwsh --config ~/Documents/PowerShell/omp.json | Invoke-Expression

# Disable Python virtual environment prompts
$Env:VIRTUAL_ENV_DISABLE_PROMPT = 1

# Change the awful default coloring
$PSStyle.FileInfo.Directory = "`e[95;1m"
