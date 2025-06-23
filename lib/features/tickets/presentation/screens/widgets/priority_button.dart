import 'package:flutter/material.dart';

class PriorityButtons extends StatefulWidget {
  const PriorityButtons({super.key, required this.priorityText});

  final String? priorityText;

  @override
  State<PriorityButtons> createState() => _PriorityButtonsState();
}

class _PriorityButtonsState extends State<PriorityButtons> {
  String statusText = "Open";

  Color _getPriorityColor() => switch (widget.priorityText) {
    "Low" => Colors.green,
    "Medium" => Colors.orange,
    "Urgent" => Colors.red,
    _ => Colors.transparent,
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildButton(
          text: widget.priorityText!,
          prefix: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _getPriorityColor(),
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 12),
        _buildButton(
          text: statusText,
          onTap: () => setState(() {
            statusText = statusText == "Open" ? "Closed" : "Open";
          }),
        ),
        SizedBox(width: 12,),
        if (statusText == "Closed")
          _buildButton(text: "Spam"),
      ],
    );
  }
  Widget _buildButton({required String text, VoidCallback? onTap, Widget? prefix}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefix != null) ...[
              prefix,
              const SizedBox(width: 6),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}