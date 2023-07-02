import 'package:flutter/material.dart';
import '../models/index.dart' as models;


class ReviewProvider extends ChangeNotifier {
  List<models.Review> _reviewers = [];

  List<models.Review> get getReviews => _reviewers;

  void setReviews(List<models.Review> reviewes) {
    _reviewers = reviewes;
    notifyListeners();
  }
}
