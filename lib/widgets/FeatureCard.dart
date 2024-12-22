import 'package:flutter/material.dart';

class Featurecard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final VoidCallback Path;

  const Featurecard(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.imagePath,
      required this.Path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: Path,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image Section
              Image.network(
                imagePath,
                height: 105,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 4),
              // Title Section
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
