import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmotionalWellbeingAssessmentPage extends StatefulWidget {
  @override
  _EmotionalWellbeingAssessmentPageState createState() =>
      _EmotionalWellbeingAssessmentPageState();
}

class _EmotionalWellbeingAssessmentPageState
    extends State<EmotionalWellbeingAssessmentPage> {
  final _formKey = GlobalKey<FormState>();
  final _supabaseClient = Supabase.instance.client;

  String? _name;
  String? _gender;
  int? _age;
  List<String?> _answers = List.filled(10, null);

  bool _isSubmitting = false;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'How often do you feel stressed?',
      'options': ['Never', 'Rarely', 'Sometimes', 'Often'],
      'correct': 'Sometimes'
    },
    {
      'question': 'How often do you exercise?',
      'options': ['Never', 'Rarely', 'Sometimes', 'Often'],
      'correct': 'Often'
    },
    {
      'question': 'How often do you feel anxious?',
      'options': ['Never', 'Rarely', 'Sometimes', 'Often'],
      'correct': 'Sometimes'
    },
    {
      'question': 'How often do you sleep well?',
      'options': ['Never', 'Rarely', 'Sometimes', 'Often'],
      'correct': 'Often'
    },
    {
      'question': 'How often do you feel happy?',
      'options': ['Never', 'Rarely', 'Sometimes', 'Often'],
      'correct': 'Often'
    },
    {
      'question': 'How often do you socialize?',
      'options': ['Never', 'Rarely', 'Sometimes', 'Often'],
      'correct': 'Often'
    },
    {
      'question': 'How often do you feel tired?',
      'options': ['Never', 'Rarely', 'Sometimes', 'Often'],
      'correct': 'Sometimes'
    },
    {
      'question': 'How often do you eat healthy?',
      'options': ['Never', 'Rarely', 'Sometimes', 'Often'],
      'correct': 'Often'
    },
    {
      'question': 'How often do you feel motivated?',
      'options': ['Never', 'Rarely', 'Sometimes', 'Often'],
      'correct': 'Often'
    },
    {
      'question': 'How often do you take breaks?',
      'options': ['Never', 'Rarely', 'Sometimes', 'Often'],
      'correct': 'Often'
    },
  ];

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_name == null || _gender == null || _age == null) {
        _showSnackbar('All fields are required.');
        return;
      }
      int score = 0;
      for (int i = 0; i < _questions.length; i++) {
        if (_answers[i] == _questions[i]['correct']) {
          score++;
        }
      }
      setState(() {
        _isSubmitting = true;
      });

      try {
        final response = await _supabaseClient
            .from('assessmentpage')
            .insert({
              'name': _name,
              'gender': _gender,
              'age': _age,
              'score': score,
            })
            .select()
            .single();

        if (response != null) {
          _showSnackbar('Data added successfully', isSuccess: true);
          _showResult(score);
        }
      } on PostgrestException catch (error) {
        _showSnackbar('Database Error: ${error.message}');
      } catch (error) {
        _showSnackbar('Unexpected Error: $error');
      } finally {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _showResult(int score) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Assessment Result'),
        content: Text('Your score is $score out of 10'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSnackbar(String message, {bool isSuccess = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Emotional Wellbeing Assessment',
          style: TextStyle(color: Colors.grey.shade200, fontSize: 18),
        ),
        backgroundColor: Colors.grey.shade700,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Form Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Material(
                elevation: 8.0,
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: LinearGradient(
                      colors: [Colors.yellow.shade100, Colors.green.shade100],
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(Icons.person,
                                color: Colors.green.shade700),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _name = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(Icons.accessibility_new,
                                color: Colors.green.shade700),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your gender';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _gender = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Age',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(Icons.calendar_today,
                                color: Colors.green.shade700),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your age';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _age = int.tryParse(value!);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Question Section
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green.shade50,
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  for (int i = 0; i < _questions.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _questions[i]['question'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade500,
                            ),
                          ),
                          SizedBox(height: 10),
                          ..._questions[i]['options'].map<Widget>((option) {
                            return Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(vertical: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: RadioListTile<String>(
                                title: Text(option),
                                value: option,
                                groupValue: _answers[i],
                                onChanged: (value) {
                                  setState(() {
                                    _answers[i] = value;
                                  });
                                },
                                tileColor: Colors.white,
                                selectedTileColor: Colors.green.shade50,
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Submit Button Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
                ),
                child: _isSubmitting
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Submit',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
