import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/medication.dart';
import '../config/theme.dart';

class AddMedicationScreen extends StatefulWidget {
  const AddMedicationScreen({super.key});

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _doseController = TextEditingController();
  final _pharmacyController = TextEditingController();
  
  String _frequency = 'Once daily';
  int _refillsRemaining = 3;
  final List<String> _times = ['09:00'];

  final List<String> _frequencyOptions = [
    'Once daily',
    'Twice daily',
    'Three times daily',
    'Four times daily',
    'As needed',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _doseController.dispose();
    _pharmacyController.dispose();
    super.dispose();
  }

  void _addTime() {
    setState(() {
      _times.add('12:00');
    });
  }

  void _removeTime(int index) {
    if (_times.length > 1) {
      setState(() {
        _times.removeAt(index);
      });
    }
  }

  Future<void> _saveMedication() async {
    if (_formKey.currentState!.validate()) {
      final appProvider = Provider.of<AppProvider>(context, listen: false);
      
      final medication = Medication(
        id: '',
        name: _nameController.text,
        dose: _doseController.text,
        frequency: _frequency,
        times: _times,
        refillsRemaining: _refillsRemaining,
        pharmacy: _pharmacyController.text,
        history: [],
      );

      appProvider.addMedication(medication);
      
      if (mounted) {
        context.go('/medications');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    
    return Scaffold(
      backgroundColor: AppTheme.grayBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/medications'),
        ),
        title: const Text('Add Medication'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(isLandscape ? 12 : 16),
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(isLandscape ? 16 : 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Medication Name
                      Text(
                        'Medication Name',
                        style: TextStyle(
                          fontSize: isLandscape ? 13 : 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: isLandscape ? 6 : 8),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Enter medication name',
                          constraints: BoxConstraints(
                            minHeight: isLandscape 
                                ? AppTheme.minTouchTargetLandscape 
                                : AppTheme.minTouchTarget,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter medication name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: isLandscape ? 14 : 16),
                      
                      // Dose
                      Text(
                        'Dose',
                        style: TextStyle(
                          fontSize: isLandscape ? 13 : 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: isLandscape ? 6 : 8),
                      TextFormField(
                        controller: _doseController,
                        decoration: InputDecoration(
                          hintText: 'e.g., 10mg',
                          constraints: BoxConstraints(
                            minHeight: isLandscape 
                                ? AppTheme.minTouchTargetLandscape 
                                : AppTheme.minTouchTarget,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter dose';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: isLandscape ? 14 : 16),
                      
                      // Frequency
                      Text(
                        'Frequency',
                        style: TextStyle(
                          fontSize: isLandscape ? 13 : 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: isLandscape ? 6 : 8),
                      DropdownButtonFormField<String>(
                        value: _frequency,
                        decoration: InputDecoration(
                          constraints: BoxConstraints(
                            minHeight: isLandscape 
                                ? AppTheme.minTouchTargetLandscape 
                                : AppTheme.minTouchTarget,
                          ),
                        ),
                        items: _frequencyOptions.map((freq) {
                          return DropdownMenuItem(
                            value: freq,
                            child: Text(freq),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _frequency = value!;
                          });
                        },
                      ),
                      SizedBox(height: isLandscape ? 14 : 16),
                      
                      // Times
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Times',
                            style: TextStyle(
                              fontSize: isLandscape ? 13 : 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: _addTime,
                            icon: const Icon(Icons.add, size: 16),
                            label: const Text('Add Time'),
                          ),
                        ],
                      ),
                      SizedBox(height: isLandscape ? 6 : 8),
                      
                      ..._times.asMap().entries.map((entry) {
                        final index = entry.key;
                        final time = entry.value;
                        
                        return Padding(
                          padding: EdgeInsets.only(bottom: isLandscape ? 6 : 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isLandscape ? 12 : 16,
                                    vertical: isLandscape ? 12 : 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryLight,
                                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
                                  ),
                                  child: Text(
                                    time,
                                    style: TextStyle(
                                      fontSize: isLandscape ? 13 : 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              if (_times.length > 1) ...[
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  onPressed: () => _removeTime(index),
                                  color: AppTheme.errorColor,
                                ),
                              ],
                            ],
                          ),
                        );
                      }),
                      SizedBox(height: isLandscape ? 14 : 16),
                      
                      // Pharmacy
                      Text(
                        'Pharmacy',
                        style: TextStyle(
                          fontSize: isLandscape ? 13 : 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: isLandscape ? 6 : 8),
                      TextFormField(
                        controller: _pharmacyController,
                        decoration: InputDecoration(
                          hintText: 'Enter pharmacy name',
                          constraints: BoxConstraints(
                            minHeight: isLandscape 
                                ? AppTheme.minTouchTargetLandscape 
                                : AppTheme.minTouchTarget,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter pharmacy';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: isLandscape ? 14 : 16),
                      
                      // Refills
                      Text(
                        'Refills Remaining',
                        style: TextStyle(
                          fontSize: isLandscape ? 13 : 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: isLandscape ? 6 : 8),
                      Slider(
                        value: _refillsRemaining.toDouble(),
                        min: 0,
                        max: 12,
                        divisions: 12,
                        label: _refillsRemaining.toString(),
                        onChanged: (value) {
                          setState(() {
                            _refillsRemaining = value.toInt();
                          });
                        },
                      ),
                      Text(
                        '$_refillsRemaining refill${_refillsRemaining == 1 ? '' : 's'}',
                        style: TextStyle(
                          fontSize: isLandscape ? 12 : 14,
                          color: AppTheme.grayMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: isLandscape ? 16 : 24),
              
              // Save Button
              ElevatedButton(
                onPressed: _saveMedication,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    double.infinity,
                    isLandscape 
                        ? AppTheme.minTouchTargetLandscape 
                        : AppTheme.minTouchTarget,
                  ),
                ),
                child: const Text('Save Medication'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
