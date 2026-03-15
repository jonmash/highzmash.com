#!/bin/bash
# Favicon generation script for highzmash.com
# Generates all required favicon sizes from the source SVG

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
IMAGES_DIR="$PROJECT_ROOT/static/images"
SOURCE_SVG="$IMAGES_DIR/favicon.svg"

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick is not installed. Please install it first:"
    echo "  Ubuntu/Debian: sudo apt-get install imagemagick"
    echo "  macOS: brew install imagemagick"
    exit 1
fi

# Check if source SVG exists
if [ ! -f "$SOURCE_SVG" ]; then
    echo "Error: Source SVG not found at $SOURCE_SVG"
    exit 1
fi

echo "Generating favicons from $SOURCE_SVG..."

cd "$IMAGES_DIR"

# Generate PNG sizes
echo "  → favicon-16x16.png"
convert -background none -density 300 "$SOURCE_SVG" -resize 16x16 favicon-16x16.png

echo "  → favicon-32x32.png"
convert -background none -density 300 "$SOURCE_SVG" -resize 32x32 favicon-32x32.png

echo "  → apple-touch-icon.png (180x180)"
convert -background none -density 300 "$SOURCE_SVG" -resize 180x180 apple-touch-icon.png

echo "  → favicon-full.png (512x512)"
convert -background none -density 300 "$SOURCE_SVG" -resize 512x512 favicon-full.png

echo ""
echo "Favicon generation complete!"
echo "Files generated in $IMAGES_DIR:"
echo "  - favicon-16x16.png"
echo "  - favicon-32x32.png"
echo "  - apple-touch-icon.png"
echo "  - favicon-full.png"
echo ""
echo "Note: favicon.svg should be manually optimized from favicon-source.svg if needed"
