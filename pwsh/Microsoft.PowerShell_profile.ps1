# Terminal-Icons
Import-Module -Name Terminal-Icons # Install-Module -Name Terminal-Icons -Repository PSGallery

# PSReadLine
Import-Module PSReadLine
#Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

Set-PSReadLineKeyHandler -Key Ctrl+f -Function Complete
Set-PSReadLineKeyHandler -Key Ctrl+j -Function NextHistory
Set-PSReadLineKeyHandler -Key Ctrl+k -Function PreviousHistory
#Set-PSReadLineKeyHandler -Key Ctrl+h -Function BackwardChar
#Set-PSReadLineKeyHandler -Key Ctrl+l -Function ForwardChar
#Set-PSReadLineKeyHandler -Key Ctrl+Shift+l -Function ClearScreen

# Custom Functions
function ls-list([string]$arg) # ls with list view
{
    Get-ChildItem $arg | Format-Wide -AutoSize
}
Set-Alias -Name ls -Value ls-list

function reload # simple reload config command
{
    . $PROFILE
}

function prompt # custom prompt
{
    $ESC = [char]27
    "$ESC[38;2;115;140;190m`u{e70f} $env:USERNAME ~ $($executionContext.SessionState.Path.CurrentLocation)`r`n$ESC[38;2;180;210;230m⮞ "

    # PSReadLine highlighting can change the prompt color :(
}

function match-drive([string]$arg)
{
    # match Drive letter
    if (($arg.Length -eq 1) -and ($arg -match "[a-zA-Z]") )
    {
        $arg = $arg + ":\"
    }
    return $arg
}

function d([string]$arg) # find dir through fzf
{
    $arg = match-drive($arg)
    fd --type d . $arg | fzf -e | cd
}

function dd([string]$drive, [string] $dir) # find dir without fzf
{
    $drive = match-drive($drive)
    $results_str = fd --type d . $drive
    $results = $results_str.Split("\n")
    <#
    $results | ForEach-Object {
        if ($_.Contains($dir, "InvariantCultureIgnoreCase"))
        {
            cd $_
            return
        }
    }
    #>
    $results | where {$_.Contains($dir, "InvariantCultureIgnoreCase")} | select -First 1 | cd
}
