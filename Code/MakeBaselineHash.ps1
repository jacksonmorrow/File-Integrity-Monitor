#Make Baseline Hashes
$version = "20191007"
$sP = "C:\Users\jacks\OneDrive\Desktop\Integrity_Folder_Demo"
$baseStorePath = "C:\Users\jacks\OneDrive\Desktop\FileIntegrityCheck\baseline_hashes.csv"
$count = 0

Write-Output "FIM"

cd $sP

Write-Output "ls"

$fL = Get-ChildItem -Recurse
$fN = $fL.Count

$startime = $(Get-Date)
Write-Output "Started at $startime"

$Results = foreach ($FL_Item in $fL)
{
	#Setting up progress bar
    $count++
    Write-Progress -Activity "Hashing Files: $FL_Item " -Status "Processed $count of $fN" -PercentComplete (($count / $fL.Count) * 100)
	
	#Getting file hash
    $hash = Get-FileHash $FL_Item.FullName -Algorithm MD5

    if ($hash)
    {
        [PSCustomObject]@{
        Hash = $hash.Hash
        Path = $hash.Path
        }
    }
}

Write-Output "Scan started at $startime and ended at $(Get-Date)"


# on screen display
#$Results

# send to CSV file    
$Results | Sort Path | Export-Csv -Path $baseStorePath