#!/bin/bash
# Semantic Versioning Script for Transcribulator

# Default values
TYPE=${1:-patch}
MESSAGE=$2

# Function to display help
show_help() {
    echo "Transcribulator Semantic Versioning Script"
    echo ""
    echo "Usage: ./scripts/version.sh [type] [message]"
    echo ""
    echo "Types:"
    echo "  patch     Increment patch version (bug fixes) - default"
    echo "  minor     Increment minor version (new features, backwards compatible)"
    echo "  major     Increment major version (breaking changes)"
    echo "  meta      Meta version (no code changes, just project maintenance)"
    echo ""
    echo "Example:"
    echo "  ./scripts/version.sh minor 'Added support for Python 3.10'"
    echo ""
}

# Display help if requested
if [[ "$TYPE" == "help" || "$TYPE" == "--help" || "$TYPE" == "-h" ]]; then
    show_help
    exit 0
fi

# Validate version type
if [[ "$TYPE" != "patch" && "$TYPE" != "minor" && "$TYPE" != "major" && "$TYPE" != "meta" ]]; then
    echo "Error: Invalid version type '$TYPE'. Must be one of: patch, minor, major, meta"
    show_help
    exit 1
fi

# Require a message
if [[ -z "$MESSAGE" ]]; then
    echo "Error: A version message is required"
    show_help
    exit 1
fi

# Read current version from Cargo.toml
CURRENT_VERSION=$(grep -m 1 'version\s*=' Cargo.toml | sed -E 's/.*"([^"]+)".*/\1/')
if [[ -z "$CURRENT_VERSION" ]]; then
    echo "Error: Could not find version in Cargo.toml"
    exit 1
fi

# Parse version parts
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

# Update version based on type
case "$TYPE" in
    "major")
        MAJOR=$((MAJOR + 1))
        MINOR=0
        PATCH=0
        ;;
    "minor")
        MINOR=$((MINOR + 1))
        PATCH=0
        ;;
    "patch")
        PATCH=$((PATCH + 1))
        ;;
    "meta")
        # No version change for meta
        ;;
esac

# Create new version string
NEW_VERSION="$MAJOR.$MINOR.$PATCH"

# Only update files if this is not a meta version
if [[ "$TYPE" != "meta" ]]; then
    # Update version in Cargo.toml
    sed -i.bak -E "s/version\s*=\s*\"[^\"]+\"/version = \"$NEW_VERSION\"/" Cargo.toml
    rm Cargo.toml.bak

    echo "Updated version from $CURRENT_VERSION to $NEW_VERSION"
else
    echo "Meta version: Keeping version at $CURRENT_VERSION"
fi

# Create a git commit with the version change
if [[ "$TYPE" == "meta" ]]; then
    COMMIT_MESSAGE="Meta: $MESSAGE"
else
    COMMIT_MESSAGE="Version $NEW_VERSION: $MESSAGE"
fi

# Stage changes
git add Cargo.toml

# Commit changes
git commit -m "$COMMIT_MESSAGE"

# Create a tag for non-meta versions
if [[ "$TYPE" != "meta" ]]; then
    git tag -a "v$NEW_VERSION" -m "$COMMIT_MESSAGE"
    echo "Created tag v$NEW_VERSION"
fi

echo "Committed changes with message: $COMMIT_MESSAGE"
echo "Don't forget to push changes and tags: git push && git push --tags"
