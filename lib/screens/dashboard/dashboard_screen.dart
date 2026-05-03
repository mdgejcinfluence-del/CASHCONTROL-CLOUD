
import 'package:flutter/material.dart';\nimport '../config/config_screen.dart';\nimport '../employee/employee_screen.dart';
import '../../services/logic/finance_calculator.dart';
import '../../models/transaction.dart';
import '../../models/business_config.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // DONNÉES TEMPORAIRES (Simulation en attendant la liaison Hive)
    final stats = FinanceCalculator.calculateDailyReport(
      transactions: [
        DailyTransaction(id: '1', date: DateTime.now(), label: 'Lavage Auto', amount: 5000, type: TransactionType.income, commissionAmount: 500),
        DailyTransaction(id: '2', date: DateTime.now(), label: 'Achat Savon', amount: 1200, type: TransactionType.expense),
      ],
      config: BusinessConfig(monthlyRent: 30000, monthlyElectricity: 5000),
      activeEmployees: [],
    );

    final bool isPositive = (stats['benefice_net'] ?? 0) >= 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('Tableau de Bord', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.settings, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ConfigScreen()))),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Aujourd'hui", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
            const SizedBox(height: 16),
            
            // Carte du Bénéfice Net (La plus importante)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isPositive ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
              ),
              child: Column(
                children: [
                  const Text("BÉNÉFICE NET RÉEL", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("${stats['benefice_net']?.toStringAsFixed(0)} FCFA", 
                    style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Grille des statistiques
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildStatCard("Recettes", "${stats['recettes']?.toStringAsFixed(0)}", Icons.trending_up, Colors.green),
                _buildStatCard("Dépenses", "${stats['depenses']?.toStringAsFixed(0)}", Icons.trending_down, Colors.orange),
                _buildStatCard("Commissions", "${stats['commissions']?.toStringAsFixed(0)}", Icons.people, Colors.blue),
                _buildStatCard("Charges Fixes", "${stats['charges_fixes']?.toStringAsFixed(0)}", Icons.account_balance, Colors.purple),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Boutons d'action rapide
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ConfigScreen())),
                    icon: const Icon(Icons.add),
                    label: const Text("Vente"),\n                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EmployeeScreen())),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E293B), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ConfigScreen())),
                    icon: const Icon(Icons.remove_circle_outline),
                    label: const Text("Dépense"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF1E293B), padding: const EdgeInsets.symmetric(vertical: 16)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          const SizedBox(height: 4),
          Text("$value F", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        ],
      ),
    );
  }
}
