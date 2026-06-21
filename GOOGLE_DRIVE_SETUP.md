# Adding Google Drive Images to Your Gallery

## Step 1: Get File IDs from Google Drive

To use images directly from Google Drive in your gallery, follow these steps:

1. Go to your Google Drive folder: https://drive.google.com/drive/u/2/folders/1mBdYXcJtQmenhwume_qkajPpkoQU9Tw1

2. For each image/video you want to add:
   - **Right-click the file** → Click **"Get link"**
   - The URL will look like: `https://drive.google.com/file/d/FILE_ID_HERE/view?usp=sharing`
   - **Copy the FILE_ID** (the long string between `/d/` and `/view`)

## Step 2: Add File IDs to index.html

Open `index.html` and find the `media` array in the `<script>` section. Replace entries with Google Drive file IDs:

```javascript
const media = [
  { id: "1ABC123DEF456", name: "Mountain View" },  // Google Drive file
  { id: "2XYZ789GHI012", name: "Sunset Photo" },   // Google Drive file
  { url: "local-file.jpg", name: "Local Image" },   // Local file
];
```

## Step 3: Make Files Shareable

For the gallery to work, files must be accessible. The easiest way:

1. Right-click file → **Share**
2. Set to **"Anyone with the link can view"**
   - This lets people view without signing in

OR

2. Keep them private and share the link manually with viewers

## Example Configuration

Here's how your updated `index.html` media array should look:

```javascript
const media = [
  { id: "1mBdYXcJtQmenhwume_qkajPpkoQU9Tw1", name: "Ladakh Photo 1" },
  { id: "ANOTHER_FILE_ID", name: "Ladakh Photo 2" },
  // ... more entries
];
```

## Testing

After updating the file IDs:
1. Save `index.html`
2. Open it in your browser
3. Navigate through images using arrow buttons or keyboard arrows

## Notes

- Google Drive direct links work best with **publicly shared files**
- The gallery automatically detects if an item has an `id` (Google Drive) or `url` (local file)
- You can mix local files and Google Drive files in the same gallery
