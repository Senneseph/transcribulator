# Semantic Versioning Script for Transcribulator

param (
    [string]$type = "patch",  # patch, minor, major, or meta
    [string]$message = ""
)

# Function to display help
function Show-Help {
    Write-Host "Transcribulator Semantic Versioning Script"
    Write-Host ""
    Write-Host "Usage: .\scripts\version.ps1 [type] [message]"
    Write-Host ""
    Write-Host "Types:"
    Write-Host "  patch     Increment patch version (bug fixes) - default"
    Write-Host "  minor     Increment minor version (new features, backwards compatible)"
    Write-Host "  major     Increment major version (breaking changes)"
    Write-Host "  meta      Meta version (no code changes, just project maintenance)"
    Write-Host ""
    Write-Host "Example:"
    Write-Host "  .\scripts\version.ps1 minor 'Added support for Python 3.10'"
    Write-Host ""
}

# Display help if requested
if ($type -eq "help" -or $type -eq "--help" -or $type -eq "-h") {
    Show-Help
    exit 0
}

# Validate version type
$validTypes = @("patch", "minor", "major", "meta")
if (-not $validTypes.Contains($type)) {
    Write-Host "Error: Invalid version type '$type'. Must be one of: patch, minor, major, meta" -ForegroundColor Red
    Show-Help
    exit 1
}

# Require a message
if ($message -eq "") {
    Write-Host "Error: A version message is required" -ForegroundColor Red
    Show-Help
    exit 1
}

# Read current version from Cargo.toml
$cargoToml = Get-Content -Path "Cargo.toml" -Raw
$versionMatch = [regex]::Match($cargoToml, 'version\s*=\s*"([^"]+)"')
if (-not $versionMatch.Success) {
    Write-Host "Error: Could not find version in Cargo.toml" -ForegroundColor Red
    exit 1
}

$currentVersion = $versionMatch.Groups[1].Value
$versionParts = $currentVersion.Split('.')

# Parse version parts
$major = [int]$versionParts[0]
$minor = [int]$versionParts[1]
$patch = [int]$versionParts[2]

# Update version based on type
switch ($type) {
    "major" {
        $major++
        $minor = 0
        $patch = 0
    }
    "minor" {
        $minor++
        $patch = 0
    }
    "patch" {
        $patch++
    }
    "meta" {
        # No version change for meta
    }
}

# Create new version string
$newVersion = "$major.$minor.$patch"

# Only update files if this is not a meta version
if ($type -ne "meta") {
    # Update version in Cargo.toml
    $newCargoToml = $cargoToml -replace 'version\s*=\s*"([^"]+)"', "version = `"$newVersion`""
    Set-Content -Path "Cargo.toml" -Value $newCargoToml

    Write-Host "Updated version from $currentVersion to $newVersion" -ForegroundColor Green
} else {
    Write-Host "Meta version: Keeping version at $currentVersion" -ForegroundColor Green
}

# Create a git commit with the version change
$commitMessage = "Version $newVersion: $message"
if ($type -eq "meta") {
    $commitMessage = "Meta: $message"
}

# Stage changes
git add Cargo.toml

# Commit changes
git commit -m $commitMessage

# Create a tag for non-meta versions
if ($type -ne "meta") {
    git tag -a "v$newVersion" -m $commitMessage
    Write-Host "Created tag v$newVersion" -ForegroundColor Green
}

Write-Host "Committed changes with message: $commitMessage" -ForegroundColor Green
Write-Host "Don't forget to push changes and tags: git push && git push --tags" -ForegroundColor Yellow
