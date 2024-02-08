import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String? userId;
  final String? transactionId;
  final int? total;
  final String noOfTickets;
  final String sourceLocation;
  final String destinationLocation;
  final String date;
  final List<String> seatNumbers;

  TransactionModel({
    this.userId,
    required this.transactionId,
    required this.total,
    required this.noOfTickets,
    required this.sourceLocation,
    required this.destinationLocation,
    required this.date,
    required this.seatNumbers,
  });

  factory TransactionModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return TransactionModel(
      userId: data['userId'] ?? '',
      transactionId: data['transactionId'] ?? '',
      total: data['total'] ?? 0,
      noOfTickets: data['noOfTickets'] ?? '',
      sourceLocation: data['sourceLocation'] ?? '',
      destinationLocation: data['destinationLocation'] ?? '',
      date: data['date'] ?? '',
      seatNumbers: List<String>.from(data['seatNumbers']) ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'transactionId': transactionId,
      'total': total,
      'noOfTickets': noOfTickets,
      'sourceLocation': sourceLocation,
      'destinationLocation': destinationLocation,
      'date': date,
      'seatNumbers': seatNumbers,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      userId: map['userId'] ?? '',
      transactionId: map['transactionId'] ?? '',
      total: map['total']  ?? 0,
      noOfTickets: map['noOfTickets'] ?? '',
      sourceLocation: map['sourceLocation'] ?? '',
      destinationLocation: map['destinationLocation'] ?? '',
      date: map['date'] ?? '',
      seatNumbers: List<String>.from(map['seatNumbers']) ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));
}