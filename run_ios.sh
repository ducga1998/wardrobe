#!/bin/bash

# Device ID for iPhone 16 Pro (iOS 18.2)
DEVICE_ID="09638229-51BB-4C91-8B8D-FC70DF9573C6"

echo "Booting iPhone 16 Pro Simulator..."
xcrun simctl boot "$DEVICE_ID" 2>/dev/null || echo "Simulator already booted."

echo "Opening Simulator app..."
open -a Simulator

echo "Running Flutter app..."
flutter run -d "$DEVICE_ID"
