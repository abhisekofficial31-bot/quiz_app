import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AppUser {
  final String id;
  final String name;
  final String email;
  final bool isGuest;
  final String avatar;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.isGuest,
    required this.avatar,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'isGuest': isGuest,
        'avatar': avatar,
      };

  factory AppUser.fromMap(Map<String, dynamic> m) => AppUser(
        id: m['id'],
        name: m['name'],
        email: m['email'],
        isGuest: m['isGuest'] ?? false,
        avatar: m['avatar'] ?? '🧑',
      );
}

class AuthProvider extends ChangeNotifier {
  AuthStatus _status = AuthStatus.unknown;
  AppUser? _user;
  String? _error;

  AuthStatus get status => _status;
  AppUser? get user => _user;
  String? get error => _error;
  bool get isLoggedIn => _status == AuthStatus.authenticated;

  // ── Avatars to pick from ───────────────────────────────────────────────
  static const List<String> avatars = [
    '🧑', '👩', '👨', '👧', '👦', '🧑‍🦱', '👩‍🦰', '👨‍🦳',
    '🧑‍🦲', '👩‍🦱', '🧑‍💻', '👩‍🎓', '👨‍🎓', '🦸', '🧙', '🥷',
  ];

  // ── Initialize: restore session ────────────────────────────────────────
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('current_user');
    if (userJson != null) {
      try {
        _user = AppUser.fromMap(jsonDecode(userJson));
        _status = AuthStatus.authenticated;
      } catch (_) {
        _status = AuthStatus.unauthenticated;
      }
    } else {
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  // ── Sign Up ────────────────────────────────────────────────────────────
  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
    required String avatar,
  }) async {
    _error = null;
    final prefs = await SharedPreferences.getInstance();

    // Check if email already exists
    final existing = prefs.getString('user_$email');
    if (existing != null) {
      _error = 'An account with this email already exists.';
      notifyListeners();
      return false;
    }

    if (password.length < 6) {
      _error = 'Password must be at least 6 characters.';
      notifyListeners();
      return false;
    }

    final id = const Uuid().v4();
    final hashedPw = _hashPassword(password);

    final userData = {
      'id': id,
      'name': name,
      'email': email,
      'password': hashedPw,
      'isGuest': false,
      'avatar': avatar,
    };

    await prefs.setString('user_$email', jsonEncode(userData));

    _user = AppUser(
        id: id, name: name, email: email, isGuest: false, avatar: avatar);
    await _saveSession();
    _status = AuthStatus.authenticated;
    notifyListeners();
    return true;
  }

  // ── Sign In ────────────────────────────────────────────────────────────
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _error = null;
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user_$email');

    if (userJson == null) {
      _error = 'No account found with this email.';
      notifyListeners();
      return false;
    }

    final data = jsonDecode(userJson) as Map<String, dynamic>;
    final hashedPw = _hashPassword(password);

    if (data['password'] != hashedPw) {
      _error = 'Incorrect password. Please try again.';
      notifyListeners();
      return false;
    }

    _user = AppUser(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      isGuest: false,
      avatar: data['avatar'] ?? '🧑',
    );
    await _saveSession();
    _status = AuthStatus.authenticated;
    notifyListeners();
    return true;
  }

  // ── Guest Mode ─────────────────────────────────────────────────────────
  Future<void> continueAsGuest() async {
    _user = AppUser(
      id: 'guest_${const Uuid().v4()}',
      name: 'Guest Player',
      email: '',
      isGuest: true,
      avatar: '🥷',
    );
    await _saveSession();
    _status = AuthStatus.authenticated;
    notifyListeners();
  }

  // ── Update profile ─────────────────────────────────────────────────────
  Future<void> updateProfile({String? name, String? avatar}) async {
    if (_user == null) return;
    _user = AppUser(
      id: _user!.id,
      name: name ?? _user!.name,
      email: _user!.email,
      isGuest: _user!.isGuest,
      avatar: avatar ?? _user!.avatar,
    );
    await _saveSession();

    // Update stored account if not guest
    if (!_user!.isGuest) {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user_${_user!.email}');
      if (userJson != null) {
        final data = jsonDecode(userJson) as Map<String, dynamic>;
        data['name'] = _user!.name;
        data['avatar'] = _user!.avatar;
        await prefs.setString('user_${_user!.email}', jsonEncode(data));
      }
    }
    notifyListeners();
  }

  // ── Sign Out ───────────────────────────────────────────────────────────
  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user');
    _user = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  // ── Helpers ────────────────────────────────────────────────────────────
  Future<void> _saveSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user', jsonEncode(_user!.toMap()));
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password + 'quiz_master_salt_2024');
    return sha256.convert(bytes).toString();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
