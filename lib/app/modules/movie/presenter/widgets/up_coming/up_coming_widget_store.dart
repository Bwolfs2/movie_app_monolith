import '../../../../../core/either_adapter/dartz_either_adapter.dart';
import '../../../../../core/error/failure.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/use_cases/get_movie_now_playing.dart';

class UpComingWidgetStore extends StreamStore<Failure, List<Movie>> {
  final IGetMovieNowPlaying _getMovieNowPlaying;

  UpComingWidgetStore(this._getMovieNowPlaying) : super([]);

  Future<void> load() async => executeEither(() => DartzEitherAdapter.adapter(_getMovieNowPlaying()));
}
