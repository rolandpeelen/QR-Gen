# QR Code Generator Guidelines

## Commands
- Generate QR codes: `./generate_qrcodes.sh`
- Run script with debugging: `bash -x ./generate_qrcodes.sh`
- First-time setup: `cp links.example.csv links.csv` then edit links.csv

## Dependencies
- qrencode: For QR code generation (`brew install qrencode`)
- ImageMagick: For image manipulation (`brew install imagemagick`)
- pdftk: For PDF manipulation (`brew install pdftk-java`)
- Berkeley Mono Bold font (or modify the FONT variable in script)

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
- User data files (links.csv) should not be committed to the repository
- Use links.example.csv as a template for users to create their own links.csv

## Repository Management
- Keep qr_pdfs/ directory with generated output excluded from Git
- Do not commit user-specific files like links.csv
- Provide example files with .example suffix (e.g., file.example.ext)

## Development Workflow
- Commit changes after completing each task
- Use detailed commit messages with a short title and bullet points for changes
- Structure commits with co-authorship using this format:
  ```
  git -c commit.gpgsign=false commit -m "Descriptive title

  - Bullet point detailing first change
  - Bullet point detailing second change
  - Additional details about the implementation

  🤖 Generated with [Claude Code](https://claude.ai/code)

  Co-Authored-By: Claude <noreply@anthropic.com>"
  ```
- Disable GPG signing with `-c commit.gpgsign=false` if GPG is configured
- Do not push changes automatically; only commit to local repository
- Commit frequently with small, logical changes rather than large batch updates