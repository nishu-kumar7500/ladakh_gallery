# How to Extract Google Drive File IDs and Update Your Gallery

## Quick Steps to Get File IDs from Your Google Drive Folder

### Method 1: Manual (Easiest)

1. **Open your Google Drive folder:**
   - https://drive.google.com/drive/u/2/folders/1mBdYXcJtQmenhwume_qkajPpkoQU9Tw1

2. **For each image file you want to add:**
   - Right-click the image file
   - Select **"Get link"** from the context menu
   - A dialog will open showing: `https://drive.google.com/file/d/FILE_ID_HERE/view?usp=sharing`
   - **Copy the FILE_ID** (the long string between `/d/` and `/view`)
   - Example: If the URL is `https://drive.google.com/file/d/1ABC123DEF456GHI789/view?usp=sharing`, copy `1ABC123DEF456GHI789`

3. **Update index.html:**
   - Open `index.html` in a text editor
   - Find the `const media = [` section
   - Replace the placeholder entries with your actual file IDs:
   ```javascript
   const media = [
     { id: "YOUR_FILE_ID_HERE", name: "Photo Name" },
     { id: "ANOTHER_FILE_ID", name: "Another Photo" },
     // ... more photos
   ];
   ```

4. **Save and open index.html in your browser** to see your photos!

---

## Method 2: Using Browser Console (Fast for Multiple Files)

1. Open your Google Drive folder in a new tab
2. Open **Developer Tools** (Press `F12`)
3. Click on the **Console** tab
4. Paste this script:

```javascript
// Get all file links from the current Google Drive folder view
const files = Array.from(document.querySelectorAll('[data-id]')).map(el => ({
  id: el.getAttribute('data-id'),
  name: el.getAttribute('aria-label') || 'Unnamed'
}));

console.log(JSON.stringify(files, null, 2));
// Copy the output and paste into index.html
```

5. Copy the output and paste it into your `index.html` media array

---

## Method 3: Using Python (For Technical Users)

Save this as `extract_drive_ids.py` in your photos folder:

```python
#!/usr/bin/env python3
"""
This script requires you to authenticate with Google Drive API
For a simpler solution, use Method 1 or 2 above.
"""

# Setup instructions:
# 1. Install: pip install google-auth-oauthlib google-auth-httplib2 google-api-python-client
# 2. Create OAuth credentials at https://console.cloud.google.com/
# 3. Download credentials.json and place in this folder
# Then run this script

from google.auth.transport.requests import Request
from google.oauth2.service_account import Credentials
from googleapiclient.discovery import build

FOLDER_ID = "1mBdYXcJtQmenhwume_qkajPpkoQU9Tw1"

# Authentication setup required - for now, use Method 1 manually
print("Use Method 1 (Manual) for easiest setup without API authentication")
```

---

## Troubleshooting

### Photos not loading?
- ✅ Make sure files are **"Shared"** in Google Drive
- ✅ Set sharing to **"Anyone with the link can view"**
- ✅ File IDs are correct and have no extra spaces
- ✅ Check browser console (F12) for error messages

### Can't find the Get Link option?
- Make sure you have edit or view permissions on the file
- Try right-clicking on the file thumbnail directly
- Or double-click the file, then look for a "Get link" button near the file name

---

## File ID Format Check

A valid Google Drive file ID:
- ✅ Looks like: `1mBdYXcJtQmenhwume_qkajPpkoQU9Tw1`
- ✅ Contains: letters, numbers, hyphens, underscores
- ✅ Length: Usually 28-40 characters
- ❌ Should NOT include: `/d/`, `/view`, or the full URL

---

## Example Configuration

Here's how your completed `index.html` should look (with real file IDs):

```javascript
const media = [
  { id: "1mBdYXcJtQmenhwume_qkajPpkoQU9Tw1", name: "Mountain View" },
  { id: "1ABC123DEF456GHI789JKL012MNO345PQR", name: "Sunset Photo" },
  { id: "2XYZ789GHI012JKL345MNO678PQR901STU", name: "Beach Scene" },
  { id: "3DEF456GHI789JKL012MNO345PQR678STU", name: "Forest Path" },
];
```

Once you have your file IDs ready, update the `index.html` and you're done! 🎉
