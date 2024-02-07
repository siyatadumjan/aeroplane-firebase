import 'package:cloud_firestore/cloud_firestore.dart';
import 'transactionModel.dart';

class BookingModel {
  final String id;
  final String userId;
  final String transactionId;
  final List<String> seatNumber;
  final String date;

  BookingModel({
    required this.id,
    required this.userId,
    required this.transactionId,
    required this.seatNumber,
    required this.date,
  });

  factory BookingModel.fromTransactionModel(
      String id, String userId, TransactionModel transaction) {
    return BookingModel(
      id: id,
      userId: userId,
      transactionId: transaction.transactionId!,
      seatNumber: transaction.seatNumbers,
      date: transaction.date,
    );
  }
}
