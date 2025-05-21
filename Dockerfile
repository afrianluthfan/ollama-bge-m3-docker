FROM ollama/ollama:latest

# Install curl if it's not already available
RUN apt-get update && apt-get install -y curl

# Create the startup script
RUN echo '#!/bin/sh\n\
set -e\n\
echo "🔸 Starting Ollama server in background..."\n\
ollama serve &\n\
SERVER_PID=$!\n\
\n\
# Wait until Ollama returns HTTP 200\n\
echo "🔸 Waiting for Ollama server to become ready..."\n\
max_retries=30\n\
retry_count=0\n\
while :; do\n\
  status=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:11434/ || true)\n\
  if [ "$status" = "200" ]; then\n\
    echo "✅ Ollama server is up!"\n\
    break\n\
  fi\n\
  retry_count=$((retry_count + 1))\n\
  if [ $retry_count -ge $max_retries ]; then\n\
    echo "❌ Server did not start in time."\n\
    exit 1\n\
  fi\n\
  echo "⏳ Waiting... ($retry_count/$max_retries), status: $status"\n\
  sleep 2\n\
done\n\
\n\
# Pull the model only if not already present\n\
echo "📦 Checking if model bge-m3 exists..."\n\
if ! ollama list | grep -q "^bge-m3"; then\n\
  ollama list\n\
  echo "⬇️ Pulling model: bge-m3"\n\
  ollama pull bge-m3\n\
else\n\
  echo "✅ Model bge-m3 already present, skipping pull."\n\
fi\n\
\n\
# Restart Ollama in foreground\n\
kill $SERVER_PID\n\
sleep 2\n\
echo "🚀 Starting Ollama server in foreground..."\n\
exec ollama serve' > /start-ollama.sh && chmod +x /start-ollama.sh

ENTRYPOINT ["/start-ollama.sh"]
