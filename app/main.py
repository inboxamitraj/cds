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
st.title("Welcome to My App")
st.write(f"This is the {visitor_count} visitor.")

