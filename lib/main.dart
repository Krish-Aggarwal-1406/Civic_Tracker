import 'package:civic_tracker/Modules/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homepage.dart';

void main() {
  runApp(const CivicTrackApp());
}

class CivicTrackApp extends StatelessWidget {
  const CivicTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    // "Lavender Haze" Theme - with distinct text fields
    const Color primaryColor = Color(0xFF8B5CF6);    // Confident, rich purple
    const Color accentColor = Color(0xFFA78BFA);     // Lighter, softer purple
    const Color backgroundColor = Color(0xFFF5F3FF);  // Very light, soft lavender
    const Color surfaceColor = Colors.white;          // Clean white for cards & text fields
    const Color onTextColor = Color(0xFF4C1D95);      // Deep, dark purple for text
    const Color lightShadow = Colors.white;           // Clean white highlight
    // SHADOW FIX: Making the dark shadow more visible for better 3D effect
    const Color darkShadow = Color(0xFFD1C8E8);        // A more prominent, darker lavender shadow

    return GetMaterialApp(
      title: 'CivicTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: accentColor,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: backgroundColor,
          onBackground: onTextColor,
          surface: surfaceColor, // Updated surface color
          onSurface: onTextColor,
        ),
        extensions: const <ThemeExtension<dynamic>>[
          NeumorphicTheme(
            lightShadow: lightShadow,
            darkShadow: darkShadow,
          ),
        ],
        textTheme: GoogleFonts.lexendTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: onTextColor,
          displayColor: onTextColor,
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: backgroundColor,
            elevation: 0,
            iconTheme: IconThemeData(color: onTextColor),
            titleTextStyle: TextStyle(color: onTextColor, fontSize: 20, fontWeight: FontWeight.bold)
        ),
      ),
      home: const SigninScreen(),
    );
  }
}

@immutable
class NeumorphicTheme extends ThemeExtension<NeumorphicTheme> {
  const NeumorphicTheme({
    required this.lightShadow,
    required this.darkShadow,
  });

  final Color lightShadow;
  final Color darkShadow;

  @override
  NeumorphicTheme copyWith({Color? lightShadow, Color? darkShadow}) {
    return NeumorphicTheme(
      lightShadow: lightShadow ?? this.lightShadow,
      darkShadow: darkShadow ?? this.darkShadow,
    );
  }

  @override
  NeumorphicTheme lerp(ThemeExtension<NeumorphicTheme>? other, double t) {
    if (other is! NeumorphicTheme) {
      return this;
    }
    return NeumorphicTheme(
      lightShadow: Color.lerp(lightShadow, other.lightShadow, t)!,
      darkShadow: Color.lerp(darkShadow, other.darkShadow, t)!,
    );
  }
}
