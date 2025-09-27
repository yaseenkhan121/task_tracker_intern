import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  // Component for the daily selector pill
  Widget _buildDatePill(String day, int date, {bool isSelected = false}) {
    final color = isSelected ? AppColors.primaryPurple : AppColors.cardWhite;
    final textColor = isSelected ? AppColors.cardWhite : AppColors.primaryText;

    // Applies bold font weight when the pill is selected
    final textStyle = isSelected
        ? AppStyles.bodyText.copyWith(color: textColor, fontWeight: FontWeight.bold)
        : AppStyles.bodyText.copyWith(color: textColor);

    return Container(
      width: 50,
      height: 70, // Ensures consistent height in the horizontal list
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$date', style: textStyle),
          // Copying the base style and adjusting font size for the day abbreviation
          Text(day, style: textStyle.copyWith(fontSize: 12)),
        ],
      ),
    );
  }

  // Component for a time-blocked task
  Widget _buildScheduleTask({required String title, required String time, Color color = AppColors.greenTask}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(15),
        // Stylish left border to indicate task color/type
        border: Border(left: BorderSide(color: color, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyles.subheading.copyWith(fontSize: 14)),
          const SizedBox(height: 4),
          Text(time, style: AppStyles.secondaryBodyText),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            floating: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryText),
              onPressed: () {
                // Allows the user to navigate back
                Navigator.pop(context);
              },
            ),
            title: const Text('Schedule', style: AppStyles.heading1),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert, color: AppColors.primaryText),
                onPressed: () {
                  // Placeholder for additional actions
                },
              ),
            ],
          ),

          // Header: Today and Date
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Today', style: AppStyles.heading1.copyWith(fontSize: 28)),
                  Text('Sunday, 27 March', style: AppStyles.secondaryBodyText),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Horizontal Date Picker
          SliverToBoxAdapter(
            child: SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 24, right: 12),
                children: [
                  _buildDatePill('Mon', 1),
                  _buildDatePill('Tue', 2),
                  // Default selected day for the mock schedule
                  _buildDatePill('Wed', 3, isSelected: true),
                  _buildDatePill('Thu', 4),
                  _buildDatePill('Fri', 5),
                  _buildDatePill('Sat', 6),
                  _buildDatePill('Sun', 7),
                ],
              ),
            ),
          ),

          // Schedule List
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    // Tasks with different color coding
                    _buildScheduleTask(
                      title: 'Mobile App Design Research',
                      time: '09:00 am - 10:30 am',
                      color: AppColors.blueTask,
                    ),
                    _buildScheduleTask(
                      title: 'Preparation for Mobile App Design',
                      time: '10:00 am - 12:45 pm',
                      color: AppColors.primaryPurple,
                    ),

                    _buildScheduleTask(
                      title: 'Lunch & Rest',
                      time: '14:00 pm - 15:30 pm',
                      color: AppColors.redTask,
                    ),

                    _buildScheduleTask(
                      title: 'Finish Up the Project',
                      time: '15:30 pm - 18:00 pm',
                      color: AppColors.greenTask,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100), // Space for FAB/Bottom Padding
            ]),
          ),
        ],
      ),
    );
  }
}
