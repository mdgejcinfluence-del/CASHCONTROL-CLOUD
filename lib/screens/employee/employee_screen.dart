
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../models/transaction.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  String? selectedEmployee;
  String? selectedService;
  final List<String> employees = ["Marc", "Jean", "Sophie"];
  final Map<String, double> services = {
    "Lavage Complet": 5000,
    "Lavage Simple": 2000,
    "Nettoyage Intérieur": 3000,
  };

  void _submitVente() async {
    if (selectedEmployee == null || selectedService == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sélectionnez un employé et un service"), backgroundColor: Colors.orange),
      );
      return;
    }

    final box = await Hive.openBox('transactions');
    final amount = services[selectedService!]!;
    
    final newTransaction = DailyTransaction(
      id: const Uuid().v4(),
      date: DateTime.now(),
      label: selectedService!,
      amount: amount,
      type: TransactionType.income,
      employeeId: selectedEmployee,
      commissionAmount: amount * 0.1, // Commission de 10% par défaut
    );

    await box.add(newTransaction.toMap());

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("✅ Vente enregistrée !"), backgroundColor: Colors.green),
    );
    
    setState(() => selectedService = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saisie Terrain'), backgroundColor: const Color(0xFF1E293B), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Employé", style: TextStyle(fontWeight: FontWeight.bold)),
            _buildEmployeeSelector(),
            const SizedBox(height: 20),
            const Text("Service", style: TextStyle(fontWeight: FontWeight.bold)),
            _buildServiceGrid(),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, 
              height: 55, 
              child: ElevatedButton(
                onPressed: _submitVente,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981), foregroundColor: Colors.white),
                child: const Text("VALIDER LA VENTE"),
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeSelector() {
    return Wrap(
      spacing: 10,
      children: employees.map((emp) => ChoiceChip(
        label: Text(emp),
        selected: selectedEmployee == emp,
        onSelected: (val) => setState(() => selectedEmployee = val ? emp : null),
      )).toList(),
    );
  }

  Widget _buildServiceGrid() {
    return Expanded(
      child: ListView(
        children: services.keys.map((s) => Card(
          color: selectedService == s ? Colors.blue[50] : Colors.white,
          child: ListTile(
            title: Text(s),
            trailing: Text("${services[s]} F"),
            onTap: () => setState(() => selectedService = s),
          ),
        )).toList(),
      ),
    );
  }
}
