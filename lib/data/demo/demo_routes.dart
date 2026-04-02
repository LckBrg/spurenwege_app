import '../models/route_model.dart';
import '../models/route_step_model.dart';

final List<RouteModel> demoRoutes = [
  RouteModel(
    id: 'feldkirch_stiller_auftakt',
    title: 'Feldkirch – Der stille Auftakt',
    city: 'Feldkirch',
    shortDescription:
        'Ein atmosphärischer Einstieg zwischen offenem Stadtleben, Höhe und stiller Beobachtung.',
    longDescription:
        'Diese Route ist als erster echter Spurenwege-Einstieg gedacht. Sie zeigt nicht einfach Orte, sondern führt dich Schritt für Schritt durch eine Stimmung. Du beginnst im offenen Raum des Alltags. Danach verdichtet sich die Wahrnehmung. Die Route verrät dir ihre Stationen nicht im Voraus. Du musst sie dir erspielen.',
    durationLabel: '45–60 min',
    difficulty: 'Leicht bis mittel',
    focus: 'Geschichte & Atmosphäre',
    isPremium: false,
    startImage: 'assets/images/spots/marktplatz.jpg',
    tier: RouteTier.teaser,
    mood: 'Ruhig, dicht, entdeckend',
    steps: [
      RouteStepModel(
        id: 'feldkirch_step_1',
        storyText:
            'Am Anfang wirkt alles offen. Menschen gehen vorbei, Stimmen vermischen sich, Wege kreuzen sich. Genau hier beginnt deine Spur. Nicht an einem geheimen Ort, sondern mitten im sichtbaren Leben der Stadt. Doch der nächste Zielpunkt liegt nicht offen vor dir. Du musst ihn erkennen.',
        riddleQuestion:
            'Suche den Ort, der als offenes Zentrum des alten städtischen Lebens gilt. Wo trafen sich Handel, Alltag und Bewegung?',
        acceptedAnswers: [
          'Marktplatz',
          'Marktplatz Feldkirch',
          'Feldkircher Marktplatz',
        ],
        hints: [
          'Gesucht ist kein Turm und keine Burg.',
          'Es ist ein offener Platz im Herzen der Stadt.',
          'Die Lösung ist: Marktplatz Feldkirch.',
        ],
        revealedLocationTitle: 'Nächstes Ziel: Schattenburg',
        revealedLocationDescription:
            'Gut. Du hast den offenen Anfang erkannt. Jetzt führt dich die Spur dorthin, wo sich der Blick verändert. Gehe weiter zur Schattenburg – dorthin, wo Höhe, Mauern und Distanz eine andere Wirkung erzeugen.',
      ),
      RouteStepModel(
        id: 'feldkirch_step_2',
        storyText:
            'Mit der Höhe verändert sich auch die Wahrnehmung. Unten war Bewegung. Hier oben wirkt alles langsamer, dichter, beobachteter. Manche Orte müssen nichts erklären – sie tragen ihre Wirkung allein durch ihre Präsenz.',
        riddleQuestion:
            'Welcher erhöhte Ort über Feldkirch steht für Überblick, Schutz und geschichtliche Dichte?',
        acceptedAnswers: [
          'Schattenburg',
          'die Schattenburg',
          'Burg Schattenburg',
          'Schattenburg Feldkirch',
        ],
        hints: [
          'Gesucht ist kein Platz.',
          'Der Ort liegt über der Stadt.',
          'Die Lösung ist: Schattenburg.',
        ],
        revealedLocationTitle: 'Route abgeschlossen',
        revealedLocationDescription:
            'Du hast die zweite Spur gelöst. Für die erste veröffentlichbare Version endet die Route hier bewusst kompakt. Später können an dieser Stelle weitere versteckte Schritte folgen.',
      ),
    ],
  ),
  RouteModel(
    id: 'schattenburg_perspektive',
    title: 'Schattenburg – Über der Stadt',
    city: 'Feldkirch',
    shortDescription:
        'Eine kurze Route über Perspektive, Distanz und die Wirkung eines erhöhten Ortes.',
    longDescription:
        'Diese Route konzentriert sich stärker auf die Schattenburg als Stimmungsträger. Sie ist kompakt, direkt und bewusst dichter angelegt. Weniger Strecke, mehr Atmosphäre.',
    durationLabel: '20–30 min',
    difficulty: 'Leicht',
    focus: 'Burg & Wahrnehmung',
    isPremium: false,
    startImage: 'assets/images/spots/schattenburg.jpg',
    tier: RouteTier.teaser,
    mood: 'Erhöht, still, konzentriert',
    steps: [
      RouteStepModel(
        id: 'schattenburg_step_1',
        storyText:
            'Nicht jeder Ort wirkt durch Lautstärke. Manche wirken durch Lage. Wenn sich der Blick hebt, verändert sich auch das Gefühl für die Stadt unter dir.',
        riddleQuestion:
            'Welche Burg über Feldkirch bildet den Ausgangspunkt dieser Route?',
        acceptedAnswers: [
          'Schattenburg',
          'die Schattenburg',
          'Burg Schattenburg',
        ],
        hints: [
          'Es ist eine Burg, kein Platz.',
          'Sie liegt über der Altstadt.',
          'Die Lösung ist: Schattenburg.',
        ],
        revealedLocationTitle: 'Route abgeschlossen',
        revealedLocationDescription:
            'Diese kurze Teaser-Route endet hier. Sie zeigt, wie Spurenwege auch mit wenigen, aber gezielt gesetzten Schritten wirken kann.',
      ),
    ],
  ),
  RouteModel(
    id: 'bludenz_spuren_der_altstadt',
    title: 'Bludenz – Spuren der Altstadt',
    city: 'Bludenz',
    shortDescription:
        'Eine ruhige Route durch enge Gassen, alte Wege und die stille Präsenz der Altstadt.',
    longDescription:
        'Diese Route ist zurückhaltender und weniger dramatisch. Genau das ist ihre Stärke. Sie zeigt, wie Atmosphäre nicht durch Spektakel entsteht, sondern durch Struktur, Dichte und das Gefühl, dass ein Ort lange geblieben ist.',
    durationLabel: '20–30 min',
    difficulty: 'Leicht',
    focus: 'Altstadt & Stimmung',
    isPremium: false,
    startImage: 'assets/images/spots/bludenz.jpg',
    tier: RouteTier.standard,
    mood: 'Ruhig, dicht, nachwirkend',
    steps: [
      RouteStepModel(
        id: 'bludenz_step_1',
        storyText:
            'Die Altstadt wirkt nicht laut. Sie zwingt sich nicht auf. Aber wer langsamer wird, merkt schnell, dass solche Orte ihre Wirkung nicht verloren haben. Sie tragen sie nur stiller.',
        riddleQuestion:
            'Welcher historische Stadtbereich bildet das Zentrum dieser Route?',
        acceptedAnswers: [
          'Altstadt Bludenz',
          'die Altstadt Bludenz',
          'Bludenzer Altstadt',
          'Altstadt',
        ],
        hints: [
          'Gesucht ist kein einzelnes Gebäude.',
          'Der Ort gehört zu Bludenz.',
          'Die Lösung ist: Altstadt Bludenz.',
        ],
        revealedLocationTitle: 'Route abgeschlossen',
        revealedLocationDescription:
            'Diese kompakte Route endet hier. Später kann aus ihr eine längere, dichtere Altstadt-Erlebnisroute werden.',
      ),
    ],
  ),
  RouteModel(
    id: 'marktplatz_wo_wege_beginnen',
    title: 'Marktplatz – Wo Wege beginnen',
    city: 'Feldkirch',
    shortDescription:
        'Ein kurzer Einstieg in das offene Herz der Stadt – alltagsnah, ruhig und bewusst gesetzt.',
    longDescription:
        'Diese sehr kompakte Route ist als niedrigschwelliger Einstieg gedacht. Sie zeigt in kleiner Form, wie Spurenwege aus Stimmung, Blickführung und Rätselmechanik ein Erlebnis macht.',
    durationLabel: '10–15 min',
    difficulty: 'Leicht',
    focus: 'Stadt & Einstieg',
    isPremium: false,
    startImage: 'assets/images/spots/marktplatz.jpg',
    tier: RouteTier.teaser,
    mood: 'Offen, urban, einladend',
    steps: [
      RouteStepModel(
        id: 'marktplatz_step_1',
        storyText:
            'Bevor eine Spur geheim wird, beginnt sie oft sichtbar. Hier, wo sich Wege kreuzen und Menschen kommen und gehen, startet das Erlebnis bewusst im Offenen.',
        riddleQuestion:
            'Welcher zentrale Platz in Feldkirch steht für offenen Anfang, Handel und Bewegung?',
        acceptedAnswers: [
          'Marktplatz',
          'Marktplatz Feldkirch',
          'Feldkircher Marktplatz',
        ],
        hints: [
          'Gesucht ist ein Platz.',
          'Er liegt zentral in Feldkirch.',
          'Die Lösung ist: Marktplatz Feldkirch.',
        ],
        revealedLocationTitle: 'Route abgeschlossen',
        revealedLocationDescription:
            'Du hast den Einstieg gelöst. Diese kurze Teaser-Route endet hier bewusst einfach.',
      ),
    ],
  ),
  RouteModel(
    id: 'feldkirch_gasserplatz_stille_spur',
    title: 'Gasserplatz – Die stille Spur',
    city: 'Feldkirch',
    shortDescription:
        'Eine konzentrierte Route über einen unscheinbaren Ort und die Wirkung stiller Geschichte.',
    longDescription:
        'Diese Route soll später eine dichtere, ernstere Spur werden. Sie lebt nicht vom Offensichtlichen, sondern davon, dass manche Orte ihre Geschichte nicht zeigen, sondern nur bewahren.',
    durationLabel: '25–35 min',
    difficulty: 'Mittel',
    focus: 'Stille Orte & Wirkung',
    isPremium: true,
    startImage: 'assets/images/spots/marktplatz.jpg',
    tier: RouteTier.premium,
    mood: 'Still, ernst, nachwirkend',
    steps: [
      RouteStepModel(
        id: 'gasserplatz_step_1',
        storyText:
            'Nicht jeder bedeutende Ort fällt sofort auf. Manche bleiben im Alltag beinahe unsichtbar – und genau das macht sie stärker.',
        riddleQuestion:
            'Welcher unscheinbare Ort in Feldkirch steht hier im Zentrum der Spur?',
        acceptedAnswers: [
          'Gasserplatz',
          'der Gasserplatz',
        ],
        hints: [
          'Gesucht ist kein Turm und keine Burg.',
          'Es ist ein eher stiller Platz.',
          'Die Lösung ist: Gasserplatz.',
        ],
        revealedLocationTitle: 'Route abgeschlossen',
        revealedLocationDescription:
            'Diese Premium-Demoroute endet hier noch sehr kompakt. Später kann daraus eine deutlich stärkere Version mit mehr Tiefe entstehen.',
      ),
    ],
  ),
];