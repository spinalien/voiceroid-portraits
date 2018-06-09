$ErrorActionPreference = 'stop'

$targets = 'åãåéÇ‰Ç©ÇË', '„GêØÇ†Ç©ÇË', 'ã’ótà©', 'ã’ótà®'
$targetsEnglish = 'Yukari', 'Akari', 'Akane', 'Aoi'
$packagePath = './pachage/'

for($i = 0; $i -lt 4; $i++)
{
    $targetPath = $(Join-Path $packagePath $targets[$i])
    $destPath =  $(Join-Path $targetPath '/PSDTool/')
    New-Item $destPath -ItemType Directory

    # PSDTool
    robocopy '../PSDTool' $destPath $targetName /S

    $destPath =  $(Join-Path $targetPath '/YMM/')

    #YMM
    robocopy $(Join-Path '../YMM' $targets[$i]) $destPath '*.png' /S

    $archiveFile = $(Join-Path $packagePath $targetsEnglish[$i]) + '.zip'
    Compress-Archive -Path $targetPath -DestinationPath $archiveFile

    Remove-Item $targetPath -Recurse
}
