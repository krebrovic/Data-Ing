import schedule
import time
import sys
import subprocess

def job():
    
    schedule.every().monday.at("10:00").do(subprocess.call([sys.executable, 'C:\\Users\\krebrovic\\Desktop\\Data engineering zadatak\\DE.py'], shell=True))

while True:
    schedule.run_pending()
    time.sleep(1)

