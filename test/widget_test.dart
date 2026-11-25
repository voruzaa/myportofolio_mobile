import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';

void main() {
  testWidgets('kartu aksi membuka formulir edukasi', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('MyPortfolio'), findsOneWidget);
    expect(find.text('2506596041'), findsOneWidget);
    expect(find.text('Forza Derian'), findsOneWidget);
    expect(find.text('PBP F'), findsOneWidget);

    await tester.tap(find.text('Tambah Edukasi'));
    await tester.pumpAndSettle();

    expect(find.byType(EducationFormPage), findsOneWidget);
  });

  testWidgets('drawer membuka formulir edukasi', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Education'));
    await tester.pumpAndSettle();

    expect(find.byType(EducationFormPage), findsOneWidget);
  });

  testWidgets('formulir edukasi menolak isian kosong', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: EducationFormPage()));

    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    expect(find.text('Nama institusi tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Jurusan atau gelar tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Tanggal mulai wajib dipilih!'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('formulir edukasi menolak isian hanya spasi', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: EducationFormPage()));

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nama Institusi'),
      '   ',
    );

    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    expect(find.text('Nama institusi tidak boleh kosong!'), findsOneWidget);
  });

  testWidgets('formulir edukasi menampilkan ringkasan setelah valid', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: EducationFormPage()));

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nama Institusi'),
      'Universitas Indonesia',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Jurusan atau Gelar'),
      'Ilmu Komputer',
    );

    await tester.tap(find.widgetWithText(InkWell, 'Pilih tanggal').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Institusi: Universitas Indonesia'), findsOneWidget);
    expect(find.text('Jurusan: Ilmu Komputer'), findsOneWidget);
  });
}
