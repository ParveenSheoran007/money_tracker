import 'package:flutter/material.dart';
import 'package:money_tracker/dashboard/ui/add_money_record.dart';
import 'package:money_tracker/dashboard/ui/money_recoed_list_screen.dart';
import 'package:money_tracker/dashboard/ui/money_record_chart_screen.dart';
import 'package:money_tracker/shard/app_string.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabScreenList = [
    const MoneyRecordListScreen(),
    const MoneyRecordChartScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: openAddTransactionScreen,
          child: const Icon(Icons.add),
        ),
        extendBody: true,
        appBar: AppBar(
          title: const Text(moneyRecord),
          backgroundColor: Colors.white,
          leading:Image.asset(
            'assets/image/Your paragraph text.png',
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.view_list),
              label: moneyRecord,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: labelTextChart,
            ),
          ],
        ),
        body: _tabScreenList[_selectedIndex],
      ),
    );
  }
  void openAddTransactionScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const AddMoneyRecordScreen();
        },
      ),
    );
  }

}
