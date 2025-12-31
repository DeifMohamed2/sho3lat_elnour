import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../models/auth/api_error.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  String? _authToken;

  void setAuthToken(String? token) {
    _authToken = token;
  }

  String? get authToken => _authToken;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (_authToken != null) 'Authorization': 'Bearer $_authToken',
      };

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? additionalHeaders,
  }) async {
    try {
      final url = Uri.parse(ApiConstants.getUrl(endpoint));
      final headers = {
        ..._headers,
        ...?additionalHeaders,
      };

      print('📤 [API] POST Request to: ${url.toString()}');
      print('📤 [API] Headers: ${headers.toString()}');
      print('📤 [API] Body: ${jsonEncode(body)}');

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          print('⏱️ [API] Request timeout');
          throw ApiError.fromString(
            'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى',
            statusCode: 408,
          );
        },
      );

      print('📥 [API] Response Status: ${response.statusCode}');
      print('📥 [API] Response Body: ${response.body}');

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('✅ [API] Request successful');
        return responseData;
      } else {
        print('❌ [API] Request failed with status ${response.statusCode}');
        throw ApiError.fromJson(responseData, statusCode: response.statusCode);
      }
    } on http.ClientException catch (e) {
      throw ApiError.fromString(
        'خطأ في الاتصال بالخادم: ${e.message}',
        statusCode: 0,
      );
    } on FormatException {
      throw ApiError.fromString(
        'خطأ في تنسيق البيانات المستلمة من الخادم',
        statusCode: 0,
      );
    } on ApiError {
      rethrow;
    } catch (e) {
      throw ApiError.fromString(
        'حدث خطأ غير متوقع: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? queryParameters,
    Map<String, String>? additionalHeaders,
  }) async {
    try {
      var url = Uri.parse(ApiConstants.getUrl(endpoint));
      
      if (queryParameters != null && queryParameters.isNotEmpty) {
        url = url.replace(queryParameters: queryParameters);
      }

      final headers = {
        ..._headers,
        ...?additionalHeaders,
      };

      final response = await http.get(
        url,
        headers: headers,
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw ApiError.fromString(
            'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى',
            statusCode: 408,
          );
        },
      );

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return responseData;
      } else {
        throw ApiError.fromJson(responseData, statusCode: response.statusCode);
      }
    } on http.ClientException catch (e) {
      throw ApiError.fromString(
        'خطأ في الاتصال بالخادم: ${e.message}',
        statusCode: 0,
      );
    } on FormatException {
      throw ApiError.fromString(
        'خطأ في تنسيق البيانات المستلمة من الخادم',
        statusCode: 0,
      );
    } on ApiError {
      rethrow;
    } catch (e) {
      throw ApiError.fromString(
        'حدث خطأ غير متوقع: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  Future<Map<String, dynamic>> patch(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? additionalHeaders,
  }) async {
    try {
      final url = Uri.parse(ApiConstants.getUrl(endpoint));
      final headers = {
        ..._headers,
        ...?additionalHeaders,
      };

      print('📤 [API] PATCH Request to: ${url.toString()}');
      print('📤 [API] Headers: ${headers.toString()}');
      print('📤 [API] Body: ${jsonEncode(body)}');

      final response = await http.patch(
        url,
        headers: headers,
        body: jsonEncode(body),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          print('⏱️ [API] Request timeout');
          throw ApiError.fromString(
            'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى',
            statusCode: 408,
          );
        },
      );

      print('📥 [API] Response Status: ${response.statusCode}');
      print('📥 [API] Response Body: ${response.body}');

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('✅ [API] Request successful');
        return responseData;
      } else {
        print('❌ [API] Request failed with status ${response.statusCode}');
        throw ApiError.fromJson(responseData, statusCode: response.statusCode);
      }
    } on http.ClientException catch (e) {
      throw ApiError.fromString(
        'خطأ في الاتصال بالخادم: ${e.message}',
        statusCode: 0,
      );
    } on FormatException {
      throw ApiError.fromString(
        'خطأ في تنسيق البيانات المستلمة من الخادم',
        statusCode: 0,
      );
    } on ApiError {
      rethrow;
    } catch (e) {
      throw ApiError.fromString(
        'حدث خطأ غير متوقع: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? additionalHeaders,
  }) async {
    try {
      final url = Uri.parse(ApiConstants.getUrl(endpoint));
      final headers = {
        ..._headers,
        ...?additionalHeaders,
      };

      print('📤 [API] PUT Request to: ${url.toString()}');
      print('📤 [API] Headers: ${headers.toString()}');
      print('📤 [API] Body: ${jsonEncode(body)}');

      final response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(body),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          print('⏱️ [API] Request timeout');
          throw ApiError.fromString(
            'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى',
            statusCode: 408,
          );
        },
      );

      print('📥 [API] Response Status: ${response.statusCode}');
      print('📥 [API] Response Body: ${response.body}');

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('✅ [API] Request successful');
        return responseData;
      } else {
        print('❌ [API] Request failed with status ${response.statusCode}');
        throw ApiError.fromJson(responseData, statusCode: response.statusCode);
      }
    } on http.ClientException catch (e) {
      throw ApiError.fromString(
        'خطأ في الاتصال بالخادم: ${e.message}',
        statusCode: 0,
      );
    } on FormatException {
      throw ApiError.fromString(
        'خطأ في تنسيق البيانات المستلمة من الخادم',
        statusCode: 0,
      );
    } on ApiError {
      rethrow;
    } catch (e) {
      throw ApiError.fromString(
        'حدث خطأ غير متوقع: ${e.toString()}',
        statusCode: 0,
      );
    }
  }
}

