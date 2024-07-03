# Use the Ubuntu 22.04 base image
FROM --platform=linux/amd6 ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Add Python 3.8 to the image
FROM --platform=linux/amd64  python:3.8

# Update package lists for the Ubuntu system
RUN apt-get update

# Install the 'unzip' package
RUN apt install unzip

# Copy the Chrome Debian package to the image
COPY packages/chrome_114_amd64.deb ./

# Install the SQLite3 package
RUN apt install sqlite3 -y

# Install the Chrome Debian package
RUN apt install ./chrome_114_amd64.deb -y

# Download ChromeDriver binary version 114.0.5735.90 for Linux
RUN wget https://chromedriver.storage.googleapis.com/114.0.5735.90/chromedriver_linux64.zip

# Unzip the downloaded ChromeDriver binary
RUN unzip chromedriver_linux64.zip

# Move the ChromeDriver binary to /usr/bin
RUN mv chromedriver /usr/bin/chromedriver

# Set the working directory inside the image to /app
WORKDIR /app

# Copy the scripts to the container
COPY scripts /app

# Install Selenium version 4.0.0 using pip
RUN pip install selenium==4.0.0

# Install Jupyter Notebook
RUN pip install notebook

# Install SpaCy
RUN pip install -U pip setuptools wheel
RUN pip install spacy
RUN python -m spacy download en_core_web_sm
RUN python -m spacy download nl_core_news_sm
RUN python -m spacy download de_core_news_sm

# Install pandas
RUN pip install pandas

# Expose the Jupyter Notebook port
EXPOSE 8888

# Start Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]