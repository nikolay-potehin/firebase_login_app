import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login_app/blocs/authentication/authentication_bloc.dart';
import 'package:firebase_login_app/firebase_options.dart';
import 'package:firebase_login_app/repository/user_repository.dart';
import 'package:firebase_login_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    Provider(
      create: (_) => UserRepository(),
      child: const LoginApp(),
    ),
  );
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = context.read<UserRepository>();

    return BlocProvider<AuthenticationBloc>(
      create: (_) => AuthenticationBloc(repository),
      child: MaterialApp(
        title: 'Login App',
        initialRoute: RouteGenerator.homePage,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.deepOrange,
        ),
      ),
    );
  }
}
