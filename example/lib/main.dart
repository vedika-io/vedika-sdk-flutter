// Room scan in a Flutter app: a WebView loads the Vedika room-scan page, the page posts its
// progress and the finished capture to the app, and the app uploads it.
//
// Set kScanPageUrl to the room-scan page you host or the one Vedika gives you. The API key
// belongs on your server; point kApiBase at your authenticated proxy for the Vedika API and
// name its host in trustedHosts (the SDK sends keys only to hosts you name).
// On a phone whose WebView has no WebXR the page reports `unsupported`; hand a native
// scanner's capture to `scan.acceptCapture(capture)` instead (see README.md).
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vedika_sdk/vedika_sdk.dart';
import 'package:webview_flutter/webview_flutter.dart';

const kScanPageUrl = 'https://vedika.io/vastu-ar/host.html';
const kApiHost = 'app.example.com';
const kApiBase = 'https://$kApiHost';

void main() => runApp(const MaterialApp(home: ScanScreen()));

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late final VedikaClient client;
  late final RoomScanController scan;
  late final WebViewController web;
  late final StreamSubscription<RoomScanSnapshot> changes;

  @override
  void initState() {
    super.initState();
    client = VedikaClient(apiKey: 'proxy-placeholder', baseUrl: kApiBase, trustedHosts: const [kApiHost]);
    scan = RoomScanController(client: client);
    web = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('VedikaHost', onMessageReceived: (m) => scan.handleMessage(m.message))
      ..loadRequest(Uri.parse(kScanPageUrl));
    scan.inject = web.runJavaScript;
    changes = scan.changes.listen((_) => setState(() {}));
  }

  @override
  void dispose() {
    changes.cancel();
    scan.dispose();
    client.dispose();
    super.dispose();
  }

  /// A failed upload returns the scan to `captured` with the error shown; tapping again retries
  /// under the same idempotency key, so it is not billed twice.
  Future<void> upload() async {
    try {
      await scan.upload();
    } catch (_) {
      // The controller keeps the capture and puts the message in scan.snapshot.error.
    }
  }

  @override
  Widget build(BuildContext context) {
    final phase = scan.snapshot.phase;
    return Scaffold(
      appBar: AppBar(title: const Text('Room scan')),
      body: Column(children: [
        Expanded(child: WebViewWidget(controller: web)),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Text('Scan: ${phase.name}', key: const Key('scan-phase')),
            if (scan.snapshot.error != null) Text(scan.snapshot.error!),
            if (phase == RoomScanPhase.captured)
              ElevatedButton(onPressed: upload, child: const Text('Upload scan')),
            if (phase == RoomScanPhase.scanning)
              TextButton(onPressed: scan.cancel, child: const Text('Cancel')),
            if (phase == RoomScanPhase.uploaded ||
                phase == RoomScanPhase.cancelled ||
                phase == RoomScanPhase.unsupported ||
                phase == RoomScanPhase.failed)
              TextButton(onPressed: scan.reset, child: const Text('Scan again')),
          ]),
        ),
      ]),
    );
  }
}
