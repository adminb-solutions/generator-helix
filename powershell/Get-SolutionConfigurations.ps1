
Function Get-SolutionConfigurations {
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true)]
    [string]$SolutionFile)

    $SolutionConfigurationPattern = @"
(?x)
^[^=]+ = \s* (?<configuration> \w+  \| .+)
"@

    $set = New-Object System.Collections.Generic.HashSet[string]

    Get-Content -Path $SolutionFile |
        ForEach-Object {
            if ($_ -match $SolutionConfigurationPattern) {
                $set.Add($Matches['configuration']) | Out-Null
            }
        }
    $set
}

