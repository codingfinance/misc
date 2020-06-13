#! /bin/bash

# Run the get spx components file

Rscript get_spx_components.r

# Create a file to commit to github

touch my_file.txt
echo "
#! /bin/bash

git add .
git commit -m 'Get SPX Components data'
git push
" >> my_file.txt

bash my_file.txt
rm my_file.txt

git add .
git commit -m 'Get SPX Components data'
git push

