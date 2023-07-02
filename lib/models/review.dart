class Review {
  final String text;
  final double rating;
  final String title;
  final String path;
  final DateTime date;
  final String reviewer;
  final List<Map<String, dynamic>>? subRatings;

  Review({
    required this.text,
    required this.rating,
    required this.title,
    required this.path,
    required this.date,
    required this.reviewer,
    required this.subRatings,
  });
}
