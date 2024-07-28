import 'package:buksam_flutter_practicum/data/models/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class FirebaseUserService {
  final _userCollection = FirebaseFirestore.instance.collection("users");

  Stream<List<User>> getUsers() {
    // birinchi return'da collection ichiga kiryapmiz (table)
    return _userCollection.snapshots().map((querySnapshot) {
      // ikkinchi return'da collection ichidagi hujjatlarga kiryapmiz (rows)
      return querySnapshot.docs.map((doc) {
        // uchinchi return'da har bitta hujjatni (row)
        // User obyektiga aylantiryapmiz
        return User.fromMap(doc.data());
      }).toList();
    });
  }

  Future<void> addUser(User user) async {
    try {
      await _userCollection.doc(user.id).set(user.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editUser(String id, User user) async {
    try {
      await _userCollection.doc(id).update(user.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _userCollection.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addBookSummary(String id, Book book) async {
    try {
      await _userCollection.doc(id).set(
        {"history": book},
        SetOptions(
          merge: true,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
