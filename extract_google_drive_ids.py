#!/usr/bin/env python3
"""
Extract Google Drive file IDs from a shared folder and generate HTML code.
This script uses the Google Drive REST API.
"""

import requests
import json
import re
from pathlib import Path

# Folder ID to extract files from
FOLDER_ID = "1mBdYXcJtQmenhwume_qkajPpkoQU9Tw1"

def extract_file_ids_from_html(folder_id):
    """
    Extract file IDs by parsing Google Drive folder HTML.
    This works with publicly shared folders.
    """
    url = f"https://drive.google.com/drive/folders/{folder_id}"
    
    try:
        # Try to get file info using Google Drive's public API
        api_url = f"https://www.googleapis.com/drive/v3/files?q='{folder_id}'+in+parents&key=AIzaSyApAl9k5dDvKrZp4LKVxfLqLSJu1j_KqEI"
        
        response = requests.get(api_url, timeout=10)
        
        if response.status_code == 200:
            data = response.json()
            files = data.get('files', [])
            return files
        else:
            print(f"API request failed with status {response.status_code}")
            return None
            
    except Exception as e:
        print(f"Error: {e}")
        return None

def generate_media_array(files):
    """Generate JavaScript media array from file list."""
    if not files:
        print("No files found. Trying alternative method...")
        return None
    
    media_lines = ["const media = ["]
    
    for file in files:
        file_id = file.get('id', '')
        file_name = file.get('name', 'Unknown')
        
        # Remove file extension for cleaner display
        display_name = Path(file_name).stem
        
        media_lines.append(f'  {{ id: "{file_id}", name: "{display_name}" }},')
    
    media_lines.append("];")
    
    return "\n".join(media_lines)

def main():
    print("🔍 Extracting file IDs from Google Drive folder...")
    print(f"Folder ID: {FOLDER_ID}\n")
    
    # Try to extract files
    files = extract_file_ids_from_html(FOLDER_ID)
    
    if files:
        print(f"✅ Found {len(files)} files!\n")
        
        # Generate JavaScript code
        media_code = generate_media_array(files)
        
        if media_code:
            print("Generated JavaScript code:\n")
            print(media_code)
            print("\n" + "="*60)
            print("📋 Copy the code above and paste it into index.html")
            print("="*60)
            
            # Save to file
            output_file = Path(__file__).parent / "media_array.js"
            output_file.write_text(media_code)
            print(f"\n✅ Saved to: {output_file}")
        else:
            print("Could not generate media array")
    else:
        print("⚠️ Could not extract files automatically.")
        print("\nManual method - Use this browser console script instead:\n")
        print("""
// Open your Google Drive folder in browser:
// https://drive.google.com/drive/u/2/folders/1mBdYXcJtQmenhwume_qkajPpkoQU9Tw1

// Open DevTools (F12) -> Console tab -> paste this:

const files = [];
document.querySelectorAll('[data-id]').forEach(el => {
  const id = el.getAttribute('data-id');
  const name = el.getAttribute('aria-label') || el.textContent.trim();
  if (id) files.push({ id, name });
});

const mediaCode = 'const media = [\\n' + 
  files.map(f => `  { id: "${f.id}", name: "${f.name.replace(/\\.jpg|\\.mp4/i, '')}" },`).join('\\n') +
  '\\n];';
  
console.log(mediaCode);
// Copy the output from console
        """)

if __name__ == "__main__":
    main()
