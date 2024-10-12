import streamlit as st
import redis

# Connect to Redis
redis_host = "dbone-tsce7z.serverless.apse1.cache.amazonaws.com"
redis_port = 6379

r = redis.Redis(host= redis_host, port=6379, db=0, ssl=True, decode_responses=True)

r.ping()

if not r.exists('visitor_counter'):
    r.set('visitor_counter', 0)

visitor_count = r.incr('visitor_counter')

print(visitor_count)

# Display the message

st.set_page_config(page_title="app", layout="centered")

st.markdown("<h1 style='text-align: center;'>This is the visitor Number</h1>", unsafe_allow_html=True)

# Layout for the circular counter
st.markdown(
    """
    <style>
    .circle {
        width: 200px;
        height: 200px;
        border-radius: 50%;
        background-color: #1e90ff;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 48px;
        font-weight: bold;
        margin: 100px auto;
    }
    </style>
    """,
    unsafe_allow_html=True
)


st.markdown(
    f'<div class="circle">{visitor_count}</div>',
    unsafe_allow_html=True
)