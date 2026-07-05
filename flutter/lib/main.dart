import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'services/transaction_service.dart';
import 'theme.dart';
import 'screens/login_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/pin_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const OmPayApp());
}

class OmPayApp extends StatelessWidget {
  const OmPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProxyProvider<AuthService, TransactionService>(
          create: (context) => TransactionService(context.read<AuthService>()),
          update: (context, auth, previous) => previous ?? TransactionService(auth),
        ),
      ],
      child: MaterialApp(
        title: 'OM Pay',
        debugShowCheckedModeBanner: false,
        theme: OmTheme.dark,
        initialRoute: '/login',
        routes: {
          '/login': (_) => const LoginScreen(),
          '/otp': (_) => const OtpScreen(),
          '/pin': (_) => const PinScreen(),
          '/home': (_) => const HomeScreen(),
          '/profile': (_) => const ProfileScreen(),
        },
      ),
    );
  }
}
