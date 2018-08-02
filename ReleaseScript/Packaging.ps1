$ErrorActionPreference = 'stop'

$targets = 'åãåéÇ‰Ç©ÇË', '„GêØÇ†Ç©ÇË', 'ã’ótà©', 'ã’ótà®', 'ìåñkÇ´ÇËÇΩÇÒv2'
$targetsEnglish = 'Yukari', 'Akari', 'Akane', 'Aoi', 'Kiritan_v2'
$packagePath = './pachage/'

for($i = 0; $i -lt 5; $i++)
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
    Compress-Archive -Path $targetPath -DestinationPath $archiveFile

    Remove-Item $targetPath -Recurse
}
