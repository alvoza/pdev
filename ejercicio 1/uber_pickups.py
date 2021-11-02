import streamlit as st
import pandas as pd
import seaborn as sns
import numpy as np


DATA_URL = 'https://s3-us-west-2.amazonaws.com/streamlit-demo-data/uber-raw-data-sep14.csv.gz'

@st.cache(allow_output_mutation=True)
def download_data():
    return pd.read_csv(DATA_URL)

nrow = st.sidebar.slider('No. Rows to Display:', 0,10000, value=100)
hour_range = st.sidebar.slider('Select the hour range:', 0,24,(8,17))

st.sidebar.write('Hours selected: ', hour_range[0], hour_range[1])

data = (download_data()
        .rename(columns={'Date/Time': 'date_time', 'Lat': 'lat', 'Lon': 'lon', 'Base': 'base'})
        .assign(date_time=lambda df: pd.to_datetime(df.date_time))
        .loc[lambda df: (df.date_time.dt.hour >= hour_range[0]) & (df.date_time.dt.hour < hour_range[1])]
        .loc[1:nrow]
        )

data.sort_values("date_time", axis=0, ascending=True, inplace=True, na_position='last')
data
#st.sidebar.write('Rows selected after filter: ', len(data))

st.map(data)


sns.displot(data.date_time.dt.hour)
st.pyplot()
