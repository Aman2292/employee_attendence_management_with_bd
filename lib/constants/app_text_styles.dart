import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Headings (Pages and Sections)
  static TextStyle pageTitle = GoogleFonts.raleway(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  static TextStyle sectionTitle = GoogleFonts.raleway(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static TextStyle subsectionTitle = GoogleFonts.raleway(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  // Body Content
  static TextStyle bodyRegular = GoogleFonts.raleway(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
  );

  static TextStyle bodySmall = GoogleFonts.raleway(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
  );

  static TextStyle bodyLight = GoogleFonts.raleway(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textLight,
  );

  // Buttons
  static TextStyle buttonPrimary = GoogleFonts.raleway(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle buttonSecondary = GoogleFonts.raleway(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textDark,
  );

  // Labels and Chips
  static TextStyle labelBold = GoogleFonts.raleway(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static TextStyle labelRegular = GoogleFonts.raleway(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textDark,
  );

  static TextStyle labelLight = GoogleFonts.raleway(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textLight,
  );

  // Status Indicators
  static TextStyle statusPresent = GoogleFonts.raleway(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.success,
  );

  static TextStyle statusAbsent = GoogleFonts.raleway(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.warning,
  );

  static TextStyle statusPending = GoogleFonts.raleway(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.buttonColor,
  );

  // Info or Meta text
  static TextStyle infoNote = GoogleFonts.raleway(
    fontSize: 12,
    fontStyle: FontStyle.italic,
    color: AppColors.textLight,
  );
}
