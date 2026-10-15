## 1.0.5 - 2026-10-15

### Fixed

- Five methods called routes that the API does not document. Each now calls
  the documented route:
  - `astrology.currentDasha` calls `/v2/astrology/dasha/current-all`. The
    Vimshottari block now carries the full Maha, Antar and Pratyantar ladder
    with `currentMahaDasha`, `currentAntarDasha` and `currentPratyantarDasha`,
    and the Ashtottari and Yogini blocks are full timelines. Before, each
    block held only the running period.
  - `astrology.choghadiya` and `astrology.hora` send GET with the parameters
    as the query string, as documented. The POST they sent before was
    rejected with 400 asking for a birth datetime.
  - `astrology.saturnTransit` and `astrology.moonTransit` call
    `/v2/astrology/planet-transit` and are deprecated. The response now lists
    all nine planets under `data.planets`. Read Saturn or the Moon from the
    entry with that `name`. Each entry has `sign`, `signNumber`, `degree`,
    `nakshatra`, `isRetrograde`, `houseFromLagna` and `houseFromMoon`, with
    `natalMoonSign` and `natalLagnaSign` beside the list. The old one-planet
    fields `effect`, `gocharaVerdict`, `houseFromMoonLabel`, `longitude` and
    `signIndex` are gone. For Saturn over the natal Moon, use
    `astrology.sadeSati`.

### Added

- `astrology.planetTransit`, which calls `/v2/astrology/planet-transit`.
- `test/openapi_paths_test.dart` fails when any SDK method calls a route, or
  uses a method, that the public API reference does not document. The
  documented operations are kept in `test/fixtures/public_operations.txt`.
  `dart run tool/public_operations.dart` refreshes that list inside the
  Vedika repository.

## 1.0.4 - 2026-10-14

### Added

- The room scan bridge is exported from `package:vedika_sdk/vedika_sdk.dart`:
  `RoomScanController`, `VastuRoomScanService` (`uploadRoomCapture`,
  `mergeCaptures`), `RoomScanSnapshot`, `RoomScanPhase`, the message classes
  `RoomScanMessage`, `RoomScanReady`, `RoomScanStateMessage`,
  `RoomScanCaptureMessage`, `RoomScanErrorMessage`, `RoomScanMergeRequest` and
  `RoomScanInvalid`, `RoomScanRefused`, `parseRoomScanMessage`,
  `resolveMergeScript`, `rejectMergeScript`, `roomScanBridgeSchema` and
  `roomCaptureSchema`. The code was in the repository since 1.0.3 but was not
  exported, so it could only be imported from `src/`. It uses no WebView
  package: the app supplies its own WebView and passes the page's messages to
  `RoomScanController.handleMessage`.

## 1.0.3 - 2026-10-06

### Fixed

- 38 methods called routes that answer 404 on `api.vedika.io` and now call the
  live route: `astrology.planets`, `houses`, `mahaDasha`, `antarDasha`,
  `gunaMatch`, `lifePath`, `destinyNumber`, `numerologyComplete`,
  `jaiminiCharaKarakas`, `fixedStars`, `asteroids`, `sunMoonTimes`,
  `festivals` (now `/festivals/upcoming`, with `from`, `days`, `region`); every
  `numerology.*` method that used `/pythagorean`, `/chaldean`, `/lo-shu`,
  `/kabbalah` or the bare `/life-path` style names; and
  `western.harmonics` (the harmonic is now the path segment),
  `directions`, `lots`, `astrocartography`, `dignities`, `hemisphereEmphasis`.
- `western.stellium` is deprecated: the API has no stellium route, so it now
  fails with `UnsupportedError` instead of a 404 after a paid-looking call.
- Any 2xx is a success. Only 200 and 202 were accepted, so a 201 or 204 raised
  an error. `getRaw` had the same 200-only check.
- `X-SDK` reported `vedika-flutter/1.0.0` on every release. It now follows
  `VedikaClient.sdkVersion`, which is kept equal to `pubspec.yaml` by a test.

### Added

- `VedikaInsufficientCredits.required`, `available`, `deficit` and
  `purchaseUrl`, read from the 402 body. A 402 is never retried.
- `VedikaApiError.code`, the API's machine-readable error code.
- `VedikaRateLimitError.isDailyLimit`, `isRetryable` and `upgradeUrl`. A 429 is
  classified by its body `code`, never by rate-limit headers.
  `DAILY_LIMIT_EXCEEDED` is not retryable. `retryAfterSeconds` now reads the
  body's `retryAfter` first and the `Retry-After` header second.
- `VedikaIdempotencyNotSupportedError` for 422 `IDEMPOTENCY_NOT_SUPPORTED`
  (no charge was attempted; call again without `idempotencyKey`).

## 1.0.2 - 2026-09-17

- Removed internal tracking references from source and test comments.
- The `documentation` link in `pubspec.yaml` now points to the Flutter
  integration guide; the previous address returned 404.

## 1.0.1 - 2026-09-07

### Security

- The API key is now sent only to an approved origin. `baseUrl` is checked when
  the client is constructed: `api.vedika.io`, loopback, or a host named in the
  new `trustedHosts` parameter. Any other host throws `ArgumentError` before a
  request can carry the key. Previously any `https://` origin was accepted and
  received `Authorization: Bearer <key>` on the first call, so a `baseUrl`
  taken from remote config, a deep link, or a QR payload exfiltrated the
  customer's key from the user's device.
- `allowInsecureHttp` now relaxes the scheme only and can no longer be used to
  reach a foreign host.
- Requests assert their destination host against the origin pinned at
  construction, so future changes to URL building fail closed.

## 1.0.0

- Initial release.
- Full coverage of 500+ Vedika Intelligence API endpoints.
- 23 domain-specific service classes.
- Typed response models with `fromJson` factories.
- Automatic error handling (401, 402, 429, 5xx).
- Configurable base URL and timeout.
- Support for custom `http.Client` injection (testing).
