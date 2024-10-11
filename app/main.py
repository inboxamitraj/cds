import streamlit as st
import redis

# Connect to Redis
redis_host = "clustercfg.app.tsce7z.apse1.cache.amazonaws.com"  # Change this if you're using a remote Redis server
redis_port = 6379
redis_client = redis.StrictRedis(host=redis_host, port=6379, db=0, decode_responses=True)

# Initialize the counter if not already present
if not redis_client.exists('visitor_counter'):
    redis_client.set('visitor_counter', 0)

# Increment the counter
visitor_count = redis_client.incr('visitor_counter')

# Display the message
st.title("Welcome to My App")
st.write(f"This is the {visitor_count} visitor.")
