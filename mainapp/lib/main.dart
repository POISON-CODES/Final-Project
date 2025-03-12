import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/features/auth/cubit/auth_cubit.dart';
import 'package:mainapp/features/auth/pages/sign_up.dart';
import 'package:mainapp/features/configurations/cubit/configuration_cubit.dart';
import 'package:mainapp/features/home/pages/home_page.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => AuthCubit()),
    BlocProvider(create: (_) => ConfigurationCubit()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getInitialUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Cera Pro",
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        useMaterial3: true,
      ),
      home: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        if (state is AuthLogin) {
          return const HomePage();
        } else {
          return const SignUpPage();
        }
      }),
    );
  }
}
