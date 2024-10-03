import 'package:dio/dio.dart';
import 'package:newwave_solution_flutter_test/home/model/api_response_model.dart';
import 'package:newwave_solution_flutter_test/home/model/place_model.dart';
import 'package:newwave_solution_flutter_test/network/api_endpoint.dart';
import 'package:newwave_solution_flutter_test/network/api_util.dart';
import 'package:newwave_solution_flutter_test/utils/constants.dart';

class SearchRepository {
  final dio = Dio();

  Future<List<Place>?> searchPlaces(String query) async {
    try {
      String at = Constants.VN;

      // Add the API key as a query parameter
      Map<String, dynamic> queryParams = {
        'q': query,
        'at': at,
        'apikey': Constants.API_KEY // Use apikey as a query parameter
      };

      var response = await dio.get(ApiEndPoints.API_AUTO_SUGGEST,
          queryParameters: queryParams);

      var jsonData = response.data;

      print('result: ${jsonData.toString()}');

      ApiResponse apiResponse = ApiResponse.fromJson(jsonData);
      List<Place> places = apiResponse.items;

      return places;
    } on DioException catch (e) {
      // Handle the error and print the response data for better debugging
      print('Error: ${e.response?.data}');
    }
    return null;
  }
}

