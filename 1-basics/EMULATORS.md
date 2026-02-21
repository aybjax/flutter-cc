# Running on Emulators & Simulators

## Fixes Applied

### macOS — "Operation not permitted" on HTTP requests
macOS apps run in a sandbox by default. The `com.apple.security.network.client` entitlement was missing, so all HTTP requests failed silently.

**Fix:** Added `com.apple.security.network.client` → `true` to both:
- `macos/Runner/DebugProfile.entitlements`
- `macos/Runner/Release.entitlements`

### iOS — CocoaPods not wired up
The Xcode project was missing Pod integration. Plugins like `file_picker`, `geolocator_apple`, and `shared_preferences_foundation` use native code distributed via CocoaPods.

**Fix:** Ran `pod install` inside `ios/`, which generated `Podfile.lock` and updated `project.pbxproj` to link the Pod frameworks.

### Android — No issues in code
The Android manifest already had `INTERNET` and location permissions. The only issue was not having an emulator running.

---

## Starting Emulators

### Android Emulator

```bash
# List available Android emulators
/Users/aybjax/Library/Android/sdk/emulator/emulator -list-avds

# Start an emulator (currently: Medium_Phone_API_35)
/Users/aybjax/Library/Android/sdk/emulator/emulator -avd Medium_Phone_API_35

# Or use Flutter shorthand
flutter emulators --launch Medium_Phone_API_35
```

### iOS Simulator

```bash
# List all available iOS simulators
xcrun simctl list devices available

# Boot a specific simulator by UUID
xcrun simctl boot <DEVICE-UUID>

# Or open the Simulator app (boots the last-used device)
open -a Simulator

# Or use Flutter shorthand (boots default iOS simulator)
flutter emulators --launch apple_ios_simulator
```

---

## Running the App

```bash
# List connected devices
flutter devices

# Run on a specific device
flutter run -d emulator-5554      # Android emulator
flutter run -d <SIMULATOR-UUID>   # iOS simulator
flutter run -d macos              # macOS desktop
flutter run -d chrome             # Web
```

---

## Changing the Phone Model

### Android — AVD Manager

Each Android emulator is an AVD (Android Virtual Device) with a specific phone profile.

**Via Android Studio:**
1. Open Android Studio → Tools → Device Manager
2. Click "Create Virtual Device"
3. Pick a hardware profile (Pixel 9, Pixel Fold, Small Phone, etc.)
4. Select a system image (API level)
5. Finish — the new AVD appears in `emulator -list-avds`

**Via command line:**
```bash
# List available device definitions
/Users/aybjax/Library/Android/sdk/cmdline-tools/latest/bin/avdmanager list device

# Create a new AVD (example: Pixel 8 with API 35)
/Users/aybjax/Library/Android/sdk/cmdline-tools/latest/bin/avdmanager create avd \
  -n Pixel_8_API_35 \
  -k "system-images;android-35;google_apis;arm64-v8a" \
  -d pixel_8

# Delete an AVD
/Users/aybjax/Library/Android/sdk/cmdline-tools/latest/bin/avdmanager delete avd -n Medium_Phone_API_35
```

You may need to download system images first:
```bash
/Users/aybjax/Library/Android/sdk/cmdline-tools/latest/bin/sdkmanager "system-images;android-35;google_apis;arm64-v8a"
```

### iOS — Simulator Runtimes & Devices

iOS simulators are tied to Xcode runtimes. Each runtime provides a set of device types.

**Via Xcode:**
1. Open Xcode → Window → Devices and Simulators → Simulators tab
2. Click "+" at the bottom left
3. Pick a device type (iPhone 16 Pro, iPad Air, etc.)
4. Pick an OS version (runtime)
5. Name it and click Create

**Via command line:**
```bash
# List available runtimes
xcrun simctl list runtimes

# List available device types
xcrun simctl list devicetypes

# Create a new simulator
xcrun simctl create "My iPhone 16 Pro" "iPhone 16 Pro" "iOS-18-6"

# Delete a simulator
xcrun simctl delete <DEVICE-UUID>
```

**To add new iOS versions**, install additional simulator runtimes:
- Xcode → Settings → Platforms → click "+" to download (e.g., iOS 17.5, iOS 18.2)
- Or: `xcodebuild -downloadPlatform iOS`

### Currently Available

**Android:**
| Name | API | Arch |
|------|-----|------|
| Medium_Phone_API_35 | Android 15 (API 35) | arm64 |

**iOS Simulators (sample):**
| Device | iOS Version | UUID |
|--------|-------------|------|
| iPhone 16 Pro | 18.6 | 902A690C-... |
| iPhone 16 Pro Max | 18.6 | 66940FAB-... |
| iPhone 15 Pro | 17.5 | 14D76FA4-... |
| iPhone 16 Pro | 18.2 | CD8DC8D2-... |
