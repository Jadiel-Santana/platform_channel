import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../components/components.dart';

class PalindromeWidget extends StatelessWidget {
  final String result;
  final Function(String value) onChanged;

  const PalindromeWidget({
    super.key,
    required this.result,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextField(
            onChanged: onChanged,
          ),
          const SizedBox(height: 30),
          Text(
            result,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: (result.contains('NÃO')) ? AppColors.red : AppColors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
