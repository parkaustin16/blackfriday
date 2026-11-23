# Quick Reference

## Project Structure

```
blackfriday/
├── app.py                       # Main Streamlit application (800 lines)
├── requirements.txt             # Python dependencies
├── packages.txt                 # Linux system dependencies
├── Dockerfile                   # Docker container definition
├── docker-compose.yml           # Docker Compose configuration
├── setup.sh                     # Quick setup script
├── README.md                    # User documentation
├── IMPLEMENTATION_GUIDE.md      # Technical implementation details
├── DEPLOYMENT_GUIDE.md          # Deployment instructions
├── secrets.toml.example         # Configuration template
└── .gitignore                   # Git ignore rules
```

## File Sizes and Line Counts

| File | Lines | Purpose |
|------|-------|---------|
| app.py | 800 | Main application logic |
| README.md | 45 | Quick start guide |
| IMPLEMENTATION_GUIDE.md | 320 | Technical documentation |
| DEPLOYMENT_GUIDE.md | 280 | Deployment instructions |
| requirements.txt | 8 | Python dependencies |
| packages.txt | 15 | Linux system libraries |

## Quick Start Commands

```bash
# 1. Setup
bash setup.sh

# 2. Run locally
streamlit run app.py

# 3. Run with Docker
docker-compose up -d

# 4. View logs
docker-compose logs -f

# 5. Stop Docker
docker-compose down
```

## Key Features

✅ Multi-region support (20+ LG subsidiaries)
✅ Desktop & Mobile viewport modes
✅ Full-page screenshot capture
✅ Lazy image loading support
✅ Bot detection bypass
✅ Cloudinary integration
✅ Airtable integration
✅ Cookie consent handling
✅ Error recovery & diagnostics
✅ Docker & Kubernetes ready

## Configuration

### Required for Basic Use
- None (app works out of the box)

### Optional for Cloud Features
```toml
# Cloudinary (image hosting)
CLOUDINARY_CLOUD_NAME = "your-cloud"
CLOUDINARY_API_KEY = "your-key"
CLOUDINARY_API_SECRET = "your-secret"

# Airtable (metadata storage)
AIRTABLE_API_KEY = "your-token"
AIRTABLE_BASE_ID = "your-base"
AIRTABLE_TABLE_NAME = "BlackFriday"
```

## Tech Stack

| Component | Technology |
|-----------|------------|
| Framework | Streamlit |
| Browser Automation | Playwright |
| Browser Engine | Chromium |
| Image Hosting | Cloudinary (optional) |
| Database | Airtable (optional) |
| Container | Docker |
| Language | Python 3.8+

## URL Patterns Supported

For subsidiary code `{code}`:

1. Custom overrides (Colombia, France)
2. `https://www.lg.com/{code}/black-friday/`
3. `https://www.lg.com/{code-with-dashes}/black-friday/`
4. `https://www.lg.com/{code}/bf/`
5. `https://www.lg.com/{code}/blackfriday/`

## Regions & Subsidiaries

| Region | Codes | Count |
|--------|-------|-------|
| Asia | au, jp, hk, tw, in, sg, my, th, vn, ph, id | 11 |
| Europe | uk, ch_fr, ch_de, fr, de, it, be_fr, es, nl, cz, se, pt, hu, pl, at | 15 |
| LATAM | mx, br, ar, cl, co, pe, pa | 7 |
| MEA | kz, tr, eg_en, eg_ar, ma, sa_en, sa, za | 8 |
| Canada | ca_en, ca_fr | 2 |
| **Total** | | **43** |

## Viewport Specifications

### Desktop Mode
- Width: 1920px
- Height: 1080px
- Device Scale Factor: 2x
- User Agent: Windows/Chrome

### Mobile Mode
- Width: 390px
- Height: 844px
- Device Scale Factor: 2x
- User Agent: Android/Chrome

## Capture Workflow

