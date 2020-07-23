Add-Type -AssemblyName System.IO.Compression.FileSystem

$ErrorActionPreference = 'stop'

$targets = 'ia_next', 'one_next', 'vflower_next', '弦巻マキ_next', '結月ゆかり_next', '琴葉茜_next', '琴葉葵_next'
$targetsEnglish = 'ia_next', 'one_next', 'vflower_next', 'maki_next', 'yukari_next', 'akane_next', 'aoi_next'
$packagePath = './pachage/'

If (test-path $packagePath) {
    Remove-Item -Recurse -Force $packagePath
}

for($i = 0; $i -lt $targets.Length; $i++)
{
    $targetPath = $(Join-Path $packagePath $targets[$i])
    New-Item $targetPath -ItemType Directory

    # PSDTool
    $destPath =  $(Join-Path $targetPath '/PSDTool/')
    $targetName = $targets[$i] + '*'
    robocopy '../PSDTool' $destPath $targetName /S

    $archiveFile = $(Join-Path $packagePath $targetsEnglish[$i]) + '.zip'
    [IO.Compression.ZipFile]::CreateFromDirectory($targetPath, $archiveFile, [IO.Compression.CompressionLevel]::Optimal, $true, [Text.Encoding]::Default)

    Remove-Item $targetPath -Recurse
}
