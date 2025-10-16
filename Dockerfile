
FROM python:3.11-slim as builder
WORKDIR /app
COPY requirements.txt .
RUN python -m venv /opt/venv && /opt/venv/bin/pip install --no-cache-dir -r requirements.txt

FROM python:3.11-slim
WORKDIR /app
COPY --from=builder /opt/venv /opt/venv

COPY . .
EXPOSE 8000
ENV PATH="/opt/venv/bin:$PATH"

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
