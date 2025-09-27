import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  String _selectedStatus = 'Todo';
  String _selectedColor = 'purple';
  bool _isLoading = false;

  final List<Map<String, dynamic>> _statusOptions = [
    {'name': 'Todo', 'color': AppColors.primaryPurple},
    {'name': 'In Progress', 'color': AppColors.blueTask},
    {'name': 'Completed', 'color': AppColors.greenTask},
  ];

  final List<Map<String, dynamic>> _colorOptions = [
    {'name': 'purple', 'color': AppColors.primaryPurple},
    {'name': 'blue', 'color': AppColors.blueTask},
    {'name': 'green', 'color': AppColors.greenTask},
    {'name': 'red', 'color': AppColors.redTask},
  ];

  Future<void> _createTask() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) throw "User not logged in";

        await FirebaseFirestore.instance.collection('tasks').add({
          'title': _titleController.text,
          'subtitle': _subtitleController.text,
          'status': _selectedStatus,
          'statusColor': _selectedColor,
          'time': Timestamp.now(),
          'assignees': [],
          'duration': 'N/A',
          'userId': user.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });

        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Task created successfully!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create task: $e')),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 32,
        ),
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Create New Task',
                style: AppStyles.heading1.copyWith(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: AppColors.cardWhite,
                ),
                validator: (value) => (value == null || value.isEmpty) ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _subtitleController,
                decoration: InputDecoration(
                  labelText: 'Task Subtitle',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: AppColors.cardWhite,
                ),
                validator: (value) => (value == null || value.isEmpty) ? 'Please enter a subtitle' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: AppColors.cardWhite,
                ),
                items: _statusOptions.map<DropdownMenuItem<String>>((option) {
                  return DropdownMenuItem<String>(
                    value: option['name'] as String,
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: option['color'] as Color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(option['name'] as String),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedStatus = value!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedColor,
                decoration: InputDecoration(
                  labelText: 'Card Color',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: AppColors.cardWhite,
                ),
                items: _colorOptions.map<DropdownMenuItem<String>>((option) {
                  return DropdownMenuItem<String>(
                    value: option['name'] as String,
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: option['color'] as Color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(option['name'] as String),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedColor = value!),
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _createTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  foregroundColor: AppColors.cardWhite,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Create Task', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
