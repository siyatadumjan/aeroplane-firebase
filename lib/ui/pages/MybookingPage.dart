import 'package:flutter/material.dart';

import '../../models/transactionModel.dart';
import '../../services/transaction_services.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late Future<List<TransactionModel>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    // Retrieve the transactions for the current user
    _transactionsFuture = TransactionService.getTransactionsByUserId();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String currentTime = '${now.hour}:${now.minute}:${now.second}';
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Transactions'),
      ),
      body: FutureBuilder<List<TransactionModel>>(
        future: _transactionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final transactions = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    tileColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.airplane_ticket,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      transaction.transactionId!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Total: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                ),
                              ),
                              TextSpan(
                                text: transaction.total.toString(),
                              ),
                            ],
                          ),

                          ),

                        const SizedBox(height: 2),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Source: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                ),
                              ),
                              TextSpan(
                                text: transaction.sourceLocation,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Destination: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                ),
                              ),
                              TextSpan(
                                text: transaction.destinationLocation,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Departure Time: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                ),
                              ),
                              TextSpan(
                                text: currentTime,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Seat Numbers: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                ),
                              ),

                              TextSpan(
                                text: transaction.seatNumbers.toString(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          transaction.date,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                );


              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load transactions: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: Text('No transactions found.'),
            );
          }
        },
      ),
    );
  }
}
