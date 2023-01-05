import 'dart:convert';
import 'package:dataprovider/globals/global.dart';
import 'package:dataprovider/model/models.dart';
import 'package:http/http.dart' as http;

class ApiHelpers {
  ApiHelpers._();

  static final ApiHelpers apiHelpers = ApiHelpers._();

  String baseURI = "https://jsonplaceholder.typicode.com";

  Future<List<Provider>?> getData() async {
    String api = baseURI + Global.endpoint;
    http.Response data = await http.get(Uri.parse(api));

    if (data.statusCode == 200) {
      List decodeData = jsonDecode(data.body);
      List<Provider> allData =
          decodeData.map((e) => Provider.fromMap(data: e)).toList();

      return allData;
    }
    return null;
  }
}
