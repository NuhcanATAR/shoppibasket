import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppibasket/features/products/model/product_model.dart';
import 'package:shoppibasket/product/service/user_service.dart';

class User extends ChangeNotifier {
  Map<Product, int> basketProducts = {};

  late UserService service;

  User(BuildContext context) {
    service = context.read<UserService>();
  }

  List<Product> get basketItems => basketProducts.keys.toList();

  double get basketTotalMoney {
    if (basketProducts.isEmpty) {
      return 0;
    } else {
      double _total = 0;
      basketProducts.forEach((key, value) {
        _total += key.price! * value;
      });
      return _total;
    }
  }

  int get totalProduct {
    return basketProducts.length;
  }

  void addFirstItemToBasket(Product product) {
    basketProducts[product] = 1;
    service.addProduct(product);
    notifyListeners();
  }

  void incrementProduct(Product product) {
    if (basketProducts[product] == null) {
      addFirstItemToBasket(product);
      return;
    } else {
      var value = basketProducts[product];
      if (value != null) {
        value++;
        basketProducts[product] = value;
      }
    }
    notifyListeners();
  }

  void increseProduct(Product product) {
    if (basketProducts[product] == null) return;
    if (basketProducts[product] == 0) {
      basketProducts.removeWhere((key, value) => key == product);
    } else {
      var value = basketProducts[product];
      if (value != null) {
        value--;
        basketProducts[product] = value;
      }
    }
    notifyListeners();
  }
}
