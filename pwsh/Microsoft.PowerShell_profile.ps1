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

function prompt # custom prompt
{
    $ESC = [char]27
    "$ESC[38;2;115;140;190m`u{e70f} $env:USERNAME ~ $($executionContext.SessionState.Path.CurrentLocation)`r`n$ESC[38;2;180;210;230m⮞ "

    # PSReadLine highlighting can change the prompt color :(
}

### CUSTOM FUNCTIONS ###

function ls-list([string]$arg) # ls with list view
{
    Get-ChildItem $arg | Format-Wide -AutoSize
}
Set-Alias -Name ls -Value ls-list


# dive: dve <drive>
# fuzzy find in a drive, requires fzf
# automatically cd into selected result
function dve([string]$drive)
{
    if ($drive -eq "")
    {
        Write-Host "Missing input: dve <drive>."
        return
    }

    $drive = match-drive($drive)
    if ($drive -eq "")
    {
        Write-Host "Invalid Drive, provide drive letter without ':'"
        return
    }

    fd --type d . $drive  | fzf -e | cd
}

# dive: ddve <drive> <folder>
# tries to find the entered folder and cd into it
# TODO: occasionally finds and selects the wrong directory/sub-dir
function ddve([string]$drive, [string] $dir)
{
    if ($dir -eq "")
    {
        Write-Host "Missing input: ddve <drive> <dir>."
        return
    }

    $drive = match-drive($drive)
    $results_str = fd --type d . $drive --max-depth 4
    $results = $results_str.Split("\n")
    <#
    $results | ForEach-Object {
        if (($_ + "\").Contains("\" + $dir + "\", "InvariantCultureIgnoreCase"))
        {
            cd $_
            return
        }
    }
    #>
    $results | where {($_+"\").Contains("\" + $dir + "\", "InvariantCultureIgnoreCase")} | select -First 1 | cd
}

# Replacement for 'where', since that cant find 90% of binaries
function which ($arg) 
{
    Get-Command $arg -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

### UTIL FUNCTIONS ###

function match-drive([string]$arg)
{
    # match Drive letter
    if (($arg.Length -eq 1) -and ($arg -match "[a-zA-Z]") )
    {
        $arg = $arg + ":\"
        return $arg
    }
    return ""
}

