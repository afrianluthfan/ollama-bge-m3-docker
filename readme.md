# Ollama with BGE-M3 Embeddings Docker

This repository contains a Dockerfile for running [Ollama](https://ollama.com/) with the [BGE-M3 embedding model](https://huggingface.co/BAAI/bge-m3), ready to serve as an API endpoint for generating text embeddings.

## What's Included

- A Dockerfile based on the official Ollama image
- Automated pulling of the `bge-m3` embedding model (only if not already available)
- Configuration to serve the model as a local HTTP API

## Prerequisites

- [Docker](https://www.docker.com/get-started) installed
- Internet connection (only required on first-time model pull)

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

### 3. Run the container with persistent model volume

To persist the downloaded models and avoid redownloading each time:

```bash
docker run -d \
  -p 11434:11434 \
  -v ollama-models:/root/.ollama \
  --name ollama-server \
  ollama-bge-m3:latest
```

### 4. Verify the server is running

```bash
curl http://localhost:11434/api/embeddings -d '{
  "model": "bge-m3",
  "prompt": "This is a test sentence for embeddings."
}'
```

## Using the API

You can generate embeddings with a simple POST request:

```bash
curl http://localhost:11434/api/embeddings -d '{
  "model": "bge-m3",
  "prompt": "Your text here"
}'
```

### Example in Python

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

### Start the container again

```bash
docker start ollama-server
```

### Remove the container

```bash
docker rm ollama-server
```

## Volume for Model Persistence

Models are stored in `/root/.ollama`. To ensure they are not lost between runs, use a Docker volume:

```bash
docker run -d \
  -p 11434:11434 \
  -v ollama-models:/root/.ollama \
  --name ollama-server \
  ollama-bge-m3:latest
```

## Environment Variables

You can pass optional environment variables to customize Ollama behavior:

```bash
docker run -d -p 11434:11434 \
  -v ollama-models:/root/.ollama \
  -e OLLAMA_HOST=0.0.0.0:11434 \
  --name ollama-server \
  ollama-bge-m3:latest
```

## License

This project is licensed under the MIT License. See the Ollama license for further details.

## Acknowledgements

- [Ollama](https://github.com/ollama/ollama) - Local LLM server
- [BGE-M3](https://huggingface.co/BAAI/bge-m3) - Multilingual embedding model by BAAI

---

# 🇮🇩 Versi Bahasa Indonesia

# Ollama dengan Model Embedding BGE-M3 (Docker)

Repositori ini berisi Dockerfile untuk menjalankan [Ollama](https://ollama.com/) bersama model embedding [BGE-M3](https://huggingface.co/BAAI/bge-m3), siap digunakan sebagai endpoint API untuk menghasilkan embeddings dari teks.

## Fitur

- Dockerfile berbasis image resmi Ollama
- Penarikan otomatis model `bge-m3` (hanya jika belum ada)
- Konfigurasi server embedding API lokal via HTTP

## Prasyarat

- [Docker](https://www.docker.com/get-started) telah terinstal di sistem Anda
- Koneksi internet (hanya diperlukan saat pertama kali menarik model)

## Cara Cepat

### 1. Kloning repositori ini

```bash
git clone https://github.com/afrianluthfan/ollama-bge-m3-docker.git
cd ollama-bge-m3-docker
```

### 2. Build Docker image-nya

```bash
docker build -t ollama-bge-m3:latest .
```

### 3. Jalankan container dengan volume untuk model

Agar model yang sudah diunduh tidak perlu diunduh ulang setiap kali container dijalankan:

```bash
docker run -d \
  -p 11434:11434 \
  -v ollama-models:/root/.ollama \
  --name ollama-server \
  ollama-bge-m3:latest
```

### 4. Verifikasi server sudah aktif

```bash
curl http://localhost:11434/api/embeddings -d '{
  "model": "bge-m3",
  "prompt": "Ini adalah kalimat uji coba untuk embeddings."
}'
```

## Menggunakan API

Kirim permintaan `POST` ke endpoint berikut untuk menghasilkan embeddings:

```bash
curl http://localhost:11434/api/embeddings -d '{
  "model": "bge-m3",
  "prompt": "Teks Anda di sini"
}'
```

### Contoh dengan Python

```python
import requests
import json

response = requests.post(
    "http://localhost:11434/api/embeddings",
    headers={"Content-Type": "application/json"},
    data=json.dumps({
        "model": "bge-m3",
        "prompt": "Ini adalah kalimat uji coba untuk embeddings."
    })
)

print(response.json())
```

## Manajemen Container

### Hentikan container

```bash
docker stop ollama-server
```

### Jalankan ulang container

```bash
docker start ollama-server
```

### Hapus container

```bash
docker rm ollama-server
```

## Volume untuk Menyimpan Model

Model disimpan dalam direktori `/root/.ollama`. Untuk memastikan model tidak hilang saat container dimatikan, gunakan volume Docker:

```bash
docker run -d \
  -p 11434:11434 \
  -v ollama-models:/root/.ollama \
  --name ollama-server \
  ollama-bge-m3:latest
```

## Variabel Lingkungan

Anda bisa menambahkan variabel lingkungan saat menjalankan container, misalnya:

```bash
docker run -d \
  -p 11434:11434 \
  -v ollama-models:/root/.ollama \
  -e OLLAMA_HOST=0.0.0.0:11434 \
  --name ollama-server \
  ollama-bge-m3:latest
```

## Lisensi

Proyek ini menggunakan lisensi MIT. Untuk lisensi Ollama dan BGE-M3, lihat masing-masing repositorinya.

## Ucapan Terima Kasih

- [Ollama](https://github.com/ollama/ollama) - Server LLM lokal
- [BGE-M3](https://huggingface.co/BAAI/bge-m3) - Model embedding multibahasa oleh BAAI
