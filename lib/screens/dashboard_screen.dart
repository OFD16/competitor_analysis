import 'dart:convert';

import 'package:competitor_analysis/services/api_service.dart';
import 'package:competitor_analysis/widgets/cards/product_card.dart';
import "package:fluent_ui/fluent_ui.dart";
import 'package:http/http.dart';

import '../utils/index.dart' as utils;
import '../models/index.dart' as models;
import '../themes/constants.dart' show Constants;
import 'package:intl/intl.dart' show DateFormat;
import 'package:html/parser.dart' show parse;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

const mainUrl = 'https://www.etsy.com/';

String? shopId = '';
String? listingId = '';
String? continueURL = '';
double? pageCount = 0;

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController urlController = TextEditingController(
      text:
          'https://www.etsy.com/listing/1228308510/notion-template-personal-planner-notion?ga_order=most_relevant&ga_search_type=all&ga_view_type=gallery&ga_search_query=notion+planner+2023&ref=sr_gallery-1-2&pro=1&sts=1&organic_search_click=1');
  bool loading = false;

  late models.Product etsyObj = models.Product();

  models.Product product = models.Product();

  List<models.Review> reviewList = [];

  Future getUrlDocument(String continueURL) async {
    setState(() {
      loading = true;
      continueURL = utils.Extractter().extractUrl(urlController.text);
    });
    if (continueURL.isNotEmpty) {
      Response res = await ApiService().getHtmlDocument(continueURL);

      var document = parse(res.body);

      var newShopId = document
          .querySelectorAll('div[data-shop-id]')[0]
          .attributes["data-shop-id"];

      var newListingId = document
          .querySelectorAll('div[data-listing-id]')[0]
          .attributes["data-listing-id"];

      var title = utils.Extractter()
          .extractTextContent(document, Constants.titleClassName);

      var description = utils.Extractter().extractTextContent(
          document, Constants.descriptionClassName); //Açıklama

      var price = utils.Extractter()
          .extractTextContent(document, Constants.priceClassName); //Tam fiyat

      var discountPrice = utils.Extractter()
          .extractTextContent(document, Constants.discountPriceClassName)
          .replaceAll(RegExp(r'^Price:\s*'), ''); //Indirimli fiyat

      var shopOwnerName = utils.Extractter().extractTextContent(
          document, Constants.shopOwnerNameClassName); //Mağaza sahibinin adı

      var shopName = utils.Extractter().extractTextContent(
          document, Constants.shopNameClassName); //Mağaza adı

      var shopCommentCount = utils.Extractter().extractTextContent(
          document, Constants.shopReviewCountClassName); //Mağaza yorum sayısı

      var productCommentCount = utils.Extractter().extractTextContent(
          document, Constants.productReviewCountClassName); //Ürün yorum sayısı

      var shopImageUrl = utils.Extractter().extractAttribute(document,
          Constants.shopImageUrlClassName, 'src'); //Mağaza resim linki

      var productImageUrl = utils.Extractter().extractAttribute(
          document,
          Constants.productFirstImageUrlClassName,
          'src'); //Ürünün ilk resim linki

      var shopUrl = utils.Extractter().extractAttribute(
          document, Constants.shopUrlClassName, 'href'); //Mağazanın linki

      var discountRate = utils.Extractter().extractDiscountRate(
          document, Constants.discountRateClassName, '(', ')',
          removeOffText: true); //Indirim oranı

      setState(() {
        pageCount = (int.parse(productCommentCount) / 4.0);
        print('pagecount $pageCount');
      });

      product = models.Product(
          title: title,
          description: description,
          price: price,
          discountPrice: discountPrice,
          shopOwnerName: shopOwnerName,
          shopName: shopName,
          shopCommentCount: shopCommentCount,
          productCommentCount: productCommentCount,
          shopImageUrl: shopImageUrl,
          productImageUrl: productImageUrl,
          shopUrl: shopUrl,
          discountRate: discountRate);

      print('listingId:$listingId');
      print('shopId:$shopId');

      setState(() {
        shopId = newShopId;
        listingId = newListingId;
        loading = false;
      });
      return null;
    }
  }

  Future getReviewsDocument(String prodcutUrl) async {
    setState(() {
      loading = true;
    });

    Response res =
        await ApiService().getReviews(1, prodcutUrl, listingId!, shopId!);

    var body = jsonDecode(utf8.decode(res.bodyBytes));

    final document = parse(body["output"]["reviews"]);

    var reviewsLength = document
        .getElementsByClassName(
            "wt-text-truncate.wt-text-body-small.wt-text-gray")
        .length;

    for (int index = 0; index < reviewsLength; index++) {
      models.Review review =
          models.Review('', 0, '', '', DateTime(DateTime.january), '');

      var reviewText =
          document.getElementById("review-preview-toggle-$index")?.text.trim();
      var reviewUser = document
          .getElementsByClassName(
              "wt-text-truncate.wt-text-body-small.wt-text-gray")[index]
          .text
          .trim();
      var reviewRating = int.parse(document
          .querySelectorAll('input[name="rating"]')
          .sublist(1)[index]
          .attributes['value']!);
      var reviewDate = DateFormat('MMM d, yyyy').parse(document
          .getElementsByClassName(
              "wt-text-body-small wt-text-gray wt-align-self-flex-start wt-no-wrap wt-text-right-xs wt-flex-grow-xs-1")[index]
          .text);
      var reviewProductTitle =
          document.querySelectorAll('a[data-review-link]')[index].text;
      var reviewProductPath = document
          .querySelectorAll('a[data-review-link]')[index]
          .attributes["href"];

      setState(() {
        loading = false;
        review = models.Review(reviewText, reviewRating, reviewProductTitle,
            reviewProductPath, reviewDate, reviewUser);
        reviewList.add(review);
      });
    }
    // for (var review in reviewList) {
    //   print('reviewers: ${review.reviewer}');
    //   print('reviewers: ${review.path}');
    //   print(' ----------------------------------------------------');
    // }
  }

  @override
  void initState() {
    super.initState();
    // getUrlDocument(continueURL);
    // getComments();
    // getCommentsRequest();
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
              // Button(
              //   child: const Text(
              //     'Analiz Et',
              //     style: TextStyle(height: 1.8),
              //   ),
              //   onPressed: () {
              //     // setState(() {
              //     //   continueURL =
              //     //       utils.Extractter().extractUrl(urlController.text);
              //     // });
              //     // getReviewsDocument(urlController.text);
              //     // getUrlDocument(continueURL);
              //   },
              // ),
            ],
          ),
          const SizedBox(height: 20),
          if (!loading)
            Column(
              children: [
                ProductCard(product: product),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button(
                      child: const Text(
                        'İlk Dökümanı Çek',
                        style: TextStyle(height: 1.8),
                      ),
                      onPressed: () {
                        setState(() {
                          continueURL =
                              utils.Extractter().extractUrl(urlController.text);
                        });

                        getUrlDocument(continueURL!);
                      },
                    ),
                    Button(
                      child: const Text(
                        'Yorumları Çek',
                        style: TextStyle(height: 1.8),
                      ),
                      onPressed: () async {
                        for (int i = 0; i < pageCount!.toInt(); i++) {
                          await getReviewsDocument(urlController.text);
                        }
                      },
                    ),
                  ],
                )
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

