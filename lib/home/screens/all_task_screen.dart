import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../widgets/task_list_item.dart';
import 'task_details_screen.dart';

class AllTasksScreen extends StatelessWidget {
  final String status;
  const AllTasksScreen({super.key, required this.status});

  Color _getStatusColor(String? colorName) {
    switch (colorName) {
      case 'green': return AppColors.greenTask;
      case 'purple': return AppColors.primaryPurple;
      case 'red': return AppColors.redTask;
      case 'blue': return AppColors.blueTask;
      default: return AppColors.primaryPurple;
    }
  }

  String _formatTimeAgo(Timestamp? timestamp) {
    if (timestamp == null) return 'N/A';
    final created = timestamp.toDate();
    final diff = DateTime.now().difference(created);
    if (diff.inDays > 7) return '${created.day}/${created.month}/${created.year}';
    if (diff.inDays > 0) return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    if (diff.inHours > 0) return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
    return 'Just now';
  }

  @override
  Widget build(BuildContext context) {
    final query = FirebaseFirestore.instance.collection('tasks').where('status', isEqualTo: status);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryPurple,
        title: Text('$status Tasks', style: AppStyles.subheading.copyWith(color: Colors.white)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: query.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) return Center(child: Text('No tasks found.'));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final taskDoc = docs[index];
              final data = taskDoc.data() as Map<String, dynamic>;
              return TaskListItem(
                title: data['title'] ?? 'No Title',
                time: _formatTimeAgo(data['createdAt'] as Timestamp?),
                statusColor: _getStatusColor(data['statusColor']),
                icon: status == 'Completed' ? Icons.check_circle : Icons.radio_button_unchecked,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => TaskDetailsScreen(taskId: taskDoc.id)));
                },
              );
            },
          );
        },
      ),
    );
  }
}
