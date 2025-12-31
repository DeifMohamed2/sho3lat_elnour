import '../constants/api_constants.dart';
import '../models/auth/login_request.dart';
import '../models/auth/login_response.dart';
import '../models/auth/api_error.dart';
import 'api_service.dart';
import 'session_storage_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();
  final SessionStorageService _sessionStorage = SessionStorageService();

  /// Initialize and load saved session if exists
  Future<void> initialize() async {
    await _sessionStorage.initialize();
    final savedToken = await _sessionStorage.getToken();
    if (savedToken != null && savedToken.isNotEmpty) {
      _apiService.setAuthToken(savedToken);
      print('✅ [AUTH] Loaded saved session token');
    } else {
      print('ℹ️ [AUTH] No saved session found');
    }
  }

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

  /// Save session data after successful login
  Future<bool> saveSession({
    required String token,
    required Map<String, dynamic> student,
    required List<Map<String, dynamic>> students,
    Map<String, dynamic>? parent,
  }) async {
    await _sessionStorage.initialize();
    final saved = await _sessionStorage.saveSession(
      token: token,
      student: student,
      students: students,
    );
    
    // Save parent data if provided
    if (parent != null) {
      await _sessionStorage.saveParentData(parent);
      print('✅ [AUTH] Parent data saved');
    }
    
    if (saved) {
      _apiService.setAuthToken(token);
      print('✅ [AUTH] Session saved successfully');
    } else {
      print('❌ [AUTH] Failed to save session');
    }
    return saved;
  }

  /// Get saved session data
  Future<Map<String, dynamic>?> getSavedSession() async {
    await _sessionStorage.initialize();
    final hasSession = await _sessionStorage.hasSession();
    if (!hasSession) {
      return null;
    }

    final token = await _sessionStorage.getToken();
    final student = await _sessionStorage.getCurrentStudent();
    final students = await _sessionStorage.getAllStudents();
    final parent = await _sessionStorage.getParentData();

    if (token != null && student != null && students != null) {
      return {
        'token': token,
        'student': student,
        'students': students,
        if (parent != null) 'parent': parent,
      };
    }
    return null;
  }

  /// Logout - clears the stored auth token and session data
  Future<void> logout() async {
    await _sessionStorage.initialize();
    await _sessionStorage.clearSession();
    _apiService.setAuthToken(null);
    print('✅ [AUTH] Logged out and session cleared');
  }

  /// Check if user is currently authenticated
  bool get isAuthenticated => _apiService.authToken != null;

  /// Check if a saved session exists
  Future<bool> hasSavedSession() async {
    await _sessionStorage.initialize();
    return await _sessionStorage.hasSession();
  }
}

