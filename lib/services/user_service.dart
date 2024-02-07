import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aeroplane/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';



class UserService {
  static Future<UserModel> getLoggedInUser() async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').doc(userId).get();

      return UserModel(
          id: userId!,
          email: snapshot['email'],
          name: snapshot['name'],
          hobby: snapshot['hobby'],
          balance: snapshot['balance']);
    } catch (e) {
      throw e;
    }
  }

  CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        'email': user.email,
        'name': user.name,
        'hobby': user.hobby,
        'balance': user.balance
      });
    } catch (e) {}
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot = await _userReference.doc(id).get();

      return UserModel(
          id: id,
          email: snapshot['email'],
          name: snapshot['name'],
          hobby: snapshot['hobby'],
          balance: snapshot['balance']);
    } catch (e) {
      throw e;
    }
  }

}

