import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class ProjectStatusCard extends StatelessWidget {
  final String status;
  final int taskCount;
  final Color cardColor;
  final IconData icon;

  const ProjectStatusCard({
    required this.status,
    required this.taskCount,
    required this.cardColor,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon and status (using Stack to create the badge effect)
          Stack(
            children: [
              Icon(icon, size: 40, color: AppColors.cardWhite.withOpacity(0.4)),
              Positioned(
                top: 5,
                left: 5,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.cardWhite,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Text Details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                status,
                style: AppStyles.subheading.copyWith(
                  color: AppColors.cardWhite,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '$taskCount Task',
                style: AppStyles.secondaryBodyText.copyWith(
                  color: AppColors.cardWhite.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}