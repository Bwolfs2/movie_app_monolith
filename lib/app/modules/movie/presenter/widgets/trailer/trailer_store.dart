import '../../../../../core/either_adapter/dartz_either_adapter.dart';
import '../../../../../core/error/failure.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/trailer.dart';
import '../../../domain/use_cases/get_movie_trailer_by_id.dart';
import '../../../domain/use_cases/get_tv_show_trailer_by_id.dart';

class TrailerStore extends StreamStore<Failure, List<Trailer>> {
  final IGetMovieTrailerById _getMovieTrailerById;
  final IGetTvShowTrailer _getTvShowTrailer;
  TrailerStore(this._getMovieTrailerById, this._getTvShowTrailer) : super([]);

  Future<void> loadMovieTrailer(int movieId) async => executeEither(() => DartzEitherAdapter.adapter(_getMovieTrailerById(movieId)));
  Future<void> loadTvShowTrailer(int movieId) async => executeEither(() => DartzEitherAdapter.adapter(_getTvShowTrailer(movieId)));
}
