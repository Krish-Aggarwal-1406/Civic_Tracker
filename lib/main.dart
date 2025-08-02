import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homepage.dart';

void main() {
  runApp(const CivicTrackApp());
}

class CivicTrackApp extends StatelessWidget {
  const CivicTrackApp({super.key});

  @override
  Widget build(BuildContext context) {

    const Color primaryColor = Color(0xFF3B82F6);
    const Color backgroundColor = Color(0xFF1E293B);
    const Color surfaceColor = Color(0xFF1E293B);
    const Color onTextColor = Color(0xFFE2E8F0);

    const Color lightShadow = Color(0xFF293548);
    const Color darkShadow = Color(0xFF131A24);

    return MaterialApp(
      title: 'CivicTrack',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,

        colorScheme: const ColorScheme.dark(
          primary: primaryColor,

          surface: surfaceColor,
          onPrimary: Colors.white,

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
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),

      home:  HomePage(),
    );
  }
}

// Custom Theme Extension to pass shadow colors easily
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
