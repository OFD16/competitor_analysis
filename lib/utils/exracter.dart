import 'package:html/parser.dart' show parse;
import 'package:intl/intl.dart' show DateFormat;

class Extractter {
  String extractUrl(String url) {
    final uri = Uri.parse(url);
    return uri.path + (uri.query.isNotEmpty ? '?' + uri.query : '');
  }

  String extractTextContent(dynamic document, String cssSelector) {
    final element = document.querySelector(cssSelector);
    return element?.text?.trim() ?? '';
  }

  List<String> extractReviewersNames(
      dynamic document, List<String> cssSelectors) {
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
      dynamic document, String cssSelector, String attributeName) {
    final element = document.querySelector(cssSelector);
    return element?.attributes[attributeName] ?? '';
  }

  String extractDiscountRate(dynamic document, String cssSelector,
      String startDelimiter, String endDelimiter,
      {bool removeOffText = false}) {
    String discountRateText = extractTextContent(document, cssSelector);
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

  String extractFormattedRating(dynamic document, String cssSelector) {
    final ratingElement = document.querySelector(cssSelector);
    final rating = ratingElement?.attributes['data-rating'];
    final parsedRating = rating != null ? int.tryParse(rating) : null;
    final formattedRating = parsedRating != null
        ? '${5 - parsedRating} stars'
        : 'Rating Not Available';
    return formattedRating;
  }

  List<int> extractRatingsList(dynamic document, String cssSelector) {
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

  List<String> extractReviewTexts(dynamic document, String cssSelector) {
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

  List<DateTime> extractDates(dynamic document, String cssSelector) {
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
}
