import 'package:flutter/material.dart';
import '../screens/staff_list_screen.dart';
import '../screens/assign_shift_screen.dart';
import 'generate_report_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, String>> staffList = [];
  List<String> notifications = [];
  String? nextShift;

  void _navigateToStaffScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StaffListScreen(existingStaff: staffList),
      ),
    );

    if (result != null && result is List<Map<String, String>>) {
      setState(() {
        staffList = result;
        notifications.insert(
          0,
          'Staff updated. Total staff: ${staffList.length}',
        );
      });
    }
  }

  void _navigateToAssignShiftScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssignShiftScreen(staffList: staffList),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        nextShift = result;
        notifications.insert(0, 'New shift assigned: $nextShift');
      });
    }
  }

  void _navigateToReportScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GenerateReportScreen(staffData: staffList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalStaff = staffList.length.toString();
    final recentNotification =
        notifications.isNotEmpty ? notifications.first : 'No updates yet';
    final displayShift = nextShift ?? 'No upcoming shift assigned.';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, [Employer Name]',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionCard(
                  icon: Icons.people,
                  label: 'View Staff',
                  onTap: _navigateToStaffScreen,
                ),
                _buildActionCard(
                  icon: Icons.assignment,
                  label: 'Assign Shift',
                  onTap: _navigateToAssignShiftScreen,
                ),
                _buildActionCard(
                  icon: Icons.bar_chart,
                  label: 'Report',
                  onTap: _navigateToReportScreen,
                ),
              ],
            ),
            const SizedBox(height: 40),
            const _SectionHeader(title: 'Staff Overview'),
            const SizedBox(height: 20),
            _buildInfoCard('Total Staff', totalStaff),
            const SizedBox(height: 20),
            const _SectionHeader(title: 'Upcoming Shifts'),
            _buildInfoCard('Next Shift', displayShift),
            const SizedBox(height: 20),
            const _SectionHeader(title: 'Notifications'),
            _buildInfoCard('Recent', recentNotification),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: Colors.deepOrange),
              const SizedBox(height: 10),
              Text(label, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(content, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    );
  }
}
