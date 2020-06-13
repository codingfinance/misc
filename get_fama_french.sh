#! /bin/bash

# Run the get fama french file
git pull
source activate nlp_course
python get_fama_french.py

# Create a file to commit to github

touch my_file.txt
echo "
#! /bin/bash

git add .
git commit -m 'Get Fama French data'
git push
" >> my_file.txt

bash my_file.txt
rm my_file.txt
rm F-F_Research_Data_Factors.CSV
rm fama_french.zip

git add .
git commit -m 'Get Fama French data'
git push

