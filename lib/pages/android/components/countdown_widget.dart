import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class CountdownDateTime extends StatelessWidget {
  final DateTime dateTime;

  const CountdownDateTime({
    super.key,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppColors.backgroundDark,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.lock_clock,
                    color: AppColors.gold,
                    size: 30,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Horário de Brasília',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.gold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LabelText(
                  label: 'HORAS',
                  value: dateTime.hour,
                ),
                const Text(
                  ':',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                  ),
                ),
                LabelText(
                  label: 'MINUTOS',
                  value: dateTime.minute,
                ),
                const Text(
                  ':',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                  ),
                ),
                LabelText(
                  label: 'SEGUNDOS',
                  value: dateTime.second,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  final String label;
  final int value;

  const LabelText({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            (value.toString().isNotEmpty)
                ? value.toString().padLeft(2, '0')
                : '00',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
