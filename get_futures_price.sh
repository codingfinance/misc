#! /bin/bash

# Run the futures_closing_price file

Rscript yahoo_finance_futures.r

# Create a file to commit to github

touch my_file.txt
echo "
#! /bin/bash

git add .
git commit -m 'my commit'
git push
" >> my_file.txt

bash my_file.txt
rm my_file.txt

git add .
git commit -m 'Get closing Futures price from yahoo finance'
git push
