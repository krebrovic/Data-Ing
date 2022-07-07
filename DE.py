import pandas as pd
import numpy as np
import matplotlib.pyplot as plt 
import seaborn as sns
import sqlite3 as sl
import time, os, fnmatch, shutil
import csvfile




# First we read data

try:
    df_stores = pd.read_csv('C:/Users/krebrovic/Desktop/Data engineering zadatak/_data_in/stores_dataset.csv')
    df_features = pd.read_csv('C:/Users/krebrovic/Desktop/Data engineering zadatak/_data_in/Features_dataset.csv', parse_dates = ['Date'])
    df_sales = pd.read_csv('C:/Users/krebrovic/Desktop/Data engineering zadatak/_data_in/sales_dataset.csv', parse_dates = ['Date'])
except:
    print('no file') 
    ######## and send email #################
    
# one time, we create db
con = sl.connect('myDB_new.db')

# we create all the tables if they dont exist, otherwise append
df_stores.to_sql('Stores', con, if_exists='append', index=False)

df_features.to_sql('Features', con, if_exists='append', index=False)

df_features.to_sql('Sales', con, if_exists='append', index=False)



#move to archive
t = time.localtime()
timestamp = time.strftime('%b-%d-%Y_%H%M', t)
shutil.move('C:/Users/krebrovic/Desktop/Data engineering zadatak/_data_in/stores_dataset.csv', 'C:/Users/krebrovic/Desktop/Data engineering zadatak/Archive/stores_dataset'+ timestamp +'.csv')
shutil.move('C:/Users/krebrovic/Desktop/Data engineering zadatak/_data_in/Features_dataset.csv', 'C:/Users/krebrovic/Desktop/Data engineering zadatak/Archive/Features_dataset'+ timestamp +'.csv')
shutil.move('C:/Users/krebrovic/Desktop/Data engineering zadatak/_data_in/sales_dataset.csv', 'C:/Users/krebrovic/Desktop/Data engineering zadatak/Archive/sales_dataset'+ timestamp +'.csv')

#### Send an Email #####
## this is where the code for email goes

######################

##### write to log file
## code

###########################


