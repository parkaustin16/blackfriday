# Deployment Guide

This document describes how to deploy the Black Friday Screen Capture app in various environments.

## Local Development

### Quick Start

```bash
# 1. Clone/navigate to the project
cd /workspaces/blackfriday

# 2. Run the setup script
bash setup.sh

# 3. Start the app
streamlit run app.py
```

The app will be available at `http://localhost:8501`

### Manual Setup

If you prefer to set up manually:

```bash
# Install dependencies
pip install -r requirements.txt

# Install Playwright Chromium
python -m playwright install chromium

# Create configuration directory
mkdir -p .streamlit

# Create secrets file
cp secrets.toml.example .streamlit/secrets.toml
# Edit .streamlit/secrets.toml with your credentials

# Run the app
streamlit run app.py
```

## Docker Deployment

### Build and Run with Docker

```bash
# Build the image
docker build -t blackfriday-capture .

# Run the container
docker run -p 8501:8501 \
  -e CLOUDINARY_CLOUD_NAME=your_cloud \
  -e CLOUDINARY_API_KEY=your_key \
  -e CLOUDINARY_API_SECRET=your_secret \
  -e AIRTABLE_API_KEY=your_token \
  -e AIRTABLE_BASE_ID=your_base \
  -v $(pwd)/captures:/app/captures \
  blackfriday-capture
```

### Deploy with Docker Compose

```bash
# 1. Create .env file with your credentials
cat > .env << 'EOF'
CLOUDINARY_CLOUD_NAME=your_cloud
CLOUDINARY_API_KEY=your_key
CLOUDINARY_API_SECRET=your_secret
AIRTABLE_API_KEY=your_token
AIRTABLE_BASE_ID=your_base
AIRTABLE_TABLE_NAME=BlackFriday
EOF

# 2. Start the service
docker-compose up -d

# 3. View logs
docker-compose logs -f

# 4. Stop the service
docker-compose down
```

## Streamlit Cloud Deployment

### Setup

