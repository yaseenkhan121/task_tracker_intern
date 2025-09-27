import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import 'package:intl/intl.dart';

class TaskDetailsScreen extends StatelessWidget {
  final String taskId;

  const TaskDetailsScreen({super.key, required this.taskId});

  // Reusable detail row inside card
  Widget _buildDetailRow({required String label, required String value, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 22, color: AppColors.primaryPurple),
            const SizedBox(width: 12),
          ],
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: AppStyles.secondaryBodyText.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value.isNotEmpty ? value : 'N/A',
              style: AppStyles.bodyText.copyWith(color: AppColors.primaryText),
            ),
          ),
        ],
      ),
    );
  }

  // Header with gradient
  Widget _buildDetailHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryPurple, AppColors.primaryPurple.withOpacity(0.8)],
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'Task Details',
            style: AppStyles.subheading.copyWith(fontSize: 22, color: Colors.white),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  // Avatar stack
  Widget _buildAvatarStack(List<dynamic>? assignees) {
    if (assignees == null || assignees.isEmpty) {
      return const Text("No Assignees", style: AppStyles.secondaryBodyText);
    }
    return SizedBox(
      height: 40,
      child: Stack(
        children: List.generate(assignees.length, (index) {
          return Positioned(
            left: index * 28.0,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primaryPurple.withOpacity(0.8 - index * 0.1),
              child: Text(
                assignees[index][0].toUpperCase(),
                style: const TextStyle(color: AppColors.cardWhite, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }),
      ),
    );
  }

  String _formatDueTime(dynamic timestamp) {
    if (timestamp == null) return 'No Due Date';
    if (timestamp is Timestamp) return DateFormat('dd MMM yyyy, hh:mm a').format(timestamp.toDate());
    return timestamp.toString();
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('tasks').doc(taskId).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text("Task not found"));
            }

            final data = snapshot.data!.data() as Map<String, dynamic>? ?? {};

            final title = data['title'] ?? 'Untitled Task';
            final description = data['description'] ?? 'No description available';
            final dueTime = _formatDueTime(data['time']);
            final assignees = (data['assignees'] as List<dynamic>?) ?? [];
            final attachment = data['attachment'] ?? '';

            return Column(
              children: [
                _buildDetailHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppStyles.heading1.copyWith(fontSize: 26)),
                        const SizedBox(height: 16),

                        // Description Card
                        _buildCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Description', style: AppStyles.subheading),
                              const SizedBox(height: 8),
                              Text(description, style: AppStyles.bodyText.copyWith(color: AppColors.secondaryText)),
                            ],
                          ),
                        ),

                        // Assignees Card
                        if (assignees.isNotEmpty)
                          _buildCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDetailRow(label: 'Assigned to', value: '', icon: Icons.group),
                                const SizedBox(height: 8),
                                _buildAvatarStack(assignees),
                              ],
                            ),
                          ),

                        // Due Date Card
                        _buildCard(
                          child: _buildDetailRow(label: 'Due To', value: dueTime, icon: Icons.access_time),
                        ),

                        // Attachment Card
                        if (attachment.isNotEmpty)
                          _buildCard(
                            child: _buildDetailRow(label: 'Attachment', value: attachment, icon: Icons.attachment),
                          ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
