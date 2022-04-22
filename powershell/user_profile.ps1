# Aliases
New-Alias vim nvim
New-Alias vi nvim
New-Alias l Get-ChildItem
New-Alias grep findstr

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

# Oh My Posh
Import-Module posh-git
Import-Module oh-my-posh
oh-my-posh init pwsh --config ~/.config/powershell/omp.json | Invoke-Expression

# Disable Python virtual environment prompts
$Env:VIRTUAL_ENV_DISABLE_PROMPT = 1
