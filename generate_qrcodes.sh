#!/bin/bash

# Exit on error
set -e

CSV_FILE="links.csv"
OUTPUT_DIR="qr_pdfs"
FONT="Berkeley-Mono-Bold"  # Berkeley Mono Bold font
SQUARE_SIZE=1200  # Reduced from 1500 to better fit on A4
QR_SIZE=20  # QR code module size
BORDER_COLOR="#333333"  # Darker border color for better visibility
BORDER_WIDTH=2  # Border width in pixels

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR/temp"  # Temporary directory for intermediate files

# Skip the header line and process each row
tail -n +2 "$CSV_FILE" | while IFS=, read -r title link; do
    echo "Processing: $title"
    
    # Create a larger QR code image
    qrencode -o "$OUTPUT_DIR/temp/temp_qr.png" -s $QR_SIZE "$link"
    
    # Create a blank square canvas with padding
    magick -size ${SQUARE_SIZE}x${SQUARE_SIZE} xc:white "$OUTPUT_DIR/temp/temp_canvas.png"
    
    # Add title text with Berkeley Mono Bold font
    magick "$OUTPUT_DIR/temp/temp_canvas.png" \
        -gravity North -font "$FONT" -pointsize 60 -annotate +0+180 "$title" \
        "$OUTPUT_DIR/temp/temp_with_title.png"
    
    # Add QR code to the center
    magick "$OUTPUT_DIR/temp/temp_with_title.png" \
        "$OUTPUT_DIR/temp/temp_qr.png" \
        -gravity Center -composite \
        "$OUTPUT_DIR/temp/temp_final.png"
    
    # Add dashed border (on all sides) for cutting guides
    magick "$OUTPUT_DIR/temp/temp_final.png" \
        -fill none -stroke "$BORDER_COLOR" -strokewidth $BORDER_WIDTH \
        -draw "stroke-dasharray 10 10 rectangle 0,0 $((SQUARE_SIZE-1)),$((SQUARE_SIZE-1))" \
        "$OUTPUT_DIR/temp/temp_bordered.png"
    
    # Save PNG for the composite layout
    cp "$OUTPUT_DIR/temp/temp_bordered.png" "$OUTPUT_DIR/temp/${title// /_}.png"
    
    # Clean up temporary files
    rm "$OUTPUT_DIR/temp/temp_qr.png" "$OUTPUT_DIR/temp/temp_canvas.png" "$OUTPUT_DIR/temp/temp_with_title.png" "$OUTPUT_DIR/temp/temp_final.png" "$OUTPUT_DIR/temp/temp_bordered.png"
done

# Create A4 printing layouts (2x2 grid per page)
echo "Creating A4 printing layouts..."

# Count how many QR codes we have
QR_COUNT=$(find "$OUTPUT_DIR/temp" -maxdepth 1 -name "*.png" | wc -l)
PAGE_COUNT=$(( (QR_COUNT + 3) / 4 ))  # Ceiling division to calculate pages needed

# Create each page as a PDF
for ((page=0; page<PAGE_COUNT; page++)); do
    # Calculate starting index for this page
    START_IDX=$((page * 4))
    
    # Create a blank A4 canvas for this page
    magick -size 2480x3508 xc:white "$OUTPUT_DIR/temp/temp_a4.png"
    
    # Get files for this page (up to 4)
    FILES=($(find "$OUTPUT_DIR/temp" -maxdepth 1 -name "*.png" | sort | head -n $((START_IDX + 4)) | tail -n 4))
    
    # Add each QR code to its position
    for ((i=0; i<${#FILES[@]}; i++)); do
        file="${FILES[$i]}"
        
        # Calculate position (0=top-left, 1=top-right, 2=bottom-left, 3=bottom-right)
        X=$((i % 2 * 1240 + 0))  # No left margin, 1240px offset for second column
        Y=$((i / 2 * 1754 + 0))  # No top margin, 1754px offset for second row
        
        # Add QR code to the A4 canvas
        magick "$OUTPUT_DIR/temp/temp_a4.png" "$file" -geometry +${X}+${Y} -composite "$OUTPUT_DIR/temp/temp_a4_new.png"
        mv "$OUTPUT_DIR/temp/temp_a4_new.png" "$OUTPUT_DIR/temp/temp_a4.png"
    done
    
    # Convert the canvas to PDF
    magick "$OUTPUT_DIR/temp/temp_a4.png" -page A4 "$OUTPUT_DIR/temp/print_layout_page_$((page+1)).pdf"
    
    # Clean up temporary files
    rm "$OUTPUT_DIR/temp/temp_a4.png"
done

# Combine all layout pages into one PDF
pdftk "$OUTPUT_DIR"/temp/print_layout_page_*.pdf cat output "$OUTPUT_DIR/print_layout_all.pdf"

# Clean up temporary files
rm -rf "$OUTPUT_DIR/temp"

echo "Done! Print layout saved as $OUTPUT_DIR/print_layout_all.pdf"