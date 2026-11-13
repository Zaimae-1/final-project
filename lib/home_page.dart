import 'package:flutter/material.dart';

import 'visual_style.dart';

const _prayers = [
  ('Subuh', '04.45'),
  ('Zuhur', '12.06'),
  ('Asar', '15.26'),
  ('Magrib', '17.52'),
  ('Isya', '19.03'),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.onNavigate});

  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('home'),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        _PrayerHero(
          onNotifications: () => showUnavailable(context, 'Pengingat azan'),
        ),
        const SizedBox(height: 24),
        _PrayerSchedule(onOpen: () => _showSchedule(context)),
        const SizedBox(height: 24),
        Text(
          'Menu cepat',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final twoColumns =
                constraints.maxWidth < 288 ||
                MediaQuery.textScalerOf(context).scale(14) > 18;
            final width =
                (constraints.maxWidth - (twoColumns ? 8 : 24)) /
                (twoColumns ? 2 : 4);
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _QuickAction(
                  'Al-Qur’an',
                  Icons.menu_book_outlined,
                  width,
                  () => onNavigate(1),
                ),
                _QuickAction(
                  'Kiblat',
                  Icons.explore_outlined,
                  width,
                  () => onNavigate(2),
                ),
                _QuickAction(
                  'Doa',
                  Icons.volunteer_activism_outlined,
                  width,
                  () => showUnavailable(context, 'Doa'),
                ),
                _QuickAction(
                  'Tasbih',
                  Icons.radio_button_checked,
                  width,
                  () => showUnavailable(context, 'Tasbih'),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _showSchedule(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          children: [
            Text(
              'Jadwal salat Jakarta',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Text('Contoh jadwal untuk demo'),
            const SizedBox(height: 12),
            for (final (name, time) in _prayers)
              ListTile(title: Text(name), trailing: Text('$time WIB')),
          ],
        ),
      ),
    );
  }
}

class _PrayerHero extends StatelessWidget {
  const _PrayerHero({required this.onNotifications});

  final VoidCallback onNotifications;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.forest,
          image: DecorationImage(
            image: AssetImage('assets/mosque-at-dusk.png'),
            fit: BoxFit.cover,
            alignment: Alignment.centerRight,
          ),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: AppColors.card, fontSize: 14),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 20,
                      color: AppColors.gold,
                    ),
                    const SizedBox(width: 6),
                    const Expanded(
                      child: Text(
                        'Jakarta',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: onNotifications,
                      tooltip: 'Pengingat azan',
                      color: AppColors.card,
                      icon: const Icon(Icons.notifications_none_rounded),
                    ),
                  ],
                ),
                const Text('11 Ramadan 1446 H'),
                const SizedBox(height: 38),
                const Text(
                  'Salat berikutnya',
                  style: TextStyle(color: AppColors.mint),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Magrib',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                ),
                const Text(
                  '17.52',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 64,
                    height: 1.05,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Contoh jadwal · WIB',
                  style: TextStyle(color: AppColors.mint),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PrayerSchedule extends StatelessWidget {
  const _PrayerSchedule({required this.onOpen});

  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Jadwal salat hari ini',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                onPressed: onOpen,
                tooltip: 'Lihat semua waktu salat',
                icon: const Icon(Icons.arrow_forward_rounded),
              ),
            ],
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final stack =
                  constraints.maxWidth < 260 ||
                  MediaQuery.textScalerOf(context).scale(14) > 18;
              return Wrap(
                spacing: 4,
                runSpacing: 4,
                children: [
                  for (final (name, time) in _prayers)
                    Container(
                      width:
                          (constraints.maxWidth - (stack ? 8 : 16)) /
                          (stack ? 3 : 5),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: name == 'Magrib'
                            ? const Color(0xfff5e2b6)
                            : AppColors.paper,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Column(
                        children: [
                          Text(name, style: const TextStyle(fontSize: 11)),
                          const SizedBox(height: 3),
                          Text(
                            time,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction(this.label, this.icon, this.width, this.onTap);

  final String label;
  final IconData icon;
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 13),
          backgroundColor: AppColors.card,
          side: const BorderSide(color: AppColors.line),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 25),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
