import 'package:dio/dio.dart';
import 'gallery_item_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = "https://ajcjewel.com:4000/api/global-gallery/list";
  final String _token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfdXNlcklkXyI6IjYzMDI2ZjIxNWE5ZDVjNDY1NzQ3MTMxYSIsIl9lbXBsb3llZUlkXyI6IjYzMDI2ZjIxYTI1MTZhMTU0YTUxY2YxOSIsIl91c2VyUm9sZV8iOiJzdXBlcl9hZG1pbiIsImlhdCI6MTcyNjEyNTUzNCwiZXhwIjoxNzU3NjYxNTM0fQ.WtYYgVWtxVQlbwoIKddHcUGGAKRKMIJayaRHzqjtRU";

  ApiProvider() {
    _dio.options.headers['Authorization'] = 'Bearer $_token';
    _dio.options.validateStatus = (status) {
      return status! < 500;
    };
  }

  Future<List<GalleryItem>> fetchGalleryItems() async {
    try {
      final response = await _dio.post(_url, data: {
        "statusArray": [1],
        "screenType": [],
        "responseFormat": [],
        "globalGalleryIds": [],
        "categoryIds": [],
        "docTypes": [],
        "types": [],
        "limit": 10,
        "skip": 0,
        "searchingText": ""
      });

      if (response.statusCode == 200) {
        final List<dynamic> itemsJson = response.data['data']['list'];
        return itemsJson.map((json) => GalleryItem.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please check your authentication token');
      } else {
        throw Exception('Failed to load gallery items. Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized: Please check your authentication token');
      } else {
        throw Exception('Error occurred: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
// import 'package:dio/dio.dart';
// import 'gallery_item_model.dart';
//
// class ApiProvider {
//   final Dio _dio = Dio();
//   final String _url = "https://ajcjewel.com:4000/api/global-gallery/list";
//   final String _token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfdXNlcklkXyI6IjYzMDI2ZjIxNWE5ZDVjNDY1NzQ3MTMxYSIsIl9lbXBsb3llZUlkXyI6IjYzMDI2ZjIxYTI1MTZhMTU0YTUxY2YxOSIsIl91c2VyUm9sZV8iOiJzdXBlcl9hZG1pbiIsImlhdCI6MTcyNjEyNTUzNCwiZXhwIjoxNzU3NjYxNTM0fQ.WtYYgVWtxVQlbwoIKddHcUGGAKRKMIJayaRHzqjtRU";
//
//   ApiProvider() {
//     _dio.options.headers['Authorization'] = 'Bearer $_token';
//     _dio.options.validateStatus = (status) {
//       return status! < 500;
//     };
//   }
//
//   Future<List<GalleryItem>> fetchGalleryItems() async {
//     try {
//       final response = await _dio.post(_url, data: {
//         // ... your request body ...
//       });
//
//       if (response.statusCode == 200) {
//         // ... (parse your response data) ...
//       } else if (response.statusCode == 401) {
//         throw Exception('Unauthorized: Invalid or expired token.');
//       } else {
//         throw Exception('Failed to load gallery items. Status code: ${response.statusCode}');
//       }
//     } on DioException catch (e) {
//       // ... handle Dio-specific exceptions, potentially with more detail ...
//     } catch (e) {
//       throw Exception('Unexpected error: $e');
//     }
//   }
// }