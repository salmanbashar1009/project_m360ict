import 'package:flutter/material.dart';

class PriorityButtons extends StatelessWidget {
  const PriorityButtons({super.key, required this.priorityText});

  final String priorityText;

  Color _getPriorityColor() => switch (priorityText) {
    "Low" => Colors.green,
    "Medium" => Colors.orangeAccent,
    "Urgent" => Colors.red,
    _ => Colors.transparent,
  };

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _getPriorityColor(),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 6),
          Text(
            priorityText,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}