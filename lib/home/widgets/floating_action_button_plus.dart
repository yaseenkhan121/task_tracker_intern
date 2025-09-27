import 'package:flutter/material.dart';
import 'package:task_tracker_intern/core/constants/app_colors.dart';
// FIX: Corrected import file name from custom_bottom.dart to custom_bottom_nav_bar.dart
import 'package:task_tracker_intern/core/widgets/custom_bottom_nav_bar.dart';
import 'package:task_tracker_intern/home/screens/home_screen.dart';
import 'package:task_tracker_intern/home/screens/profile_screen.dart';
import 'package:task_tracker_intern/projects/screens/projects_screen.dart';
import 'package:task_tracker_intern/schedule/screens/schedule_screen.dart';
// Assuming you named the file this

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const ScheduleScreen(),
    const ProjectsScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The currently selected screen is displayed here
      body: _widgetOptions.elementAt(_selectedIndex),

      // -----------------------------------------------------
      // FLOATING ACTION BUTTON IMPLEMENTATION
      // -----------------------------------------------------
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement navigation to the 'Add New Task' screen
          debugPrint('Add New Task button pressed!');
        },
        // The primary purple color from your constants
        backgroundColor: AppColors.primaryPurple,
        // Custom shape for the rounded rectangle look
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        // The white plus icon
        child: const Icon(
            Icons.add,
            color: AppColors.cardWhite,
            size: 30
        ),
      ),

      // Position the FAB to be docked centrally, cutting into the BottomAppBar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // -----------------------------------------------------
      // CUSTOM BOTTOM NAVIGATION BAR (with the notch)
      // -----------------------------------------------------
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
} // Removed the incorrect trailing comma