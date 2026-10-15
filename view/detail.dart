import 'package:flutter/material.dart';
import 'package:game_app/model/detailgame.dart';
import 'package:game_app/viewmodel/fetchgame.dart';
import 'package:readmore/readmore.dart';

class Detail extends StatelessWidget {
  final int gameTerpilih;

  const Detail({
    super.key,
    required this.gameTerpilih,
  });

  Future<DetailGame> fetchData() async {
    return await fetchDataFromAPI(gameTerpilih);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Game'),
      ),
      body: FutureBuilder<DetailGame>(
        future: fetchData(),
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          // Tidak ada data
          if (!snapshot.hasData) {
            return const Center(
              child: Text('Tidak ada data game.'),
            );
          }

          final game = snapshot.data!;

          return SingleChildScrollView(
            child: Container(
              color: Colors.amber,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ==========================================
                  // GAMBAR UTAMA
                  // ==========================================
                  if (game.thumbnail != null)
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      child: Image.network(
                        game.thumbnail!,
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 220,
                            color: Colors.grey.shade300,
                            child: const Center(
                              child: Text(
                                'Gambar tidak dapat ditampilkan',
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  // ==========================================
                  // ISI DETAIL
                  // ==========================================
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ======================================
                        // JUDUL GAME
                        // ======================================
                        Text(
                          game.title ?? 'Tidak ada judul',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          '${game.genre ?? '-'} • ${game.platform ?? '-'}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 15),

                        // ======================================
                        // MINIMUM SYSTEM REQUIREMENTS
                        // ======================================
                        if (game.minimumSystemRequirements != null) ...[
                          const Text(
                            'Minimum System Requirements',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          _requirementRow(
                            'OS',
                            game.minimumSystemRequirements!.os,
                          ),

                          _requirementRow(
                            'Processor',
                            game.minimumSystemRequirements!.processor,
                          ),

                          _requirementRow(
                            'Memory',
                            game.minimumSystemRequirements!.memory,
                          ),

                          _requirementRow(
                            'Graphics',
                            game.minimumSystemRequirements!.graphics,
                          ),

                          _requirementRow(
                            'Storage',
                            game.minimumSystemRequirements!.storage,
                          ),

                          const SizedBox(height: 15),
                        ],

                        // ======================================
                        // SCREENSHOTS
                        // ======================================
                        if (game.screenshots != null &&
                            game.screenshots!.isNotEmpty) ...[
                          const Text(
                            'Screenshots',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          SizedBox(
                            height: 130,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: game.screenshots!.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 8);
                              },
                              itemBuilder: (context, index) {
                                final screenshot =
                                game.screenshots![index];

                                return ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  child: Image.network(
                                    screenshot.image ?? '',
                                    width: 190,
                                    height: 130,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) {
                                      return Container(
                                        width: 190,
                                        height: 130,
                                        color: Colors.grey.shade300,
                                        child: const Center(
                                          child: Text(
                                            'Gambar error',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 15),
                        ],

                        // ======================================
                        // DESKRIPSI
                        // ======================================
                        ReadMoreText(
                          game.description ??
                              'Deskripsi tidak tersedia.',
                          trimLines: 4,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: ' Selengkapnya',
                          trimExpandedText: ' Lebih sedikit',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 13,
                            height: 1.4,
                          ),
                          moreStyle: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                          lessStyle: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ==========================================================
  // WIDGET UNTUK BARIS SYSTEM REQUIREMENTS
  // ==========================================================
  static Widget _requirementRow(
      String label,
      String? value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 75,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Text(
            ': ',
            style: TextStyle(
              fontSize: 12,
            ),
          ),

          Expanded(
            child: Text(
              value ?? '-',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
