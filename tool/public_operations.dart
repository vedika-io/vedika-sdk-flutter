// Lists the documented public operations and the routes the SDK calls.
//
// `dart run tool/public_operations.dart` (from sdks/flutter in the Vedika
// monorepo) rewrites test/fixtures/public_operations.txt from
// web/vedika-public/openapi.json.
import 'dart:convert';
import 'dart:io';

const fixturePath = 'test/fixtures/public_operations.txt';
const monorepoSpecPath = '../../web/vedika-public/openapi.json';

const _methods = ['get', 'post', 'put', 'patch', 'delete'];

/// `METHOD /path` for every operation in an OpenAPI document, sorted.
List<String> publicOperations(String openapiJson) {
  final paths = (jsonDecode(openapiJson) as Map)['paths'] as Map;
  return [
    for (final e in paths.entries)
      for (final m in _methods)
        if ((e.value as Map).containsKey(m)) '${m.toUpperCase()} ${e.key}'
  ]..sort();
}

/// One request the SDK source makes. Interpolated segments are `*`.
class SdkCall {
  final String method;
  final String path;
  final String where;
  const SdkCall(this.method, this.path, this.where);
}

// `dart format` may break a call as `_client\n    .get(`.
final _call = RegExp(r'_client\s*\.(get|getRaw|post)\(\s*');

List<SdkCall> sdkCalls(Directory lib) => [
      for (final f in lib.listSync(recursive: true).whereType<File>())
        if (f.path.endsWith('.dart'))
          ...sdkCallsIn(f.readAsStringSync(), f.path)
    ];

List<SdkCall> sdkCallsIn(String source, String file) {
  final calls = <SdkCall>[];
  for (final m in _call.allMatches(source)) {
    final where =
        '$file:${'\n'.allMatches(source.substring(0, m.start)).length + 1}';
    final (path, end) = _literal(source, m.end, where);
    final next = source.substring(end).trimLeft();
    if (!next.startsWith(',') && !next.startsWith(')')) {
      throw FormatException('path is not a single string literal', where);
    }
    calls.add(SdkCall(
        m.group(1) == 'post' ? 'POST' : 'GET', path.split('?').first, where));
  }
  return calls;
}

/// Reads the string literal at [i]; returns its text with every
/// interpolation replaced by `*`, and the index after the closing quote.
(String, int) _literal(String s, int i, String where) {
  final q = s[i];
  if (q != "'" && q != '"') {
    throw FormatException('path is not a single string literal', where);
  }
  final out = StringBuffer();
  i++;
  while (i < s.length && s[i] != q) {
    if (s[i] == r'\') {
      out.write(s[i + 1]);
      i += 2;
    } else if (s.startsWith(r'${', i)) {
      i = _skipBraces(s, i + 1);
      out.write('*');
    } else if (s[i] == r'$') {
      i++;
      while (i < s.length && RegExp(r'\w').hasMatch(s[i])) {
        i++;
      }
      out.write('*');
    } else {
      out.write(s[i++]);
    }
  }
  return (out.toString(), i + 1);
}

/// [i] is at `{`; returns the index after its matching `}`, skipping
/// nested braces and quoted strings.
int _skipBraces(String s, int i) {
  var depth = 0;
  while (i < s.length) {
    final c = s[i];
    if (c == "'" || c == '"') {
      i++;
      while (s[i] != c) {
        i += s[i] == r'\' ? 2 : 1;
      }
    } else if (c == '{') {
      depth++;
    } else if (c == '}' && --depth == 0) {
      return i + 1;
    }
    i++;
  }
  throw const FormatException('unclosed interpolation');
}

/// True when some documented operation with the same method matches
/// [call]: a `*` stands for one or more path characters, and a `{name}`
/// template in the spec for one segment.
bool isDocumented(SdkCall call, Set<String> operations) {
  final sdk =
      RegExp('^${call.path.split('*').map(RegExp.escape).join('.+')}\$');
  final concrete = call.path.replaceAll('*', 'x');
  for (final op in operations) {
    final space = op.indexOf(' ');
    if (op.substring(0, space) != call.method) continue;
    final path = op.substring(space + 1);
    if (sdk.hasMatch(path)) return true;
    final template = RegExp(
        '^${path.split(RegExp(r'\{[^}]+\}')).map(RegExp.escape).join('[^/]+')}\$');
    if (template.hasMatch(concrete)) return true;
  }
  return false;
}

void main() {
  final ops = publicOperations(File(monorepoSpecPath).readAsStringSync());
  File(fixturePath)
    ..createSync(recursive: true)
    ..writeAsStringSync('${ops.join('\n')}\n');
  stdout.writeln('${ops.length} operations -> $fixturePath');
}
