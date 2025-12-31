import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing user session persistence
/// Stores authentication token and user data locally
class SessionStorageService {
  static const String _keyToken = 'auth_token';
  static const String _keyStudent = 'current_student';
  static const String _keyStudents = 'all_students';
  static const String _keyParent = 'parent_data';

  static final SessionStorageService _instance = SessionStorageService._internal();
  factory SessionStorageService() => _instance;
  SessionStorageService._internal();

  SharedPreferences? _prefs;

  /// Initialize the service - must be called before use
  Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Save authentication token
  Future<bool> saveToken(String token) async {
    await initialize();
    return await _prefs!.setString(_keyToken, token);
  }

  /// Get saved authentication token
  Future<String?> getToken() async {
    await initialize();
    return _prefs!.getString(_keyToken);
  }

  /// Save parent data
  Future<bool> saveParentData(Map<String, dynamic> parent) async {
    await initialize();
    return await _prefs!.setString(_keyParent, jsonEncode(parent));
  }

  /// Get saved parent data
  Future<Map<String, dynamic>?> getParentData() async {
    await initialize();
    final parentJson = _prefs!.getString(_keyParent);
    if (parentJson == null) return null;
    try {
      return jsonDecode(parentJson) as Map<String, dynamic>;
    } catch (e) {
      print('❌ [SESSION] Error parsing parent data: $e');
      return null;
    }
  }

  /// Save current student data
  Future<bool> saveCurrentStudent(Map<String, dynamic> student) async {
    await initialize();
    return await _prefs!.setString(_keyStudent, jsonEncode(student));
  }

  /// Get saved current student data
  Future<Map<String, dynamic>?> getCurrentStudent() async {
    await initialize();
    final studentJson = _prefs!.getString(_keyStudent);
    if (studentJson == null) return null;
    try {
      return jsonDecode(studentJson) as Map<String, dynamic>;
    } catch (e) {
      print('❌ [SESSION] Error parsing student data: $e');
      return null;
    }
  }

  /// Save all students list
  Future<bool> saveAllStudents(List<Map<String, dynamic>> students) async {
    await initialize();
    return await _prefs!.setString(_keyStudents, jsonEncode(students));
  }

  /// Get saved all students list
  Future<List<Map<String, dynamic>>?> getAllStudents() async {
    await initialize();
    final studentsJson = _prefs!.getString(_keyStudents);
    if (studentsJson == null) return null;
    try {
      final List<dynamic> decoded = jsonDecode(studentsJson) as List<dynamic>;
      return decoded.map((item) => item as Map<String, dynamic>).toList();
    } catch (e) {
      print('❌ [SESSION] Error parsing students data: $e');
      return null;
    }
  }

  /// Save complete session (token, student, students)
  Future<bool> saveSession({
    required String token,
    required Map<String, dynamic> student,
    required List<Map<String, dynamic>> students,
  }) async {
    await initialize();
    try {
      final tokenSaved = await saveToken(token);
      final studentSaved = await saveCurrentStudent(student);
      final studentsSaved = await saveAllStudents(students);
      
      print('💾 [SESSION] Session saved:');
      print('   - Token: ${tokenSaved ? "Saved" : "Failed"}');
      print('   - Student: ${studentSaved ? "Saved" : "Failed"}');
      print('   - Students: ${studentsSaved ? "Saved" : "Failed"}');
      
      return tokenSaved && studentSaved && studentsSaved;
    } catch (e) {
      print('❌ [SESSION] Error saving session: $e');
      return false;
    }
  }

  /// Check if a session exists
  Future<bool> hasSession() async {
    await initialize();
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  /// Clear all session data (logout)
  Future<bool> clearSession() async {
    await initialize();
    try {
      final tokenRemoved = await _prefs!.remove(_keyToken);
      final studentRemoved = await _prefs!.remove(_keyStudent);
      final studentsRemoved = await _prefs!.remove(_keyStudents);
      
      print('🗑️ [SESSION] Session cleared:');
      print('   - Token: ${tokenRemoved ? "Removed" : "Failed"}');
      print('   - Student: ${studentRemoved ? "Removed" : "Failed"}');
      print('   - Students: ${studentsRemoved ? "Removed" : "Failed"}');
      
      return tokenRemoved && studentRemoved && studentsRemoved;
    } catch (e) {
      print('❌ [SESSION] Error clearing session: $e');
      return false;
    }
  }
}

