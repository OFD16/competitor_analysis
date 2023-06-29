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

late String htmlCode;

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
      final body = await res.body;
      final document = await parse(body);

      setState(() {
        htmlCode = body.toString();
      });

      var index = 0;
      var reviewText =
          await document.getElementById("review-preview-toggle-$index");
      // print('reviewText: ${reviewText!.text.trim()}');

      // var reviewUser = await document.getElementsByClassName(
      //     "wt-text-truncate.wt-text-body-small.wt-text-gray");

      // print('reviewUser: ${reviewUser[index].text}');

      // var reviewRating =
      //     document.querySelectorAll('input[name="rating"]').sublist(2);

      // print('reviewRating: ${reviewRating[index].attributes["value"]}');

      // var reviewDate = document.getElementsByClassName(
      //     "wt-text-body-small wt-text-gray wt-align-self-flex-start wt-no-wrap wt-text-right-xs wt-flex-grow-xs-1");

      // print(
      //     'reviewDate: ${DateFormat('MMM d, yyyy').parse(reviewDate[index].text)}');

      var reviewProduct = await document
          .getElementsByClassName("wt-display-flex-xs wt-pt-xs-1")
          .sublist(1);

      // print('reviewProduct: ${reviewProduct}');
      // print('reviewProduct: ${reviewProduct[3].outerHtml}');
    } catch (e) {
      print(e);
    }
  }

  void getCommentsRequest() async {
    final url = Uri.parse(
        'https://www.etsy.com/api/v3/ajax/bespoke/member/neu/specs/reviews');

    final headers = {
      'Content-Type': 'text/plain',
      // 'Content-Length': '0',
      'User-Agent': 'PostmanRuntime/7.32.3',
      'Host': '',
      //

      'Accept': '*/*',
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive',
      //
      'authority': 'www.etsy.com',
      'accept': '*/*',
      'accept-language':
          'en-XA,en;q=0.9,tr-TR;q=0.8,tr;q=0.7,en-GB;q=0.6,en-US;q=0.5',
      'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'cookie':
          'uaid=Y5Ek8zsTfxToOox5zDEDnRMYz-tjZACClLmFGjC6Wqk0MTNFyUrJ3SIxw9TV2T1QNyS00j_POL44xKcoOdIjzTEgS6mWAQA.; user_prefs=9rB1j-Y570gGHh2HEMf3Wp_YuZZjZACClLmFGjA6WikkKFJJJ680J0dHKTVPNzRYSQcoBBUxglC4iFgGAA..; fve=1688039720.0; _fbp=fb.1.1688039720856.6805171157864266; ua=531227642bc86f3b5fd7103a0c0b4fd6; _gcl_au=1.1.1069083127.1688039723; _gid=GA1.2.667656085.1688039723; _pin_unauth=dWlkPVpESXlaVFkyTURjdFpUWXlZUzAwWW1Sa0xUZ3pNR0l0WmpreU9EZGtaV0ppWlRnMA; last_browse_page=https%3A%2F%2Fwww.etsy.com%2Fshop%2FViePlanners; _dc_gtm_UA-2409779-1=1; _ga=GA1.1.1894837630.1688039723; _uetsid=d43afc80167311ee8b41757c28512ea9; _uetvid=d43b0140167311eeaf856f315edfd087; _ga_KR3J610VYM=GS1.1.1688054419.4.1.1688056874.58.0.0',
      'origin': 'https://www.etsy.com',
      'referer':
          'https://www.etsy.com/listing/1228308510/notion-template-personal-planner-notion?ga_order=most_relevant&ga_search_type=all&ga_view_type=gallery&ga_search_query=notion+planner+2023&ref=sr_gallery-1-2&pro=1&sts=1&organic_search_click=1',
      'sec-ch-ua':
          '"Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"Windows"',
      "sec-fetch-mode": "cors",
      "sec-fetch-site": "same-origin",
      "user-agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36",
      "x-csrf-token":
          "3:1688056871:3U-si0K1G6xGHeZ1_jyI84ix15tB:c35340146eb0675cb495b534c963c98064e078af814e266f18a83c42f3779865",
      "x-detected-locale": "TRY|en-US|TR",
      "x-page-guid": "f5a504d35db.14c9ca9ab1e3f00c6d55.00",
      "x-recs-primary-location":
          "https://www.etsy.com/listing/1228308510/notion-template-personal-planner-notion?ga_order=most_relevant&ga_search_type=all&ga_view_type=gallery&ga_search_query=notion+planner+2023&ref=sr_gallery-1-2&pro=1&sts=1&organic_search_click=1",
      'x-recs-primary-referrer': '',
      'X-Requested-With': 'XMLHttpRequest',
      //
    };

    const body =
        'log_performance_metrics=true&specs%5Breviews%5D%5B%5D=Etsy%5CModules%5CListingPage%5CReviews%5CApiSpec&specs%5Breviews%5D%5B1%5D%5Blisting_id%5D=1228308510&specs%5Breviews%5D%5B1%5D%5Bshop_id%5D=35583724&specs%5Breviews%5D%5B1%5D%5Brender_complete%5D=true&specs%5Breviews%5D%5B1%5D%5Bactive_tab%5D=same_listing_reviews&specs%5Breviews%5D%5B1%5D%5Bshould_lazy_load_images%5D=false&specs%5Breviews%5D%5B1%5D%5Bshould_use_pagination%5D=true&specs%5Breviews%5D%5B1%5D%5Bpage%5D=2&specs%5Breviews%5D%5B1%5D%5Bshould_show_variations%5D=false&specs%5Breviews%5D%5B1%5D%5Bis_reviews_untabbed_cached%5D=false&specs%5Breviews%5D%5B1%5D%5Bwas_landing_from_external_referrer%5D=false&specs%5Breviews%5D%5B1%5D%5Bsort_option%5D=Relevancy';

    http.post(url, headers: headers, body: body).then((response) {
      print('headeRS: ${response.headers}');
      print('body: ${response.body}');
      final csrfToken = response.headers['x-csrf-token'];
      if (csrfToken != null) {
        // Update the CSRF token in the headers
        headers['x-csrf-token'] = csrfToken;

        // Retry the request with the updated headers
        http.post(url, headers: headers, body: body).then((response) {
          print('Response status: ${response.statusCode}');
          print('Response body: ${response.body}');
        }).catchError((error) {
          print('Error: $error');
        });
      } else {
        print('CSRF token not found in the response headers');
      }
    }).catchError((error) {
      print('Error: $error');
    });
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
    getCommentsRequest();
    //fetchReviews();
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
            SelectableText(htmlCode)
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
//Request
  // void fetchReviews() async {
  //   var url = Uri.parse(
  //       'https://www.etsy.com/api/v3/ajax/bespoke/member/neu/specs/reviews');

  //   var headers = {
  //     "accept": "*/*",
  //     "accept-language":
  //         "en-XA,en;q=0.9,tr-TR;q=0.8,tr;q=0.7,en-GB;q=0.6,en-US;q=0.5",
  //     "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
  //     "sec-ch-ua":
  //         "\"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"114\", \"Google Chrome\";v=\"114\"",
  //     "sec-ch-ua-mobile": "?0",
  //     "sec-ch-ua-platform": "\"Windows\"",
  //     "sec-fetch-dest": "empty",
  //     "sec-fetch-mode": "cors",
  //     "sec-fetch-site": "same-origin",
  //     "x-csrf-token":
  //         "3:1688056871:3U-si0K1G6xGHeZ1_jyI84ix15tB:c35340146eb0675cb495b534c963c98064e078af814e266f18a83c42f3779865",
  //     "x-detected-locale": "TRY|en-US|TR",
  //     "x-page-guid": "f5a504d35db.14c9ca9ab1e3f00c6d55.00",
  //     "x-recs-primary-location":
  //         "https://www.etsy.com/listing/1228308510/notion-template-personal-planner-notion?ga_order=most_relevant&ga_search_type=all&ga_view_type=gallery&ga_search_query=notion+planner+2023&ref=sr_gallery-1-2&pro=1&sts=1&organic_search_click=1",
  //     "x-recs-primary-referrer": "",
  //     "x-requested-with": "XMLHttpRequest"
  //   };

  //   var body =
  //       "log_performance_metrics=true&specs%5Breviews%5D%5B%5D=Etsy%5CModules%5CListingPage%5CReviews%5CApiSpec&specs%5Breviews%5D%5B1%5D%5Blisting_id%5D=1228308510&specs%5Breviews%5D%5B1%5D%5Bshop_id%5D=35583724&specs%5Breviews%5D%5B1%5D%5Brender_complete%5D=true&specs%5Breviews%5D%5B1%5D%5Bactive_tab%5D=same_listing_reviews&specs%5Breviews%5D%5B1%5D%5Bshould_lazy_load_images%5D=false&specs%5Breviews%5D%5B1%5D%5Bshould_use_pagination%5D=true&specs%5Breviews%5D%5B1%5D%5Bpage%5D=2&specs%5Breviews%5D%5B1%5D%5Bshould_show_variations%5D=false&specs%5Breviews%5D%5B1%5D%5Bis_reviews_untabbed_cached%5D=false&specs%5Breviews%5D%5B1%5D%5Bwas_landing_from_external_referrer%5D=false&specs%5Breviews%5D%5B1%5D%5Bsort_option%5D=Relevancy";

  //   var response = await http.post(url, headers: headers, body: body);

  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  // }




// Column(
//               children: [
//                 // Container(
//                 //   child: Text('sfad'),
//                 // ),
//                 components.ProductCard(
//                   product: etsyObj,
//                 ),
//                 // Text('description: ${etsyObj?.description}'), //description
//               ],
//             )
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
