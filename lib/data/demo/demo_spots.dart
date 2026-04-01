import '../models/spot.dart';

const List<Spot> demoSpots = [
  Spot(
    id: 'feldkirch-gasserplatz',
    title: 'Gasserplatz',
    city: 'Feldkirch',
    shortDescription: 'Ein geschichtsträchtiger Ort mit düsterem Hintergrund.',
    longDescription:
        'Der Gasserplatz in Feldkirch ist ein Ort, der auf den ersten Blick '
        'unscheinbar wirken kann. Gerade solche Plätze sind für Spurenwege '
        'interessant: Orte, an denen Geschichte nicht laut, sondern leise '
        'weiterlebt. Hier könnte später ein Story-Spot mit Text, Audio und '
        'historischem Kontext entstehen.',
    category: 'Geschichte',
    estimatedDuration: Duration(minutes: 20),
  ),
  Spot(
    id: 'feldkirch-schattenburg',
    title: 'Schattenburg',
    city: 'Feldkirch',
    shortDescription: 'Die Schattenburg prägt das Stadtbild von Feldkirch.',
    longDescription:
        'Die Schattenburg gehört zu den bekanntesten Wahrzeichen Feldkirchs. '
        'Für Spurenwege eignet sich dieser Spot ideal, weil sich hier '
        'Geschichte, Aussicht, Atmosphäre und Erzählung gut verbinden lassen. '
        'Später können wir hier Stationen, Hinweise und kleine Erlebnisinhalte '
        'einbauen.',
    category: 'Sehenswürdigkeit',
    estimatedDuration: Duration(minutes: 35),
  ),
  Spot(
    id: 'bludenz-altstadt',
    title: 'Altstadt Bludenz',
    city: 'Bludenz',
    shortDescription:
        'Altstadtflair, Geschichte und viele mögliche Geschichten.',
    longDescription:
        'Die Altstadt von Bludenz bietet sich für eine entdeckungsbasierte '
        'Route sehr gut an. Enge Gassen, markante Plätze und historische '
        'Bezüge machen solche Orte ideal für kleine Erlebnisstationen mit '
        'Audio, Rätseln oder erzählerischen Elementen.',
    category: 'Altstadt',
    estimatedDuration: Duration(minutes: 30),
  ),
];
