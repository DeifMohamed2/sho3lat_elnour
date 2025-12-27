import '../constants/api_constants.dart';
import '../models/auth/login_request.dart';
import '../models/auth/login_response.dart';
import '../models/auth/api_error.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  /// Login with phone number and student code
  /// 
  /// Returns [LoginResponse] on success
  /// Throws [ApiError] on failure
  Future<LoginResponse> login(LoginRequest request) async {
    print('🔐 [AUTH] Starting login process...');
    print('🔐 [AUTH] Phone Number: ${request.phoneNumber}');
    print('🔐 [AUTH] Student Code: ${request.studentCode}');
    print('🔐 [AUTH] FCM Token: ${request.fcmToken ?? "Not provided"}');
    
    try {
      print('🔐 [AUTH] Sending login request...');
      final requestBody = request.toJson();
      print('🔐 [AUTH] Request body: $requestBody');
      
      final response = await _apiService.post(
        ApiConstants.loginEndpoint,
        requestBody,
      );

      print('🔐 [AUTH] Received response, parsing...');
      final loginResponse = LoginResponse.fromJson(response);
      
      print('🔐 [AUTH] Login Response parsed successfully');
      print('🔐 [AUTH] Success: ${loginResponse.success}');
      print('🔐 [AUTH] Message: ${loginResponse.message}');
      print('🔐 [AUTH] Message (EN): ${loginResponse.messageEn}');
      print('🔐 [AUTH] Token received: ${loginResponse.token.isNotEmpty ? "${loginResponse.token.substring(0, 20)}..." : "Empty"}');
      print('🔐 [AUTH] Student count: ${loginResponse.students.length}');
      print('🔐 [AUTH] Has blocked students: ${loginResponse.hasBlockedStudents}');
      print('🔐 [AUTH] Blocked count: ${loginResponse.blockedCount}');
      
      // Store the auth token for future requests
      if (loginResponse.token.isNotEmpty) {
        _apiService.setAuthToken(loginResponse.token);
        print('✅ [AUTH] Auth token stored successfully');
      } else {
        print('⚠️ [AUTH] Warning: Empty token received');
      }

      print('✅ [AUTH] Login successful!');
      return loginResponse;
    } on ApiError catch (e) {
      print('❌ [AUTH] Login failed with ApiError');
      print('❌ [AUTH] Error message: ${e.message}');
      print('❌ [AUTH] Error message (EN): ${e.messageEn}');
      print('❌ [AUTH] Status code: ${e.statusCode}');
      if (e.blockReason != null) {
        print('❌ [AUTH] Block reason: ${e.blockReason}');
      }
      rethrow;
    } catch (e) {
      print('❌ [AUTH] Login failed with unexpected error: $e');
      if (e is ApiError) {
        rethrow;
      }
      throw ApiError.fromString(
        'حدث خطأ أثناء تسجيل الدخول: ${e.toString()}',
      );
    }
  }

  /// Logout - clears the stored auth token
  void logout() {
    _apiService.setAuthToken(null);
  }

  /// Check if user is currently authenticated
  bool get isAuthenticated => _apiService.authToken != null;
}

