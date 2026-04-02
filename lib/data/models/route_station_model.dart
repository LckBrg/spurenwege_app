import 'spot.dart';

class RouteStationModel {
  final Spot spot;
  final String storyIntro;
  final String riddleQuestion;
  final List<String> acceptedAnswers;
  final List<String> hints;

  const RouteStationModel({
    required this.spot,
    required this.storyIntro,
    required this.riddleQuestion,
    required this.acceptedAnswers,
    required this.hints,
  });

  bool matchesAnswer(String value) {
    final normalizedInput = _normalize(value);

    if (normalizedInput.isEmpty) {
      return false;
    }

    for (final answer in acceptedAnswers) {
      if (_normalize(answer) == normalizedInput) {
        return true;
      }
    }

    return false;
  }

  String get primaryAnswer {
    if (acceptedAnswers.isEmpty) {
      return '';
    }
    return acceptedAnswers.first;
  }

  String _normalize(String value) {
    var text = value.trim().toLowerCase();

    text = text
        .replaceAll('ä', 'ae')
        .replaceAll('ö', 'oe')
        .replaceAll('ü', 'ue')
        .replaceAll('ß', 'ss');

    text = text.replaceAll(RegExp(r'[^a-z0-9\s]'), ' ');
    text = text.replaceAll(RegExp(r'\s+'), ' ').trim();

    const removablePrefixes = [
      'der ',
      'die ',
      'das ',
      'ein ',
      'eine ',
      'am ',
      'an der ',
      'an dem ',
      'im ',
      'in der ',
      'in dem ',
      'beim ',
      'zum ',
      'zur ',
    ];

    bool changed = true;
    while (changed) {
      changed = false;
      for (final prefix in removablePrefixes) {
        if (text.startsWith(prefix)) {
          text = text.substring(prefix.length).trim();
          changed = true;
        }
      }
    }

    return text;
  }
}