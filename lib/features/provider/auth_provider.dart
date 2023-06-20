import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  late UserCredential _userCredential;
  final IAuthService _authService = AuthSignInService();
  Future<UserCredential> signInUser(String email, String password) async {
    _userCredential = await _authService.signInWithEmailAndPassword(email, password);
    notifyListeners();
    return _userCredential;
  }

  Future<UserCredential> createUser(String email, String password) async {
    _userCredential = await _authService.signUpWithEmailAndPassword(email, password);
    notifyListeners();
    return _userCredential;
  }

  Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
  }
}
