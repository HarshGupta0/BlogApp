import 'package:flutter/material.dart';
import 'dart:math';
getRandomColor() => [
  Colors.blueAccent,
  Colors.redAccent,
  Colors.greenAccent,
][Random().nextInt(3)];