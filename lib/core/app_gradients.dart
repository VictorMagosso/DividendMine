import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AppGradients {
  static final linear = LinearGradient(colors: [
    Color(0xFF09090A),
    Color(0xFF161616),
  ], stops: [
    0.0,
    0.695
  ], transform: GradientRotation(2.13959913 * pi));

  static final appBarLinear = LinearGradient(colors: [
    Color(0xFF6552D4),
    Color(0xFF495A94),
  ], stops: [
    0.0,
    0.695
  ], transform: GradientRotation(2.13959913 * pi));

  static final sumUpBg = LinearGradient(colors: [
    Color(0xFF120F1F),
    Color(0xFF1F183A),
  ], stops: [
    0.0,
    0.695
  ], transform: GradientRotation(2.13959913 * pi));
}
