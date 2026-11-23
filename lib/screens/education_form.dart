import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _institutionController = TextEditingController();
  final _majorController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void dispose() {
    _institutionController.dispose();
    _majorController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  Future<void> _pickStartDate(FormFieldState<DateTime> field) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked == null) return;
    setState(() {
      _startDate = picked;
      if (_endDate != null && _endDate!.isBefore(picked)) {
        _endDate = null;
      }
    });
    field.didChange(picked);
  }

  Future<void> _pickEndDate(FormFieldState<DateTime> field) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime(1990),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() => _endDate = picked);
    field.didChange(picked);
  }

  String? _validateStart(DateTime? value) {
    if (value == null) return 'Tanggal mulai wajib dipilih!';
    return null;
  }

  String? _validateEnd(DateTime? value) {
    if (value == null) return null;
    if (_startDate != null && value.isBefore(_startDate!)) {
      return 'Tanggal selesai tidak boleh sebelum tanggal mulai!';
    }
    return null;
  }

  Widget _buildDateField({
    required String label,
    required DateTime? value,
    required String? errorText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          errorText: errorText,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value == null ? 'Pilih tanggal' : _formatDate(value)),
            const Icon(Icons.calendar_today, size: 18.0),
          ],
        ),
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _institutionController.clear();
    _majorController.clear();
    _descriptionController.clear();
    setState(() {
      _startDate = null;
      _endDate = null;
    });
  }

  void _showSummary() {
    final start = _startDate!;
    final end = _endDate;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edukasi berhasil ditambahkan!'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Institusi: ${_institutionController.text.trim()}'),
              Text('Jurusan: ${_majorController.text.trim()}'),
              Text('Mulai: ${_formatDate(start)}'),
              Text('Selesai: ${end == null ? 'Sekarang' : _formatDate(end)}'),
              if (_descriptionController.text.trim().isNotEmpty)
                Text('Catatan: ${_descriptionController.text.trim()}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _resetForm();
              Navigator.pop(dialogContext);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    _showSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Education Form')),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _institutionController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Contoh: Universitas Indonesia',
                    labelText: 'Nama Institusi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    if (text.isEmpty) {
                      return 'Nama institusi tidak boleh kosong!';
                    }
                    if (text.length < 3) {
                      return 'Nama institusi minimal 3 karakter!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _majorController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Contoh: Ilmu Komputer',
                    labelText: 'Jurusan atau Gelar',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    if (text.isEmpty) {
                      return 'Jurusan atau gelar tidak boleh kosong!';
                    }
                    if (text.length < 3) {
                      return 'Jurusan atau gelar minimal 3 karakter!';
                    }
                    return null;
                  },
                ),
              ),
              FormField<DateTime>(
                initialValue: _startDate,
                validator: _validateStart,
                builder: (field) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildDateField(
                    label: 'Tanggal Mulai',
                    value: _startDate,
                    errorText: field.errorText,
                    onTap: () => _pickStartDate(field),
                  ),
                ),
              ),
              FormField<DateTime>(
                initialValue: _endDate,
                validator: _validateEnd,
                builder: (field) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildDateField(
                    label: 'Tanggal Selesai (opsional)',
                    value: _endDate,
                    errorText: field.errorText,
                    onTap: () => _pickEndDate(field),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  maxLength: 300,
                  decoration: InputDecoration(
                    hintText: 'Contoh: IPK 3.8, aktif di himpunan',
                    labelText: 'Catatan (opsional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onPressed: _save,
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
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
