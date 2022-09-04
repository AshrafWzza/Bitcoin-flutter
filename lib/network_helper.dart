import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  var url = Uri.parse(
      'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=97586C47-214E-4083-85B7-AD60A38C1464');
  Future getData() async {
    http.Response response = await http.get(Uri.parse(url.toString()));
    if (response.statusCode == 200) {
      String data = response.body;
      print(response.statusCode);
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
