
import 'package:flutter/material.dart';
import '../../services/storage/storage_service.dart';
import '../dashboard/dashboard_screen.dart';

class PinScreen extends StatefulWidget {
  final bool isCreationMode;
  const PinScreen({super.key, required this.isCreationMode});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String currentInput = "";

  void _onNumberPressed(String number) {
    if (currentInput.length < 4) {
      setState(() => currentInput += number);
    }
    if (currentInput.length == 4) {
      _verifyPin();
    }
  }

  void _verifyPin() async {
    if (widget.isCreationMode) {
      await StorageService.savePin(currentInput);
      _navigateToDashboard();
    } else {
      String? savedPin = await StorageService.getPin();
      if (currentInput == savedPin) {
        _navigateToDashboard();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Code PIN incorrect"), backgroundColor: Colors.red),
        );
        setState(() => currentInput = "");
      }
    }
  }

  void _navigateToDashboard() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 64, color: Color(0xFF1E293B)),
            const SizedBox(height: 20),
            Text(
              widget.isCreationMode ? "Créez votre PIN Maître" : "Saisissez votre PIN",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
            ),
            const SizedBox(height: 10),
            const Text("Sécurité CASHCONTROL CLOUD", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
            // Affichage des points du PIN
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index < currentInput.length ? const Color(0xFF3B82F6) : Colors.grey[300],
                ),
              )),
            ),
            const SizedBox(height: 50),
            // Pavé numérique (simplifié pour le script)
            _buildKeypad(),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.5,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          String val = "";
          if (index < 9) val = (index + 1).toString();
          if (index == 10) val = "0";
          if (val == "") return const SizedBox();
          
          return TextButton(
            onPressed: () => _onNumberPressed(val),
            child: Text(val, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
          );
        },
      ),
    );
  }
}
