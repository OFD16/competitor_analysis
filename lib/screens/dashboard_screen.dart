import "package:fluent_ui/fluent_ui.dart";

import 'package:web_scraper/web_scraper.dart';

import 'package:html/parser.dart' show parse;

import '../models/index.dart' as models;
import '../widgets/index.dart' as components;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

final webScraper = WebScraper('https://www.etsy.com/');

late String continueURL;

// =
//     // 'listing/1228308510/notion-template-personal-planner-notion?click_key=39c4fcf6f889d88a2698c2ba8c54932026fb8902%3A1228308510&click_sum=9e5b1f00&ref=shop_home_feat_1&pro=1&sts=1';
//     'listing/1260554960/notion-template-student-planner-academic?click_key=26f1b7030175d487b705f77fa4b4eda9904d0370%3A1260554960&click_sum=b7e6daf6&ref=related-2&pro=1&sts=1';

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController urlController = TextEditingController(
      text:
          'https://www.etsy.com/listing/1228308510/notion-template-personal-planner-notion?ga_order=most_relevant&ga_search_type=all&ga_view_type=gallery&ga_search_query=notion+planner+2023&ref=sr_gallery-1-2&pro=1&sts=1&organic_search_click=1');
  bool loading = false;

  late models.Product etsyObj = models.Product();

  // models.Product etsyObj = {
  //   "title": "",
  //   "description": "",
  //   "price": "",
  //   "discountPrice": "",
  //   "discountRate": "",
  //   "imageUrl": "",
  //   "shopOwnerName": "",
  //   "shopUrl": "",
  //   "shopName": "",
  //   "productCommentCount": "",
  //   "shopCommentCount": "",
  //   "reviews": [],
  // };

  String extractUrl(String url) {
    final uri = Uri.parse(url);
    return uri.path + (uri.query.isNotEmpty ? '?' + uri.query : '');
  }

  Future<dynamic> fetchDocument(String continueURL) async {
    if (continueURL.isNotEmpty) {
      setState(() {
        loading = true;
      });
      if (await webScraper.loadWebPage(continueURL)) {
        final res = webScraper.getPageContent();
        final document = parse(res);

        //final element = document.querySelector('$tagName.$className');

        // Extract the comment data.
        // String className14 = 'div[data-test-id="Comment"]';
        // var commentElements = document.querySelectorAll(className14);
        // List<String> comments = [];
        // for (var commentElement in commentElements) {
        //   var comment = commentElement.querySelector('.Comment-text')?.text;
        //   comments.add(comment!);
        // }

        // // Print the comment data.
        // print(comments);

        //Başlık
        String className12 = 'h1[data-buy-box-listing-title="true"]';
        var titleElement = document.querySelector(className12);
        var title = titleElement?.text.trim();

        //Açıklama
        String className3 = 'wt-text-body-01.wt-break-word';
        final descriptionElement = document.querySelector('p.$className3');
        final description = descriptionElement?.text.trim();

        //Tam fiyat
        String className2 = 'wt-text-strikethrough';
        final priceElement = document.querySelector('span.$className2');
        final price = priceElement?.text.trim();

        //Indirimli fiyat
        String className5 = 'wt-text-title-03';
        final discountPriceElement = document.querySelector('p.$className5');
        final discountPrice = discountPriceElement?.text
            .trim()
            .replaceAll(RegExp(r'^Price:\s*'), '');

        //Indirim oranı
        String className4 = 'wt-text-caption.wt-text-gray';
        final discountRateElement = document.querySelector('p.$className4');
        final discountRateText = discountRateElement?.text.trim();
        final discountRateStartIndex = discountRateText!.indexOf('(');
        final discountRateEndIndex = discountRateText.indexOf(')');
        final discountRate = discountRateText
            .substring(discountRateStartIndex + 1, discountRateEndIndex)
            .trim();

        //Mağaza sahibi resmi
        String className8 = 'div.wt-thumbnail-larger img';
        var imageUrlElement = document.querySelector(className8);
        var shopImageUrl = imageUrlElement?.attributes['src'];

        //Ürünün ilk resmi
        String className16 = 'img';
        var productImageUrlElement = document.querySelector(className16);
        var productImageUrl = productImageUrlElement?.attributes['src'];

        //Mağaza sahibinin adı
        String className9 = 'p.wt-text-body-03.wt-line-height-tight.wt-mb-lg-1';
        var nameElement = document.querySelector(className9);
        var shopOwnerName = nameElement?.text;

        //Mağazanın urli ve ismi
        String className10 = 'a.wt-text-link[href*="shop"]';
        var containerElement = document.querySelector(className10);
        var shopUrl = containerElement?.attributes['href'];
        var shopName = containerElement?.text;

        String className15 =
            'div.wt-content-toggle--truncated-inline-multi.wt-break-word wt-text-body-01"]';
        var reviewsElement = document.querySelector(className15);
        var reviews = reviewsElement?.text;

        //Ürün yorum sayısı
        String className11 = 'span.wt-badge.wt-badge--status-02.wt-ml-xs-2';
        var productCommentCountElement = document.querySelector(className11);
        var productCommentCount = productCommentCountElement?.text.trim();

        //Mağaza yorum sayısı
        String className13 =
            'span.wt-badge.wt-badge--status-02.wt-ml-xs-2.wt-nowrap';
        var shopCommentCountElement = document.querySelector(className13);
        var shopCommentCount = shopCommentCountElement?.text.trim();

        // print('//////////////////////////////////');
        // print("reviewsElement $reviewsElement");
        // print("reviews $reviews");
        // print('//////////////////////////////////');

        setState(() {
          loading = false;
          etsyObj.title = title;
          etsyObj.description = description;
          etsyObj.discountPrice = discountPrice;
          etsyObj.discountRate = discountRate;
          etsyObj.price = price;
          etsyObj.shopImageUrl = shopImageUrl;
          etsyObj.productImageUrl = productImageUrl;
          etsyObj.productCommentCount = productCommentCount;
          etsyObj.shopCommentCount = shopCommentCount;
          etsyObj.shopName = shopName;
          etsyObj.shopOwnerName = shopOwnerName;
          etsyObj.shopUrl = shopUrl;
        });

        return document;
      }

      setState(() {
        loading = false;
      });
      return null;
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchDocument();
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormBox(
                  controller: urlController,
                ),
              ),
              const SizedBox(width: 10),
              Button(
                child: const Text(
                  'Analiz Et',
                  style: TextStyle(height: 1.8),
                ),
                onPressed: () {
                  setState(() {
                    continueURL = extractUrl(urlController.text);
                  });
                  fetchDocument(continueURL);
                },
              ),
            ],
          ),
          if (!loading)
            Column(
              children: [
                // Container(
                //   child: Text('sfad'),
                // ),
                components.ProductCard(),
                Text('title: ${etsyObj.title}'), // title
                // Text('description: ${etsyObj?.description}'), //description
                Text('price: ${etsyObj.price}'), // price
                Text('discountPrice: ${etsyObj.discountPrice}'), //discountprice
                Text('discountRate: ${etsyObj.discountRate}'), //discounted rate
                Text('imageUrl: ${etsyObj.productImageUrl}'), // imageUrl
                Text('shopName: ${etsyObj.shopName}'), // shopName
                Text(
                    'shopOwnerName: ${etsyObj.shopOwnerName}'), // shopOwnerName
                Text('shopUrl: ${etsyObj.shopUrl}'), // shopUrl
                Text(
                    'shopCommentCount: ${etsyObj.shopCommentCount}'), // shopCommentCount
                Text(
                    'productCommentCount: ${etsyObj.productCommentCount}'), // productCommentCount
                Text(
                    'reviews.length: ${etsyObj.reviews.length}'), // productCommentCount
              ],
            )
          else
            const ProgressRing(),
        ],
      ),
    );
  }
}
