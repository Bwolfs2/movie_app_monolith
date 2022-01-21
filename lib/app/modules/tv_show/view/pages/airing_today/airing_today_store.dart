import 'package:flutter_triple/flutter_triple.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/tv_show.dart';
import '../../../domain/usecases/get_tv_airing_today.dart';

class AiringTodayStore extends StreamStore<Failure, List<TvShow>> {
  final GetTvAiringToday _getTvAiringToday;

  AiringTodayStore(this._getTvAiringToday) : super([]);

  Future<void> load() => execute(_getTvAiringToday);
}
