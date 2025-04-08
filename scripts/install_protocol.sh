#!/bin/bash

# Register protocol handler for Linux
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    cat > ~/.local/share/applications/transcribulator-handler.desktop <<EOL
[Desktop Entry]
Name=Transcribulator
Exec=transcribulator-protocol %u
Type=Application
Terminal=false
MimeType=x-scheme-handler/transcribulator;
EOL

    xdg-mime default transcribulator-handler.desktop x-scheme-handler/transcribulator

# Register protocol handler for macOS
elif [[ "$OSTYPE" == "darwin"* ]]; then
    cat > /Applications/Transcribulator.app/Contents/Info.plist <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>transcribulator</string>
            </array>
        </dict>
    </array>
</dict>
</plist>
EOL
fi