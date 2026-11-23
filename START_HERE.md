# 🛍️ Black Friday Screen Capture App - Start Here

Welcome! This document will guide you through the Black Friday Screen Capture app.

## ⚡ Quick Start (2 minutes)

```bash
# Navigate to the project
cd /workspaces/blackfriday

# Run automated setup
bash setup.sh

# Start the app
streamlit run app.py

# Open in browser
http://localhost:8501
```

That's it! The app is ready to use.

## 📚 Documentation Guide

Choose what you need:

### 👤 I'm a User - I Want to Capture Screenshots
**Read:** `README.md` → `QUICK_REFERENCE.md`

Then:
1. Run `bash setup.sh`
2. Run `streamlit run app.py`
3. Select subsidiary and mode
4. Click "Capture Full Page"

### 👨‍💻 I'm a Developer - I Want to Customize the App
**Read:** `IMPLEMENTATION_GUIDE.md` → `app.py` → `QUICK_REFERENCE.md`

Then:
1. Edit functions in `app.py`
2. Customize regions, URLs, viewports
3. Add new integrations
4. Test changes

### 🚀 I'm DevOps - I Want to Deploy This
**Read:** `DEPLOYMENT_GUIDE.md` → Choose your platform

Options:
- Local: `streamlit run app.py`
- Docker: `docker-compose up -d`
- Cloud: Streamlit Cloud, Heroku, AWS, etc.

### 🔧 I Have Questions
**Read:** `QUICK_REFERENCE.md` → "Troubleshooting Matrix"

## 📋 What This App Does

Captures high-quality, full-page screenshots of Black Friday promotional pages from 43+ LG subsidiaries worldwide.

**Key features:**
- ✅ Multi-region support (Asia, Europe, LATAM, MEA, Canada)
- ✅ Desktop & Mobile viewport modes
- ✅ Full-page scrolling capture
- ✅ Lazy image loading support
- ✅ Bot detection bypass
- ✅ Cloudinary + Airtable integration (optional)
- ✅ One-click deployment options

## 📂 Project Files Overview

```
app.py                    → Main application (800 lines, Python)
                             Core screenshot capture logic

setup.sh                  → Automated setup script
                             Installs dependencies, creates config

Dockerfile                → Docker container definition
docker-compose.yml        → Multi-service Docker setup

requirements.txt          → Python dependencies
packages.txt              → Linux system libraries

secrets.toml.example      → Configuration template
                             Copy to .streamlit/secrets.toml

README.md                 → Quick start guide (1 page)
IMPLEMENTATION_GUIDE.md   → Technical reference (10 pages)
DEPLOYMENT_GUIDE.md       → 7 deployment options (8 pages)
QUICK_REFERENCE.md        → Quick lookup guide (7 pages)
PROJECT_SUMMARY.md        → Project overview (8 pages)
START_HERE.md             → This file!

.gitignore                → Git ignore rules
```

## 🎯 Common Tasks

### Task 1: Capture a Screenshot (Basic)
```
1. Run: streamlit run app.py
2. Select: LG Subsidiary (dropdown)
3. Select: Mode (Desktop or Mobile)
4. Click: "Capture Full Page"
5. Download: PNG file
```

### Task 2: Upload to Cloudinary (Optional)
```
1. Set CLOUDINARY_* env vars in .streamlit/secrets.toml
2. Click: "Upload to Cloudinary"
3. Share: Public URL
```

### Task 3: Save to Airtable (Optional)
```
1. Set AIRTABLE_* env vars in .streamlit/secrets.toml
2. Click: "Save to Airtable"
3. View: Record in Airtable
```

### Task 4: Deploy to Production
```
1. Read: DEPLOYMENT_GUIDE.md
2. Choose: Platform (Docker, Heroku, AWS, etc.)
3. Follow: Platform-specific instructions
```

### Task 5: Customize for Your Needs
```
1. Read: IMPLEMENTATION_GUIDE.md
2. Edit: app.py (regions, URLs, viewports, etc.)
3. Test: Local Streamlit server
4. Deploy: To your chosen platform
```

## 🛠️ System Requirements

- Python 3.8+
- pip (Python package manager)
- Linux/Mac/Windows (with appropriate libraries)
- 2GB RAM minimum
- 500MB disk space

## ✅ Verification Checklist

After setup, verify everything works:

```bash
✅ Python syntax validated
✅ All imports available
✅ setup.sh runs without errors
✅ streamlit runs successfully
✅ Browser opens to localhost:8501
✅ Subsidiary dropdown loads
✅ Capture button is clickable
```

