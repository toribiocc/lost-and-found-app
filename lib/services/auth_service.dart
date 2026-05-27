import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> registerUser({
    required String username,
    required String email,
    required String password,
    required String avatarUrl,
}) async {

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
      );

      String uid = userCredential.user!.uid;

      UserModel user = UserModel(uid: uid, username: username, email: email, avatarUrl: avatarUrl);

      await _firestore.collection('users').doc(uid).set(user.toMap());

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> loginUser({
    required String email,
    required String password,
}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;


  }
}
