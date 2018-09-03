Function Add-Line {
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true)]
    [string]$FileName,
    [Parameter(Mandatory=$true)]
    [string]$Pattern,
    [Parameter(Mandatory=$true)]
    [string[]]$LinesToAdd)
    
    $OriginalContents = Get-Content $FileName
    $hasBeenAdded = $false
    [String[]] $ModifiedContent = @() 
    Foreach ($Line in $OriginalContents)
    {   
        $ModifiedContent += $Line
        if ($Line.Trim() -eq $Pattern -and !$hasBeenAdded) 
        { 
            $ModifiedContent += $LinesToAdd   
            $hasBeenAdded = $true;
        }
    }
    $timestamp = Get-Date -Format o | ForEach-Object {$_ -replace ":", "."}

    Set-Content "$FileName-$timestamp" $ModifiedContent -Force
    Rename-Item -Path "$FileName-$timestamp" -NewName "$FileName" -Force
}
