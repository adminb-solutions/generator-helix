Function Add-BuildConfigurations {
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectPath,
    [Parameter(Mandatory=$true)]
    [object[]]$Configurations)

    $propertyGroupCondition = "</PropertyGroup>" 
    foreach ($configuration in $Configurations)
    {
        $configurationToAdd = $configuration.Replace(" ","")
        $addProjectBuildConfiguration = @(
                    "  <PropertyGroup Condition=`"'`$(Configuration)|`$(Platform)' == '$configurationToAdd'`">",
                    "    <DebugSymbols>true</DebugSymbols>",
                    "    <OutputPath>bin\</OutputPath>",
                    "    <DefineConstants>DEBUG;TRACE</DefineConstants>",
                    "    <DebugType>full</DebugType>",
                    "    <PlatformTarget>AnyCPU</PlatformTarget>",
                    "    <ErrorReport>prompt</ErrorReport>",
                    "    <CodeAnalysisRuleSet>MinimumRecommendedRules.ruleset</CodeAnalysisRuleSet>",
                    "  </PropertyGroup>")

        Write-Output "Writing $configurationToAdd to $ProjectPath"
        Add-Line -FileName $projectPath -Pattern $propertyGroupCondition -LinesToAdd $addProjectBuildConfiguration
    }
}
