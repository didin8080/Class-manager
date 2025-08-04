FROM python:3.11-slim

# Install gcc and dev dependencies needed for building wheels
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    python3-dev \
    libffi-dev \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt /app/

RUN pip install --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

COPY . /app/

EXPOSE 8000

# Optional: set non-root user here
# RUN adduser --disabled-password appuser && chown -R appuser /app
# USER appuser

CMD python manage.py migrate && python manage.py runserver 0.0.0.0:8000
