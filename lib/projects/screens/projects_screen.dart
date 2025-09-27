import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../widgets/project_status_card.dart'; // Ensure this is created from the previous response

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  // Component for upcoming activity list item
  Widget _buildActivityItem({required String title, required String time}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyles.bodyText.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.access_time, size: 14, color: AppColors.secondaryText),
              const SizedBox(width: 4),
              Text('Working', style: AppStyles.secondaryBodyText),
              const SizedBox(width: 8),
              Text(time, style: AppStyles.secondaryBodyText),
            ],
          ),
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
                // Typically navigates back, or to a specific screen if this is a top-level screen
              },
            ),
            title: const Text('Projects', style: AppStyles.heading1),
            centerTitle: true,
          ),

          // Project Status Grid
          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.95, // Adjust this ratio for perfect card sizing
              children: const [
                ProjectStatusCard(
                  status: 'Completed',
                  taskCount: 89,
                  cardColor: AppColors.blueTask,
                  icon: Icons.check_circle_outline,
                ),
                ProjectStatusCard(
                  status: 'Pending',
                  taskCount: 16,
                  cardColor: AppColors.greenTask,
                  icon: Icons.access_time_filled,
                ),
                ProjectStatusCard(
                  status: 'Canceled',
                  taskCount: 67,
                  cardColor: AppColors.redTask,
                  icon: Icons.cancel_outlined,
                ),
                ProjectStatusCard(
                  status: 'On Going',
                  taskCount: 7,
                  cardColor: AppColors.orangeTask,
                  icon: Icons.run_circle_outlined,
                ),
              ],
            ),
          ),

          // Upcoming Activity Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Upcoming Activity', style: AppStyles.subheading.copyWith(fontSize: 18)),
                  Text(
                    'View All',
                    style: AppStyles.secondaryBodyText.copyWith(color: AppColors.primaryPurple, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),

          // Upcoming Activity List
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    _buildActivityItem(
                      title: 'Conduct User Research',
                      time: '09:00 pm - 10:30 pm',
                    ),
                    _buildActivityItem(
                      title: 'Working Dashboard Design',
                      time: '09:00 am - 09:45 am',
                    ),
                    // ... more items
                  ],
                ),
              ),
              const SizedBox(height: 100), // Space for FAB
            ]),
          ),
        ],
      ),
      // REMOVED: floatingActionButton and floatingActionButtonLocation
      // These are managed by the parent MainDashboard.
    );
  }
}