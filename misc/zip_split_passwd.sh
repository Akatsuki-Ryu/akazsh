echo input the file name 
read filename
zip -P zheshiyigexinwen $filename+compress.zip *

zip -r -s 50m $filename.zip $filename+compress.zip
rm -r $filename+compress.zip