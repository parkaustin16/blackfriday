#!/bin/bash
# Quick Start Script for Black Friday Screen Capture App

set -e

echo "🛍️  Black Friday Screen Capture App - Setup"
echo "============================================"
echo ""

# Check Python version
echo "✓ Checking Python version..."
python --version | grep -q "Python 3" || {
    echo "❌ Python 3 is required. Please install Python 3.8 or higher."
    exit 1
}

# Install dependencies
echo ""
echo "✓ Installing Python dependencies..."
pip install -q -r requirements.txt || {
    echo "❌ Failed to install Python dependencies"
    exit 1
}

# Install Playwright Chromium
echo ""
echo "✓ Installing Playwright Chromium..."
python -m playwright install chromium || {
    echo "⚠️  Playwright Chromium installation had issues"
    echo "   On Linux, you may need to run:"
    echo "   python -m playwright install-deps chromium"
}

# Create streamlit config
echo ""
echo "✓ Creating Streamlit configuration..."
mkdir -p .streamlit

# Create .streamlit/config.toml if it doesn't exist
if [ ! -f .streamlit/config.toml ]; then
    cat > .streamlit/config.toml << 'EOF'
[theme]
primaryColor = "#FF4B4B"
backgroundColor = "#FFFFFF"
secondaryBackgroundColor = "#F0F2F6"
textColor = "#262730"
font = "sans serif"

[client]
showErrorDetails = true

[logger]
level = "info"
EOF
    echo "   Created .streamlit/config.toml"
fi

# Setup secrets template
if [ ! -f .streamlit/secrets.toml ]; then
    mkdir -p .streamlit
    cat > .streamlit/secrets.toml << 'EOF'
# Configure these credentials to enable cloud features

# Cloudinary (optional - for image hosting)
# CLOUDINARY_CLOUD_NAME = "your-cloud-name"
# CLOUDINARY_API_KEY = "your-api-key"
# CLOUDINARY_API_SECRET = "your-api-secret"

# Airtable (optional - for metadata storage)
# AIRTABLE_API_KEY = "your-token"
# AIRTABLE_BASE_ID = "your-base-id"
# AIRTABLE_TABLE_NAME = "BlackFriday"
EOF
    echo "   Created .streamlit/secrets.toml (configure your API keys here)"
fi

# Create captures directory
mkdir -p captures

echo ""
echo "✅ Setup complete!"
echo ""
echo "📖 Next steps:"
echo "   1. Configure API credentials (optional):"
echo "      Edit .streamlit/secrets.toml with your Cloudinary and/or Airtable keys"
echo ""
echo "   2. Run the app:"
echo "      streamlit run app.py"
echo ""
echo "   3. Open your browser to:"
echo "      http://localhost:8501"
echo ""
echo "📚 For more information, see README.md and IMPLEMENTATION_GUIDE.md"
