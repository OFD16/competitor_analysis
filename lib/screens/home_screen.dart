import 'package:web_scraper/web_scraper.dart';

import 'package:html/parser.dart' show parse;

import 'package:fluent_ui/fluent_ui.dart';

import './index.dart' as screens;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int _currentPage = 0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: Container(
          margin: const EdgeInsets.only(left: 20),
          child: const Text(
            'Competitor Analysis',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      pane: NavigationPane(
        size: const NavigationPaneSize(
          openMinWidth: 250,
          openMaxWidth: 320,
        ),
        items: <NavigationPaneItem>[
          PaneItem(
            icon: const Icon(FluentIcons.app_icon_default),
            title: const Text('Dashboard'),
            body: const screens.DashboardScreen(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.chart),
            title: const Text('Analyze'),
            body: const screens.AnalysisScreen(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.user_clapper),
            title: const Text('Profile'),
            body: const screens.ProfileScreen(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
            body: const screens.SettingsScreen(),
          ),
        ],
        selected: _currentPage,
        onChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );

    // const SafeArea(
    //   child: Text('HomeScreen'),
    // );
  }
}

  // String getElementContent(Element? element) {
  //   return element?.text?.trim() ?? '';
  // }

  // Future<dynamic> fetchDocument() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   if (await webScraper.loadWebPage(continueURL)) {
  //     final res = webScraper.getPageContent();
  //     final document = parse(res);

  //     //final element = document.querySelector('$tagName.$className');

  //     // Extract the comment data.
  //     // String className14 = 'div[data-test-id="Comment"]';
  //     // var commentElements = document.querySelectorAll(className14);
  //     // List<String> comments = [];
  //     // for (var commentElement in commentElements) {
  //     //   var comment = commentElement.querySelector('.Comment-text')?.text;
  //     //   comments.add(comment!);
  //     // }

  //     // // Print the comment data.
  //     // print(comments);

  //     //Başlık
  //     String className12 = 'h1[data-buy-box-listing-title="true"]';
  //     var titleElement = document.querySelector(className12);
  //     var title = titleElement?.text.trim();

  //     //Açıklama
  //     String className3 = 'wt-text-body-01.wt-break-word';
  //     final descriptionElement = document.querySelector('p.$className3');
  //     final description = descriptionElement?.text.trim();

  //     //Tam fiyat
  //     String className2 = 'wt-text-strikethrough';
  //     final priceElement = document.querySelector('span.$className2');
  //     final price = priceElement?.text.trim();

  //     //Indirimli fiyat
  //     String className5 = 'wt-text-title-03';
  //     final discountPriceElement = document.querySelector('p.$className5');
  //     final discountPrice = discountPriceElement?.text.trim();

  //     //Indirim oranı
  //     String className4 = 'wt-text-caption.wt-text-gray';
  //     final discountRateElement = document.querySelector('p.$className4');
  //     final discountRateText = discountRateElement?.text?.trim();
  //     final discountRateStartIndex = discountRateText!.indexOf('(');
  //     final discountRateEndIndex = discountRateText.indexOf(')');
  //     final discountRate = discountRateText
  //         .substring(discountRateStartIndex + 1, discountRateEndIndex)
  //         .trim();

  //     //Mağaza sahibi resmi
  //     String className8 = 'div.wt-thumbnail-larger img';
  //     var imageUrlElement = document.querySelector(className8);
  //     var imageUrl = imageUrlElement?.attributes['src'];

  //     //Mağaza sahibinin adı
  //     String className9 = 'p.wt-text-body-03.wt-line-height-tight.wt-mb-lg-1';
  //     var nameElement = document.querySelector(className9);
  //     var name = nameElement?.text;

  //     //Mağazanın urli ve ismi
  //     String className10 = 'a.wt-text-link[href*="shop"]';
  //     var containerElement = document.querySelector(className10);
  //     var link = containerElement?.attributes['href'];
  //     var name1 = containerElement?.text;

  //     String className15 =
  //         'div.wt-content-toggle--truncated-inline-multi.wt-break-word wt-text-body-01"]';
  //     var reviewsElement = document.querySelector(className15);
  //     var reviews = reviewsElement?.text;

  //     //Ürün yorum sayısı
  //     String className11 = 'span.wt-badge.wt-badge--status-02.wt-ml-xs-2';
  //     var productCommentCountElement = document.querySelector(className11);
  //     var productCommentCount = productCommentCountElement?.text.trim();

  //     //Mağaza yorum sayısı
  //     String className13 =
  //         'span.wt-badge.wt-badge--status-02.wt-ml-xs-2.wt-nowrap';
  //     var shopCommentCountElement = document.querySelector(className13);
  //     var shopCommentCount = shopCommentCountElement?.text.trim();

  //     print('//////////////////////////////////');
  //     print("reviewsElement $reviewsElement");
  //     print("reviews $reviews");
  //     print('//////////////////////////////////');

  //     setState(() {
  //       // res2 = titleElement.toString();
  //       //print("res2 $res2");
  //     });

  //     setState(() {
  //       loading = false;
  //     });

  //     return document;
  //   }

  //   setState(() {
  //     loading = false;
  //   });
  //   return null;
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchDocument();
  // }


// class Feed extends StatefulWidget {
//   final void Function()? onPress;
//   const Feed({super.key, this.onPress});

//   @override
//   State<Feed> createState() => _FeedState();
// }

// class _FeedState extends State<Feed> {
//   // wrapLink(String link) async {
//   //   // final webScraper = WebScraper('https://webscraper.io');
//   //   // if (await webScraper.loadWebPage('/test-sites/e-commerce/allinone')) {
//   //   //   List<Map<String, dynamic>> elements = webScraper.getElement('h3.title > a.caption', ['href']);
//   //   //   print(elements);
//   //   // }
//   //   setState(() {
//   //     loading = true;
//   //   });
//   //   if (await webScraper.loadWebPage(continueURL)) {
//   //     String page = webScraper.getPageContent();
//   //     List<String> page1 = webScraper.getAllScripts();
//   //     print('--------------------------------');
//   //     print(page);
//   //     print('--------------------------------');
//   //     print('--------------------------------');
//   //     print(page1);
//   //     print('--------------------------------');

//   //     setState(() {
//   //       res = page;
//   //       res1 = page1;
//   //     });

//   //     // List<Map<String, dynamic>> elements =
//   //     // webScraper.getElement('h3.title > a.caption', ['href']);
//   //     // print(elements);
//   //   }

//   //   setState(() {
//   //     loading = false;
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         const Center(child: Text('link ekle')),
//         // TextField(
//         //   controller: linkController,
//         // ),
//         // TextButton(
//         //   onPressed: widget.onPress,
//         //   child: const Text('Analyze'),
//         // ),
//         const SizedBox(width: 60),
//         loading ? const ProgressRing() : Text(res2),
//       ],
//     );
//   }
// }


// List<String> tagNames = [
//   'a',
//   'abbr',
//   'acronym',
//   'address',
//   'applet',
//   'area',
//   'article',
//   'aside',
//   'audio',
//   'b',
//   'base',
//   'basefont',
//   'bdi',
//   'bdo',
//   'big',
//   'blockquote',
//   'body',
//   'br',
//   'button',
//   'canvas',
//   'caption',
//   'center',
//   'cite',
//   'code',
//   'col',
//   'colgroup',
//   'data',
//   'datalist',
//   'dd',
//   'del',
//   'details',
//   'dfn',
//   'dialog',
//   'dir',
//   'div',
//   'dl',
//   'dt',
//   'em',
//   'embed',
//   'fieldset',
//   'figcaption',
//   'figure',
//   'font',
//   'footer',
//   'form',
//   'frame',
//   'frameset',
//   'h1',
//   'h2',
//   'h3',
//   'h4',
//   'h5',
//   'h6',
//   'head',
//   'header',
//   'hr',
//   'html',
//   'i',
//   'iframe',
//   'img',
//   'input',
//   'ins',
//   'kbd',
//   'label',
//   'legend',
//   'li',
//   'link',
//   'main',
//   'map',
//   'mark',
//   'meta',
//   'meter',
//   'nav',
//   'noframes',
//   'noscript',
//   'object',
//   'ol',
//   'optgroup',
//   'option',
//   'output',
//   'p',
//   'param',
//   'picture',
//   'pre',
//   'progress',
//   'q',
//   'rp',
//   'rt',
//   'ruby',
//   's',
//   'samp',
//   'script',
//   'section',
//   'select',
//   'small',
//   'source',
//   'span',
//   'strike',
//   'strong',
//   'style',
//   'sub',
//   'summary',
//   'sup',
//   'svg',
//   'table',
//   'tbody',
//   'td',
//   'template',
//   'textarea',
//   'tfoot',
//   'th',
//   'thead',
//   'time',
//   'title',
//   'tr',
//   'track',
//   'tt',
//   'u',
//   'ul',
//   'var',
//   'video',
//   'wbr',
// ];

// final webScraper = WebScraper('https://www.etsy.com/');
// String res = '';
// String res2 = '';
// List<String> res1 = [];
// const continueURL =
//     // 'listing/1228308510/notion-template-personal-planner-notion?click_key=39c4fcf6f889d88a2698c2ba8c54932026fb8902%3A1228308510&click_sum=9e5b1f00&ref=shop_home_feat_1&pro=1&sts=1';
//     'listing/1260554960/notion-template-student-planner-academic?click_key=26f1b7030175d487b705f77fa4b4eda9904d0370%3A1260554960&click_sum=b7e6daf6&ref=related-2&pro=1&sts=1';
// // Fetch the document

// TextEditingController linkController = TextEditingController();
// bool loading = false;
// // List<String> page1 = webScraper.getAllScripts();