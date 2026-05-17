import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/constants/route_constants.dart';
import 'package:flutter_template/core/utils/validators.dart';
import 'package:flutter_template/core/widgets/app_button.dart';
import 'package:flutter_template/core/widgets/app_text_field.dart';
import 'package:flutter_template/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_template/features/auth/presentation/widgets/auth_header.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _passwordStrengthNotifier = ValueNotifier<double>(0);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _passwordStrengthNotifier.dispose();
    super.dispose();
  }

  double _calculatePasswordStrength(String value) {
    if (value.isEmpty) return 0;
    var score = 0.0;
    if (value.length >= 8) score += 0.4;
    if (RegExp(r'[A-Z]').hasMatch(value)) score += 0.2;
    if (RegExp(r'[0-9]').hasMatch(value)) score += 0.2;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) score += 0.2;
    return score.clamp(0, 1);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(authControllerProvider.notifier).signUp(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
    if (mounted) context.go(RouteConstants.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const AuthHeader(
                  title: 'Create account',
                  subtitle: 'Start building with Rite Labs',
                ),
                const SizedBox(height: 32),
                AppTextField(
                  controller: _nameController,
                  label: 'Full name',
                  hint: 'Jane Doe',
                  validator: (value) => Validators.requiredField(value, field: 'Name'),
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'name@example.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Create a password',
                  variant: AppTextFieldVariant.password,
                  onChanged: (value) =>
                      _passwordStrengthNotifier.value = _calculatePasswordStrength(value),
                  validator: Validators.password,
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder<double>(
                  valueListenable: _passwordStrengthNotifier,
                  builder: (_, strength, __) => LinearProgressIndicator(value: strength),
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: _confirmController,
                  label: 'Confirm password',
                  hint: 'Re-enter password',
                  variant: AppTextFieldVariant.password,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppButton(
                  onPressed: _submit,
                  label: 'Create account',
                  loading: authState.isLoading,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () => context.go(RouteConstants.login),
                      child: const Text('Sign In'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
