# Setup Paths
$additionalPaths = @(
    "C:\Program Files\nodejs",
    "C:\Program Files\Git\cmd",
    "C:\Users\glenj\AppData\Roaming\npm\node_modules\vsce"
)

# Update the PATH environment variable
foreach ($pathToAdd in $additionalPaths) {
    if (-not ($env:Path -like "*$pathToAdd*")) {
        $env:Path += ";" + $pathToAdd
    }
}

Write-Host "Updated PATH environment variable:"
Write-Host $env:Path

# Step 1: Git Stage, Commit, and Push
Git-StageCommitPush

if ($LASTEXITCODE -ne 0) {
    Write-Host "$ansiRed Error in Git staging, committing, or pushing. Aborting deployment. $ansiReset"
    exit 1
}

# Step 2: Package your extension using vsce
vsce package

if ($LASTEXITCODE -ne 0) {
    Write-Host "$ansiRed Error in packaging the extension using vsce. Aborting deployment. $ansiReset"
    exit 1
}

# Step 3: Install the extension globally in VSCode
# Replace with your extension ID if needed
code --install-extension "C:\Users\glenj\vba-subroutine-extractor\vba-subroutine-extractor-1.0.0.vsix"

# Optional: Show a success message
Write-Host "Deployment complete. Extension installed and enabled globally."
