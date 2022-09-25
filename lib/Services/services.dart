import 'package:debt_and_loan/Services/dio_client.dart';
import 'package:dio/dio.dart';

import '../Model/model.dart';

class ClientServices {
  static Dio dio = DioClient.dio;

   Future<List<ClientDetails>?> fetchPosts(int page) async {
    try {
      var response = await dio.get('/flutterTest.php?pageNo=$page');

      TotalModelData totalModelData = TotalModelData.fromJson(response.data);
      return totalModelData.data;
    } on DioError catch (e) {
      return [];
    }
  }




  // static Future<List<ClientDetails>?> clientServices() async {
  //   try {
  //     var response = await dio.get('/flutterTest.php');

  //     TotalModelData totalModelData = TotalModelData.fromJson(response.data);
  //     return totalModelData.data;
  //   } on DioError catch (e) {
  //     return [];
  //   }
  // }
}
