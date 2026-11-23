# Black Friday Screen Capture App - Implementation Guide

## Overview

This is a Streamlit-based web application for capturing high-quality, full-page screenshots of Black Friday promotional pages from LG's global subsidiaries. It's based on the memberdays template but adapted for Black Friday campaigns.

## Project Structure

```
blackfriday/
├── app.py                      # Main Streamlit application
├── requirements.txt            # Python dependencies
├── packages.txt               # Linux system dependencies
├── README.md                  # User documentation
├── .gitignore                 # Git ignore rules
├── secrets.toml.example       # Example configuration template
└── captures/                  # Output directory (created at runtime)
```

## Key Features

### 1. Multi-Region Support
- **5 Regions**: Asia, Europe, LATAM, MEA, Canada
- **20+ Subsidiaries**: Australia, Japan, Hong Kong, UK, Germany, France, Brazil, Mexico, etc.
- Easy dropdown selection for target subsidiary

### 2. Dual Mode Capture
- **Desktop Mode**: 1920x1080 viewport at 2x device scale factor
- **Mobile Mode**: 390x844 viewport at 2x device scale factor
- Automatically sets appropriate user agents and headers for each mode

### 3. Smart Page Capture
- **Full-page scrolling**: Automatically scrolls through entire page to load lazy-loaded content
- **Image optimization**: Resolves `data-src`, `data-lazy-src`, and `data-srcset` attributes
- **Font loading**: Waits for all web fonts to load before capture
- **High quality**: PNG format with device-scale rendering

### 4. Bot Detection Bypass
- **Stealth techniques**: Removes webdriver detection and automation markers
- **Request blocking**: Filters out chat widgets, tracking, and bot-detection requests
- **Human-like behavior**: Random mouse movements before and after navigation
- **Cookie consent**: Automatically dismisses OneTrust consent banners

### 5. Cloud Integration
- **Cloudinary**: Upload screenshots to cloud storage with automatic public URLs
- **Airtable**: Save capture metadata (URL, country, timestamp, etc.) to a database
- **Optional**: Both services are optional; app works without them

### 6. UI Features
- **Real-time status**: Progress updates during capture
- **Image preview**: Displays captured screenshot with dimensions and file size
- **Download**: Direct PNG download button
- **Error handling**: Detailed error messages and diagnostics

## Installation

### Prerequisites
- Python 3.8+
- pip
- Linux environment (or Windows/macOS with appropriate system libraries)

### Setup Steps

1. **Clone or enter the directory**:
```bash
cd /workspaces/blackfriday
```

2. **Install Python dependencies**:
```bash
pip install -r requirements.txt
```

3. **Install Playwright Chromium**:
```bash
python -m playwright install chromium
```

4. **Configure secrets** (optional):
```bash
mkdir -p .streamlit
cp secrets.toml.example .streamlit/secrets.toml
# Edit .streamlit/secrets.toml with your API keys
```

## Configuration

### Environment Variables

The app reads configuration from either:
1. Streamlit secrets (`.streamlit/secrets.toml`)
2. Environment variables

**Optional Cloudinary Configuration**:
```toml
CLOUDINARY_CLOUD_NAME = "your-cloud-name"
CLOUDINARY_API_KEY = "your-api-key"
CLOUDINARY_API_SECRET = "your-api-secret"
```

**Optional Airtable Configuration**:
```toml
AIRTABLE_API_KEY = "your-token"
AIRTABLE_BASE_ID = "your-base-id"
AIRTABLE_TABLE_NAME = "BlackFriday"  # Defaults to "BlackFriday"
```

### Airtable Table Schema

The app expects an Airtable table with these columns:
- **Name** (Text): Record identifier
- **domain** (Text): Subsidiary code
- **country** (Text): Country name
- **period** (Date): Capture date
- **banner-type** (Text): Type of capture (e.g., "black-friday-pc")
- **capture** (Attachment): Link to screenshot URL

## Usage

### Running the App

```bash
streamlit run app.py
```

The app will be available at `http://localhost:8501`

### Capturing a Screenshot

1. **Select Subsidiary**: Choose target region/subsidiary from dropdown
2. **Select Mode**: Choose "desktop" or "mobile"
3. **Verify URL**: Auto-populated URL can be edited if needed
4. **Capture**: Click "Capture Full Page" button
5. **Download**: Once complete, download the PNG or upload to cloud

### Workflow

```
Select Subsidiary
      ↓
Select Mode (Desktop/Mobile)
      ↓
Verify/Edit URL
      ↓
Click Capture
      ↓
Browser launches & navigates
      ↓
Dismisses consent banners
      ↓
Scrolls through entire page
      ↓
Loads lazy images & fonts
      ↓
Takes full-page screenshot
      ↓
Display preview & options
      ↓
(Optional) Upload to Cloudinary
      ↓
(Optional) Save metadata to Airtable
```

