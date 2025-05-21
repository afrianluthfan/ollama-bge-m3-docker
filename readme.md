# Ollama with BGE-M3 Embeddings Docker

This repository contains a Dockerfile for running [Ollama](https://ollama.com/) with the BGE-M3 embedding model, ready to serve as an API endpoint for generating embeddings.

## What's Included

- A Dockerfile that uses the official Ollama image
- Automatic pulling of the BGE-M3 embedding model
- Configuration to serve the model as an API

## Prerequisites

- [Docker](https://www.docker.com/get-started) installed on your system
- Internet connection (to pull the Docker image and the BGE-M3 model)

## Quick Start

### 1. Clone this repository

```bash
git clone https://github.com/afrianluthfan/ollama-bge-m3-docker.git
cd ollama-bge-m3-docker
```

### 2. Build the Docker image

```bash
docker build -t ollama-bge-m3:latest .
```

### 3. Run the container

```bash
docker run -d -p 11434:11434 --name ollama-server ollama-bge-m3:latest
```

This will:
- Start a container named `ollama-server`
- Pull the BGE-M3 model (this may take some time depending on your internet connection)
- Start the Ollama server on port 11434

### 4. Verify the server is running

```bash
curl http://localhost:11434/api/embeddings -d '{
  "model": "bge-m3",
  "prompt": "This is a test sentence for embeddings."
}'
```

## Using the API

Once the server is running, you can generate embeddings by sending POST requests to the `/api/embeddings` endpoint:

```bash
curl http://localhost:11434/api/embeddings -d '{
  "model": "bge-m3",
  "prompt": "Your text here"
}'
```

### Example with Python

```python
import requests
import json

response = requests.post(
    "http://localhost:11434/api/embeddings",
    headers={"Content-Type": "application/json"},
    data=json.dumps({
        "model": "bge-m3",
        "prompt": "This is a test sentence for embeddings."
    })
)

print(response.json())
```

## Container Management

### Stop the container

```bash
docker stop ollama-server
```

### Start an existing container

```bash
docker start ollama-server
```

### Remove the container

```bash
docker rm ollama-server
```

## Persistence

To persist the downloaded models between container restarts, mount a volume:

```bash
docker run -d -p 11434:11434 -v ollama-models:/root/.ollama --name ollama-server ollama-bge-m3:latest
```

## Environment Variables

The Ollama server accepts various environment variables that you can pass using the `-e` flag:

```bash
docker run -d -p 11434:11434 -e OLLAMA_HOST=0.0.0.0:11434 --name ollama-server ollama-bge-m3:latest
```

## License

This project is licensed under the MIT License - see Ollama's repository for more details about its license.

## Acknowledgements

- [Ollama](https://github.com/ollama/ollama) - For providing the embedding server
- [BGE-M3](https://huggingface.co/BAAI/bge-m3) - BAAI's powerful multilingual embedding model
