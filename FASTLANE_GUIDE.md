# Fastlane Guide for Flutter Project

This guide explains how to use the Fastlane setup in this project to automate your iOS and Android releases.

## Prerequisites

1.  **Install Fastlane:**
    ```bash
    brew install fastlane
    ```

2.  **Navigate to project root:**
    ```bash
    cd /Users/nguyenminhduc/Desktop/flutter-boilerplate-project
    ```

## iOS Setup (TestFlight)

1.  **Configure `ios/fastlane/Appfile`:**
    Open `ios/fastlane/Appfile` and update:
    - `app_identifier`: Your App Bundle ID (e.g., `com.yourcompany.app`).
    - `apple_id`: Your Apple ID email.

2.  **Authentication:**
    Fastlane needs to access your App Store Connect. The easiest way is to use an App Store Connect API Key.
    - Create a key in [App Store Connect](https://appstoreconnect.apple.com/access/api).
    - You can set environment variables or use `fastlane match` later for more advanced setup.

3.  **Run Beta Lane:**
    To build and upload to TestFlight:
    ```bash
    cd ios
    fastlane beta
    ```

## Android Setup (Google Play)

1.  **Configure `android/fastlane/Appfile`:**
    Open `android/fastlane/Appfile` and update:
    - `package_name`: Your Android Package Name (e.g., `com.yourcompany.app`).
    - `json_key_file`: Path to your Google Play Service Account JSON key.

2.  **Service Account Key:**
    - Go to Google Play Console -> Setup -> API access.
    - Create a Service Account and download the JSON key.
    - Save it as `android/fastlane/api-key.json` (Make sure to add this to `.gitignore`!).

3.  **Run Beta Lane:**
    To build and upload to Google Play Internal Track:
    ```bash
    cd android
    fastlane beta
    ```

## Common Commands

- **`fastlane beta`**: The main command you'll use to ship a new build.
- **`fastlane lanes`**: List all available lanes.

## Troubleshooting

- **Code Signing (iOS):** If you encounter signing issues, ensure your Xcode project settings have "Automatically manage signing" enabled or consider setting up `fastlane match`.
- **Build Number:** For iOS, ensure "Apple Generic Versioning" is enabled in Xcode Build Settings to allow `increment_build_number` to work.
