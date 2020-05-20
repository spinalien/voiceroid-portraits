Add-Type -AssemblyName System.IO.Compression.FileSystem

$ErrorActionPreference = 'stop'

$targets = 'ia_next', 'one_next'
$targetsEnglish = 'ia_next', 'one_next'
$packagePath = './pachage/'

If (test-path $packagePath) {
    Remove-Item -Recurse -Force $packagePath
}

for($i = 0; $i -lt 3; $i++)
{
    $targetPath = $(Join-Path $packagePath $targets[$i])
    New-Item $targetPath -ItemType Directory

    # PSDTool
    $destPath =  $(Join-Path $targetPath '/PSDTool/')
    $targetName = $targets[$i] + '*'
    robocopy '../PSDTool' $destPath $targetName /S

    #YMM
    $destPath =  $(Join-Path $targetPath '/YMM/')
    robocopy $(Join-Path '../YMM' $targets[$i]) $destPath '*.png' /S
    robocopy $(Join-Path '../YMM' $targets[$i]) $destPath '*.pfv' /S

    $archiveFile = $(Join-Path $packagePath $targetsEnglish[$i]) + '.zip'
    [IO.Compression.ZipFile]::CreateFromDirectory($targetPath, $archiveFile, [IO.Compression.CompressionLevel]::Optimal, $true, [Text.Encoding]::Default)

    Remove-Item $targetPath -Recurse
}
