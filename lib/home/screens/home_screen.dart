import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_tracker_intern/home/screens/all_task_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/widgets/avatar_stack.dart';
import '../widgets/task_list_item.dart';
import 'task_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Color _getStatusColor(String? colorName) {
    switch (colorName) {
      case 'green':
        return AppColors.greenTask;
      case 'purple':
        return AppColors.primaryPurple;
      case 'red':
        return AppColors.redTask;
      case 'blue':
        return AppColors.blueTask;
      default:
        return AppColors.primaryPurple;
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

  Future<void> _deleteTask(String taskId) async {
    try {
      await _firestore.collection('tasks').doc(taskId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task deleted successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete task: $e")),
      );
    }
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('task_tracker 👋', style: AppStyles.heading1),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.notifications_none, color: AppColors.primaryText),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Search for task',
              hintStyle: AppStyles.secondaryBodyText,
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: AppColors.secondaryText),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {bool showViewAll = true, String? status}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppStyles.subheading.copyWith(fontSize: 18)),
          if (showViewAll && status != null)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AllTasksScreen(status: status)),
                );
              },
              child: Text(
                'View All',
                style: AppStyles.secondaryBodyText.copyWith(
                    color: AppColors.primaryPurple, fontWeight: FontWeight.w600),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTaskStream({
    required Query query,
    required Widget Function(List<QueryDocumentSnapshot>) builder,
    String emptyMessage = 'No tasks found.',
  }) {
    return StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(child: Text('Error: ${snapshot.error}'));
        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) return Center(child: Text(emptyMessage));
        return builder(docs);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader()),

              // In Progress Section
              SliverToBoxAdapter(child: _buildSectionHeader('In Progress', status: 'In Progress')),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 160,
                  child: _buildTaskStream(
                    query: _firestore.collection('tasks').where('status', isEqualTo: 'In Progress'),
                    emptyMessage: 'No ongoing tasks.',
                    builder: (docs) => ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(right: 16),
                      itemCount: docs.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final taskDoc = docs[index];
                        final task = taskDoc.data() as Map<String, dynamic>;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => TaskDetailsScreen(taskId: taskDoc.id)));
                          },
                          child: Container(
                            width: 250,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF48A5EE), Color(0xFF6748EE)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.blueTask.withOpacity(0.4),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5))
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(task['title'] ?? 'No Title',
                                    style: AppStyles.subheading
                                        .copyWith(color: AppColors.cardWhite)),
                                Text(task['subtitle'] ?? 'No Subtitle',
                                    style: AppStyles.secondaryBodyText.copyWith(
                                        color: AppColors.cardWhite.withOpacity(0.8))),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AvatarStack(
                                      imageUrls: List<String>.from(task['assignees'] ?? []),
                                      maxShown: 3,
                                      baseColor: AppColors.blueTask,
                                    ),
                                    Text(task['duration'] ?? 'N/A',
                                        style: AppStyles.secondaryBodyText.copyWith(
                                            color: AppColors.cardWhite,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Todo Section
              SliverToBoxAdapter(child: _buildSectionHeader('Todo List', status: 'Todo')),
              SliverToBoxAdapter(
                child: _buildTaskStream(
                  query: _firestore.collection('tasks').where('status', isEqualTo: 'Todo'),
                  emptyMessage: 'No todo tasks.',
                  builder: (docs) => Column(
                    children: docs.map((taskDoc) {
                      final data = taskDoc.data() as Map<String, dynamic>;
                      final docId = taskDoc.id;
                      return TaskListItem(
                        title: data['title'] ?? 'No Title',
                        time: _formatTimeAgo(data['createdAt'] as Timestamp?),
                        statusColor: _getStatusColor(data['statusColor']),
                        icon: Icons.radio_button_unchecked,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => TaskDetailsScreen(taskId: docId)));
                        },
                        onDeleteTap: () async {
                          await _deleteTask(docId);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),

              // Completed Section
              SliverToBoxAdapter(child: _buildSectionHeader('Completed Tasks', showViewAll: false)),
              SliverToBoxAdapter(
                child: _buildTaskStream(
                  query: _firestore.collection('tasks').where('status', isEqualTo: 'Completed'),
                  emptyMessage: 'No completed tasks yet.',
                  builder: (docs) => Column(
                    children: docs.map((taskDoc) {
                      final data = taskDoc.data() as Map<String, dynamic>;
                      final docId = taskDoc.id;
                      return TaskListItem(
                        title: data['title'] ?? 'No Title',
                        time: _formatTimeAgo(data['createdAt'] as Timestamp?),
                        statusColor: _getStatusColor(data['statusColor']),
                        icon: Icons.check_circle,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => TaskDetailsScreen(taskId: docId)));
                        },
                        onDeleteTap: () async {
                          await _deleteTask(docId);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
    );
  }
}
