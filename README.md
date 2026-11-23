# Black Friday Screen Capture App

Streamlit app to capture high-quality full-page screenshots from Black Friday campaign pages.

## Features

- **Multi-region support**: Capture Black Friday pages from different LG subsidiaries
- **Desktop and Mobile modes**: Screenshots in both desktop (1920x1080) and mobile (390x844) viewports
- **Full-page capture**: Automatically scrolls through and captures entire page content
- **Lazy-loading support**: Resolves lazy-loaded images before capture
- **Bot detection bypass**: Implements stealth techniques to avoid anti-bot detection
- **Cloud integration**: Cloudinary integration for image hosting and Airtable for record management
- **Smart blocking**: Removes chat widgets, overlays, and consent banners

## Install

```bash
pip install -r requirements.txt
python -m playwright install chromium
```

## Run

```bash
streamlit run app.py
```

## Configuration

Set environment variables or add to `.streamlit/secrets.toml`:

- `CLOUDINARY_HIDDEN_CLOUD_NAME` - Cloudinary cloud name
- `CLOUDINARY_HIDDEN_API_KEY` - Cloudinary API key
- `CLOUDINARY_HIDDEN_API_SECRET` - Cloudinary API secret
- `AIRTABLE_HIDDEN_API_KEY` - Airtable API key
- `AIRTABLE_HIDDEN_BASE_ID` - Airtable base ID
- `AIRTABLE_HIDDEN_TABLE_NAME` - Airtable table name (default: "BlackFriday")