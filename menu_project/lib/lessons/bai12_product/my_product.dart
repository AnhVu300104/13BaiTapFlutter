import 'package:flutter/material.dart';
import 'package:flutter_lessons/lessons/bai12_product/api.dart';
import 'package:flutter_lessons/lessons/bai12_product/product.dart';

const Color primaryColor = Color(0xff2979FF);
const Color bgColor = Color(0xffF5F6F8);

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  List<Product> all = [];
  List<Product> filtered = [];
  List<CartItem> cart = [];

  List<String> categories = ["All"];
  String selectedCategory = "All";
  String keyword = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    all = await test.getAllProduct();
    filtered = List.from(all);
    categories.addAll(all.map((p) => p.category).toSet().toList());
    setState(() {});
  }

  void filter() {
    filtered = all.where((p) {
      bool matchName = p.title.toLowerCase().contains(keyword.toLowerCase());
      bool matchCate = selectedCategory == "All" || p.category == selectedCategory;
      return matchName && matchCate;
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: buildSearchBar(),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartPage(cart)),
              ).then((_) => setState(() {})); // Reload để cập nhật giỏ hàng nếu có xóa bên kia
            },
          )
        ],
      ),
      body: all.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                buildCategoryBar(),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: filtered.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.62),
                    itemBuilder: (context, index) =>
                        productCard(filtered[index]),
                  ),
                )
              ],
            ),
    );
  }

  Widget buildSearchBar() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: const InputDecoration(
          hintText: "Tìm kiếm sản phẩm...",
          border: InputBorder.none,
          icon: Icon(Icons.search),
        ),
        onChanged: (v) {
          keyword = v;
          filter();
        },
      ),
    );
  }

  Widget buildCategoryBar() {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categories.map((c) {
          bool selected = c == selectedCategory;
          return GestureDetector(
            onTap: () {
              selectedCategory = c;
              filter();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: selected ? primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: primaryColor),
              ),
              child: Center(
                child: Text(
                  c,
                  style: TextStyle(
                    color: selected ? Colors.white : primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget productCard(Product p) {
    return GestureDetector(
      onTap: () => goDetail(p),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 4,
        shadowColor: Colors.black12,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.network(p.image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Đã bán: ${p.count}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 18),
                Text("${p.rate} (${p.count})",
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              "\$${p.price}",
              style: const TextStyle(
                  color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => addToCart(p),
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: const Text("Thêm giỏ hàng"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addToCart(Product p) {
    final index = cart.indexWhere((item) => item.product.id == p.id);
    if (index >= 0) {
      cart[index].quantity++;
    } else {
      cart.add(CartItem(product: p));
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Đã thêm vào giỏ!")));
    setState(() {});
  }

  void goDetail(Product p) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProductDetail(p, addToCart)),
    );
  }
}

class ProductDetail extends StatelessWidget {
  final Product p;
  final Function(Product) addToCart;
  const ProductDetail(this.p, this.addToCart, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(p.title),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Image.network(p.image, height: 250),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                p.title,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange),
                  Text("${p.rate} • ${p.count} đánh giá"),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                "\$${p.price}",
                style: const TextStyle(
                    fontSize: 28,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                "Đã bán: ${p.count}",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                p.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          onPressed: () => addToCart(p),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text("THÊM VÀO GIỎ HÀNG", style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  final List<CartItem> cart;
  const CartPage(this.cart, {super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void increaseQuantity(CartItem item) {
    setState(() {
      item.quantity++;
    });
  }

  void decreaseQuantity(CartItem item) {
    setState(() {
      if (item.quantity > 1) {
        item.quantity--;
      }
    });
  }

  // --- MỚI THÊM: Hàm xóa hẳn item khỏi giỏ ---
  void removeItem(CartItem item) {
    setState(() {
      widget.cart.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    double total = widget.cart.fold(
        0, (sum, item) => sum + item.product.price * item.quantity);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Giỏ hàng"),
      ),
      body: widget.cart.isEmpty
          ? const Center(child: Text("Giỏ hàng trống!"))
          : ListView(
              children: widget.cart.map((item) {
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.network(item.product.image, width: 50),
                    title: Text(item.product.title),
                    subtitle: Text(
                        "\$${item.product.price} x ${item.quantity} = \$${(item.product.price * item.quantity).toStringAsFixed(2)}"),
                    trailing: SizedBox(
                      width: 150, // --- SỬA: Tăng width để chứa đủ 3 nút ---
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => decreaseQuantity(item),
                          ),
                          Text(item.quantity.toString()),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => increaseQuantity(item),
                          ),
                          // --- MỚI THÊM: Nút Xóa (Thùng rác) ---
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => removeItem(item),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
      bottomNavigationBar: widget.cart.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Tổng tiền",
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "\$${total.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Thanh toán thành công!")),
                        );
                        setState(() {
                          widget.cart.clear();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Thanh toán",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}