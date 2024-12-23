import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'story_controller.dart';

class YourStoryPage extends StatefulWidget {
  @override
  _YourStoryPageState createState() => _YourStoryPageState();
}

class _YourStoryPageState extends State<YourStoryPage> {
  final _storyController = StoryController();
  final _formKey = GlobalKey<FormState>();

  String? _name, _gender, _story;
  int? _age;
  File? _imageFile;

  final _imagePicker = ImagePicker();
  bool _isSubmitting = false;
  List<Map<String, dynamic>> _stories = [];

  /// Picks an image from the gallery.
  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  /// Submits the story.
  Future<void> _submitStory() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isSubmitting = true;
      });

      try {
        String? imageUrl;

        if (_imageFile != null) {
          imageUrl = await _storyController.uploadImage(_imageFile!);
        }

        await _storyController.addStory(
          name: _name!,
          age: _age!,
          gender: _gender!,
          story: _story!,
          imageUrl: imageUrl,
        );

        _showSnackbar('Story added successfully!');
        await _loadStories();
        _formKey.currentState!.reset();
        setState(() {
          _imageFile = null;
        });
      } catch (error) {
        _showSnackbar('Error: $error');
      } finally {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Future<void> _loadStories({int? id}) async {
    try {
      final stories = await _storyController.fetchStories(id: id);
      setState(() {
        _stories = stories;
      });
    } catch (error) {
      _showSnackbar('Error: $error');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add and View Motivational Stories',
          style: TextStyle(
              color: Colors.grey.shade200,
              fontSize: 17,
              fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.grey.shade700, // LinkedIn blue color
        elevation: 4,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
              12.0), // Increased padding for better spacing
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add Story Form
              Card(
                color: Colors.white,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _imageFile != null
                                ? FileImage(_imageFile!)
                                : null,
                            child: _imageFile == null
                                ? Icon(Icons.add_a_photo, size: 50)
                                : null,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.black54),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 15),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Enter a name' : null,
                          onSaved: (value) => _name = value,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Age',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.black54),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 15),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value!.isEmpty ? 'Enter an age' : null,
                          onSaved: (value) => _age = int.tryParse(value!),
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.black54),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 15),
                          ),
                          items: ['Male', 'Female', 'Other']
                              .map((gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender),
                                  ))
                              .toList(),
                          onChanged: (value) => _gender = value,
                          validator: (value) =>
                              value == null ? 'Select a gender' : null,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Story',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.black54),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 15),
                          ),
                          maxLines: 3,
                          maxLength: 230,
                          validator: (value) =>
                              value!.isEmpty ? 'Enter your story' : null,
                          onSaved: (value) => _story = value,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _isSubmitting ? null : _submitStory,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade500,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: _isSubmitting
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Stories Section
              Card(
                color: Colors.green.shade50,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Stories',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 24),
                      _stories.isEmpty
                          ? Text(
                              'No stories added yet!',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _stories.length,
                              itemBuilder: (context, index) {
                                final story = _stories[index];
                                return Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 4,
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Image Section
                                      story['image_url'] != null
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                              ),
                                              child: Image.network(
                                                story['image_url'],
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 150,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Container(
                                              color: Colors.grey.shade300,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 150,
                                            ),
                                      SizedBox(height: 12),
                                      // Name and Story Text
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          story['name'],
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          story['story'],
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
