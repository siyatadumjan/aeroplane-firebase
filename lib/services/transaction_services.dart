import 'dart:convert';

import 'package:aeroplane'
    '/models/user_model.dart';
import 'package:aeroplane/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/transactionModel.dart';

class TransactionService {
  static final userId = FirebaseAuth.instance.currentUser!.uid;

  static Future<UserModel> getLoggedInUser() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      return UserModel(
        id: userId,
        email: snapshot['email'],
        name: snapshot['name'],
        hobby: snapshot['hobby'],
        balance: snapshot['balance'],
      );
    } catch (e) {
      throw e;
    }
  }

  static Future<TransactionModel> createTransaction({
    required int total,
    required String noOfTickets,
    required String sourceLocation,
    required String destinationLocation,
    required String date,
    required List<String> seatNumbers,
  }) async {
    try {
      UserModel user = await UserService.getLoggedInUser();
      int balance = user.balance!;
      balance = balance - total;
      final transactionRef =
      FirebaseFirestore.instance.collection('transactions').doc();

      // Update the user's balance in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'balance': balance});

      // Create a transaction document in Firestore
      final transactionData = {
        'transactionId': "Aeroplane${transactionRef.id}",
        'userId': userId,
        'noOfTickets': noOfTickets,
        'sourceLocation': sourceLocation,
        'destinationLocation': destinationLocation,
        'date': date,
        'seatNumbers': seatNumbers,
        'total': total,
      };

      await transactionRef.set(transactionData);

      return TransactionModel(
        transactionId: transactionRef.id,
        userId: userId,
        total: total,
        noOfTickets: noOfTickets,
        sourceLocation: sourceLocation,
        destinationLocation: destinationLocation,
        date: date,
        seatNumbers: seatNumbers,
      );
    } catch (error) {
      // Handle any errors that occur during the transaction
      print('Transaction failed: $error');
      rethrow;
    }
  }

  static Future<int> getTotalBalance() async {
    try {
      UserModel user = await UserService.getLoggedInUser();
      int balance = user.balance!;
      return balance;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<TransactionModel>> getTransactionsByUserId() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('transactions')
          .where('userId', isEqualTo: userId)
          .get();

      return querySnapshot.docs
          .map((doc) => TransactionModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      throw e;
    }
  }
}