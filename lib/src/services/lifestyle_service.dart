import '../client.dart';

/// Lifestyle endpoints under `/v2/lifestyle/`.
///
/// 8 GET endpoints: love compatibility, zodiac gifts/food/travel/fitness,
/// fortune cookie, spirit animal, lucky color.
class LifestyleService {
  final VedikaClient _client;
  LifestyleService(this._client);

  /// Love compatibility between two signs.
  Future<Map<String, dynamic>> loveCompatibility(
          String sign1, String sign2) =>
      _client.get('/v2/lifestyle/love-compatibility/$sign1/$sign2');

  /// Gift ideas for a zodiac sign.
  Future<Map<String, dynamic>> zodiacGift(String sign) =>
      _client.get('/v2/lifestyle/zodiac-gift/$sign');

  /// Food preferences for a zodiac sign.
  Future<Map<String, dynamic>> zodiacFood(String sign) =>
      _client.get('/v2/lifestyle/zodiac-food/$sign');

  /// Travel destinations for a zodiac sign.
  Future<Map<String, dynamic>> zodiacTravel(String sign) =>
      _client.get('/v2/lifestyle/zodiac-travel/$sign');

  /// Fitness style for a zodiac sign.
  Future<Map<String, dynamic>> zodiacFitness(String sign) =>
      _client.get('/v2/lifestyle/zodiac-fitness/$sign');

  /// Random fortune cookie.
  Future<Map<String, dynamic>> fortuneCookie() =>
      _client.get('/v2/lifestyle/fortune-cookie');

  /// Spirit animal for a zodiac sign.
  Future<Map<String, dynamic>> spiritAnimal(String sign) =>
      _client.get('/v2/lifestyle/spirit-animal/$sign');

  /// Lucky color for today by sign.
  Future<Map<String, dynamic>> luckyColorToday(String sign) =>
      _client.get('/v2/lifestyle/lucky-color-today/$sign');
}
