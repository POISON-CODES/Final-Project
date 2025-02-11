import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/core/utils/utils.dart';
import 'package:mainapp/custom/widgets/custom_global_widgets.dart';
import 'package:mainapp/features/auth/cubit/auth_cubit.dart';
import 'package:mainapp/features/auth/pages/log_in.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (builder) => const SignUpPage());

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _createUser() {
    if (formKey.currentState!.validate()) {
      context.read<AuthCubit>().createUser(
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            phoneNumber: phoneController.text.trim(),
            password: passwordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          } else if (state is AuthSignUp) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Account Created! Login Now!"),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 80),
                  CustomFormField(
                    controller: nameController,
                    obscureText: false,
                    textInputType: TextInputType.text,
                    labelText: 'Name',
                    validator: nameValidator,
                  ),
                  SizedBox(height: 10),
                  CustomFormField(
                    controller: emailController,
                    obscureText: false,
                    textInputType: TextInputType.emailAddress,
                    labelText: 'E-mail',
                    validator: emailValidator,
                  ),
                  SizedBox(height: 10),
                  CustomFormField(
                    controller: phoneController,
                    obscureText: false,
                    textInputType: TextInputType.phone,
                    labelText: 'Phone Number',
                    validator: phoneValidator,
                  ),
                  SizedBox(height: 10),
                  CustomFormField(
                    controller: passwordController,
                    obscureText: true,
                    textInputType: TextInputType.text,
                    labelText: 'Password',
                    validator: passwordValidator,
                  ),
                  SizedBox(height: 80),
                  ElevatedButton(
                    onPressed: _createUser,
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(LoginPage.route()),
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: "Sign In",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
