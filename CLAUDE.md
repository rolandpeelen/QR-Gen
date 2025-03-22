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