import 'package:flutter/material.dart';
import 'package:mini_catalog/models/product_model.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Data> products;
  final Set<int> cartIds;
  const CheckoutScreen({super.key, required this.products, required this.cartIds});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  String selectedPaymentMethod = "Credit Card";

  double calculateTotal() {
    final cartProducts = widget.products.where((product) => widget.cartIds.contains(product.id)).toList();
    double total = 0;
    for (var product in cartProducts) {
      String priceString = product.price ?? "0";
      priceString = priceString.replaceAll(RegExp(r'[^\d.]'), '');
      total += double.tryParse(priceString) ?? 0;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final cartProducts = widget.products.where((product) => widget.cartIds.contains(product.id)).toList();
    final total = calculateTotal();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Checkout", style: TextStyle(color: Colors.black)),
        leadingWidth: 20,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Summary",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),

                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      ...cartProducts.map((product) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                product.name ?? "",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Text(
                              product.price ?? "",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade800,
                              ),
                            ),
                          ],
                        ),
                      )),
                      Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "\$${total.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                Text(
                  "Shipping Information",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),

                Container(
                  decoration: BoxDecoration(
                    color: Color(0xfff5f5f7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Full Name",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.person_outline, color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Container(
                  decoration: BoxDecoration(
                    color: Color(0xfff5f5f7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.phone_outlined, color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Container(
                  decoration: BoxDecoration(
                    color: Color(0xfff5f5f7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: addressController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Delivery Address",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.location_on_outlined, color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                    ),
                  ),
                ),

                SizedBox(height: 24),

                Text(
                  "Payment Method",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPaymentMethod = "Credit Card";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: selectedPaymentMethod == "Credit Card" ? Colors.black : Color(0xfff5f5f7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.credit_card,
                                color: selectedPaymentMethod == "Credit Card" ? Colors.white : Colors.grey,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Card",
                                style: TextStyle(
                                  color: selectedPaymentMethod == "Credit Card" ? Colors.white : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPaymentMethod = "Cash";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: selectedPaymentMethod == "Cash" ? Colors.black : Color(0xfff5f5f7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.money,
                                color: selectedPaymentMethod == "Cash" ? Colors.white : Colors.grey,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Cash",
                                style: TextStyle(
                                  color: selectedPaymentMethod == "Cash" ? Colors.white : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                if (selectedPaymentMethod == "Credit Card") ...[
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xfff5f5f7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: cardNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Card Number",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.credit_card, color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xfff5f5f7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: expiryController,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              hintText: "MM/YY",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.calendar_today, color: Colors.grey),
                              contentPadding: EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xfff5f5f7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: cvvController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "CVV",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                              contentPadding: EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

                SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isEmpty ||
                        phoneController.text.isEmpty ||
                        addressController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please fill all shipping information"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red.shade600,
                            margin: EdgeInsets.only(
                              bottom: 70,
                              left: 20,
                              right: 20,
                            ),
                          )
                      );
                      return;
                    }

                    if (selectedPaymentMethod == "Credit Card" &&
                        (cardNumberController.text.isEmpty ||
                            expiryController.text.isEmpty ||
                            cvvController.text.isEmpty)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please fill all card information"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red.shade600,
                            margin: EdgeInsets.only(
                              bottom: 70,
                              left: 20,
                              right: 20,
                            ),
                          )
                      );
                      return;
                    }

                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green, size: 28),
                            SizedBox(width: 8),
                            Text("Order Confirmed!"),
                          ],
                        ),
                        content: Text(
                          "Your order has been placed successfully. We'll send you a confirmation email shortly.",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              widget.cartIds.clear();
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            },
                            child: Text("Continue Shopping", style: TextStyle(color: Colors.blue.shade800)),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Place Order - \$${total.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    cardNumberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }
}