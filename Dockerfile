# Use the official Python image as the base image
FROM python:3.9

USER 1001
# Create a working directory inside the container
WORKDIR /app

# Copy your Python script and requirements.txt file into the container
COPY app/main.py /app/
COPY app/requirements.txt /app/

# Create and activate a virtual environment
RUN python -m venv venv
ENV PATH="/app/venv/bin:$PATH"

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Run your Python script when the container starts
CMD ["streamlit", "run", "main.py"]