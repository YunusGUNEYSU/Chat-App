import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/constants/firebase_constants.dart';

abstract class IAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Future<UserCredential> signInWithEmailAndPassword(String email, String password);
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password);
}

class AuthSignInService extends IAuthService {
  @override
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      final response =
          await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      _firestore.collection(FirebaseConstants.user.value).doc(_firebaseAuth.currentUser!.uid).set({
        'uid': _firebaseAuth.currentUser!.uid,
        'email': email,
        'password': password,
      }, SetOptions(merge: true));
      return response;
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final response =
          await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      _firestore.collection('Users').doc(_firebaseAuth.currentUser!.uid).set({
        'uid': _firebaseAuth.currentUser!.uid,
        'email': email,
        'password': password,
      });
      return response;
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }
}
