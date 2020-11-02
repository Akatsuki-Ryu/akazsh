echo input the file name 
read filename
echo input the package password
read password
echo input the split size in mb
read volsize
zip -P $password $filename+compress.zip *

zip -r -s $volsize\m $filename.zip $filename+compress.zip
rm -r $filename+compress.zip