1. **Create a GitHub repository**:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/YOUR_USERNAME/blackfriday-capture.git
   git push -u origin main
   ```

2. **Create a `.streamlit/secrets.toml` file** (not in git):
   ```toml
   CLOUDINARY_CLOUD_NAME = "your_cloud"
   CLOUDINARY_API_KEY = "your_key"
   CLOUDINARY_API_SECRET = "your_secret"
   AIRTABLE_API_KEY = "your_token"
   AIRTABLE_BASE_ID = "your_base"
   ```

3. **Deploy to Streamlit Cloud**:
   - Go to https://streamlit.io/cloud
   - Connect your GitHub repository
   - Select the branch and main file (`app.py`)
   - Add secrets in the Streamlit Cloud dashboard (copy from `.streamlit/secrets.toml`)
   - Deploy!

## Heroku Deployment

### Setup

1. **Create a Procfile**:
   ```
   web: streamlit run app.py --logger.level=error --client.showErrorDetails=true --server.port=$PORT --server.headless=true
   ```

2. **Create a `.buildpacks` file**:
   ```
   https://github.com/heroku/heroku-buildpack-apt.git
   https://github.com/heroku/heroku-buildpack-python.git
   ```

3. **Create an `Aptfile`**:
   ```
   libatk1.0-0
   libatk-bridge2.0-0
   libatspi2.0-0
   libgtk-3-0
   libnss3
   libxcomposite1
   libxdamage1
   libxfixes3
   libxrandr2
   libgbm1
   libasound2t64
   libpangocairo-1.0-0
   libpango-1.0-0
   libcairo2
   ```

4. **Deploy**:
   ```bash
   git push heroku main
   ```

5. **Set environment variables**:
   ```bash
   heroku config:set CLOUDINARY_CLOUD_NAME=your_cloud
   heroku config:set CLOUDINARY_API_KEY=your_key
   heroku config:set CLOUDINARY_API_SECRET=your_secret
   heroku config:set AIRTABLE_API_KEY=your_token
   heroku config:set AIRTABLE_BASE_ID=your_base
   ```

## AWS Deployment

### Using AWS Lambda + API Gateway

This is a more complex setup. Consider using **AWS Fargate** (containerized) instead:

1. **Create ECR repository**:
   ```bash
   aws ecr create-repository --repository-name blackfriday-capture --region us-east-1
   ```

2. **Build and push image**:
   ```bash
   docker build -t blackfriday-capture .
   docker tag blackfriday-capture:latest <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/blackfriday-capture:latest
   docker push <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/blackfriday-capture:latest
   ```

3. **Create Fargate task** using AWS Console or CLI

## Render.com Deployment

1. **Connect your GitHub repository** to Render.com
2. **Create a new Web Service**:
   - Runtime: Docker
   - Build: `docker build -t blackfriday .`
   - Start: `streamlit run app.py`
3. **Add environment variables**:
   - `CLOUDINARY_CLOUD_NAME`
   - `CLOUDINARY_API_KEY`
   - `CLOUDINARY_API_SECRET`
   - `AIRTABLE_API_KEY`
   - `AIRTABLE_BASE_ID`

## Fly.io Deployment

1. **Install flyctl**: https://fly.io/docs/hands-on/install-flyctl/

2. **Launch the app**:
   ```bash
   fly launch
   # Follow prompts to create a new app
   ```

3. **Set secrets**:
   ```bash
   fly secrets set CLOUDINARY_CLOUD_NAME=your_cloud
   fly secrets set CLOUDINARY_API_KEY=your_key
   fly secrets set CLOUDINARY_API_SECRET=your_secret
   fly secrets set AIRTABLE_API_KEY=your_token
   fly secrets set AIRTABLE_BASE_ID=your_base
   ```

4. **Deploy**:
   ```bash
   fly deploy
   ```

## DigitalOcean App Platform

1. **Connect your GitHub repository** to DigitalOcean
2. **Configure the app**:
   - Service: `streamlit run app.py`
   - Build command: `pip install -r requirements.txt && python -m playwright install chromium`
   - Port: 8501
3. **Add environment variables** for all API keys
4. **Deploy**

## Production Best Practices

### Security

- Never commit `.streamlit/secrets.toml` to version control
- Use `.env` files only locally
- Use platform-specific secret management (Streamlit Secrets, Heroku Config Vars, etc.)
- Use HTTPS only
- Rotate API keys regularly

### Performance

- Enable browser caching in Cloudinary
- Use regional CDN for image distribution
- Monitor capture times and optimize timeout values
- Consider rate limiting if capturing frequently

### Monitoring

- Set up error tracking (Sentry, Rollbar, etc.)
- Monitor application logs
- Set up alerts for failures
- Track capture success/failure rates

### Scaling

- For high volume: Deploy multiple instances behind a load balancer
- Consider queue-based architecture for async captures
- Use managed browser services (e.g., Browserless) instead of local Chromium

## Troubleshooting Deployments

### Docker build fails with Playwright issues
```bash
# Add to Dockerfile before pip install:
RUN apt-get update && apt-get install -y --no-install-recommends $(cat packages.txt)
```

### App timeout during capture
- Increase timeout in Streamlit config: `client.toolbarMode = "minimal"`
- Reduce page complexity or use different URL
- Use cloud-based browser service

### Cloudinary/Airtable API calls fail
- Verify credentials are correctly set
- Check API key permissions
- Verify network connectivity
- Review API rate limits

### Memory issues
- Increase container memory allocation
- Use lightweight alternatives for dependencies
- Monitor memory usage during captures

## Maintenance

### Regular Updates

```bash
# Update dependencies
pip install --upgrade -r requirements.txt

# Update Playwright browsers
python -m playwright install --with-deps
```

### Backup

- Backup Airtable database regularly
- Archive captures to cold storage
- Maintain version control of configuration

## Support

- For Streamlit issues: https://discuss.streamlit.io
- For Playwright issues: https://github.com/microsoft/playwright/issues
- For deployment platform issues: Check respective documentation
