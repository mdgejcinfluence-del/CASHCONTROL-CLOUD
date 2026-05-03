
class BusinessConfig {
  final double monthlyRent;
  final double monthlyElectricity;
  final double monthlyWater;
  final Map<String, double> otherFixedCosts;

  BusinessConfig({
    this.monthlyRent = 0,
    this.monthlyElectricity = 0,
    this.monthlyWater = 0,
    this.otherFixedCosts = const {},
  });

  // Calcul du coût fixe journalier (Total / 30)
  double get dailyFixedCost {
    double total = monthlyRent + monthlyElectricity + monthlyWater;
    otherFixedCosts.forEach((key, value) => total += value);
    return total / 30;
  }
}
