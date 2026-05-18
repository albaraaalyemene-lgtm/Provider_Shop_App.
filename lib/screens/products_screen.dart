import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة بيانات وهمية للمنتجات
    final List<Item> dummyProducts = [
      Item(id: 'p1', title: 'شاحن أنكر ذكي', price: 25.0),
      Item(id: 'p2', title: 'سماعة بلوتوث لاسلكية', price: 45.0),
      Item(id: 'p3', title: 'ساعة ذكية مقاومة للماء', price: 89.0),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('متجر المهندس براء'),
        actions: [
          // أيقونة السلة في شريط التطبيق تقرأ العداد بشكل ديناميكي
          Consumer<CartProvider>(
            builder: (context, cart, child) => Badge(
              label: Text(cart.cartItems.length.toString()),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dummyProducts.length,

        itemBuilder: (context, index) {
          final product = dummyProducts[index];
          return ProductItemCard(product: product);
        },
      ),
    );
  }
}

// استخدام StatefulWidget لإدارة الحالة المحلية (Local State) مثل زر المفضلة
class ProductItemCard extends StatefulWidget {
  final Item product;
  const ProductItemCard({super.key, required this.product});

  @override
  State<ProductItemCard> createState() => _ProductItemCardState();
}

class _ProductItemCardState extends State<ProductItemCard> {
  bool _isFavorite = false; // حالة محلية خاصة بكل بطاقة على حدة

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: ListTile(
        title: Text(widget.product.title),
        subtitle: Text('\$${widget.product.price}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // إدارة الحالة المحلية بواسطة setState
            IconButton(
              icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Colors.red,
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
            ),
            // إدارة الحالة المشتركة بواسطة Provider
            IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              color: Colors.blue,
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).addItem(widget.product);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تمت الإضافة للسلة بنجاح!'), duration: Duration(seconds: 1)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
