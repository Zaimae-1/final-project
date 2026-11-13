import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'visual_style.dart';

const _cities = {
  'Solo': (-7.5755, 110.8243),
  'Jakarta': (-6.2088, 106.8456),
  'Bandung': (-6.9175, 107.6191),
  'Surabaya': (-7.2575, 112.7521),
};

double _bearingToKaaba(double latitude, double longitude) {
  const radians = math.pi / 180;
  const kaabaLatitude = 21.4225 * radians;
  final origin = latitude * radians;
  final longitudeDifference = (39.8262 - longitude) * radians;
  final east = math.sin(longitudeDifference) * math.cos(kaabaLatitude);
  final north =
      math.cos(origin) * math.sin(kaabaLatitude) -
      math.sin(origin) *
          math.cos(kaabaLatitude) *
          math.cos(longitudeDifference);
  return (math.atan2(east, north) / radians + 360) % 360;
}

class QiblaPage extends StatefulWidget {
  const QiblaPage({super.key});

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  String _city = 'Jakarta';

  @override
  Widget build(BuildContext context) {
    final (latitude, longitude) = _cities[_city]!;
    final bearing = _bearingToKaaba(latitude, longitude);
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        const PageHeading(title: 'Arah Kiblat', icon: Icons.explore_outlined),
        Padding(
          padding: const EdgeInsets.all(16),
          child: DropdownButtonFormField<String>(
            initialValue: _city,
            decoration: InputDecoration(
              labelText: 'Kota acuan',
              prefixIcon: const Icon(Icons.location_on_outlined),
              filled: true,
              fillColor: AppColors.card,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            items: [
              for (final city in _cities.keys)
                DropdownMenuItem(value: city, child: Text(city)),
            ],
            onChanged: (city) {
              if (city != null) setState(() => _city = city);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 22),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.line),
            ),
            child: Column(
              children: [
                Text(
                  'Arah dari $_city',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${bearing.round()}°',
                  style: const TextStyle(
                    fontSize: 55,
                    height: 1.15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.green,
                  ),
                ),
                const Text('Searah jarum jam dari utara'),
                const SizedBox(height: 20),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 284),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CustomPaint(
                      painter: _DialPainter(bearing),
                      child: const Padding(
                        padding: EdgeInsets.all(27),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text('U'),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text('T'),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text('S'),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('B'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 18, 20, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, size: 20, color: AppColors.green),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Panah menunjukkan perkiraan arah dari pusat kota. Dial ini tidak mengikuti putaran perangkat.',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DialPainter extends CustomPainter {
  const _DialPainter(this.bearing);

  final double bearing;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - 4;
    final paint = Paint()..color = AppColors.paper;
    canvas.drawCircle(center, radius, paint);
    paint
      ..color = AppColors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(center, radius, paint);
    for (var i = 0; i < 36; i++) {
      final angle = i * math.pi / 18;
      final direction = Offset(math.sin(angle), -math.cos(angle));
      final longTick = i % 3 == 0;
      paint
        ..color = longTick ? AppColors.green : AppColors.muted
        ..strokeWidth = longTick ? 1.5 : 1;
      canvas.drawLine(
        center + direction * (radius - 6),
        center + direction * (radius - (longTick ? 16 : 11)),
        paint,
      );
    }

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(bearing * math.pi / 180);
    final needle = Path()
      ..moveTo(0, -radius * .67)
      ..lineTo(radius * .085, 0)
      ..lineTo(0, radius * .26)
      ..lineTo(-radius * .085, 0)
      ..close();
    canvas.drawPath(
      needle,
      paint
        ..style = PaintingStyle.fill
        ..color = const Color(0xffa87824),
    );
    canvas.restore();

    canvas.drawCircle(center, 8, paint..color = AppColors.green);
    canvas.drawCircle(center, 3.5, paint..color = AppColors.card);
  }

  @override
  bool shouldRepaint(_DialPainter oldDelegate) =>
      bearing != oldDelegate.bearing;
}
