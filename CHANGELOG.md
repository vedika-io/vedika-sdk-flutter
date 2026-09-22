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
- Initial broad coverage of the Vedika Intelligence API.
- Domain-specific service classes.
- Typed response models with `fromJson` factories.
- Automatic error handling (401, 402, 429, 5xx).
- Configurable base URL and timeout.
- Support for custom `http.Client` injection (testing).
