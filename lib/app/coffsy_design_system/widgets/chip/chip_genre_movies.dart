import '../../common/styles/color_palettes.dart';
import '../../../core/network/model/genres.dart';
import 'package:flutter/material.dart';

class GenreChip extends StatelessWidget {
  final int id;
  const GenreChip({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(8),
      child: Text(
        Genres.genres[id] ?? 'No Gender',
        style: const TextStyle(fontSize: 12),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: ColorPalettes.grey),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
