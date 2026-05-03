
import 'package:flutter/material.dart';
import '../../services/logic/report_service.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulation des données de la journée
    const businessName = "MON LAVAGE AUTO";
    const employeeName = "Marc";
    const totalRecettes = 25000.0;
    const totalDepenses = 3000.0;
    const netProfit = 18500.0; // Après retrait des commissions et charges journalières
    const salesCount = 8;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Rapport de Clôture'),
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.assignment_turned_in, size: 80, color: Color(0xFF10B981)),
            const SizedBox(height: 20),
            const Text("Journée Terminée !", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Vérifiez les chiffres avant d'envoyer au patron.", textAlign: TextAlign.center),
            const SizedBox(height: 30),
            
            _buildSummaryRow("Total Recettes", "25 000 F"),
            _buildSummaryRow("Dépenses", "- 3 000 F"),
            const Divider(height: 40),
            _buildSummaryRow("Bénéfice Net", "18 500 F", isBold: true),
            
            const Spacer(),
            
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  final msg = ReportService.generateProfessionalText(
                    businessName: businessName,
                    employeeName: employeeName,
                    totalRecettes: totalRecettes,
                    totalDepenses: totalDepenses,
                    netProfit: netProfit,
                    salesCount: salesCount,
                  );
                  ReportService.shareToWhatsApp(msg);
                },
                icon: const Icon(Icons.share),
                label: const Text("ENVOYER LE RAPPORT WHATSAPP"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366), // Couleur WhatsApp
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
