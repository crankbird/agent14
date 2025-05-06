#!/usr/bin/env bash
set -e

print_status() {
  local name="$1"
  local status="$2"
  local note="$3"
  printf "%-30s %-15s %s\n" "$name" "$status" "$note"
}

echo "Development Environment Checklist"
echo "------------------------------------------------------------"
printf "%-30s %-15s %s\n" "Tool" "Status" "Notes"
echo "------------------------------------------------------------"

# Homebrew
if command -v brew >/dev/null 2>&1; then
  print_status "Homebrew" "Installed" "$(brew --version | head -n1)"
else
  print_status "Homebrew" "Missing" "Install from https://brew.sh/"
fi

# Git
if command -v git >/dev/null 2>&1; then
  print_status "Git" "Installed" "$(git --version)"
else
  print_status "Git" "Missing" "brew install git"
fi

# GitHub CLI
if command -v gh >/dev/null 2>&1; then
  print_status "GitHub CLI" "Installed" "$(gh --version | head -n1)"
else
  print_status "GitHub CLI" "Missing" "brew install gh"
fi

# Flutter
if command -v flutter >/dev/null 2>&1; then
  print_status "Flutter" "Installed" "$(flutter --version | head -n1 | sed 's/^[[:space:]]*//')"
else
  print_status "Flutter" "Missing" "brew install flutter"
fi

# Dart
if command -v dart >/dev/null 2>&1; then
  print_status "Dart" "Installed" "$(dart --version 2>&1)"
else
  print_status "Dart" "Missing" "Included in Flutter"
fi

# VS Code CLI
if command -v code >/dev/null 2>&1; then
  print_status "VS Code CLI" "Installed" "$(code --version | head -n1)"
else
  print_status "VS Code CLI" "Missing" "Install VS Code and enable 'code'"
fi

# VS Code Extensions (Flutter & Dart)
if command -v code >/dev/null 2>&1; then
  extensions=$(code --list-extensions | grep -E 'dart-code.flutter|dart-code.dart-code' | tr '\n' ', ')
  if [ -n "$extensions" ]; then
    print_status "VS Code Extensions" "Installed" "$extensions"
  else
    print_status "VS Code Extensions" "Missing" "Install 'Dart' and 'Flutter' extensions"
  fi
else
  print_status "VS Code Extensions" "Unknown" "VS Code CLI not found"
fi

# Xcode
if xcode-select -p >/dev/null 2>&1; then
  print_status "Xcode" "Installed" "$(xcodebuild -version | head -n2 | tr '\n' ' ')"
else
  print_status "Xcode" "Missing" "Install from App Store"
fi

# Android SDK & Licenses
if flutter doctor --android-licenses --quiet >/dev/null 2>&1; then
  print_status "Android SDK" "Installed" "Licenses accepted"
else
  print_status "Android SDK" "Missing/Partial" "Run 'flutter doctor --android-licenses'"
fi

# Android SDK cmdline-tools
if command -v sdkmanager >/dev/null 2>&1; then
  print_status "SDK Manager" "Installed" "sdkmanager found"
else
  print_status "SDK Manager" "Missing" "Install 'sdkmanager' via Android SDK cmdline-tools"
fi

# Emulators
emulators=$(flutter emulators)
if echo "$emulators" | grep -q "0 available"; then
  print_status "Emulators" "None" "Create with 'flutter emulators --create'"
else
  first=$(echo "$emulators" | sed -n '2p')
  print_status "Emulators" "Available" "$first"
fi

# Figma
if [ -d "/Applications/Figma.app" ]; then
  print_status "Figma" "Installed" ""
else
  print_status "Figma" "Missing" "Download from https://www.figma.com/download"
fi

# Sublime Text
if [ -d "/Applications/Sublime Text.app" ]; then
  print_status "Sublime Text" "Installed" ""
else
  print_status "Sublime Text" "Missing" "https://www.sublimetext.com/"
fi

echo ""
echo "Flutter Doctor Summary:"
flutter doctor