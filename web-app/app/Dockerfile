FROM python:3.7-slim-buster
WORKDIR /app
COPY . /app
RUN pip install -r /app/requirements.txt && \
    chmod 775 /app/gunicorn.sh
EXPOSE 80
ENTRYPOINT ["/app/gunicorn.sh"]
