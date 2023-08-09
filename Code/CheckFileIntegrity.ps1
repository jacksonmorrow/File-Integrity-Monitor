#Check File Hashes
$sP = "C:\Users\jacks\OneDrive\Desktop\Integrity_Folder_Demo"
$baseStorePath = "C:\Users\jacks\OneDrive\Desktop\FileIntegrityCheck\baseline_hashes.csv"
$currentStorePath = "C:\Users\jacks\OneDrive\Desktop\FileIntegrityCheck\current_hashes.csv"
$diffPathath = "C:\Users\jacks\OneDrive\Desktop\FileIntegrityCheck\differences_hashes.txt"

$version = "20191007"
$count = 0

Write-Output "FIM"

cd $sP


$fileList = Get-ChildItem -Recurse
$fileNumber = $fileList.Count

$startime = $(Get-Date)
Write-Output "Scan started at $startime"

$Results = foreach ($FL_Item in $fileList)
{
    $count++
    Write-Progress -Activity "Checking File Hashes: $FL_Item " -Status "Processed $count of $fileNumber" -PercentComplete (($count / $fileList.Count) * 100)
    $fileHash = Get-FileHash $FL_Item.FullName -Algorithm MD5

    if ($fileHash) #if here so we do not write blanks for folders
    {
        [PSCustomObject]@{
        Hash = $fileHash.Hash
        Path = $fileHash.Path
        }
    }
}

Write-Output "Scan started at $startime and ended at $(Get-Date)"

# Save to CSV file    
$Results | Sort Path | Export-Csv -Path $currentStorePath

# Write differences between old and new hashes to a text file
Compare-Object (Get-Content $baseStorePath)(Get-Content $currentStorePath) | Format-Table -Wrap | Out-File $diffPathath

Write-Output "Scan started at $startime and ended at $(Get-Date)"

# Read in text file
$changes = Get-Content -Path $diffPathath

# Display changes
$changes

$input = Read-Host -Prompt 'Would you like to update the base hashes? y/n'

if ($input -eq 'y')
{
    Remove-Item $baseStorePath
    $Results | Sort Path | Export-Csv -Path $baseStorePath
    Write-Output "Base hashes updated."
}

Write-Output "Done..."