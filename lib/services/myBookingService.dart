import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/myBookingModel.dart';
import '../models/transactionModel.dart';

class BookingService {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<List<TransactionModel>> getTransactionsByUserId() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('transactions')
          .where('userId', isEqualTo: userId)
          .get();

      final transactions = querySnapshot.docs
          .map((doc) => TransactionModel.fromSnapshot(doc))
          .toList();

      return transactions;
    } catch (e) {
      rethrow;
    }
  }

}
