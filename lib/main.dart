import 'package:cart_sample/api/services.dart';
import 'package:cart_sample/commons/constants.dart';
import 'package:cart_sample/feature/cart/cart_bloc/cart_bloc.dart';
import 'package:cart_sample/feature/cart/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(cartRepo: CartServices()),
      child: MaterialApp(
        title: Constants.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const MenuScreen(),
      ),
    );
  }
}
