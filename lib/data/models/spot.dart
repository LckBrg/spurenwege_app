class Spot {
  final String id;
  final String title;
  final String city;
  final String shortDescription;
  final String longDescription;
  final String category;
  final Duration estimatedDuration;

  const Spot({
    required this.id,
    required this.title,
    required this.city,
    required this.shortDescription,
    required this.longDescription,
    required this.category,
    required this.estimatedDuration,
  });
}
