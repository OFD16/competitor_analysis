import 'package:fluent_ui/fluent_ui.dart';
import '../../models/index.dart' as models;

class ReviewCard extends StatelessWidget {
  final models.Review? review;
  const ReviewCard({super.key, this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      margin: const EdgeInsets.all(10),
      child: ListTile(
          title: Text(
            review?.text ?? '?',
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
            children: [
              Text(review?.date.toString() ?? 'date'),
            ],
          )),
    );
  }
}
