
import '../../models/transaction.dart';
import '../../models/business_config.dart';
import '../../models/employee.dart';

class FinanceCalculator {
  static Map<String, double> calculateDailyReport({
    required List<DailyTransaction> transactions,
    required BusinessConfig config,
    required List<Employee> activeEmployees,
  }) {
    double totalRecettes = 0;
    double totalDepenses = 0;
    double totalCommissions = 0;
    double totalSalairesJournaliers = 0;

    for (var tx in transactions) {
      if (tx.type == TransactionType.income) {
        totalRecettes += tx.amount;
        totalCommissions += tx.commissionAmount;
      } else {
        totalDepenses += tx.amount;
      }
    }

    for (var emp in activeEmployees) {
      totalSalairesJournaliers += emp.dailyBaseCost;
    }

    double chargesFixes = config.dailyFixedCost;
    double beneficeNet = totalRecettes - totalDepenses - totalCommissions - totalSalairesJournaliers - chargesFixes;

    return {
      'recettes': totalRecettes,
      'depenses': totalDepenses,
      'commissions': totalCommissions,
      'salaires': totalSalairesJournaliers,
      'charges_fixes': chargesFixes,
      'benefice_net': beneficeNet,
    };
  }
}
