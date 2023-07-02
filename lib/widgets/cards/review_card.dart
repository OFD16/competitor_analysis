import 'package:fluent_ui/fluent_ui.dart';
import '../../models/index.dart' as models;
import 'package:intl/intl.dart' show DateFormat;

class ReviewCard extends StatelessWidget {
  final models.Review? review;
  final int order;
  const ReviewCard({super.key, this.review, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(
          review!.text,
          maxLines: 3,
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('reviewer: ${review?.reviewer ?? '?'}'),
            Text('rating: ${review?.rating ?? '?'}'),
            Text('title: ${review?.title ?? '?'}'),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('MM/dd/yyyy').format(review?.date ?? DateTime.now()),
            ),
            Text('#$order'),
            if (review!.subRatings!.isNotEmpty)
              Column(
                children: [
                  for (var subRating in review!.subRatings!)
                    if (subRating.isNotEmpty)
                      Text('${subRating['subRating']}: ${subRating['rate']}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
