import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class TaskListItem extends StatelessWidget {
  final String title;
  final String time; // Can represent createdAt or status
  final Color statusColor; // Left border status color
  final VoidCallback? onTap; // Tapping the card
  final VoidCallback? onAddTap; // Optional action button

  const TaskListItem({
    required this.title,
    required this.time,
    required this.statusColor,
    this.onTap,
    this.onAddTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => debugPrint('Tapped: $title'),
      child: Container(
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left status bar
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),

            // Task info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppStyles.subheading,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14, color: AppColors.secondaryText),
                      const SizedBox(width: 4),
                      Text(time, style: AppStyles.secondaryBodyText),
                    ],
                  ),
                ],
              ),
            ),

            // Optional Add/Action Button
            if (onAddTap != null)
              InkWell(
                onTap: onAddTap,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primaryPurple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: AppColors.cardWhite,
                    size: 20,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
