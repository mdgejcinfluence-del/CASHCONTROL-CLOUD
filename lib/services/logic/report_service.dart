
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class ReportService {
  static String generateProfessionalText({
    required String businessName,
    required String employeeName,
    required double totalRecettes,
    required double totalDepenses,
    required double netProfit,
    required int salesCount,
  }) {
    final dateStr = DateFormat('dd/MM/yyyy').format(DateTime.now());
    final currency = "FCFA";

    return '''
📊 *RAPPORT JOURNALIER - $businessName*
📅 Date : $dateStr
👤 Responsable : $employeeName
---
✅ *PERFORMANCE*
- Services réalisés : $salesCount
- Recettes Totales : ${totalRecettes.toStringAsFixed(0)} $currency

❌ *SORTIES*
- Dépenses Boutique : ${totalDepenses.toStringAsFixed(0)} $currency

💰 *RÉSULTAT NET*
*Bénéfice Réel : ${netProfit.toStringAsFixed(0)} $currency*
---
_Généré par CASHCONTROL CLOUD_
    ''';
  }

  static Future<void> shareToWhatsApp(String message) async {
    await Share.share(message);
  }
}
