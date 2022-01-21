import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/trailer.dart';
import '../repositories/movies_repository.dart';

abstract class IGetMovieTrailerById {
  Future<Either<Failure, List<Trailer>>> call(int id);
}

class GetMovieTrailerById implements IGetMovieTrailerById {
  final MoviesRepository repository;

  GetMovieTrailerById(this.repository);

  Future<Either<Failure, List<Trailer>>> call(int id) {
    return repository.getMovieTrailerById(id);
  }
}
