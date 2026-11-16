// The Flutter sample (example/lib/main.dart) must only use what the package declares and must
// keep the API key off the device. It is compiled by `flutter run`, not here.
import 'dart:io';

import 'package:test/test.dart';

void main() {
  final example = File('example/lib/main.dart').readAsStringSync();
  final bridge = File('lib/src/room_scan_bridge.dart').readAsStringSync();
  final readme = File('example/README.md').readAsStringSync();

  test('every controller member the sample calls is declared by the package', () {
    final used = RegExp(r'scan\.(\w+)').allMatches(example).map((m) => m.group(1)!).toSet();
    expect(used, containsAll(['handleMessage', 'inject', 'changes', 'upload', 'cancel', 'reset', 'snapshot']));
    // each member is declared on the controller, not merely a word that appears in the file
    final controller = bridge.substring(bridge.indexOf('class RoomScanController'));
    for (final member in used) {
      expect(controller, matches(RegExp('(\\b$member\\s*[(=;]|get $member\\b|\\b$member;)')), reason: member);
    }
  });

  test('the sample builds the controller from a client that trusts only the named proxy host', () {
    expect(example, matches(RegExp(r'client = VedikaClient\([^;]*trustedHosts')));
    expect(example, contains('RoomScanController(client: client)'));
    expect(example, contains('trustedHosts'));
    expect(example, contains('scan.dispose()'));
    expect(example, contains('client.dispose()'));
    expect(example, isNot(contains('vk_live_')));
    expect(example, isNot(contains('api.vedika.io')));
  });

  test('the sample routes the page channel to the controller and injects merge answers', () {
    expect(example, contains("addJavaScriptChannel('VedikaHost'"));
    expect(example, contains('scan.inject = web.runJavaScript'));
    final page = File('../../web/vedika-public/js/vastu/room-scan-host-bridge.js');
    if (page.existsSync()) {
      expect(page.readAsStringSync(), contains('VedikaHost'));
    } else {
      markTestSkipped('the page bridge lives in the monorepo, not the standalone Flutter repo');
    }
  });

  test('the README points at the shared device receipt', () {
    expect(readme, contains('react-native-scan/README.md'));
    expect(readme, contains('acceptCapture'));
  });
}
