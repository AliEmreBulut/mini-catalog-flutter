import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mini_catalog/models/product_model.dart';


class ApiService {
  static const baseUrl = "https://wantapi.com/products.php";

  Future<ProductsModel> fetchProducts () async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return ProductsModel.fromJson(data);

    }else{
      throw Exception("Api'ye erişimde hata oluştu.");
    }
  }

}