```
1. Select Subsidiary → 2. Select Mode → 3. Verify URL
           ↓
4. Launch Browser → 5. Navigate to URL → 6. Dismiss Banners
           ↓
7. Scroll & Load → 8. Resolve Images → 9. Cleanup CSS
           ↓
10. Capture Screenshot → 11. Display Preview
           ↓
(Optional) 12. Upload to Cloudinary → 13. Save to Airtable
```

## Approximate Timings

| Task | Time |
|------|------|
| First capture (cold start) | 15-30s |
| Subsequent captures | 10-20s |
| Browser launch | 5-10s |
| Page navigation + load | 5-15s |
| Scroll & image loading | 2-8s |
| Screenshot capture | 1-2s |

## Troubleshooting Matrix

| Issue | Likely Cause | Solution |
|-------|-------------|----------|
| "Runtime not ready" | Chromium not installed | Run `python -m playwright install chromium` |
| HTTP 404 error | Wrong URL pattern | Edit URL in sidebar to correct format |
| Timeout during capture | Page too complex/slow | Increase timeout, try different URL |
| Images missing | CORS/CDN issues | App handles gracefully with 5s timeout |
| Upload fails | Bad credentials | Verify API keys in secrets |
| Airtable save fails | Wrong schema | Verify table has required columns |

## API Rate Limits

- **Cloudinary**: 100-5000 requests/hour (plan dependent)
- **Airtable**: 5 requests/second per base
- **Playwright**: No limits (local browser)

## Security Checklist

- [ ] Never commit `.streamlit/secrets.toml`
- [ ] Store secrets in environment variables only
- [ ] Use HTTPS for all remote connections
- [ ] Rotate API keys periodically
- [ ] Enable CORS on Cloudinary
- [ ] Restrict Airtable API key permissions
- [ ] Use private repositories if deploying
- [ ] Enable browser security features

## Performance Optimization

- Reuse browser sessions within Streamlit session
- Cache region/subsidiary lookups
- Use Cloudinary CDN for image delivery
- Batch captures if possible
- Monitor timeout values
- Clear old captures periodically

## Useful Commands

```bash
# Validate Python syntax
python -m py_compile app.py

# Check dependencies
pip list | grep -E "streamlit|playwright"

# Run tests (if added)
pytest

# Format code
black app.py

# Lint code
flake8 app.py

# Profile performance
streamlit run app.py --profile

# Generate requirements from environment
pip freeze > requirements.txt
```

## Useful URLs

- Streamlit Docs: https://docs.streamlit.io
- Playwright Docs: https://playwright.dev
- Cloudinary Docs: https://cloudinary.com/documentation
- Airtable API: https://airtable.com/developers/web/api/introduction

## Common Customizations

### Add a Region
Edit `REGIONS` dict in app.py

### Add Custom URL Override
Edit `_overrides` dict in `build_url_candidates()`

### Change Viewport Size
Modify `viewport` dict in `capture_full_page()`

### Add CSS Cleanup Rules
Edit `style.innerHTML` in CSS injection code

### Block Additional Requests
Add patterns to `_blocked` list in route handler

### Change Screenshot Format
Modify `page.screenshot()` call (supports webp, jpeg)

## Git Workflow

```bash
# Initial setup
git init
git add .
git commit -m "Initial commit: Black Friday screenshot app"
git branch -M main
git remote add origin <URL>
git push -u origin main

# Update dependencies
pip freeze > requirements.txt
git add requirements.txt
git commit -m "Update dependencies"
git push
```

## Maintenance Schedule

| Task | Frequency |
|------|-----------|
| Update dependencies | Monthly |
| Update Playwright | Monthly |
| Rotate API keys | Quarterly |
| Backup Airtable | Weekly |
| Review logs | Weekly |
| Test captures | Weekly |

## Support Resources

- GitHub Issues: https://github.com/parkaustin16/blackfriday/issues
- Streamlit Community: https://discuss.streamlit.io
- Playwright Community: https://github.com/microsoft/playwright/discussions

---

For detailed information, see:
- **README.md** - User guide
- **IMPLEMENTATION_GUIDE.md** - Technical details
- **DEPLOYMENT_GUIDE.md** - Deployment options
