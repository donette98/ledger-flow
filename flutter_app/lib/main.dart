import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/auth/login_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase here when ready
  // await Firebase.initializeApp();
  runApp(const LedgerFlowApp());
}

class LedgerFlowApp extends StatelessWidget {
  const LedgerFlowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ledger Flow',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}