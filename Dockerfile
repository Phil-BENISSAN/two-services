# Utiliser une image de base Python
FROM python:3.9-slim

# Installer les dépendances
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copier le code de l'application
COPY . /app
WORKDIR /app

# Exposer les ports pour Streamlit et FastAPI
EXPOSE 8501
EXPOSE 8000

# Démarrer les deux applications
CMD ["sh", "-c", "streamlit run streamlit_app.py --server.port=8501 --server.enableCORS=false & uvicorn fastapi_app:app --host 0.0.0.0 --port 8000"]
