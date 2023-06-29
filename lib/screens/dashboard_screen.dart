import "package:fluent_ui/fluent_ui.dart";
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:web_scraper/web_scraper.dart';

import '../models/index.dart' as models;
import '../themes/constants.dart' show Constants;
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

  void getComments() async {
    try {
      String text =
          'https://www.etsy.com/listing/1228308510/notion-template-personal-planner-notion?ga_order=most_relevant&ga_search_type=all&ga_view_type=gallery&ga_search_query=notion+planner+2023&ref=sr_gallery-1-2&pro=1&sts=1&organic_search_click=1';
      Uri url = Uri.parse(text);
      var res = await http.get(url);
      final body = res.body;
      final document = parse(body);

      var index = 0;
      var reviewText = document.getElementById("review-preview-toggle-$index");
      print('reviewText: ${reviewText!.text.trim()}');

      var reviewUser = document.getElementsByClassName(
          "wt-text-truncate.wt-text-body-small.wt-text-gray");

      print('reviewUser: ${reviewUser[index].text}');

      var reviewRating =
          document.querySelectorAll('input[name="rating"]').sublist(2);

      print('reviewRating: ${reviewRating[index].attributes["value"]}');

      var reviewDate = document.getElementsByClassName(
          "wt-text-body-small wt-text-gray wt-align-self-flex-start wt-no-wrap wt-text-right-xs wt-flex-grow-xs-1");

      print(
          'reviewDate: ${DateFormat('MMM d, yyyy').parse(reviewDate[index].text)}');

      var reviewProduct = document
          .getElementsByClassName("wt-display-flex-xs wt-pt-xs-1")
          .sublist(1);

      print('reviewProduct: ${reviewProduct}');
    } catch (e) {
      print(e);
    }
  }

  String extractUrl(String url) {
    final uri = Uri.parse(url);
    return uri.path + (uri.query.isNotEmpty ? '?' + uri.query : '');
  }

  String extractTextContent(String htmlString, String cssSelector) {
    final document = parse(htmlString);
    final element = document.querySelector(cssSelector);
    return element?.text?.trim() ?? '';
  }

  List<String> extractReviewersNames(
      String htmlString, List<String> cssSelectors) {
    final document = parse(htmlString);
    List<String> textContentList = [];

    for (String selector in cssSelectors) {
      final elements = document.querySelectorAll(selector);

      for (var element in elements) {
        String textContent = element.text.trim();
        textContentList.add(textContent);
      }
    }

    return textContentList;
  }

  String extractAttribute(
      String htmlString, String cssSelector, String attributeName) {
    final document = parse(htmlString);
    final element = document.querySelector(cssSelector);
    return element?.attributes[attributeName] ?? '';
  }

  String extractDiscountRate(String htmlString, String cssSelector,
      String startDelimiter, String endDelimiter,
      {bool removeOffText = false}) {
    String discountRateText = extractTextContent(htmlString, cssSelector);
    final discountRateStartIndex = discountRateText.indexOf(startDelimiter);
    final discountRateEndIndex = discountRateText.indexOf(endDelimiter);
    String discountRate = discountRateText
        .substring(discountRateStartIndex + 1, discountRateEndIndex)
        .trim();
    if (removeOffText) {
      discountRate = discountRate.replaceAll('Off', '');
    }
    return discountRate;
  }

  String extractFormattedRating(String htmlString, String cssSelector) {
    final document = parse(htmlString);
    final ratingElement = document.querySelector(cssSelector);
    final rating = ratingElement?.attributes['data-rating'];
    final parsedRating = rating != null ? int.tryParse(rating) : null;
    final formattedRating = parsedRating != null
        ? '${5 - parsedRating} stars'
        : 'Rating Not Available';
    return formattedRating;
  }

  List<int> extractRatingsList(String htmlString, String cssSelector) {
    final document = parse(htmlString);
    final ratingElements = document.querySelectorAll(cssSelector);
    final ratings = <int>[];
    for (var element in ratingElements) {
      final ratingText = element.text;
      final rating = int.tryParse(ratingText.split(' ')[0]);
      if (rating != null) {
        ratings.add(rating);
      }
    }
    return ratings;
  }

  List<String> extractReviewTexts(String htmlString, String cssSelector) {
    final document = parse(htmlString);
    final reviewElements = document.querySelectorAll(cssSelector);
    final reviewTexts = <String>[];
    for (var i = 0; i < 4 && i < reviewElements.length; i++) {
      final element = reviewElements[i];
      final reviewText = element.text.trim();
      if (reviewText.isNotEmpty && !reviewText.contains(' out of 5 stars')) {
        reviewTexts.add(reviewText);
      }
    }
    return reviewTexts;
  }

  List<DateTime> extractDates(String htmlString, String cssSelector) {
    final document = parse(htmlString);
    final dateElements = document.querySelectorAll(cssSelector);
    final dates = <DateTime>[];

    final dateFormat = DateFormat('MMM d, yyyy');

    for (var element in dateElements) {
      final dateText = element.text.trim();
      final date = dateFormat.parse(dateText);
      dates.add(date);
    }

    return dates;
  }

  Future<dynamic> fetchDocument(String continueURL) async {
    if (continueURL.isNotEmpty) {
      setState(() {
        loading = true;
      });
      if (await webScraper.loadWebPage(continueURL)) {
        final res = webScraper.getPageContent();

        var title = extractTextContent(res, Constants.titleClassName); //Başlık
        var description =
            extractTextContent(res, Constants.descriptionClassName); //Açıklama
        var price =
            extractTextContent(res, Constants.priceClassName); //Tam fiyat
        var discountPrice =
            extractTextContent(res, Constants.discountPriceClassName)
                .replaceAll(RegExp(r'^Price:\s*'), ''); //Indirimli fiyat
        var shopOwnerName = extractTextContent(
            res, Constants.shopOwnerNameClassName); //Mağaza sahibinin adı
        var shopName =
            extractTextContent(res, Constants.shopNameClassName); //Mağaza adı
        var shopCommentCount = extractTextContent(
            res, Constants.shopReviewCountClassName); //Mağaza yorum sayısı
        var productCommentCount = extractTextContent(
            res, Constants.productReviewCountClassName); //Ürün yorum sayısı
//-----------------------------------------------------------------
        var shopImageUrl = extractAttribute(
            res, Constants.shopImageUrlClassName, 'src'); //Mağaza resim linki
        var productImageUrl = extractAttribute(
            res,
            Constants.productFirstImageUrlClassName,
            'src'); //Ürünün ilk resim linki
        var shopUrl = extractAttribute(
            res, Constants.shopUrlClassName, 'href'); //Mağazanın linki
//-----------------------------------------------------------------
        var discountRate = extractDiscountRate(
            res, Constants.discountRateClassName, '(', ')',
            removeOffText: true); //Indirim oranı
//-----------------------------------------------------------------
        // //Reviews
//-----------------------------------------------------------------
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
      }

      setState(() {
        loading = false;
      });
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    // fetchDocument();
    getComments();
  }

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
          const SizedBox(height: 20),
          if (!loading)
            Column(
              children: [
                // Container(
                //   child: Text('sfad'),
                // ),
                components.ProductCard(
                  product: etsyObj,
                ),
                // Text('description: ${etsyObj?.description}'), //description
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: ProgressRing(),
                )
              ],
            ),
        ],
      ),
    );
  }
}
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

