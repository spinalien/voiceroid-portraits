$data = (Invoke-WebRequest https://api.github.com/repos/spinalien/voiceroid-portraits/releases | ConvertFrom-Json)
$data | ForEach-Object -Process {
    Write-Host "Name:`t" $_.name
    Write-Host "Tag:`t" $_.tag_name
    Write-Host "URL:`t" $_.url
    Write-Host "Published:`t" $_.published_at

    $_.assets | ForEach-Object -Process {
        Write-Host "ZipName:`t" $_.name
        Write-Host "DownloadCount`t:" $_.download_count
    }

    Write-Host "----"
}