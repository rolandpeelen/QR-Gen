# QR Code Generator Guidelines

## Commands
- Generate QR codes: `./generate_qrcodes.sh`
- Run script with debugging: `bash -x ./generate_qrcodes.sh`

## Dependencies
- qrencode: For QR code generation
- ImageMagick: For image manipulation (magick command)
- pdftk: For PDF manipulation

## Code Style
- Use 4-space indentation in shell scripts
- Add comments for non-obvious operations
- Prefer descriptive variable names (e.g., SQUARE_SIZE vs SZ)
- Always use double quotes around variable expansions: "${variable}"
- Include error handling with set -e at beginning of scripts
- Clean up temporary files using trap commands or explicit cleanup steps
- Keep line length under 100 characters for readability

## Data Formats
- CSV data files should be comma-separated with no spaces: `title,link`
- QR code size and border styles should be standardized for consistency

## Development Workflow
- Commit changes after completing each task: `git add . && git commit -m "Description of changes"`
- Include descriptive commit messages explaining what was changed and why
- Do not push changes automatically; only commit to local repository
- Commit frequently with small, logical changes rather than large batch updates
