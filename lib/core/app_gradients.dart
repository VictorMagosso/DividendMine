import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AppGradients {
  static final linear = LinearGradient(colors: [
    Color(0xFF16162B),
    Color(0xFF1D1A1A),
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
    Color(0xFF181529),
    Color(0xFF251D44),
  ], stops: [
    0.0,
    0.695
  ], transform: GradientRotation(2.13959913 * pi));

  static final sumUpLinear = LinearGradient(colors: [
    Color(0xFF270F7E),
    Color(0xFF131314),
  ], stops: [
    0.0,
    0.695
  ], transform: GradientRotation(2.13959913 * pi));
}
