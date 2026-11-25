import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(project.title)),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (project.projectImageUrl.isNotEmpty)
          Image.network(project.projectImageUrl),
        Text(project.description),
        const SizedBox(height: 8),
        Text('Tech stack: ${project.techStack}'),
        Text('Project URL: ${project.projectUrl}'),
      ],
    ),
  );
}
