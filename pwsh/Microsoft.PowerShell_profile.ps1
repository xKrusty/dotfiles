# Terminal-Icons
Import-Module -Name Terminal-Icons # Install-Module -Name Terminal-Icons -Repository PSGallery

# PSReadLine
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView

Set-PSReadLineKeyHandler -Key Ctrl+f -Function Complete
Set-PSReadLineKeyHandler -Key Ctrl+h -Function BackwardChar
Set-PSReadLineKeyHandler -Key Ctrl+j -Function NextHistory
Set-PSReadLineKeyHandler -Key Ctrl+k -Function PreviousHistory
Set-PSReadLineKeyHandler -Key Ctrl+l -Function ForwardChar
Set-PSReadLineKeyHandler -Key Ctrl+Shift+l -Function ClearScreen

# Custom Functions
function ls-list([string]$arg) # ls with list view
{
    Get-ChildItem $arg | Format-Wide
}
Set-Alias -Name ls -Value ls-list

function reload # simple reload config command
{
    . $PROFILE
}

# custom Prompt
function prompt
{
    $ESC = [char]27
    "$ESC[38;2;115;140;190m`u{e70f} $env:USERNAME ~ $($executionContext.SessionState.Path.CurrentLocation)`r`n$ESC[38;2;180;210;230m⮞ "

    # PSReadLine highlighting can change the prompt color :(
}
