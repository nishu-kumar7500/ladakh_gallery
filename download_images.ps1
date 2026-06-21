# Download Google Drive files to local `images` folder
# Usage: Open PowerShell in this folder and run: .\download_images.ps1

$images = @(
  @{ id = '1LeZTC-29LyeJB4hCuxn8yChHFyzKPQnq'; name = 'IMG-20260621-WA0009.jpg' },
  @{ id = '1SMGvKO8dZG-vsFL5kSz0Njl9TuJjlcx_'; name = 'IMG-20260621-WA0015.jpg' },
  @{ id = '1-GuEhQpHCyMeVwSx4w08DBcT7FuXfNaX'; name = 'IMG-20260621-WA0041.jpg' },
  @{ id = '1lSkWQV8xZdYf17UtUHnQzDrw9gah6KJl'; name = 'IMG20260614161208.jpg' },
  @{ id = '1oMTPRkoHtne68j2zpQT8pujpuP0bSsEH'; name = 'IMG20260614161215.jpg' },
  @{ id = '1lShLDpI8_zz1iypHr5pN0U3xPKi_VgZ8'; name = 'IMG20260614161226.jpg' },
  @{ id = '1Qq4HxEg8NPEN2DEXNoGg9JFQw6Kebu-0'; name = 'IMG20260614161233.jpg' },
  @{ id = '1ZxMuiRNrnrTmB4YpaH8neyRjeimVwPzw'; name = 'IMG20260615145008.jpg' },
  @{ id = '19WDUek-lOFzU4l13ahryt3yIkw5TqNpO'; name = 'IMG20260615145009.jpg' },
  @{ id = '19dJhdbsmI9s_3xER8a-7wM_KWRwFPAZH'; name = 'IMG20260615145052.jpg' },
  @{ id = '1ylk54ydvy9EosO0_pBlHDl2COJXo7Moa'; name = 'IMG20260616065446.jpg' },
  @{ id = '16VHVslQ7tQK4vgr37SfITbF74t1lwLZr'; name = 'IMG20260616071718.jpg' },
  @{ id = '1O3p1XaKKI9JAPbcYPKgZ9Iy1eLBkmgl9'; name = 'IMG20260616071720.jpg' },
  @{ id = '1Q1CMIQERL6nG4qx3KQTlMyfNaGuVjr58'; name = 'IMG20260616071837.jpg' },
  @{ id = '1WqVlweOwgAwMmTNGtJwqTiTMdphGWqsw'; name = 'IMG20260616144520.jpg' },
  @{ id = '1EX4dEqjVlOsEaGPXQb8IA0G6DYnYHkI6'; name = 'IMG20260616144629.jpg' },
  @{ id = '1VrfNK-X0yPt-NjNHQj2HEy1hoRYw4dLC'; name = 'IMG20260617143245.jpg' },
  @{ id = '1nr1_yv1pngVVzybnI3m3uC3bjQDmBBk8'; name = 'IMG20260617143311.jpg' },
  @{ id = '1zZD5IFQhx-gOKIpV9PsbD-56SoHZfA8P'; name = 'IMG20260617143347.jpg' },
  @{ id = '1uJ50qHRJR4bvbTdXuHt9VdJ5NOtQPxf1'; name = 'IMG20260617181723.jpg' },
  @{ id = '1WiXQhphtaKPwVkCkin4CiB-8LJ22cM1P'; name = 'IMG20260617181727.jpg' },
  @{ id = '1YO-CpH2JoYbhWlkdUnUHJ4CzAbFOwObT'; name = 'IMG20260617205438.jpg' },
  @{ id = '17Nq3MTYgNyqWhwoRR-pJ5FZ6O_8Tn74Y'; name = 'VID20260614143128.mp4' },
  @{ id = '13vwyyzA07FrZ839jONjzad1Tg3zTBGLQ'; name = 'VID20260614143350.mp4' },
  @{ id = '1eyuZYApWysMBtqglOgM3CL2rNO1HFyG2'; name = 'VID20260616071733.mp4' },
  @{ id = '1LZ2ieRIsnEHFnyNQBCAoyWvVS0ExbrWp'; name = 'VID20260616145012.mp4' },
  @{ id = '1OpouySG-pF19309yTVIsgMnxKkal78WO'; name = 'VID20260616145149.mp4' }
)

$imagesDir = Join-Path -Path (Get-Location) -ChildPath "images"
if (!(Test-Path $imagesDir)) { New-Item -Path $imagesDir -ItemType Directory | Out-Null }

foreach ($it in $images) {
    $id = $it.id
    $name = $it.name
    $out = Join-Path $imagesDir $name
    $url = "https://drive.google.com/uc?export=download&id=$id"
    Write-Host "Downloading $name ..."
    try {
        Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing -TimeoutSec 60
        Write-Host "Saved: $out"
    } catch {
        Write-Warning "Failed to download $name from $url - try opening in browser and downloading manually"
    }
}

Write-Host "Finished. Add the 'images' folder to your repo, update index.html media entries to point to 'images/<filename>', and push to GitHub."