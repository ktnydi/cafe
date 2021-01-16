import 'package:cafe/domain/shop.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:cafe/apiKey.dart';

class HomeModel extends ChangeNotifier {
  final scrollController = ScrollController();
  List<Shop> shops = [];
  int start = 1;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollListen() {
    scrollController.addListener(
      () async {
        if (scrollController.offset ==
            scrollController.position.maxScrollExtent) {
          this.start = shops.length + 1;
          await this.fetchShops();
        }
      },
    );
  }

  Future fetchShops() async {
    final params = {
      'key': apiKey,
      'address': '大阪',
      'start': '${this.start}',
      'format': 'json',
    };
    final uri = Uri.https(
      'webservice.recruit.co.jp',
      'hotpepper/gourmet/v1/',
      params,
    );
    final response = await http.get(uri);
    final jsonResponse = convert.jsonDecode(response.body);
    final List shopData = jsonResponse['results']['shop'];
    final shops = shopData
        .map(
          (data) => Shop(data: data),
        )
        .toList();
    this.shops = [...this.shops, ...shops];
    notifyListeners();
  }
}
