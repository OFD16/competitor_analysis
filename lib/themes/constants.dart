class Constants {
  static const String appName = 'My Flutter App';
  static const int maxUsernameLength = 20;
  static const int maxPasswordLength = 16;
  static const String apiUrl = 'https://api.example.com';

  static const String titleClassName = 'h1[data-buy-box-listing-title="true"]';
  static const String descriptionClassName = 'p.wt-text-body-01.wt-break-word';
  static const String priceClassName = 'span.wt-text-strikethrough';
  static const String discountPriceClassName = 'p.wt-text-title-03';
  static const String shopOwnerNameClassName =
      'p.wt-text-body-03.wt-line-height-tight.wt-mb-lg-1';
  static const String shopNameClassName = 'a.wt-text-link[href*="shop"]';
  static const String shopReviewCountClassName =
      'span.wt-badge.wt-badge--status-02.wt-ml-xs-2.wt-nowrap';
  static const String productReviewCountClassName =
      'span.wt-badge.wt-badge--status-02.wt-ml-xs-2';
//-----------------------------------------------------------------
  static const String shopImageUrlClassName =
      'div.wt-thumbnail-larger img'; //src
  static const String productFirstImageUrlClassName = 'img'; //src
  static const String shopUrlClassName = 'a.wt-text-link[href*="shop"]'; //href

  static const String discountRateClassName = 'p.wt-text-caption.wt-text-gray';
//-----------------------------------------------------------------
  //Reviews
  static const String reviewerNameClassName =
      'p.wt-text-truncate.wt-text-body-small.wt-text-gray';
  //wt-text-truncate wt-text-body-small wt-text-gray
  static const String reviewDateClassName =
      '.wt-text-body-small.wt-text-gray.wt-align-self-flex-start.wt-no-wrap.wt-text-right-xs.wt-flex-grow-xs-1';
  static const String reviewTextClassName = '#review-preview-toggle-0';
  static const String reviewerPurchasedItem =
      '.wt-text-caption-title.wt-text-gray.wt-flex-shrink-xs-0.wt-pb-xs-1.wt-pb-md-0 + a';
  static const String reviewRate =
      '.combined-author-stars-container .wt-icon[data-rating]';
//-----------------------------------------------------------------
  static const String reviewsUsernamesListClassName =
      'p.wt-text-truncate.wt-text-body-small.wt-text-gray';
  static const String reviewsRateListClassName = '.wt-screen-reader-only';
  static const String reviewTextsClassName = '.wt-text-truncate--multi-line';
  static const String reviewDatesClassName =
      '.wt-text-body-small.wt-text-gray.wt-align-self-flex-start.wt-no-wrap.wt-text-right-xs.wt-flex-grow-xs-1';
}
