import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class TaskListItem extends StatelessWidget {
  final String title;
  final String time;
  final Color statusColor;
  final IconData icon;
  final VoidCallback? onTap;
  final Future<void> Function()? onDeleteTap; // 🔹 async delete callback

  const TaskListItem({
    required this.title,
    required this.time,
    required this.statusColor,
    required this.icon,
    this.onTap,
    this.onDeleteTap,
    super.key,
  });

  /// 🔹 Show confirmation dialog before deletion
  Future<void> _confirmAndDelete(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Delete Task"),
        content: const Text(
          "Are you sure you want to permanently delete this task? This action cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm == true && onDeleteTap != null) {
      await onDeleteTap!();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task permanently deleted")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {
        debugPrint("Navigating to details of $title");
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.06),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon inside colored square
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: statusColor, size: 22),
            ),
            const SizedBox(width: 16),

            // Task title + time
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppStyles.subheading.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.primaryText,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: AppStyles.secondaryBodyText.copyWith(
                      fontSize: 13,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),

            // Delete button
            if (onDeleteTap != null)
              InkWell(
                onTap: () => _confirmAndDelete(context),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.delete, color: Colors.red, size: 18),
                ),
              ),

            // Arrow indicator
            const Icon(Icons.arrow_forward_ios,
                size: 16, color: AppColors.secondaryText),
          ],
        ),
      ),
    );
  }
}
