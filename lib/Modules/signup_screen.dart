import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                const SizedBox(height: 60), // Extra padding for top
                Text("Create Account", style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text("Fill the details to get started", style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface.withAlpha(180))),
                const SizedBox(height: 40),
                _buildNeumorphicTextField(
                  context: context,
                  hintText: 'Enter your username',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 20),
                _buildNeumorphicTextField(
                  context: context,
                  hintText: 'Enter your email',
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 20),
                _buildNeumorphicTextField(
                  context: context,
                  hintText: 'Enter your phone number',
                  icon: Icons.phone_outlined,
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
                const SizedBox(height: 40),
                _buildNeumorphicButton(
                  context: context,
                  text: "Register",
                  onTap: () {
                    // TODO: Add Register Logic
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?", style: textTheme.bodyMedium),
                    TextButton(
                      onPressed: () => Get.to(() => const SigninScreen()),
                      child: Text(
                        "Sign In",
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40), // Extra padding for bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Reusable Neumorphic Widgets (In a real app, move these to their own file)
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
