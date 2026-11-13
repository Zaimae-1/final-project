import 'package:final_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Quran reader and city selector work on a narrow screen', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 720);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.widgetWithText(NavigationDestination, 'Al-Qur’an'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '112');
    await tester.pumpAndSettle();
    expect(find.text('Al-Fatihah'), findsNothing);
    await tester.tap(find.text('Al-Ikhlas'));
    await tester.pumpAndSettle();
    expect(find.text('112:1'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(NavigationDestination, 'Kiblat'));
    await tester.pumpAndSettle();
    expect(find.text('295°'), findsOneWidget);
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Surabaya').last);
    await tester.pumpAndSettle();
    expect(find.text('Arah dari Surabaya'), findsOneWidget);
    expect(find.text('294°'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

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
