import 'dart:convert';

import 'package:competitor_analysis/providers/product_provider.dart';
import 'package:competitor_analysis/services/api_service.dart';
import "package:fluent_ui/fluent_ui.dart";
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../providers/comments_provider.dart';
import '../utils/index.dart' as utils;
import '../models/index.dart' as models;
import '../widgets/index.dart' as components;
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
int pageCount = 1;

String? pageHtml = '';

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController urlController = TextEditingController(
      text:
          'https://www.etsy.com/listing/1228308510/notion-template-personal-planner-notion?ga_order=most_relevant&ga_search_type=all&ga_view_type=gallery&ga_search_query=notion+planner+2023&ref=sr_gallery-1-2&pro=1&sts=1&organic_search_click=1');
  bool loading = false;
  int counter = 0;
  double progressCounter = 0.0;

  models.Product product = models.Product();

  Future getUrlDocument(String continueURL) async {
    setState(() {
      loading = true;
      progressCounter = 0.0;
      counter = 0;
    });
    if (continueURL.isNotEmpty) {
      Response res = await ApiService().getHtmlDocument(continueURL);

      var document = parse(res.body);

      var price = '';
      var discountPrice = '';
      var discountRate = '';

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

      bool isDiscountExist = document
          .querySelectorAll(
              'div.wt-display-flex-xs.wt-align-items-center.wt-flex-wrap')[0]
          .getElementsByClassName('wt-text-caption wt-text-gray')
          .isNotEmpty;
      if (isDiscountExist) {
        price = utils.Extractter()
            .extractTextContent(document, Constants.priceClassName);

        discountPrice = utils.Extractter()
            .extractTextContent(document, Constants.discountPriceClassName)
            .replaceAll(RegExp(r'^Price:\s*'), ''); //Indirimli fiyat

        discountRate = utils.Extractter().extractDiscountRate(
            document, Constants.discountRateClassName, '(', ')',
            removeOffText: true); //Indirim oranı
      } else {
        //İndirim yoksa fiyatı çekeceğimiz kısım burası
        price = utils.Extractter()
            .extractTextContent(document, Constants.discountPriceClassName)
            .replaceAll(RegExp(r'^Price:\s*'), ''); //Indirimli fiyat
      }

      var shopOwnerName = utils.Extractter().extractTextContent(
          document, Constants.shopOwnerNameClassName); //Mağaza sahibinin adı

      var shopName = utils.Extractter().extractTextContent(
          document, Constants.shopNameClassName); //Mağaza adı

      int shopCommentCount = int.parse(document.body!
          .getElementsByClassName(
              'wt-badge wt-badge--status-02 wt-ml-xs-2 wt-nowrap')[0]
          .text
          .trim()
          .replaceAll(',', '')
          .trim()); //Mağaza yorum sayısı

      int productCommentCount = int.parse(document.body!
          .getElementsByClassName('wt-badge wt-badge--status-02 wt-ml-xs-2')[0]
          .text
          .trim()
          .replaceAll(',', '')
          .trim()); //Ürün yorum sayısı

      var shopImageUrl = utils.Extractter().extractAttribute(document,
          Constants.shopImageUrlClassName, 'src'); //Mağaza resim linki

      var productImageUrl = utils.Extractter().extractAttribute(
          document,
          Constants.productFirstImageUrlClassName,
          'src'); //Ürünün ilk resim linki

      var shopUrl = utils.Extractter().extractAttribute(
          document, Constants.shopUrlClassName, 'href'); //Mağazanın linki

      setState(() {
        pageCount = productCommentCount ~/ 4;
        print('pagecount ${pageCount}');
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

      Provider.of<ProductProvider>(context, listen: false).setProduct(product);

      setState(() {
        shopId = newShopId;
        listingId = newListingId;
        loading = false;
      });

      print('listingId:$listingId');
      return null;
    }
  }

  Future getComments(String prodcutUrl, int pageCount) async {
    List<models.Review> reviewList = [];
    setState(() {
      loading = true;
    });

    for (int i = 1; i <= pageCount; i++) {
      Response res =
          await ApiService().getReviews(i, prodcutUrl, listingId!, shopId!);

      var body = jsonDecode(utf8.decode(res.bodyBytes));

      final document = parse(body["output"]["reviews"]);

      var reviewsElementsList =
          document.getElementsByClassName('wt-grid__item-xs-12 review-card');
      print('reviewsElementsList: ${reviewsElementsList}');
      print('pageCount: ${i}');
      setState(() {
        progressCounter = 100 * (counter / 4) / pageCount;
      });

      for (int i = 0; i < reviewsElementsList.length; i++) {
        var reviewItem = reviewsElementsList[i];
        models.Review review = models.Review(
          text: '',
          rating: 0,
          title: '',
          path: '',
          date: DateTime(DateTime.february),
          reviewer: '',
          subRatings: [],
        );

        if (i == 0) {
          var producSumOfRates = double.parse(document
              .getElementsByClassName('wt-display-inline-block wt-mr-xs-1')[0]
              .getElementsByTagName('input')[0]
              .attributes['value']
              .toString()); // ürünün genel puanı
        }

        var reviewElement = reviewsElementsList[i];

        var reviewElementRate = double.parse(reviewElement
            .getElementsByTagName('input')[0]
            .attributes['value']
            .toString());

        var reviewElementOwner = 'null';
        bool isOwnerClassNameExist = reviewElement
            .getElementsByClassName('wt-content-toggle__trigger-wrapper')
            .isNotEmpty;

        var isOwnerClassNameExist2 = reviewElement
            .getElementsByClassName('wt-text-caption wt-text-gray')[1]
            .getElementsByTagName('a')
            .isNotEmpty;

        if (isOwnerClassNameExist) {
          reviewElementOwner = reviewElement
              .getElementsByClassName('wt-content-toggle__trigger-wrapper')[0]
              .getElementsByTagName('span')[0]
              .text
              .split("by")[1]
              .trim();
        } else if (isOwnerClassNameExist2) {
          reviewElementOwner = reviewElement
              .getElementsByClassName('wt-text-caption wt-text-gray')[1]
              .getElementsByTagName('a')[0]
              .text
              .trim();
        } else {
          var reviewElementOwner = reviewElement
              .getElementsByClassName('wt-text-caption wt-text-gray')[1]
              .getElementsByTagName('span')[0]
              .text
              .trim();

          var ownerSplit = reviewElementOwner.split("by");
          if (ownerSplit.length > 1) {
            reviewElementOwner = ownerSplit[1].trim();
          }
        }

        var reviewElementText = '';
        bool isReviewTextExist = reviewElement
            .getElementsByClassName('wt-text-truncate--multi-line')
            .isNotEmpty;
        if (isReviewTextExist) {
          reviewElementText = reviewElement
              .getElementsByClassName('wt-text-truncate--multi-line')[0]
              .text
              .trim();
        }

        var reviewElementTitle = reviewElement
            .getElementsByClassName(
                'wt-text-link wt-text-caption wt-text-truncate wt-text-gray wt-width-half wt-pb-xs-1 wt-pb-md-0')[0]
            .text
            .trim();

        var reviewElementPath = '';
        if (reviewElementOwner == 'Inactive') {
          reviewElementPath = reviewElement
              .getElementsByClassName(
                  'wt-text-link wt-text-caption wt-text-truncate wt-text-gray wt-width-half wt-pb-xs-1 wt-pb-md-0')[0]
              .attributes['href']
              .toString();
        }

        RegExp dateRegex = RegExp(r'\b\w{3} \d{1,2}, \d{4}\b');
        var reviewElementDate = DateFormat('MMM d, yyyy').parse(
            dateRegex.stringMatch(reviewElement
                .getElementsByClassName(
                    'wt-display-flex-xs wt-align-items-center wt-pt-xs-1')[0]
                .getElementsByClassName('wt-text-caption wt-text-gray')[0]
                .text
                .trim())!);

        //Subratings çekildi
        List<Map<String, dynamic>> subRatings = [];
        var isSubRatingsExist = reviewItem
            .getElementsByClassName('wt-flex-md-1 min-width-0')
            .isNotEmpty;

        if (isSubRatingsExist) {
          var subRatingsLength = reviewItem
              .getElementsByClassName('wt-flex-md-1 min-width-0')[0]
              .getElementsByClassName('subrating-item')
              .length;

          for (int j = 0; j < subRatingsLength; j++) {
            var subRating = reviewItem
                .getElementsByClassName('wt-flex-md-1 min-width-0')[0]
                .getElementsByClassName('subrating-item')[j]
                .getElementsByClassName(
                    'wt-text-left-xs wt-width-full wt-text-body-small--tight')[0]
                .text;
            var rate = double.parse(reviewItem
                .getElementsByClassName('wt-flex-md-1 min-width-0')[0]
                .getElementsByClassName('subrating-item')[j]
                .getElementsByClassName('wt-pl-xs-2 wt-flex-xs-1')[0]
                .text);

            subRatings.add({'subRating': subRating, 'rate': rate});
          }

          print('subratings: $subRatings');
        }

        setState(() {
          loading = false;
          review = models.Review(
            text: reviewElementText,
            rating: reviewElementRate,
            title: reviewElementTitle,
            path: reviewElementPath,
            date: reviewElementDate,
            reviewer: reviewElementOwner,
            subRatings: subRatings,
          );
          reviewList.add(review);
          counter++;
          progressCounter = 100 * (counter / 4) / pageCount;
          print('çekilen yorum sayısı anlık: $counter');
        });
      }

      setState(() {
        product.reviews = reviewList;
        loading = false;
      });
    }
    Provider.of<ReviewProvider>(context, listen: false).setReviews(reviewList);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormBox(
                      controller: urlController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (!loading)
                Column(
                  children: [
                    components.ProductCard(product: product),
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
                              continueURL = utils.Extractter()
                                  .extractUrl(urlController.text);
                            });

                            getUrlDocument(continueURL!);
                          },
                        ),
                        const SizedBox(width: 10),
                        Text('${progressCounter.toInt()}   '),
                        Expanded(
                          child: progressCounter >= 95 && progressCounter <= 100
                              ? ProgressBar(
                                  value: 100,
                                  strokeWidth: 8,
                                  activeColor: Colors.green)
                              : ProgressBar(
                                  value: progressCounter, strokeWidth: 8),
                        ),
                        const Text('   100'),
                        const SizedBox(width: 10),
                        Button(
                          child: const Text(
                            'Yorumları Çek',
                            style: TextStyle(height: 1.8),
                          ),
                          onPressed: () {
                            getComments(urlController.text, pageCount);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Button(
                      child: Text(
                        'Yorumların sayısını kontrol : ${product.reviews.length}',
                        style: TextStyle(height: 1.8),
                      ),
                      onPressed: () {
                        print('Yorum sayısı = ${product.reviews.length}');
                      },
                    ),
                    //SelectableText(pageHtml!),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: product.reviews.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index < product.reviews.length) {
                          return components.ReviewCard(
                            review: product.reviews[index],
                            order: index + 1,
                          );
                        } else {
                          return const Text(
                              ''); // or any other placeholder widget
                        }
                      },
                    ),
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
        ),
      ),
    );
  }
}
