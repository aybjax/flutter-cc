# 11-fastlane: Flutter Build Flavors & Fastlane CI/CD

A minimal Flutter app demonstrating build flavors (dev, staging, production) and Fastlane-based CI/CD pipelines for both Android (Google Play Store) and iOS (TestFlight / App Store).

## What This App Teaches

- **Flutter build flavors**: Using `--flavor` flag, Android `productFlavors`, and iOS schemes
- **Environment-specific configuration**: Loading different `.env` files per flavor
- **Fastlane for Android**: Gradle integration, `supply` action for Play Store uploads
- **Fastlane for iOS**: `match` for code signing, `gym` for builds, `pilot` for TestFlight
- **GitHub Actions**: CI (lint/test on PR) and CD (build/deploy on tag) workflows
- **Freezed models**: Immutable configuration data classes with code generation

## Project Structure

```
lib/
  config/
    environment.dart        # Environment enum (dev, staging, production)
    flavor_config.dart      # Singleton config loaded from .env files
  models/
    app_config.dart         # @freezed model for app configuration
    models.dart             # Barrel export
  screens/
    home_screen.dart        # Displays current flavor/environment info
  l10n/
    app_en.arb              # English translations
    app_es.arb              # Spanish translations
    generated/              # Auto-generated l10n files
  main.dart                 # Shared FlavorApp widget
  main_dev.dart             # Entry point: development flavor
  main_staging.dart         # Entry point: staging flavor
  main_production.dart      # Entry point: production flavor

android/fastlane/
  Appfile                   # Play Store credentials
  Fastfile                  # Build & deploy lanes

ios/fastlane/
  Appfile                   # App Store credentials
  Fastfile                  # Build & deploy lanes

.github/workflows/
  ci.yml                    # Lint, analyze, test on PR
  cd.yml                    # Build & deploy on tag push

.env.dev                    # Development environment variables
.env.staging                # Staging environment variables
.env.production             # Production environment variables
```

## Running the App

Each flavor has its own entry point. Use the `--flavor` flag and `-t` (target) to select:

```bash
# Development
flutter run --flavor dev -t lib/main_dev.dart

# Staging
flutter run --flavor staging -t lib/main_staging.dart

# Production
flutter run --flavor production -t lib/main_production.dart
```

## Building for Release

```bash
# Android APK (dev)
flutter build apk --flavor dev -t lib/main_dev.dart

# Android App Bundle (production, for Play Store)
flutter build appbundle --flavor production -t lib/main_production.dart

# iOS (production)
flutter build ios --flavor production -t lib/main_production.dart
```

## Fastlane Setup Guide

### Prerequisites

1. Install Ruby (2.7+ recommended):
   ```bash
   # macOS (via Homebrew)
   brew install ruby
   ```

2. Install Fastlane:
   ```bash
   gem install fastlane
   ```

3. Install Bundler (for managing Fastlane version per project):
   ```bash
   gem install bundler
   ```

### Android Setup

1. Navigate to the Android directory:
   ```bash
   cd android
   ```

2. Initialize Bundler (creates Gemfile):
   ```bash
   bundle init
   echo 'gem "fastlane"' >> Gemfile
   bundle install
   ```

3. Configure `android/fastlane/Appfile`:
   - Set your `package_name`
   - Add your Google Play service account JSON key path
   - Generate the key at: Google Cloud Console > Service Accounts

4. Run a build lane:
   ```bash
   bundle exec fastlane build_dev
   bundle exec fastlane build_staging
   bundle exec fastlane build_prod
   ```

5. Deploy to Play Store (after configuring credentials):
   ```bash
   bundle exec fastlane deploy_play_store
   ```

### iOS Setup

1. Navigate to the iOS directory:
   ```bash
   cd ios
   ```

2. Initialize Bundler:
   ```bash
   bundle init
   echo 'gem "fastlane"' >> Gemfile
   bundle install
   ```

3. Configure `ios/fastlane/Appfile`:
   - Set your `app_identifier` (bundle ID)
   - Set your `apple_id`
   - Set your `team_id`

4. Set up code signing with match:
   ```bash
   # Initialize match (creates a private Git repo for certificates)
   bundle exec fastlane match init

   # Generate development certificates
   bundle exec fastlane match development

   # Generate App Store certificates
   bundle exec fastlane match appstore
   ```

5. Run a build lane:
   ```bash
   bundle exec fastlane build_dev
   bundle exec fastlane build_staging
   bundle exec fastlane build_prod
   ```

6. Deploy to TestFlight (after configuring credentials):
   ```bash
   bundle exec fastlane deploy_testflight
   ```

## GitHub Actions CI/CD

### CI Pipeline (`ci.yml`)

Runs automatically on every pull request to `main`:
- Installs Flutter and dependencies
- Generates code (freezed, l10n)
- Runs `flutter analyze`
- Runs `flutter test`
- Checks code formatting

### CD Pipeline (`cd.yml`)

Runs automatically when a version tag is pushed:

```bash
# Create and push a release tag to trigger CD
git tag v1.0.0
git push origin v1.0.0
```

The CD pipeline:
- Builds the production Android App Bundle via Fastlane
- Builds the production iOS IPA via Fastlane
- Uploads build artifacts
- (When configured) Deploys to Play Store and TestFlight

### Required GitHub Secrets

For full deployment, add these secrets to your GitHub repository:

| Secret | Description |
|--------|-------------|
| `GOOGLE_PLAY_JSON_KEY` | Base64-encoded Google Play service account JSON |
| `MATCH_PASSWORD` | Password for the match certificates repo |
| `MATCH_GIT_URL` | Git URL of the match certificates repo |
| `APPLE_ID` | Apple ID email for App Store Connect |
| `APP_STORE_CONNECT_API_KEY` | App Store Connect API key |

## Code Generation

After modifying `app_config.dart` or ARB files, regenerate:

```bash
# Regenerate freezed/json_serializable code
dart run build_runner build --delete-conflicting-outputs

# Regenerate l10n files
flutter gen-l10n
```

## Android Flavor Configuration

The `android/app/build.gradle.kts` defines three product flavors:

| Flavor | Application ID Suffix | Version Suffix |
|--------|-----------------------|----------------|
| dev | `.dev` | `-dev` |
| staging | `.staging` | `-staging` |
| production | (none) | (none) |

This allows all three flavors to be installed side-by-side on the same device.
