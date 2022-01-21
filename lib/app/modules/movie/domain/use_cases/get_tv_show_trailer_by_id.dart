import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/trailer.dart';
import '../repositories/movies_repository.dart';

abstract class IGetTvShowTrailer {
  Future<Either<Failure, List<Trailer>>> call(int id);
}

class GetTvShowTrailer implements IGetTvShowTrailer {
  final MoviesRepository repository;

  GetTvShowTrailer(this.repository);

  Future<Either<Failure, List<Trailer>>> call(int id) {
    return repository.getTvShowTrailerById(id);
  }
}