//         //-----------------------------------------------------------------
//         //İlk Review
//         var reviewerName = extractTextContent(
//             res, Constants.reviewerNameClassName); //Yorum yapanın adı

//         var reviewDate = extractTextContent(
//             res, Constants.reviewDateClassName); //Yorum yapma tarihi

//         var reviewText = extractTextContent(
//             res, Constants.reviewTextClassName); //Yorum metni

//         var purchasedItem = extractTextContent(
//             res, Constants.reviewerPurchasedItem); //Yorumdaki alınan ürün

//         String extractRating(String htmlString, String cssSelector) {
//           final document = parse(htmlString);
//           final ratingElement = document.querySelector(cssSelector);
//           final rating = ratingElement?.attributes['data-rating'];
//           final parsedRating = rating != null ? int.tryParse(rating) : null;
//           final formattedRating = parsedRating != null
//               ? '${5 - parsedRating} stars'
//               : 'Rating Not Available';
//           return formattedRating;
//         }

//         var reviewRating = extractRating(res, Constants.reviewRate);

// //-----------------------------------------------------------------
// çalışıyor ama 2 kez çalıştırınca fonksiyonu düzgün çalışıyor. İlk seferinde hep eksik getiriyor.
// void extractReviewersUserNameAndProfileUrls(String html) async {
//   final document = await parse(html);
//   final linkElements =
//       document.querySelectorAll('a[data-transaction-id]');
//   print('linkElements: $linkElements');

//   if (linkElements.isNotEmpty) {
//     for (final linkElement in linkElements) {
//       final profileUrl = linkElement.attributes['href'] ?? '';
//       final userName = linkElement.text.trim().replaceAll('\n', '');

//       List<String> parts = userName.split(RegExp(r'\s+'));
//       String username = '';
//       String rate = '';

//       if (parts.length >= 5) {
//         username = parts.sublist(0, parts.length - 5).join(' ');
//         rate = parts.sublist(parts.length - 5).join(' ');
//       } else if (parts.length > 0) {
//         username = parts[0];
//       }

//       print('-----------------------------------------');
//       print('profileUrl: ${profileUrl.trim()}');
//       print('Username: $username');
//       print('Rate: $rate');
//     }
//   }
// }
// //-----------------------------------------------------------------
// var productTitlesAndUrls = extractReviewersUserNameAndProfileUrls(res);

// print('newcdoc $newdoc');
// // for (var doc in newdoc) {
// //   print('doc: ${doc.outerHtml}');
// // }
// // print('doc: ${newdoc[1].outerHtml}');
// var reppp =
//     'wt-text-link wt-text-caption wt-text-truncate wt-text-gray wt-width-half wt-pb-xs-1 wt-pb-md-0'
//         .replaceAll(' ', '.');
// var elements = html.querySelectorAll(reppp);
// print('elements $elements');
// print(elements);
// print(elements[0].outerHtml);

// List<String> cssSelectors = [
//   Constants
//       .reviewsUsernamesListClassName, //Yorumlardaki usernamelerin listesi
// ];
// List<String> extractedTextList =
//     extractReviewersNames(res, cssSelectors);
// print('extractedTextList: $extractedTextList');
// List<int> ratings = extractRatingsList(
//     res,
//     Constants
//         .reviewsRateListClassName); //Yorumlardaki userların rateingleri
// print('ratings: $ratings');
// List<String> reviewTexts = extractReviewTexts(
//     res, Constants.reviewTextsClassName); //Yorumlardaki reviewslar
// print('reviewTexts: $reviewTexts');
// List<DateTime> dates =
//     extractDates(res, Constants.reviewDatesClassName);
// print('dates: $dates');
