import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class BatteryLevelWidget extends StatelessWidget {
  final String result;
  final GestureTapCallback? onPressed;

  const BatteryLevelWidget({
    super.key,
    required this.result,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: AppColors.backgroundDark,
        child: Visibility(
          visible: result.isNotEmpty,
          replacement: Material(
            color: AppColors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              splashColor: AppColors.backgroundDark.withOpacity(0.2),
              onTap: onPressed,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Clique para exibir o nível da bateria',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  result,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.backgroundLight,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 10),
                            child: Text(
                              (result.startsWith('100'))
                                  ? 'Carregado'
                                  : 'Descarregado',
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Visibility(
                          visible: result.startsWith('100'),
                          replacement: const Icon(
                            CupertinoIcons.battery_25,
                            color: AppColors.pinkDark,
                            size: 28,
                          ),
                          child: const Icon(
                            CupertinoIcons.battery_100,
                            color: AppColors.green,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      '%',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
