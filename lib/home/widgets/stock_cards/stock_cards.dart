import '../../../core/core.dart';
import 'package:flutter/material.dart';

class StockCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: 160,
        child: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 0.2, color: AppColors.secondary),
                    gradient: AppGradients.linear)),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 165,
                    children: [
                      Text(
                        "BCFF11",
                        style: AppTextStyles.cardTitle,
                      ),
                      Text(
                        "Qtd.: 25",
                        style: AppTextStyles.cardText,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 165,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Por cota: 0,54",
                              style: AppTextStyles.cardText,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Total",
                                  style: AppTextStyles.cardText,
                                ),
                                Text(
                                  "45,50",
                                  style: AppTextStyles.cardTotalMoney,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
