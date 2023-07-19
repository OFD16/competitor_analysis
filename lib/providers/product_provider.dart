import 'package:flutter/material.dart';
import '../models/index.dart' as models;
import '../models/product.dart';


class ProductProvider extends ChangeNotifier {
   models.Product _product = Product();

  models.Product get getProduct => _product;

  void setProduct(models.Product product) {
    _product = product;
    notifyListeners();
  }
}
