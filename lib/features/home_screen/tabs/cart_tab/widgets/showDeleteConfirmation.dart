import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cart_cubit.dart';

class DeleteConfirmationDialog extends StatefulWidget {
  final String itemId;
  final String itemName;
  final VoidCallback onSuccess;

  const DeleteConfirmationDialog({
    super.key,
    required this.itemId,
    required this.onSuccess,
    this.itemName = '',
  });

  @override
  State<DeleteConfirmationDialog> createState() => _DeleteConfirmationDialogState();
}

class _DeleteConfirmationDialogState extends State<DeleteConfirmationDialog> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Remove Item',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.itemName.isNotEmpty) ...[
            Text(
              '"${widget.itemName}"',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
          ],
          const Text(
            'Are you sure you want to remove this item from cart?',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          if (_isDeleting) ...[
            const SizedBox(height: 16),
            const LinearProgressIndicator(),
          ],
        ],
      ),
      actions: [
        if (!_isDeleting) ...[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: _removeItem,
            child: const Text(
              'Remove',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  void _removeItem() {
    setState(() {
      _isDeleting = true;
    });

    // Remove item using cubit
    context.read<CartCubit>().removeItem(widget.itemId);

    // Note: We'll handle the success callback in the parent widget
    // to avoid issues with context
  }
}

// Helper function to show the dialog
void showDeleteConfirmation({
  required BuildContext context,
  required String itemId,
  required VoidCallback onSuccess,
  String itemName = '',
}) {
  showDialog(
    context: context,
    builder: (context) => DeleteConfirmationDialog(
      itemId: itemId,
      onSuccess: onSuccess,
      itemName: itemName,
    ),
  );
}