// getCommentsRequest(
//     listingId: newListingId.toString(), shopId: newShopId.toString());

//         var title = extractTextContent(res, Constants.titleClassName); //Başlık
//         var description =
//             extractTextContent(res, Constants.descriptionClassName); //Açıklama
//         var price =
//             extractTextContent(res, Constants.priceClassName); //Tam fiyat
//         var discountPrice =
//             extractTextContent(res, Constants.discountPriceClassName)
//                 .replaceAll(RegExp(r'^Price:\s*'), ''); //Indirimli fiyat
//         var shopOwnerName = extractTextContent(
//             res, Constants.shopOwnerNameClassName); //Mağaza sahibinin adı
//         var shopName =
//             extractTextContent(res, Constants.shopNameClassName); //Mağaza adı
//         var shopCommentCount = extractTextContent(
//             res, Constants.shopReviewCountClassName); //Mağaza yorum sayısı
//         var productCommentCount = extractTextContent(
//             res, Constants.productReviewCountClassName); //Ürün yorum sayısı
// //-----------------------------------------------------------------
//         var shopImageUrl = extractAttribute(
//             res, Constants.shopImageUrlClassName, 'src'); //Mağaza resim linki
//         var productImageUrl = extractAttribute(
//             res,
//             Constants.productFirstImageUrlClassName,
//             'src'); //Ürünün ilk resim linki
//         var shopUrl = extractAttribute(
//             res, Constants.shopUrlClassName, 'href'); //Mağazanın linki
// //-----------------------------------------------------------------
//         var discountRate = extractDiscountRate(
//             res, Constants.discountRateClassName, '(', ')',
//             removeOffText: true); //Indirim oranı
//-----------------------------------------------------------------
// //Reviews
//-----------------------------------------------------------------
// setState(() {
//   loading = false;
//   etsyObj.title = title;
//   etsyObj.description = description;
//   etsyObj.discountPrice = discountPrice;
//   etsyObj.discountRate = discountRate;
//   etsyObj.price = price;
//   etsyObj.shopImageUrl = shopImageUrl;
//   etsyObj.productImageUrl = productImageUrl;
//   etsyObj.productCommentCount = productCommentCount;
//   etsyObj.shopCommentCount = shopCommentCount;
//   etsyObj.shopName = shopName;
//   etsyObj.shopOwnerName = shopOwnerName;
//   etsyObj.shopUrl = shopUrl;
// });

//---------------------------------------------------------------------------------------

// void getCommentsRequest(
//     {required String listingId, required String shopId}) async {
//   final baseUrl = Uri.parse(
//       'https://www.etsy.com/api/v3/ajax/bespoke/member/neu/specs/reviews');

//   const page = 1;

//   var responseBody = ApiService().getHtmlContent(continueURL);

//   var res = await http.post(baseUrl, headers: headers, body: data);

//   var body = jsonDecode(utf8.decode(res.bodyBytes));

//   final document = parse(body["output"]["reviews"]);

//   int index = 0;

//   var reviewText = document.getElementById("review-preview-toggle-$index");
//   print('reviewText: ${reviewText!.text.trim()}');

//   var reviewUser = document.getElementsByClassName(
//       "wt-text-truncate.wt-text-body-small.wt-text-gray");
//   print('reviewUser: ${reviewUser[index].text}');

//   var reviewRating =
//       document.querySelectorAll('input[name="rating"]').sublist(2);
//   print('reviewRating: ${reviewRating[index].attributes["value"]}');

//   var reviewDate = document.getElementsByClassName(
//       "wt-text-body-small wt-text-gray wt-align-self-flex-start wt-no-wrap wt-text-right-xs wt-flex-grow-xs-1");
//   print(
//       'reviewDate: ${DateFormat('MMM d, yyyy').parse(reviewDate[index].text)}');

//   var reviewProduct = document.querySelectorAll('a[data-review-link]');
//   print('reviewProduct: ${reviewProduct[index].text}');
//   print('reviewProductLink: ${reviewProduct[index].attributes["href"]}');
// }
