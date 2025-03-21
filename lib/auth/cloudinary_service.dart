import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class CloudinaryService {
  final String cloudName;
  final String uploadPreset;
  final Dio _dio = Dio();

  CloudinaryService({
    required this.cloudName,
    required this.uploadPreset,
  });

  Future<String> uploadImage(File imageFile) async {
    try {
      // Create form data
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
        ),
        'upload_preset': uploadPreset,
      });

      // Make the request
      final response = await _dio.post(
        'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
        data: formData,
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        return response.data['secure_url'];
      } else {
        throw Exception('Failed to upload image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading to Cloudinary: $e');
      rethrow;
    }
  }
}