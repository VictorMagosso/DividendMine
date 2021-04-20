import '../../../core/core.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {
  AppBarWidget()
      : super(
          preferredSize: Size.fromHeight(100),
          child: Container(
              height: 180,
              decoration: BoxDecoration(color: AppColors.primary),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Meus dividendos", style: AppTextStyles.title),
                    Container(
                        width: 58,
                        height: 58,
                        child: Image.asset(AppImages.logo)),
                  ],
                ),
              )),
        );
}
