import 'package:flutter/material.dart';

/// Apple-inspired typography system
/// Based on iOS San Francisco font hierarchy
class AppleTypography {
  AppleTypography._();

  // MARK: - Font Weights
  static const FontWeight ultraLight = FontWeight.w100;
  static const FontWeight thin = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight heavy = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  // MARK: - Large Titles
  static const TextStyle largeTitle = TextStyle(
    fontSize: 34,
    fontWeight: regular,
    letterSpacing: 0.374,
    height: 1.176, // 40pt line height
  );

  static const TextStyle largeTitleEmphasized = TextStyle(
    fontSize: 34,
    fontWeight: bold,
    letterSpacing: 0.374,
    height: 1.176,
  );

  // MARK: - Titles
  static const TextStyle title1 = TextStyle(
    fontSize: 28,
    fontWeight: regular,
    letterSpacing: 0.364,
    height: 1.214, // 34pt line height
  );

  static const TextStyle title1Emphasized = TextStyle(
    fontSize: 28,
    fontWeight: bold,
    letterSpacing: 0.364,
    height: 1.214,
  );

  static const TextStyle title2 = TextStyle(
    fontSize: 22,
    fontWeight: regular,
    letterSpacing: 0.352,
    height: 1.273, // 28pt line height
  );

  static const TextStyle title2Emphasized = TextStyle(
    fontSize: 22,
    fontWeight: bold,
    letterSpacing: 0.352,
    height: 1.273,
  );

  static const TextStyle title3 = TextStyle(
    fontSize: 20,
    fontWeight: regular,
    letterSpacing: 0.38,
    height: 1.2, // 24pt line height
  );

  static const TextStyle title3Emphasized = TextStyle(
    fontSize: 20,
    fontWeight: semibold,
    letterSpacing: 0.38,
    height: 1.2,
  );

  // MARK: - Headlines
  static const TextStyle headline = TextStyle(
    fontSize: 17,
    fontWeight: semibold,
    letterSpacing: -0.408,
    height: 1.294, // 22pt line height
  );

  static const TextStyle headlineItalic = TextStyle(
    fontSize: 17,
    fontWeight: semibold,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.408,
    height: 1.294,
  );

  // MARK: - Body
  static const TextStyle body = TextStyle(
    fontSize: 17,
    fontWeight: regular,
    letterSpacing: -0.408,
    height: 1.294, // 22pt line height
  );

  static const TextStyle bodyEmphasized = TextStyle(
    fontSize: 17,
    fontWeight: semibold,
    letterSpacing: -0.408,
    height: 1.294,
  );

  static const TextStyle bodyItalic = TextStyle(
    fontSize: 17,
    fontWeight: regular,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.408,
    height: 1.294,
  );

  // MARK: - Callout
  static const TextStyle callout = TextStyle(
    fontSize: 16,
    fontWeight: regular,
    letterSpacing: -0.32,
    height: 1.3125, // 21pt line height
  );

  static const TextStyle calloutEmphasized = TextStyle(
    fontSize: 16,
    fontWeight: semibold,
    letterSpacing: -0.32,
    height: 1.3125,
  );

  static const TextStyle calloutItalic = TextStyle(
    fontSize: 16,
    fontWeight: regular,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.32,
    height: 1.3125,
  );

  // MARK: - Subheadline
  static const TextStyle subheadline = TextStyle(
    fontSize: 15,
    fontWeight: regular,
    letterSpacing: -0.24,
    height: 1.333, // 20pt line height
  );

  static const TextStyle subheadlineEmphasized = TextStyle(
    fontSize: 15,
    fontWeight: semibold,
    letterSpacing: -0.24,
    height: 1.333,
  );

  static const TextStyle subheadlineItalic = TextStyle(
    fontSize: 15,
    fontWeight: regular,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.24,
    height: 1.333,
  );

  // MARK: - Footnote
  static const TextStyle footnote = TextStyle(
    fontSize: 13,
    fontWeight: regular,
    letterSpacing: -0.078,
    height: 1.385, // 18pt line height
  );

  static const TextStyle footnoteEmphasized = TextStyle(
    fontSize: 13,
    fontWeight: semibold,
    letterSpacing: -0.078,
    height: 1.385,
  );

  static const TextStyle footnoteItalic = TextStyle(
    fontSize: 13,
    fontWeight: regular,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.078,
    height: 1.385,
  );

  // MARK: - Caption
  static const TextStyle caption1 = TextStyle(
    fontSize: 12,
    fontWeight: regular,
    letterSpacing: 0.0,
    height: 1.333, // 16pt line height
  );

  static const TextStyle caption1Emphasized = TextStyle(
    fontSize: 12,
    fontWeight: medium,
    letterSpacing: 0.0,
    height: 1.333,
  );

  static const TextStyle caption2 = TextStyle(
    fontSize: 11,
    fontWeight: regular,
    letterSpacing: 0.066,
    height: 1.182, // 13pt line height
  );

  static const TextStyle caption2Emphasized = TextStyle(
    fontSize: 11,
    fontWeight: semibold,
    letterSpacing: 0.066,
    height: 1.182,
  );
}
