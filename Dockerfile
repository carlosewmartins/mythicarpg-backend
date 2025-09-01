# syntax=docker/dockerfile:1
ARG PYTHON_VERSION=3.13
FROM python:${PYTHON_VERSION}-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Instalar dependências
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar o código (apenas a pasta app/)
COPY app ./app

# Garante que /app entre no sys.path (ajuda em setups diferentes)
ENV PYTHONPATH=/app

EXPOSE 8000

# Use python -m para evitar problemas de PATH do uvicorn
# (deixe 1 worker por enquanto para facilitar logs)
CMD ["python", "-m", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
