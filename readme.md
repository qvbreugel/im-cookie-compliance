# :cookie: Cookie Compliance

This project sets up a Docker container with Ubuntu, Python, Jupyter Notebook, Selenium, and SQLite. It provides multiple scripts to form a Proof of Concept for an internet measurement on how to check for cookie compliance according to European Union regulations. The goal of this repository is to provide an easy way to set up the dependencies for further improvement on the methodology while keeping the dependencies in place.

## Prerequisites

- Docker: Ensure Docker is installed on your system. You can download and install it from the [official Docker website](https://www.docker.com/).

## Getting Started

### 1. Clone the Repository

Clone this repository to your local machine:

```sh
git clone https://github.com/yourusername/your-repo.git
cd your-repo
```

### 2. Build the Docker Image

Give the Docker Image a name (im-cookie-compliance) and build it:

```sh
docker build -t im-cookie-compliance .
```

### 3. Run the Docker Container

Run the Docker Container based on the image built in the previous step:

```sh
docker run -p 8888:8888 -v $(pwd)/notebooks:/notebooks im-cookie-compliance .
```

This exposes port 8888 to your local machine allowing you to interact with Jupyter notebook with the required dependencies.
The notebook should contain several notebooks numbered from 1 - 7 and a folder called data.
If Jupyter Notebook asks for a token, check the Docker Container's logs as it should provide a link to the local environment with the token embedded in the URL.

### 4. Reproduce results

To reproduce the results, run the Jupyter notebooks in order from 1 till 7.
All data in the data folder can be replaced to experiment with different domains, keywords or cookie information.

## Contact information

For any questions regarding this repository or code, feel free to contact me at q.s.vanbreugel@student.utwente.nl
