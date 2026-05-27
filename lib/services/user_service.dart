import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  Future<DocumentSnapshot> getUserData() async {

    return await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();
  }

  Future<void> updateProfile({
    required String name,
    required String avatarUrl,
  }) async {

    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .update({

      'name': name,
      'avatarUrl': avatarUrl,
    });

    QuerySnapshot posts =
    await _firestore
        .collection('posts')
        .where(
      'userId',
      isEqualTo:
      _auth.currentUser!.uid,
    )
        .get();

    for (var doc in posts.docs) {

      await doc.reference.update({

        'userName': name,
        'userAvatar': avatarUrl,
      });
    }
  }


}