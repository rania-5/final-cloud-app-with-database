FROM python:3.10-slim

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV APP=/app

WORKDIR $APP

COPY requirements.txt $APP
RUN pip3 install --no-cache-dir "Django<4" Pillow gunicorn && \
    pip3 install --no-cache-dir -r requirements.txt || true

COPY . $APP

EXPOSE 8000

CMD ["sh", "-c", "python3 manage.py migrate && gunicorn --bind 0.0.0.0:8000 --workers 3 myproject.wsgi"]
