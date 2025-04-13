import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../../blocs/habit/habit_bloc.dart';
import '../../blocs/habit/habit_event.dart';
import '../../models/habit_model.dart';
import 'package:uuid/uuid.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  List<SubHabitModel> _subHabits = [];

  void _addSubHabitField() {
    setState(() {
      _subHabits.add(SubHabitModel(title: '', time: DateTime.now()));
    });
  }

  void _updateSubHabitTitle(int index, String value) {
    _subHabits[index] = SubHabitModel(title: value, time: _subHabits[index].time);
  }

  void _updateSubHabitTime(int index, DateTime time) {
    _subHabits[index] = SubHabitModel(title: _subHabits[index].title, time: time);
  }

  Future<void> _pickTime(int index) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_subHabits[index].time),
    );

    if (picked != null) {
      final now = DateTime.now();
      final pickedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );
      setState(() => _updateSubHabitTime(index, pickedDateTime));
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _subHabits.isNotEmpty) {
      final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      final newHabit = HabitModel(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        subHabits: _subHabits,
        userId: userId,
      );

      context.read<HabitBloc>().add(AddHabitEvent(newHabit));
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Habit added successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Habit"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Habit Title'),
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 24),
              Text("Sub-habits", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              ..._subHabits.asMap().entries.map((entry) {
                final index = entry.key;
                final subHabit = entry.value;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: subHabit.title,
                          decoration: const InputDecoration(
                            labelText: 'Sub-habit',
                          ),
                          onChanged: (val) => _updateSubHabitTitle(index, val),
                          validator: (value) =>
                              value!.isEmpty ? 'Enter sub-habit title' : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      TextButton(
                        onPressed: () => _pickTime(index),
                        child: Text(
                          DateFormat.Hm().format(subHabit.time),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          setState(() {
                            _subHabits.removeAt(index);
                          });
                        },
                      )
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: _addSubHabitField,
                icon: const Icon(Icons.add),
                label: const Text("Add Sub-habit"),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Save Habit', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}  