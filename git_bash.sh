#! /bin/bash

touch my_file.txt
echo "
#! /bin/bash

git add .
git commit -m 'my commit'
git push
" >> my_file.txt

bash my_file.txt
rm my_file.txt  
