
import 'package:flutter/material.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Configuration Business', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF1E293B),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Color(0xFF3B82F6),
            tabs: [
              Tab(icon: Icon(Icons.account_balance), text: "Charges"),
              Tab(icon: Icon(Icons.layers), text: "Services"),
              Tab(icon: Icon(Icons.people), text: "Employés"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildChargesTab(),
            _buildServicesTab(),
            _buildEmployeesTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddDialog(context),
          backgroundColor: const Color(0xFF3B82F6),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildChargesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildConfigTile("Loyer Mensuel", "30 000 F", Icons.home),
        _buildConfigTile("Électricité", "5 000 F", Icons.bolt),
        _buildConfigTile("Eau", "2 000 F", Icons.water_drop),
      ],
    );
  }

  Widget _buildServicesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildConfigTile("Lavage Complet", "5 000 F (Com: 500 F)", Icons.local_car_wash),
        _buildConfigTile("Nettoyage Moteur", "2 000 F (Com: 200 F)", Icons.settings),
      ],
    );
  }

  Widget _buildEmployeesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildConfigTile("Marc", "Commission", Icons.person),
        _buildConfigTile("Jean", "Fixe (45 000 F)", Icons.person_outline),
      ],
    );
  }

  Widget _buildConfigTile(String title, String trailing, IconData icon) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey[200]!)),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: const Color(0xFFF1F5F9), child: Icon(icon, color: const Color(0xFF1E293B))),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Text(trailing, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF3B82F6))),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    // Logique d'ajout à implémenter avec Hive
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ouverture du formulaire d'ajout...")));
  }
}
