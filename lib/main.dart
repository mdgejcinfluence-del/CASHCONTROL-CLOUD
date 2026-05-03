
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/storage/storage_service.dart';
import 'screens/auth/pin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialisation du stockage local
  await StorageService.initDatabase();
  
  // Vérification du PIN existant
  final String? savedPin = await StorageService.getPin();
  
  runApp(CashControlApp(hasPin: savedPin != null));
}

class CashControlApp extends StatelessWidget {
  final bool hasPin;
  
  const CashControlApp({super.key, required this.hasPin});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CASHCONTROL CLOUD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      // Si pas de PIN, on va en création, sinon en saisie
      home: PinScreen(isCreationMode: !hasPin),
    );
  }
}
