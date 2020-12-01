import requests
import pandas as pd
from pandas import Series, DataFrame
from pandas import DataFrame as df

def hist(item):
   
    hist = requests.get(f"https://fmpcloud.io/api/v3/historical-price-full/{item}?timeseries=3650&apikey=003086c4ddcfe0b91a16db6952cbbf93")
    #convert response to json
    hist = hist.json()

    #Parse the API response and select only last ? days of prices
    hist = hist['historical'][-3650:]
    hist = pd.DataFrame.from_dict(hist)
    hist2 = {}
    hist2['date'] = hist['date']
    hist2['open'] = hist['open']
    hist2['close'] = hist['close']

    #Convert from dict to pandas datafram
    hist_df = pd.DataFrame.from_dict(hist2)
    hist_df.to_csv("{}.csv".format(item))
