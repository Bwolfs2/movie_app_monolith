import '../../../../core/error/failure.dart';

class NoDataFound extends Failure {
  NoDataFound() : super(errorMessage: 'No data found or no internet');
}

class DiscoverMovieNoInternetConnection extends Failure {
  DiscoverMovieNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class CrewNoInternetConnection extends Failure {
  CrewNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class TrailerNoInternetConnection extends Failure {
  TrailerNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class DiscoverMovieError extends Failure {
  DiscoverMovieError(
    StackTrace stackTrace,
    String label,
    dynamic exception,
    String errorMessage,
  ) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
          errorMessage: errorMessage,
        );
}

class CrewError extends Failure {
  CrewError(
    StackTrace stackTrace,
    String label,
    dynamic exception,
    String errorMessage,
  ) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
          errorMessage: errorMessage,
        );
}
