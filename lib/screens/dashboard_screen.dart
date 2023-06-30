import 'package:competitor_analysis/services/api_service.dart';
import 'package:competitor_analysis/widgets/cards/product_card.dart';
import "package:fluent_ui/fluent_ui.dart";
import 'package:html/parser.dart';

import '../utils/index.dart' as utils;
import '../models/index.dart' as models;
// import '../themes/constants.dart' show Constants;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

const mainUrl = 'https://www.etsy.com/';

var shopId = '';
var listingId = '';
var continueURL = '';

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController urlController = TextEditingController(
      text:
          'https://www.etsy.com/listing/1228308510/notion-template-personal-planner-notion?ga_order=most_relevant&ga_search_type=all&ga_view_type=gallery&ga_search_query=notion+planner+2023&ref=sr_gallery-1-2&pro=1&sts=1&organic_search_click=1');
  bool loading = false;

  late models.Product etsyObj = models.Product();

  Future getUrlDocument(String continueURL) async {
    setState(() {
      loading = true;
      continueURL = utils.Extractter().extractUrl(urlController.text);
    });
    if (continueURL.isNotEmpty) {
      var document = await ApiService().getHtmlDocument(continueURL);

      var newShopId = document
          .querySelectorAll('div[data-shop-id]')[0]
          .attributes["data-shop-id"];

      var newListingId = document
          .querySelectorAll('div[data-listing-id]')[0]
          .attributes["data-listing-id"];
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
    print('----------------------------------------------------');
    print('continueURL:$continueURL');
    print('listingId:$listingId');
    print('shopId:$shopId');
    var document =
        await ApiService().getReviews(1, prodcutUrl, listingId, shopId);

    // print('documan neymişş görelim: ${document}');

    setState(() {
      loading = false;
    });
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
              Button(
                child: const Text(
                  'Analiz Et',
                  style: TextStyle(height: 1.8),
                ),
                onPressed: () {
                  // setState(() {
                  //   continueURL =
                  //       utils.Extractter().extractUrl(urlController.text);
                  // });
                  // getReviewsDocument(urlController.text);
                  // getUrlDocument(continueURL);
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (!loading)
            Column(
              children: [
                const ProductCard(),
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

                        getUrlDocument(continueURL);
                      },
                    ),
                    Button(
                      child: const Text(
                        'Yorumları Çek',
                        style: TextStyle(height: 1.8),
                      ),
                      onPressed: () {
                        getReviewsDocument(urlController.text);
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