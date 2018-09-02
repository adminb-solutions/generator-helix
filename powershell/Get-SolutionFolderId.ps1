Function Get-SolutionFolderId {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [string]$SolutionFile,
        [Parameter(Mandatory = $true)]
        [string]$type)
   

    $SolutionFolderGuid = "{2150E333-8FDC-42A3-9474-1A3956D46DE8}"
    $SolutionProjectPattern = @"
(?x)
^ Project \( " $SolutionFolderGuid " \)
\s* = \s*
" (?<name> $type ) " , \s+
" (?<path> [^"]* ) " , \s+
" (?<guid> [^"]* ) "
"@

    Get-Content -Path $SolutionFile |
        ForEach-Object {
        if ($_ -match $SolutionProjectPattern) {
            $Matches['guid']
        }
    }
}

