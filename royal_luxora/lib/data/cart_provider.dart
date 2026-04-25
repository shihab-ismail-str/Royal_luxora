import 'package:flutter/foundation.dart';
import '../models/models.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [

CartItem(
  product: allProducts.firstWhere((p) => p.id == 'w_d1'),
  quantity: 1,
  selectedSize: 'M',
  selectedColor: '#3D1F8C',
),
CartItem(
  product: allProducts.firstWhere((p) => p.id == 'a_b1'),
  quantity: 1,
  selectedSize: 'One Size',
  selectedColor: '#1F2937',
),
CartItem(
  product: allProducts.firstWhere((p) => p.id == 'a_w1'),
  quantity: 1,
  selectedSize: 'One Size',
  selectedColor: '#D97706',
),


  ];

  List<CartItem> get items => _items;

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0, (sum, item) => sum + item.total);

  double get total => subtotal;

  void addToCart(Product product, {String size = 'M', String color = ''}) {
    final idx = _items.indexWhere((i) => i.product.id == product.id);
    if (idx >= 0) {
      _items[idx].quantity++;
    } else {
      _items.add(CartItem(
        product: product,
        quantity: 1,
        selectedSize: size,
        selectedColor: color.isEmpty ? (product.colors.isNotEmpty ? product.colors.first : '') : color,
      ));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.removeWhere((i) => i.product.id == productId);
    notifyListeners();
  }

  void incrementQty(String productId) {
    final idx = _items.indexWhere((i) => i.product.id == productId);
    if (idx >= 0) {
      _items[idx].quantity++;
      notifyListeners();
    }
  }

  void decrementQty(String productId) {
    final idx = _items.indexWhere((i) => i.product.id == productId);
    if (idx >= 0) {
      if (_items[idx].quantity > 1) {
        _items[idx].quantity--;
      } else {
        _items.removeAt(idx);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
