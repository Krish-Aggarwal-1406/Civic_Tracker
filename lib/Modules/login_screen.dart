import 'package:civic_tracker/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';
import 'signup_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome Back!", style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text("Sign in to your account", style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface.withAlpha(180))),
                const SizedBox(height: 40),
                _buildNeumorphicTextField(
                  context: context,
                  hintText: 'Enter your email',
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 20),
                _buildNeumorphicTextField(
                  context: context,
                  hintText: 'Enter your password',
                  icon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: colorScheme.primary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurface.withAlpha(180)),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _buildNeumorphicButton(
                  context: context,
                  text: "Login",
                  onTap: () {
                    Get.to(HomePage());
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an account?", style: textTheme.bodyMedium),
                    TextButton(
                      onPressed: () => Get.to(() => const SignUpScreen()),
                      child: Text(
                        "Sign Up",
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Reusable Neumorphic Widgets
Widget _buildNeumorphicTextField({
  required BuildContext context,
  required String hintText,
  required IconData icon,
  bool obscureText = false,
  Widget? suffixIcon,
}) {
  return NeumorphicContainer(
    pressed: true,
    child: TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withAlpha(178)),
        prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
        suffixIcon: suffixIcon,
        border: InputBorder.none,
      ),
    ),
  );
}

Widget _buildNeumorphicButton({
  required BuildContext context,
  required String text,
  required VoidCallback onTap,
}) {
  return NeumorphicContainer(
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    ),
  );
}

class NeumorphicContainer extends StatelessWidget {
  final Widget child;
  final bool pressed;
  const NeumorphicContainer({super.key, required this.child, this.pressed = false});

  @override
  Widget build(BuildContext context) {
    final neumorphicTheme = Theme.of(context).extension<NeumorphicTheme>()!;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: pressed
            ? [
          BoxShadow(color: neumorphicTheme.darkShadow, offset: const Offset(2, 2), blurRadius: 5, spreadRadius: 1),
          BoxShadow(color: neumorphicTheme.lightShadow, offset: const Offset(-2, -2), blurRadius: 5, spreadRadius: 1),
        ]
            : [
          BoxShadow(color: neumorphicTheme.darkShadow, offset: const Offset(4, 4), blurRadius: 15, spreadRadius: 1),
          BoxShadow(color: neumorphicTheme.lightShadow, offset: const Offset(-4, -4), blurRadius: 15, spreadRadius: 1),
        ],
      ),
      child: child,
    );
  }
}
