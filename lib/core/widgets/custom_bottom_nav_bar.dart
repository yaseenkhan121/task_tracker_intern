import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.cardWhite,
      surfaceTintColor: Colors.transparent, // Prevents Android tinting on M3
      // This shape creates the central notch for the FloatingActionButton
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      elevation: 10.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // Home (Index 0)
          _buildNavItem(0, Icons.home_outlined, Icons.home),
          // Schedule (Index 1)
          _buildNavItem(1, Icons.calendar_today_outlined, Icons.calendar_today),

          const SizedBox(width: 40), // Spacer to make room for the docked FAB

          // Projects (Index 2)
          _buildNavItem(2, Icons.folder_open_outlined, Icons.folder),
          // Profile (Index 3)
          _buildNavItem(3, Icons.person_outline, Icons.person),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData unselectedIcon, IconData selectedIcon) {
    final isSelected = selectedIndex == index;
    return InkWell(
      onTap: () => onItemTapped(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : unselectedIcon,
              // Apply primary purple color when selected
              color: isSelected ? AppColors.primaryPurple : AppColors.secondaryText,
              size: 26,
            ),
          ],
        ),
      ),
    );
  }
}