import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'dart:ui';

import 'package:worklify_app/blocs/habit/habit_bloc.dart';
import 'package:worklify_app/blocs/habit/habit_event.dart';
import 'package:worklify_app/models/habit_model.dart'; // For ImageFilter

class AddHabitDialog extends StatefulWidget {
  const AddHabitDialog({super.key});

  @override
  State<AddHabitDialog> createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  List<SubHabitModel> _subHabits = [];
  Color _selectedColor = Colors.deepPurple;
  IconData _selectedIcon = Icons.check_circle;
  String _repeatOption = "Everyday";

  final List<Color> _availableColors = [
    Colors.deepPurple,
    Colors.pink,
    Colors.orange,
    Colors.teal,
    Colors.blue,
  ];

  final List<IconData> _availableIcons = [
    Icons.fitness_center,
    Icons.book,
    Icons.water_drop,
    Icons.run_circle,
    Icons.self_improvement,
  ];

  void _addSubHabitField() {
    setState(() {
      _subHabits.add(SubHabitModel(title: '', time: DateTime.now()));
    });
  }

  void _pickTime(int index) async {
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
      setState(() {
        _subHabits[index] = _subHabits[index].copyWith(time: pickedDateTime);
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      bool areSubHabitsValid =
          _subHabits.every((sub) => sub.title.trim().isNotEmpty);
      if ( !areSubHabitsValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please complete all subhabits')),
        );
        return;
      }

      final habit = HabitModel(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        colorValue: _selectedColor.value,
        iconCodePoint: _selectedIcon.codePoint,
        iconFontFamily: _selectedIcon.fontFamily ?? '',
        subHabits: _subHabits,
        repeatOption: _repeatOption,
        userId: userId,
      );

      context.read<HabitBloc>().add(AddHabitEvent(habit));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor.withOpacity(0.9),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Create Habit",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Habit Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a title' : null,
                ),
                const SizedBox(height: 16),
                _buildColorSelector(),
                const SizedBox(height: 16),
                _buildIconSelector(),
                const SizedBox(height: 16),
                _buildRepeatOptions(),
                const SizedBox(height: 16),
                Text(
                  "Subhabits",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                ..._subHabits.asMap().entries.map((entry) {
                  final index = entry.key;
                  final subHabit = entry.value;
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: subHabit.title,
                              decoration:
                                  const InputDecoration(labelText: 'Subhabit'),
                              onChanged: (val) {
                                _subHabits[index] =
                                    _subHabits[index].copyWith(title: val);
                              },
                            ),
                          ),
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
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                TextButton.icon(
                  onPressed: _addSubHabitField,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Subhabit"),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "Save Habit",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Pick Color"),
        const SizedBox(height: 10),
        Row(
          children: _availableColors.map((color) {
            return GestureDetector(
              onTap: () => setState(() => _selectedColor = color),
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: _selectedColor == color
                      ? Border.all(color: Colors.black, width: 2)
                      : null,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildIconSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Pick Icon"),
        const SizedBox(height: 10),
        Row(
          children: _availableIcons.map((icon) {
            return GestureDetector(
              onTap: () => setState(() => _selectedIcon = icon),
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  border: _selectedIcon == icon
                      ? Border.all(color: Colors.black, width: 2)
                      : null,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 28),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRepeatOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Repeat"),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          children: ["Everyday", "Weekdays", "Weekends"].map((option) {
            return ChoiceChip(
              label: Text(option),
              selected: _repeatOption == option,
              onSelected: (_) {
                setState(() {
                  _repeatOption = option;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
