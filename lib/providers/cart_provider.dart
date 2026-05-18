
import 'package:flutter/material.dart';
import '../models/item.dart';

class CartProvider with ChangeNotifier {
// قائمة العناصر المضافة إلى السلة
final List<Item> _cartItems = [];

List<Item> get cartItems => _cartItems;

// حساب السعر الإجمالي
double get totalAmount {
  return _cartItems.fold(0.0, (sum, item) => sum + item.price);
}

// إضافة عنصر للسلة وإعلام الواجهات لإعادة البناء
void addItem(Item item) {
  _cartItems.add(item);
  notifyListeners(); // هذه الدالة السحرية التي تشرحها المحاضرة لتحديث الواجهات
}

// إزالة عنصر من السلة
void removeItem(Item item) {
  _cartItems.remove(item);
  notifyListeners();
}
}
