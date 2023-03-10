# powershellDownloader

Helps downloads images or other files from the web

Place the root folder on the desktop and make sure it's called powershellDownloader

# steps
First enter the eclipseSKU into the CSV file (note: this can also be a filename, like 'safetydatasheet' instead)

then, enter the partial URL from a magento export into the imageURL header in the CSV file(can also be a pdf, or any other file, does not have to be an image)

then, in the powershell script, you'll need to edit the $prefix variable to the prefix URL, e.g: $prefix = "https://aramsco.com/media/catalog/product"

Lastly, run the script. The files will download to the images folder. the downloader will name them eclipseSKU.filename 

e.g you download a file and entered the eclipseSKU 100, and if the file was jpg, the image will now be 100.jpg 
