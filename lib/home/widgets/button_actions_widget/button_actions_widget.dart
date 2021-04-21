import 'package:DividendMine/core/app_colors.dart';
import 'package:DividendMine/core/app_texts.dart';
import 'package:flutter/material.dart';

class ButtonActionsWidget extends StatelessWidget {
  final String label;

  ButtonActionsWidget({Key? key, required this.label})
      : assert(['Confirmar', 'Fechar'].contains(label)),
        super(key: key);

  final config = {
    'Confirmar': {
      'color': AppColors.positive,
    },
    'Fechar': {
      'color': AppColors.cancel,
    }
  };

  Color get color => config[label]!['color']!;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Text(
            label,
            style: AppTextStyles.cardText,
          ),
        ),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
