import '../models/spot.dart';

const demoSpots = [
  Spot(
    id: 'schattenburg',
    title: 'Schattenburg',
    city: 'Feldkirch',
    shortDescription: 'Die bekannte Burg über der Altstadt.',
    longDescription:
        'Die Schattenburg thront über Feldkirch und war über Jahrhunderte ein Symbol für Macht und Schutz. Von hier aus hatte man die Stadt und das Tal im Blick.',
    category: 'Geschichte',
    estimatedDuration: Duration(minutes: 20),
    imagePath: 'assets/images/spots/schattenburg.jpg',
  ),
  Spot(
    id: 'marktplatz',
    title: 'Marktplatz Feldkirch',
    city: 'Feldkirch',
    shortDescription: 'Zentrum des alten Handels.',
    longDescription:
        'Am Marktplatz trafen sich Händler, Reisende und Bewohner. Hier begann das Leben der Stadt – und viele Geschichten nahmen hier ihren Anfang.',
    category: 'Stadt',
    estimatedDuration: Duration(minutes: 15),
    imagePath: 'assets/images/spots/marktplatz.jpg',
  ),
  Spot(
    id: 'bludenz_altstadt',
    title: 'Altstadt Bludenz',
    city: 'Bludenz',
    shortDescription: 'Enge Gassen und alpine Atmosphäre.',
    longDescription:
        'Die Altstadt von Bludenz wirkt ruhig, doch zwischen den Mauern liegen viele Spuren vergangener Wege und Geschichten.',
    category: 'Stadt',
    estimatedDuration: Duration(minutes: 15),
    imagePath: 'assets/images/spots/bludenz.jpg',
  ),
];