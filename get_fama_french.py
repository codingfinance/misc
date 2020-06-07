import urllib.request
import zipfile
ff_url = "https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/F-F_Research_Data_Factors_CSV.zip"
# Download the file and save it
# We will name it fama_french.zip file
urllib.request.urlretrieve(ff_url,'fama_french.zip')
zip_file = zipfile.ZipFile('fama_french.zip', 'r')
# Next we extact the file data
# We will call it ff_factors.csv
zip_file.extractall()
# Make sure you close the file after extraction
zip_file.close()
import pandas as pd
ff_factors = pd.read_csv('F-F_Research_Data_Factors.csv', skiprows = 3, nrows = 1114, index_col = 0)
ff_factors.index = pd.to_datetime(ff_factors.index, format= '%Y%m')
ff_factors.index = ff_factors.index + pd.offsets.MonthEnd()
ff_factors = ff_factors.apply(lambda x: x/ 100)

ff_factors.to_csv("ff_factors.csv")
