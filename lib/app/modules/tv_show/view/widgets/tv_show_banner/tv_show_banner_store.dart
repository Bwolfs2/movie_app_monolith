import '../../../../../core/error/failure.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/tv_show.dart';
import '../../../domain/usecases/get_tv_airing_today.dart';

class TvShowBannerStore extends StreamStore<Failure, List<TvShow>> {
  final GetTvAiringToday _getTvAiringToday;
  TvShowBannerStore(this._getTvAiringToday) : super([]);

  Future<void> load() => execute(_getTvAiringToday);
}
