
import streamlit as st
import pandas as pd

# Title
st.title("Interns Tracker / Exit Portal")
st.write("Track interns/applicants based on their current status")

# Load data
@st.cache_data
def load_data(filepath):
    df = pd.read_csv(filepath)
    return df

df = load_data("data/applicants.csv")  # CSV with Name, Department, Status, Reason

# Sidebar filter
st.sidebar.header("Filter Applicants")
status_options = df['Status'].unique().tolist()
selected_status = st.sidebar.multiselect("Select Status", status_options, default=status_options)

# Filtered data
filtered_df = df[df['Status'].isin(selected_status)]

# Dashboard
st.subheader(f"Showing {len(filtered_df)} Applicants")
st.dataframe(filtered_df)

# Status summary
st.subheader("Status Summary")
status_counts = filtered_df['Status'].value_counts()
st.bar_chart(status_counts)
