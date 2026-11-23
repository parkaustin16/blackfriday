# Dockerfile for Black Friday Screen Capture App
# Build: docker build -t blackfriday-capture .
# Run: docker run -p 8501:8501 blackfriday-capture

FROM python:3.11-slim

WORKDIR /app

# Install system dependencies for Playwright
RUN apt-get update && apt-get install -y \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libatspi2.0-0 \
    libgtk-3-0 \
    libnss3 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libasound2t64 \
    libpangocairo-1.0-0 \
    libpango-1.0-0 \
    libcairo2 \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Playwright Chromium
RUN python -m playwright install chromium

# Copy application code
COPY app.py .
COPY README.md .

# Create streamlit config directory
RUN mkdir -p .streamlit
RUN echo '[client]\nshowErrorDetails = true\n' > .streamlit/config.toml

# Create captures directory
RUN mkdir -p captures

# Expose Streamlit default port
EXPOSE 8501

# Run Streamlit
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