## Technical Details

### Browser Automation Stack
- **Playwright**: Cross-browser automation library
- **Chromium**: Headless browser engine
- **Stealth**: Anti-bot detection techniques

### Key Functions

#### `capture_full_page(url, subsidiary_code, mode)`
Main screenshot capture function:
- Launches headless Chromium browser
- Navigates to target URL
- Dismisses cookie consent banners
- Scrolls through entire page to trigger lazy loading
- Resolves lazy-loaded images and fonts
- Removes chat widgets and overlays
- Takes full-page screenshot
- Closes browser and returns file path

#### `upload_to_cloudinary(file_path, subsidiary_code, mode)`
Uploads screenshot to Cloudinary:
- Uses SHA-1 signed upload token
- Organizes by folder: `blackfriday/{code}/{mode}`
- Returns public secure URL

#### `save_to_airtable(subsidiary_code, country_label, mode, capture_url)`
Saves metadata to Airtable:
- Pre-flight check to verify API access
- Creates record with standard schema
- Links to Cloudinary URL if available

### CSS Cleanup
The app injects CSS that:
- Hides chat widgets, popups, and banners
- Disables animations and transitions
- Optimizes image rendering for capture
- Pauses all videos

### Image Lazy-Loading Handling
Resolves multiple lazy-loading patterns:
- `data-src` / `data-lazy-src`
- `data-srcset` / `data-lazy-srcset`
- `data-original`
- `<picture>` source elements

## URL Resolution Strategy

The app attempts multiple URL patterns for each subsidiary:

1. **Custom overrides** (hardcoded for special cases like Colombia, France)
2. **Default pattern**: `https://www.lg.com/{code}/black-friday/`
3. **Dashed variant**: `https://www.lg.com/{code-with-dashes}/black-friday/`
4. **Alternative spellings**: `{code}/bf/`, `{code}/blackfriday/`

Failed URLs gracefully fall back to the first candidate.

## Runtime Status Checks

On first run, the app:
1. Attempts to install Playwright Chromium
2. Tests browser launch
3. If Linux system libraries are missing, provides installation instructions
4. Shows diagnostics if launch fails

## Troubleshooting

### "Playwright runtime not ready"
- Run: `python -m playwright install chromium`
- On Linux, may need: `python -m playwright install-deps chromium`
- Or manually install: `sudo apt-get install -y libatk1.0-0 libatk-bridge2.0-0 ...` (see error message)

### Page capture fails with HTTP 404
- Edit the URL in the sidebar to point to correct Black Friday page
- Different subsidiaries may use different URL patterns

### Images not loading
- Some images may be blocked by CORS or CDN policies
- The app handles this gracefully with 5-second timeouts

### Cloudinary upload fails
- Verify API credentials are correct
- Check that credentials have upload permissions
- Ensure base64 request isn't too large

### Airtable save fails
- Verify API token has correct permissions
- Check base ID and table name are correct
- Table must have required columns

## Development Notes

### Customizing Regions
Edit the `REGIONS` dict in `app.py` to add/remove subsidiaries or regions.

### Custom URL Overrides
Edit the `_overrides` dict in `build_url_candidates()` to handle special-case URLs.

### Modifying Capture Settings
In `capture_full_page()`:
- Change viewport dimensions
- Adjust timeout values
- Modify user agents
- Add/remove CSS cleanup rules
- Change blocked request patterns

### Adding New Integrations
Follow the pattern of `upload_to_cloudinary()` and `save_to_airtable()`:
1. Read credentials from secrets
2. Prepare payload
3. Make API request
4. Handle errors gracefully
5. Return result

## Performance Considerations

- **Browser overhead**: First capture takes ~15-30s (browser launch + network)
- **Subsequent captures**: ~10-20s (browser reuse within session)
- **Network delays**: Varies by page complexity and CDN performance
- **Large pages**: May take longer to scroll and render (timeout set to 90s)

## Security

- **No credentials in code**: All secrets via environment variables
- **HTTPS errors ignored**: For testing on dev/staging sites with self-signed certs
- **Request blocking**: Filters out known tracking and bot-detection patterns
- **No data stored**: Screenshots only stored locally (optional cloud upload)

## Future Enhancements

Potential improvements:
- Batch capture of multiple subsidiaries
- Scheduled captures with CI/CD integration
- Diff detection (compare new captures to previous)
- Full-page PDF export
- Screenshot annotations/markup
- Custom CSS injection
- Performance metrics collection
- Webhook notifications

## Support

For issues:
1. Check the diagnostics panel (expand if visible)
2. Review error message details
3. Verify network connectivity and target URL
4. Check API credentials if using cloud features
5. Try a different subsidiary as a sanity check
