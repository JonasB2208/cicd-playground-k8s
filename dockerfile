# Build Stage
FROM python:3.12-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# Final Stage
FROM python:3.12-slim
WORKDIR /usr/local/app
COPY --from=builder /install /usr/local
COPY app ./app
EXPOSE 8080
RUN useradd test_user
USER test_user
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]