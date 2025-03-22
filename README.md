# QR Code Generator

A shell script utility to generate QR codes from a CSV file and format them for printing.

## Features

- Generates QR codes from title/URL pairs in a CSV file
- Creates individual QR codes with titles
- Arranges QR codes in a 2×2 grid on A4 pages for printing
- Adds dashed cutting guides around each QR code
- Properly positions titles and QR codes for clear visibility
- Combines all pages into a single printable PDF

## Requirements

- qrencode: `brew install qrencode`
- ImageMagick: `brew install imagemagick`
- pdftk: `brew install pdftk-java`
- Berkeley Mono Bold font (or modify the FONT variable in the script)

## Usage

1. Create your own `links.csv` file based on the provided example:
   ```bash
   cp links.example.csv links.csv
   ```

2. Edit `links.csv` with your own title/link pairs:
   ```
   title,link
   My First QR,https://example.com/link1
   My Second QR,https://example.com/link2
   ```

3. Make the script executable (if not already):
   ```bash
   chmod +x generate_qrcodes.sh
   ```

4. Run the script:
   ```bash
   ./generate_qrcodes.sh
   ```

5. Find the generated PDF in the `qr_pdfs` directory:
   - `print_layout_all.pdf`: Combined PDF with all QR codes arranged for printing

## Customization

You can modify the following variables in the script:
- `SQUARE_SIZE`: Size of each QR code square in pixels (default: 1200)
- `QR_SIZE`: Size of QR code modules (default: 20)
- `BORDER_COLOR`: Color of the cutting guide border (default: #333333)
- `TOP_PADDING`: Padding from top for title (default: 100px)
- `BOTTOM_PADDING`: Padding from bottom for QR code (default: 100px)

## License

MIT