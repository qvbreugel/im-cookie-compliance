# Use the Ubuntu 22.04 base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Add Python 3.8 to the image
FROM python:3.8

# Copy the Chrome Debian package to the image
COPY packages/chrome_114_amd64.deb /tmp

# Update package lists for the Ubuntu system and installr required packages
# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    wget \
    sqlite3 \
    unzip \
    /tmp/chrome_114_amd64.deb \
    && rm /tmp/chrome_114_amd64.deb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the image to /app
WORKDIR /app

# # Download ChromeDriver binary version 114.0.5735.90 for Linux
RUN wget --progress=dot:giga https://chromedriver.storage.googleapis.com/114.0.5735.90/chromedriver_linux64.zip \
    # Unzip, install and clean ChromeDriver library
    && unzip chromedriver_linux64.zip \
    && mv chromedriver /usr/bin/chromedriver \
    && rm chromedriver_linux64.zip


# Install Selenium version 4.0.0 using pip
# hadolint ignore=DL3013
RUN pip install --no-cache-dir \
    selenium==4.0.0 \
    notebook \
    pandas \
    spacy \
    setuptools \
    wheel

# Install SpaCy models
# hadolint ignore=DL3059
RUN python -m spacy download en_core_web_sm  \
    && python -m spacy download de_core_news_sm \
    && python -m spacy download nl_core_news_sm

# Copy the scripts to the container
COPY scripts /app

# Expose the Jupyter Notebook port
EXPOSE 8888

# Start Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]