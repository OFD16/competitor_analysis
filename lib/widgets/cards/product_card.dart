import 'package:fluent_ui/fluent_ui.dart';
import '../../models/index.dart' as models;

class ProductCard extends StatelessWidget {
  final models.Product? product;
  const ProductCard({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(
                product?.productImageUrl ??
                    'https://thumbs.dreamstime.com/b/photo-camera-line-icon-image-photography-sign-picture-placeholder-symbol-quality-design-element-linear-style-photo-camera-icon-219079286.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            product?.title ?? '?',
            maxLines: 1,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Fiyat: ${product?.price ?? '?'}'),
              product!.discountPrice != ''
                  ? Text('İndirim Oranı: ${product?.discountRate ?? '?'}')
                  : const Text(''),
              product!.discountPrice != ''
                  ? Text('İndirimli Fiyat: ${product?.discountPrice ?? '?'}')
                  : const Text(''),
            ],
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(product?.shopImageUrl ??
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSJO1om5yIuoyoGVJQygoHQpZ7ABQHVNBr9drTd8z9EppOkpHGBTkBbEMILO-ygF8ab9Q&usqp=CAU'),
              ),
              Text(product?.shopName ?? '?'),
            ],
          )),
    );
  }
}
