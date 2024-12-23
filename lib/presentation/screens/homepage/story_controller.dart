import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class StoryController {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  final String _customStorageEndpoint =
      'https://cqikrjbfvpshqmghjaiu.supabase.co/storage/v1'; // Custom Supabase storage endpoint

  // Upload image to Supabase storage
  Future<String> uploadImage(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Upload the image to the custom endpoint
      final response = await _supabaseClient.storage
          .from('image_url') // Bucket name
          .uploadBinary(fileName, bytes);

      if (response.isEmpty) {
        throw Exception('Failed to upload image: Empty response from Supabase');
      }

      // Construct the public URL manually using the custom endpoint
      final imageUrl =
          '$_customStorageEndpoint/object/public/image_url/$fileName';

      return imageUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  // Add new story
  Future<void> addStory({
    required String name,
    required int age,
    required String gender,
    required String story,
    String? imageUrl,
  }) async {
    try {
      final response = await _supabaseClient
          .from('stories')
          .insert({
            'name': name,
            'age': age,
            'gender': gender,
            'story': story,
            'image_url': imageUrl,
            'created_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      if (response == null) {
        throw Exception('Failed to add story');
      }
    } catch (e) {
      throw Exception('Failed to add story: $e');
    }
  }

  // Fetch all stories or specific story by ID
  Future<List<Map<String, dynamic>>> fetchStories({int? id}) async {
    try {
      var query = _supabaseClient.from('stories').select();

      if (id != null) {
        query = query.eq('id', id);
      }

      final data = await query.order('created_at', ascending: false).select();

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      throw Exception('Failed to fetch stories: $e');
    }
  }

  // Update existing story
  Future<void> updateStory({
    required int id,
    String? name,
    int? age,
    String? gender,
    String? story,
    String? imageUrl,
  }) async {
    try {
      final Map<String, dynamic> updates = {};
      if (name != null) updates['name'] = name;
      if (age != null) updates['age'] = age;
      if (gender != null) updates['gender'] = gender;
      if (story != null) updates['story'] = story;
      if (imageUrl != null) updates['image_url'] = imageUrl;

      final response = await _supabaseClient
          .from('stories')
          .update(updates)
          .eq('id', id)
          .select()
          .single();

      if (response == null) {
        throw Exception('Failed to update story');
      }
    } catch (e) {
      throw Exception('Failed to update story: $e');
    }
  }

  // Delete story
  Future<void> deleteStory(int id) async {
    try {
      final response = await _supabaseClient
          .from('stories')
          .delete()
          .eq('id', id)
          .select()
          .single();

      if (response == null) {
        throw Exception('Failed to delete story');
      }
    } catch (e) {
      throw Exception('Failed to delete story: $e');
    }
  }
}
