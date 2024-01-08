# Setup Paths
$additionalPaths = @(
    "C:\Program Files\nodejs",
    "C:\Program Files\Git\cmd",
    "C:\Users\glenj\AppData\Roaming\npm\node_modules\vsce"
)

# Check if all required paths exist
foreach ($pathToAdd in $additionalPaths) {
    if (-not (Test-Path -Path $pathToAdd -PathType Container)) {
        Write-Host "Path not found: $pathToAdd"
        exit 1  # Abort the script with an error code
    }
}

# Update the PATH environment variable
foreach ($pathToAdd in $additionalPaths) {
    if (-not ($env:Path -split ";" | Select-String -Pattern [regex]::Escape($pathToAdd))) {
        $env:Path += ";" + $pathToAdd
    }
}

Write-Host "Updated PATH environment variable:"
Write-Host $env:Path

# Define the path to your VSIX extension file
$vsixFileName = "vba-subroutine-extractor-1.0.0.vsix"
$vsixFilePath = Join-Path -Path $PSScriptRoot -ChildPath $vsixFileName

# Step 1: Git Stage, Commit, and Push
Git-StageCommitPush

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error in Git staging, committing, or pushing. Aborting deployment."
    exit 1  # Abort the script with an error code
}

# Step 2: Package your extension using vsce
vsce package

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error in packaging the extension using vsce. Aborting deployment."
    exit 1  # Abort the script with an error code
}

# Step 3: Install the extension globally in VSCode
# Replace with your extension ID if needed
code --install-extension $vsixFilePath

# Optional: Show a success message
Write-Host "Deployment complete. Extension installed and enabled globally."
