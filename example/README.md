# Flutter room scan sample

`lib/main.dart` is a complete screen: a WebView loads the Vedika room-scan page, `RoomScanController`
reads the page's messages, and a button uploads the finished capture to
`POST /v2/astrology/vastu/ar/room-capture`.

## Run it

1. `cd sdks/flutter/example && flutter create --platforms=android,ios . && flutter pub get` (the folder holds only the
   Dart sources, so `flutter create` adds the platform projects).
2. Set `kScanPageUrl`, `kApiHost` and `kApiBase` in `lib/main.dart`. `kApiBase` is your server's proxy for the
   Vedika API; the API key stays on that server, and the SDK sends keys only to hosts you name in `trustedHosts`.
   This client posts to `<kApiBase>/v2/astrology/vastu/ar/room-capture` and `.../ar/capture-merge` with
   `Authorization: Bearer proxy-placeholder`, so the proxy must serve those two paths, check your own user
   session, replace the bearer token with your API key, forward the `Idempotency-Key` header to
   `https://api.vedika.io`, and refuse every other path. It relays a billed call with your key, so it must not
   be open to anyone. (The React Native sample posts to `<API_PROXY>/vastu/ar/...`; one proxy can serve both.)
3. `flutter run` on a device or an emulator with a camera. Add the camera permission: `android.permission.CAMERA` in
   `android/app/src/main/AndroidManifest.xml` and `NSCameraUsageDescription` in `ios/Runner/Info.plist`.

`scan.snapshot.phase` moves `idle` -> `scanning` -> `captured` -> `uploading` -> `uploaded`. A scan the user
closes before a capture exists is `cancelled`, and one that cannot continue is `failed` (the sample offers "Scan again"). A WebView with no WebXR is `unsupported`, the honest answer
on many Android phones; hand a native scanner's capture (iOS RoomPlan, Android ARCore) to
`scan.acceptCapture(capture)` and call `scan.upload()`. Every `upload()` retry of one capture reuses one
idempotency key, so a retry does not charge twice.

Record the device run in the receipt table in `sdks/react/examples/react-native-scan/README.md`.
