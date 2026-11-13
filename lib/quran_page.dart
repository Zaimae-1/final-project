import 'package:flutter/material.dart';

import 'visual_style.dart';

const _surahs = [
  (
    number: 1,
    name: 'Al-Fatihah',
    meaning: 'Pembukaan',
    arabic: 'الفاتحة',
    verses: [
      'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
      'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
      'الرَّحْمَٰنِ الرَّحِيمِ',
      'مَالِكِ يَوْمِ الدِّينِ',
      'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
      'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
      'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
    ],
  ),
  (
    number: 112,
    name: 'Al-Ikhlas',
    meaning: 'Keikhlasan',
    arabic: 'الإخلاص',
    verses: [
      'قُلْ هُوَ اللَّهُ أَحَدٌ',
      'اللَّهُ الصَّمَدُ',
      'لَمْ يَلِدْ وَلَمْ يُولَدْ',
      'وَلَمْ يَكُنْ لَهُ كُفُوًا أَحَدٌ',
    ],
  ),
  (
    number: 113,
    name: 'Al-Falaq',
    meaning: 'Waktu subuh',
    arabic: 'الفلق',
    verses: [
      'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ',
      'مِنْ شَرِّ مَا خَلَقَ',
      'وَمِنْ شَرِّ غَاسِقٍ إِذَا وَقَبَ',
      'وَمِنْ شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ',
      'وَمِنْ شَرِّ حَاسِدٍ إِذَا حَسَدَ',
    ],
  ),
  (
    number: 114,
    name: 'An-Nas',
    meaning: 'Manusia',
    arabic: 'الناس',
    verses: [
      'قُلْ أَعُوذُ بِرَبِّ النَّاسِ',
      'مَلِكِ النَّاسِ',
      'إِلَٰهِ النَّاسِ',
      'مِنْ شَرِّ الْوَسْوَاسِ الْخَنَّاسِ',
      'الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ',
      'مِنَ الْجِنَّةِ وَالنَّاسِ',
    ],
  ),
];

typedef _Surah = ({
  int number,
  String name,
  String meaning,
  String arabic,
  List<String> verses,
});

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final results = _surahs.where(
      (surah) =>
          surah.name.toLowerCase().replaceAll('-', '').contains(_query) ||
          surah.meaning.toLowerCase().contains(_query) ||
          surah.arabic.contains(_query) ||
          surah.number.toString().startsWith(_query),
    );
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        const PageHeading(title: 'Al-Qur’an', icon: Icons.menu_book_outlined),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 22),
          child: TextField(
            onChanged: (value) => setState(
              () => _query = value.trim().toLowerCase().replaceAll('-', ''),
            ),
            decoration: InputDecoration(
              labelText: 'Cari nama atau nomor surah',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: AppColors.card,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Daftar surah',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        if (results.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Surah tidak ditemukan. Coba nama atau nomor lain.'),
          ),
        for (final surah in results)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Material(
              color: AppColors.card,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
                side: const BorderSide(color: AppColors.line),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                leading: CircleAvatar(
                  backgroundColor: AppColors.mint,
                  foregroundColor: AppColors.forest,
                  child: Text('${surah.number}'),
                ),
                title: Text(
                  surah.name,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  '${surah.meaning} · ${surah.verses.length} ayat',
                ),
                trailing: Text(
                  surah.arabic,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(fontSize: 19, color: AppColors.green),
                ),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => _SurahReader(surah: surah),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _SurahReader extends StatelessWidget {
  const _SurahReader({required this.surah});

  final _Surah surah;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(surah.name),
        backgroundColor: AppColors.forest,
        foregroundColor: AppColors.card,
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up_outlined),
            tooltip: 'Audio tilawah',
            onPressed: () => showUnavailable(context, 'Audio tilawah'),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: surah.verses.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) => ListTile(
              tileColor: AppColors.card,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: Text(
                '${surah.number}:${index + 1}',
                style: const TextStyle(color: AppColors.green),
              ),
              title: Text(
                surah.verses[index],
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 28, height: 1.8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
