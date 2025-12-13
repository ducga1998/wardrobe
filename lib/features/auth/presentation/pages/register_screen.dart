import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/core/widgets/rounded_button_widget.dart';
import 'package:boilerplate/core/widgets/textfield_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/features/auth/presentation/cubit/register_cubit.dart';
import 'package:boilerplate/features/auth/presentation/cubit/register_state.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // cubit
  late RegisterCubit _registerCubit;

  @override
  void initState() {
    super.initState();
    _registerCubit = getIt<RegisterCubit>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _registerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _registerCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate('register_title') ?? 'Register'),
        ),
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              FlushbarHelper.createSuccess(
                message: AppLocalizations.of(context).translate('register_success') ?? 'Registration successful',
                title: AppLocalizations.of(context).translate('home_tv_success') ?? 'Success',
                duration: Duration(seconds: 3),
              )..show(context).then((_) {
                Navigator.of(context).pop(); // Go back to login
              });
            } else if (state is RegisterFailure) {
              FlushbarHelper.createError(
                message: state.error,
                title: AppLocalizations.of(context).translate('home_tv_error') ?? 'Error',
                duration: Duration(seconds: 3),
              )..show(context);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                _buildForm(),
                if (state is RegisterLoading)
                  Visibility(
                    visible: true,
                    child: CustomProgressIndicatorWidget(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFieldWidget(
              hint: AppLocalizations.of(context).translate('login_et_user_email') ?? 'Email',
              inputType: TextInputType.emailAddress,
              icon: Icons.email,
              textController: _emailController,
            ),
            SizedBox(height: 16),
            TextFieldWidget(
              hint: AppLocalizations.of(context).translate('login_et_user_password') ?? 'Password',
              isObscure: true,
              icon: Icons.lock,
              textController: _passwordController,
            ),
            SizedBox(height: 16),
             TextFieldWidget(
              hint: AppLocalizations.of(context).translate('register_et_confirm_password') ?? 'Confirm Password',
              isObscure: true,
              icon: Icons.lock,
              textController: _confirmPasswordController,
            ),
            SizedBox(height: 24),
            RoundedButtonWidget(
              buttonText: AppLocalizations.of(context).translate('register_btn_sign_up') ?? 'Register',
              buttonColor: Colors.orangeAccent,
              textColor: Colors.white,
              onPressed: () {
                if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                   FlushbarHelper.createError(
                    message: "Please fill in all fields",
                    title: "Error",
                    duration: Duration(seconds: 3),
                  )..show(context);
                  return;
                }
                if (_passwordController.text != _confirmPasswordController.text) {
                   FlushbarHelper.createError(
                    message: "Passwords do not match",
                    title: "Error",
                    duration: Duration(seconds: 3),
                  )..show(context);
                  return;
                }
                _registerCubit.register(_emailController.text, _passwordController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
