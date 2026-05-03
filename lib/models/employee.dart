
enum PaymentType { fixed, commission }

class Employee {
  final String id;
  final String name;
  final PaymentType paymentType;
  final double monthlySalary; // Si fixe

  Employee({
    required this.id,
    required this.name,
    required this.paymentType,
    this.monthlySalary = 0,
  });

  double get dailyBaseCost => paymentType == PaymentType.fixed ? monthlySalary / 30 : 0;
}
