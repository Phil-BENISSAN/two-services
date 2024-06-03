# Dockerfile
FROM python:3.11.9-slim AS base

# Installer les dépendances
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copier le code de l'application
COPY . /app
WORKDIR /app

# Construire l'image Nginx
FROM nginx:alpine AS nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Construire l'image finale
FROM base

# Copier les configurations Nginx
COPY --from=nginx /etc/nginx/nginx.conf /etc/nginx/nginx.conf

# Exposer les ports
EXPOSE 80

# Lancer Nginx et les applications
CMD ["sh", "-c", "streamlit run streamlit_app.py --server.port=8501 --server.enableCORS=false & uvicorn fastapi_app:app --host 0.0.0.0 --port 8000 & nginx -g 'daemon off;'"]
