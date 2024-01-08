# Define the path to your VSIX extension file
$vsixFileName = "vba-subroutine-extractor-1.0.0.vsix"
$vsixFilePath = Join-Path -Path $PSScriptRoot -ChildPath $vsixFileName

# Step 1: Git Stage, Commit, and Push
Git-StageCommitPush

# Step 2: Package your extension using vsce
vsce package

# Step 3: Install the extension globally in VSCode
# Replace with your extension ID if needed
$extensionId = "vba-subroutine-extractor"
code --install-extension $vsixFilePath
code --enable-extension $extensionId

# Optional: Show a success message
Write-Host "Deployment complete. Extension installed and enabled globally."