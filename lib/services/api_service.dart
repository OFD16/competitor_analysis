import './base_service.dart';

class ApiService {
  static const String baseUrl = 'https://www.etsy.com/';

  Future getHtmlDocument(String path) async {
    var res = await BaseService(baseUrl).getRequest(path);
    return res;
  }

  Future getReviews(
      int page, String productUrl, String listingId, String shopId) async {
    const path = 'api/v3/ajax/bespoke/member/neu/specs/reviews';
    final headers = {
      'authority': 'www.etsy.com',
      'accept': '*/*',
      'accept-language': 'en;q=0.5',
      'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'cookie':
          'uaid=lVkWsMixQsoKdTmXiQNVMhTTnxRjZACClBkVXDC6Wqk0MTNFyUrJOz87KNyssiC5MtLYON8z1MvbPdyzqMQpydzHT6mWAQA.; user_prefs=LamgXwAYpXBJgO9VelLXMkWhZRxjZACClBkVXDA6WikkKFJJJ680J0dHKTVPNzRYSQcoBBUxglC4iFgGAA..; fve=1687713802.0; _fbp=fb.1.1687713802186.3086167855707117; ua=531227642bc86f3b5fd7103a0c0b4fd6; last_browse_page=https%3A%2F%2Fwww.etsy.com%2Fshop%2FViePlanners; _fbp=fb.1.1687713802186.3086167855707117; fve=1687713802.0; uaid=_d_PLro-eqI_LhmKcwTFauRmDcpjZACClBkVj2B0tVJpYmaKkpVSUr5HvpNJXlGSkVOUV1WYRYB3YKqZa0ROZq5xllItAwA.; user_prefs=sZvLx5JHl2CJ4MO3yfVNAz5nHmdjZACClBkVj2B0tFJIUKSSTl5pTo6OUmqebmiwkg5QCCpiBKFwEbEMAA..',
      'origin': 'https://www.etsy.com',
      'referer': productUrl,
      'sec-ch-ua': '"Not.A/Brand";v="8", "Chromium";v="114", "Brave";v="114"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"Windows"',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-origin',
      'sec-gpc': '1',
      'user-agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36',
      'x-csrf-token':
          '3:1688079272:6uChyDJ5W1egCI_KMyYH5ymZQO6B:8529dc1a2d963f4bc928b8d42d67183d17676ea49b161fcff091b0a59f54d1de',
      'x-detected-locale': 'TRY|en-US|TR',
      'x-page-guid': 'f5a5da767c6.f9891077a082c15c7848.00',
      'x-recs-primary-location': productUrl,
      'x-recs-primary-referrer': '',
      'x-requested-with': 'XMLHttpRequest',
    };
    final data =
        'log_performance_metrics=true&specs%5Breviews%5D%5B%5D=Etsy%5CModules%5CListingPage%5CReviews%5CApiSpec&specs%5Breviews%5D%5B1%5D%5Blisting_id%5D=$listingId&specs%5Breviews%5D%5B1%5D%5Bshop_id%5D=$shopId&specs%5Breviews%5D%5B1%5D%5Brender_complete%5D=true&specs%5Breviews%5D%5B1%5D%5Bactive_tab%5D=same_listing_reviews&specs%5Breviews%5D%5B1%5D%5Bshould_lazy_load_images%5D=false&specs%5Breviews%5D%5B1%5D%5Bshould_use_pagination%5D=true&specs%5Breviews%5D%5B1%5D%5Bpage%5D=$page&specs%5Breviews%5D%5B1%5D%5Bshould_show_variations%5D=false&specs%5Breviews%5D%5B1%5D%5Bis_reviews_untabbed_cached%5D=false&specs%5Breviews%5D%5B1%5D%5Bwas_landing_from_external_referrer%5D=false&specs%5Breviews%5D%5B1%5D%5Bsort_option%5D=Relevancy';
    var res = await BaseService(baseUrl)
        .postRequest(path, headers: headers, body: data);
    // print('----------------------------------------------------------');
    // print('.body: ${res.body}');
    // print('----------------------------------------------------------');
    return res;
  }
}
