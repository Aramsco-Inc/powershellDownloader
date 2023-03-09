##Created by Guy Orazem/MidnightChems
#This script downloads images from a URL, this script assums that the URL provided is only partial
# e.g a magento export will show an image URL of /3/m/3m09551_aa24.jpg
#update the $prefix below to change the download destination

##The root folder for this project should be named powerImages and placed on your desktop.

# Set the path to the CSV file
$csvPath = "$env:USERPROFILE\Desktop\powerImages\image.csv"

# Set the prefix to add to the partial URLs
$prefix = "https://aramsco.com/media/catalog/product"

# Set the path to the images folder
$imageFolderPath = "$env:USERPROFILE\Desktop\powerImages\images"

# Set the path to the log file
$logFilePath = "$env:USERPROFILE\Desktop\powerImages\error.log"

$csvContent = Get-Content $csvPath
$csvContent | Set-Content $csvPath

# Create the images and log folders if they don't exist
New-Item -ItemType Directory -Force -Path $imageFolderPath
New-Item -ItemType Directory -Force -Path (Split-Path -Path $logFilePath)

# Loop through each row in the CSV file
Import-Csv $csvPath | ForEach-Object {
    # Get the SKU and partial URL from the current row
    $sku = $_.eclipseSKU
    $partialUrl = $_.imageURL

    # Construct the full image URL
    $imageUrl = "$prefix/$partialUrl"

    # Set the filename for the downloaded image
    $fileExtension = [System.IO.Path]::GetExtension($partialUrl)
    $filename = "$sku$fileExtension"
    $imageFilePath = Join-Path -Path $imageFolderPath -ChildPath $filename

    # Attempt to download the image
    try {
        Invoke-WebRequest -Uri $imageUrl -OutFile $imageFilePath -ErrorAction Stop
        Write-Host "Downloaded image for SKU $sku to $imageFilePath"
    }
    catch {
        # If the download fails, log an error message to the log file
        $errorMessage = "Failed to download image for SKU $sku from $imageUrl. Error message: $_"
        Add-Content -Path $logFilePath -Value $errorMessage
        Write-Host $errorMessage
    }
}
