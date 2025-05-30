import 'package:flutter/material.dart';

class ClearHistory extends StatelessWidget {
  final VoidCallback onHistoryCleared;

  const ClearHistory({super.key, required this.onHistoryCleared});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Clear History'),
      content: const Text('Are you sure you want to clear all conversion history?'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            onHistoryCleared();
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('Clear', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}