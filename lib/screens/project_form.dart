import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '',
      _description = '',
      _techStack = '',
      _projectUrl = '',
      _imageUrl = '';
  bool _isSubmitting = false;

  String? _urlValidator(String? value, {required bool optional}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty && optional) return null;
    final uri = Uri.tryParse(text);
    if (uri == null ||
        !['http', 'https'].contains(uri.scheme) ||
        uri.host.isEmpty) {
      return 'URL harus diawali http:// atau https://';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!await ensureLoggedIn(context)) return;
    if (!mounted) return;
    final token = context.read<AuthState>().token;
    if (token == null) return;
    setState(() => _isSubmitting = true);
    try {
      await context.read<ApiClient>().createProject(
        Project(
          title: _title.trim(),
          description: _description.trim(),
          techStack: _techStack.trim(),
          projectUrl: _projectUrl.trim(),
          projectImageUrl: _imageUrl.trim(),
        ),
        token: token,
      );
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Proyek berhasil ditambahkan!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      if (mounted) Navigator.pop(context, true);
    } on ApiException catch (error) {
      if (!mounted) return;
      if (error.statusCode == 401) {
        await context.read<AuthState>().logout();
        if (mounted) {
          await ensureLoggedIn(context);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan (${error.statusCode}).')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Widget _field({
    required String label,
    required ValueChanged<String> onChanged,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
      validator: validator,
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Add Project')),
    drawer: const LeftDrawer(),
    body: Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _field(
            label: 'Title',
            onChanged: (v) => _title = v,
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Title wajib diisi.' : null,
          ),
          _field(
            label: 'Description',
            maxLines: 4,
            onChanged: (v) => _description = v,
            validator: (v) => v == null || v.trim().isEmpty
                ? 'Description wajib diisi.'
                : null,
          ),
          _field(
            label: 'Tech Stack',
            onChanged: (v) => _techStack = v,
            validator: (v) => v == null || v.trim().isEmpty
                ? 'Tech stack wajib diisi.'
                : null,
          ),
          _field(
            label: 'Project URL',
            onChanged: (v) => _projectUrl = v,
            validator: (v) => _urlValidator(v, optional: false),
          ),
          _field(
            label: 'Project Image URL (optional)',
            onChanged: (v) => _imageUrl = v,
            validator: (v) => _urlValidator(v, optional: true),
          ),
          ElevatedButton(
            onPressed: _isSubmitting ? null : _submit,
            child: _isSubmitting
                ? const CircularProgressIndicator()
                : const Text('Save'),
          ),
        ],
      ),
    ),
  );
}
