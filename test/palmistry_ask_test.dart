import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:vedika_sdk/vedika_sdk.dart';

void main() {
  const readingId = 'palm_01K9X4N2Q7R5T8V3W6Y0ZBCDEF';
  for (final entry in {
    'en': 'What does my life line mean?',
    'hinglish': 'meri life line btaiye, samajh nhi aya',
    'hi': 'मेरी जीवन रेखा का क्या अर्थ है?',
    'bn': 'আমার জীবনরেখার অর্থ কী?',
    'ta': 'என் ஆயுள் ரேகையின் பொருள் என்ன?',
    'te': 'నా జీవిత రేఖ అర్థం ఏమిటి?',
    'gu': 'મારી જીવન રેખાનો અર્થ શું છે?',
    'kn': 'ನನ್ನ ಜೀವನ ರೇಖೆಯ ಅರ್ಥವೇನು?',
    'ml': 'എന്റെ ആയുർരേഖയുടെ അർത്ഥമെന്താണ്?',
    'mr': 'माझ्या जीवनरेषेचा अर्थ काय?',
    'pa': 'ਮੇਰੀ ਜੀਵਨ ਰੇਖਾ ਦਾ ਕੀ ਅਰਥ ਹੈ?',
    'od': 'ମୋ ଜୀବନ ରେଖାର ଅର୍ଥ କଣ?',
    'as': 'মোৰ জীৱন ৰেখাৰ অৰ্থ কি?',
    'ne': 'मेरो जीवन रेखाको अर्थ के हो?',
    'si': 'මගේ ජීවන රේඛාවේ අර්ථය කුමක්ද?',
    'ur': 'میری زندگی کی لکیر کا کیا مطلب ہے؟',
    'sa': 'मम जीवनरेखायाः अर्थः कः?',
  }.entries) {
    test('ask preserves ${entry.key} question, history and request key', () async {
      late http.Request sent;
      final transport = MockClient((request) async {
        sent = request;
        return http.Response('{"success":true,"data":{"answer":"ok"}}', 200);
      });
      final client = VedikaClient(apiKey: 'vk_test_x', httpClient: transport);
      addTearDown(client.dispose);
      final history = [{'role': 'user', 'content': entry.value}];
      final result = await client.palmistry.ask(readingId, entry.value,
          language: entry.key, history: history, idempotencyKey: 'palm-ask-1');
      expect(sent.method, 'POST');
      expect(sent.url.path, '/v2/palmistry/ask');
      expect(sent.headers['idempotency-key'], 'palm-ask-1');
      expect(jsonDecode(sent.body), {
        'readingId': readingId, 'question': entry.value,
        'language': entry.key, 'history': history,
      });
      expect(result['data'], {'answer': 'ok'});
    });
  }
  test('ask omits optional fields and preserves server errors', () async {
    late http.Request sent;
    final client = VedikaClient(apiKey: 'vk_test_x', httpClient: MockClient((request) async {
      sent = request;
      return http.Response('{"error":"reading not found"}', 404);
    }));
    addTearDown(client.dispose);
    await expectLater(client.palmistry.ask(readingId, 'Where is my reading?'), throwsA(isA<VedikaApiError>()));
    expect(jsonDecode(sent.body), {'readingId': readingId, 'question': 'Where is my reading?'});
    expect(sent.headers.containsKey('idempotency-key'), isFalse);
  });
}