## 🔑 Configuration

### Minimal Setup (No Config Needed)
Just run `setup.sh` and go!

### Add Cloud Features (Optional)
Create `.streamlit/secrets.toml`:
```toml
# Cloudinary (image hosting)
CLOUDINARY_HIDDEN_CLOUD_NAME = "your-cloud"
CLOUDINARY_HIDDEN_API_KEY = "your-key"
CLOUDINARY_HIDDEN_API_SECRET = "your-secret"

# Airtable (metadata storage)
AIRTABLE_HIDDEN_API_KEY = "your-token"
AIRTABLE_HIDDEN_BASE_ID = "your-base"
AIRTABLE_HIDDEN_TABLE_NAME = "BlackFriday"
```

## 🌍 Supported Regions

| Region | Count | Examples |
|--------|-------|----------|
| Asia | 11 | Australia, Japan, Hong Kong, Singapore |
| Europe | 15 | UK, France, Germany, Spain, Italy |
| LATAM | 7 | Mexico, Brazil, Argentina, Chile |
| MEA | 8 | Turkey, Saudi Arabia, South Africa |
| Canada | 2 | English & French |
| **Total** | **43** | Subsidiaries |

## 🚀 Deployment Options

Easiest to hardest:

1. **Local** (Easiest) - `streamlit run app.py`
2. **Docker Compose** - `docker-compose up -d`
3. **Streamlit Cloud** - Push to GitHub, deploy via UI
4. **Heroku** - Traditional PaaS, free tier available
5. **Render.com** - Modern PaaS, free tier available
6. **Docker Hub** - Push image, deploy anywhere
7. **AWS Fargate** - Containerized, enterprise grade
8. **Fly.io** - App platform, good pricing

See `DEPLOYMENT_GUIDE.md` for details on each.

## 🐛 Troubleshooting Quick Fixes

**"Python not found"**
```bash
python --version  # Requires Python 3.8+
```

**"Playwright Chromium not ready"**
```bash
python -m playwright install chromium
python -m playwright install-deps chromium  # Linux only
```

**"ImportError: No module named 'streamlit'"**
```bash
pip install -r requirements.txt
```

**"Port 8501 already in use"**
```bash
streamlit run app.py --server.port 8502
```

**More issues?** See `QUICK_REFERENCE.md` → "Troubleshooting Matrix"

## 📖 Documentation Map

```
START_HERE.md ← You are here
       ↓
README.md (Quick start)
       ↓
       ├─→ QUICK_REFERENCE.md (Lookup + troubleshoot)
       ├─→ IMPLEMENTATION_GUIDE.md (Technical details)
       └─→ DEPLOYMENT_GUIDE.md (How to deploy)
              ↓
       PROJECT_SUMMARY.md (Detailed overview)
```

## 💡 Pro Tips

1. **First-time setup?** Just run `bash setup.sh` - it handles everything
2. **Custom regions?** Edit the `REGIONS` dict in `app.py`
3. **Private deployment?** Use Docker or Streamlit Cloud
4. **Need help?** Check `QUICK_REFERENCE.md` - it has everything
5. **Contributing?** Make changes, test locally, then deploy

## 🎓 Learning Path

### Beginner
1. Run `bash setup.sh`
2. Click "Capture Full Page"
3. Download the screenshot

### Intermediate
1. Configure Cloudinary
2. Upload screenshots to cloud
3. Save metadata to Airtable

### Advanced
1. Customize regions and URLs
2. Modify viewport settings
3. Add custom integrations
4. Deploy to production platform

## 📞 Support & Resources

- **Setup Issues?** → `QUICK_REFERENCE.md`
- **How to Deploy?** → `DEPLOYMENT_GUIDE.md`
- **Need Technical Help?** → `IMPLEMENTATION_GUIDE.md`
- **Quick Lookup?** → `QUICK_REFERENCE.md`
- **Project Overview?** → `PROJECT_SUMMARY.md`

## ✨ Next Steps

```
1. Run:    bash setup.sh
2. Start:  streamlit run app.py
3. Enjoy:  http://localhost:8501
```

That's it! You now have a fully functional Black Friday screenshot capture app.

---

**Questions?** Check the docs above or the `QUICK_REFERENCE.md` troubleshooting section.

**Ready to deploy?** See `DEPLOYMENT_GUIDE.md`.

**Want to customize?** See `IMPLEMENTATION_GUIDE.md`.

**Need more info?** See `PROJECT_SUMMARY.md`.

Happy capturing! 🛍️📸
