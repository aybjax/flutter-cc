# VideoCallAybKaz

Flutter 1x1 video/audio calling app with a small chat panel, built with:

- `flutter_bloc` + `Cubit`
- `dartz`
- `dio`
- `shared_preferences`
- `get_it`
- `auto_route`
- `freezed` / `json_serializable` / `build_runner`
- `l10n` + `intl`
- `flutter_webrtc`

## Project Structure

```text
lib/
  core/
    di/
    error/
    network/
    router/
    storage/
    theme/
    utils/
  features/
    settings/
      data/
        datasources/
        dtos/
        models/
        repositories/
      domain/
        entities/
        params/
        repositories/
        usecases/
      presentation/
        cubit/
        pages/
        widgets/
    call_room/
      data/
        datasources/
        dtos/
        models/
        repositories/
      domain/
        entities/
        params/
        repositories/
        usecases/
      presentation/
        cubit/
        pages/
        widgets/
```

## Backend

The app is wired for the simple signaling backend in:

```bash
webrtc-test/2clients/index.js
```

That server:

- allows only 2 clients
- forwards WebRTC offer/answer/candidate messages
- also forwards chat messages over the same WebSocket

## Run The Signaling Server

From the workspace root:

```bash
cd webrtc-test
npm install
node 2clients/index.js
```

It starts on:

```bash
http://localhost:3000
ws://localhost:3000
```

## Flutter Setup

Inside `flutter-cc/12-aybkaz`:

```bash
flutter pub get
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Useful Signaling URLs

- macOS/iOS simulator or desktop: `ws://localhost:3000`
- Android emulator: `ws://10.0.2.2:3000`
- real phone on same Wi‑Fi: `ws://<your-lan-ip>:3000`

## Notes

- The home screen persists your display name, signaling URL, and start mode in `shared_preferences`.
- `Check server` uses `dio` and probes the HTTP endpoint derived from the WebSocket URL.
- If you later replace `webrtc-test`, only the signaling URL and message contract may need adjustment.
