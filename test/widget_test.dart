import 'package:final_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Beranda shows the demo schedule and gives feedback for Doa', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 720);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());

    expect(find.text('Contoh jadwal · WIB'), findsOneWidget);
    await tester.tap(find.byTooltip('Lihat semua waktu salat'));
    await tester.pumpAndSettle();
    expect(find.text('17.52 WIB'), findsOneWidget);
    Navigator.of(tester.element(find.text('17.52 WIB'))).pop();
    await tester.pumpAndSettle();

    final doa = find.widgetWithText(OutlinedButton, 'Doa');
    await tester.drag(find.byType(ListView), const Offset(0, -220));
    await tester.pumpAndSettle();
    await tester.tap(doa);
    await tester.pumpAndSettle();
    expect(find.text('Doa belum tersedia di versi ini.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
