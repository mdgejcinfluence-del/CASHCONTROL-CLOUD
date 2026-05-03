import 'package:flutter/material.dart';
import '../config/config_screen.dart';
import '../employee/employee_screen.dart';
import '../../services/logic/finance_calculator.dart';
import '../../models/transaction.dart';
import '../../models/business_config.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        title: const Text("CASH CONTROL - MDGEJ-C", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => ConfigScreen())
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_balance_wallet, size: 100, color: Color(0xFF00FF88)),
            const SizedBox(height: 20),
            const Text(
              "Tableau de Bord Premium",
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text("Nouvelle Vente"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00FF88),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => EmployeeScreen())
              ),
            ),
          ],
        ),
      ),
    );
  }
}