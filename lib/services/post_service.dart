import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/post_model.dart';

class PostService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> createPost({
    required String type,
    required String itemName,
    required String description,
    required String location,
    required String category,
    required String contactInfo,
  }) async {

    try {

      String docId = _firestore.collection('posts').doc().id;

      DocumentSnapshot userDoc =
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();

      final userData =
      userDoc.data() as Map<String, dynamic>;

      PostModel post = PostModel(
        id: docId,
        type: type,
        itemName: itemName,
        description: description,
        location: location,
        category: category,
        userId: _auth.currentUser!.uid,
        userName: userData['name'],
        userAvatar: userData['avatarUrl'],
        status: 'active',
        contactInfo: contactInfo,
      );

      await _firestore
          .collection('posts')
          .doc(docId)
          .set(post.toMap());

      return null;

    } catch (e) {

      return e.toString();
    }
  }

  Stream<QuerySnapshot> getPosts() {
    return _firestore
        .collection('posts')
        .snapshots();
  }

  Future<void> deletePost(String postId) async {

    await _firestore
        .collection('posts')
        .doc(postId)
        .delete();
  }

  Future<void> markPostResolved(
      String postId,
      ) async {

    await _firestore
        .collection('posts')
        .doc(postId)
        .update({

      'status': 'resolved',
    });
  }

  Future<void> updatePost({
    required String postId,
    required String itemName,
    required String description,
    required String location,
    required String category,
    required String contactInfo,
  }) async {

    await _firestore
        .collection('posts')
        .doc(postId)
        .update({

      'itemName': itemName,
      'description': description,
      'location': location,
      'category': category,
      'contactInfo': contactInfo,
    });
  }

  Stream<QuerySnapshot> getLostPosts() {

    return _firestore
        .collection('posts')
        .where('type', isEqualTo: 'lost')
        .snapshots();
  }

  Stream<QuerySnapshot> getFoundPosts() {

    return _firestore
        .collection('posts')
        .where('type', isEqualTo: 'found')
        .snapshots();
  }
}