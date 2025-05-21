FROM ollama/ollama:latest

# Create a script to pull the model and start the server
RUN echo '#!/bin/sh\n\
echo "Pulling bge-m3 model..."\n\
ollama pull bge-m3\n\
echo "Starting Ollama server..."\n\
ollama serve' > /start-ollama.sh && chmod +x /start-ollama.sh

# The default Ollama port is already exposed in the base image (11434)

# Set the entrypoint to our script
ENTRYPOINT ["/start-ollama.sh"]
