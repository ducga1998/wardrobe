
import 'package:boilerplate/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegister() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(authControllerProvider.notifier).register(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
      
      // If no error (state is data), navigate back or show success
      // The listener below handles errors/success if needed, but for register typically:
      if (!mounted) return;
      // We can also assume if it didn't throw and authState is not error, we are good.
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    ref.listen(authControllerProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${next.error}')),
        );
      } else if (!next.isLoading && next.hasValue && next.value == false) {
         // Success (and not logged in, just registered)
         // Note: Login sets value to true, Register sets value to false (if implemented as such in controller)
         // However, 'false' is also the default state. Need better signal or just toast.
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration Successful! Please Login.')),
         );
         context.pop(); // Go back to login
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value != null && value.isNotEmpty ? null : 'Enter email',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) =>
                      value != null && value.isNotEmpty ? null : 'Enter password',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Confirm password';
                    if (value != _passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _onRegister,
                        child: const Text('Register'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
