import '../../../../../coffsy_design_system/common/utils/app_constant.dart';
import '../../../../../coffsy_design_system/common/utils/argument.dart';
import '../../../../../coffsy_design_system/widgets/card/card_movies.dart';
import '../../../../../coffsy_design_system/widgets/chip/chip_genre_movies.dart';
import '../../../../../coffsy_design_system/widgets/error/error_widget.dart';
import '../../../../../coffsy_design_system/widgets/error/no_internet_widget.dart';
import '../../../../../coffsy_design_system/widgets/shimmer/shimmer_list.dart';
import '../../../../../core/error/failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../domain/entities/tv_show.dart';
import '../../../domain/errors/tv_show_failures.dart';
import 'airing_today_store.dart';

class AiringTodayPage extends StatefulWidget {
  @override
  _AiringTodayPageState createState() => _AiringTodayPageState();
}

class _AiringTodayPageState extends State<AiringTodayPage> {
  final store = Modular.get<AiringTodayStore>();
  @override
  void initState() {
    super.initState();
    store.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airing Today'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: store.load,
        showChildOpacityTransition: false,
        child: ScopedBuilder<AiringTodayStore, Failure, List<TvShow>>.transition(
          onError: (context, error) {
            if (error is NoDataFound) {
              return const Center(child: Text('No Airing Today Found'));
            }
            if (error is TvAiringTodayNoInternetConnection) {
              return Center(
                child: NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () async => await store.load(),
                ),
              );
            }
            return CustomErrorWidget(message: error?.errorMessage);
          },
          onLoading: (context) => const ShimmerList(),
          onState: (context, state) => ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              final movie = state[index];
              return CardMovies(
                image: movie.posterPath,
                title: movie.tvName ?? 'No TV Name',
                vote: movie.voteAverage.toString(),
                releaseDate: movie.tvRelease ?? 'No TV Release',
                overview: movie.overview,
                genre: movie.genreIds.take(3).map((id) => GenreChip(id: id)).toList(),
                onTap: () {
                  Modular.to.pushNamed(
                    './detail_movies',
                    arguments: ScreenArguments(
                      screenData: ScreenData(
                        movie.id,
                        movie.title,
                        movie.overview,
                        movie.releaseDate,
                        movie.genreIds,
                        movie.voteAverage,
                        movie.popularity,
                        movie.posterPath,
                        movie.backdropPath,
                        movie.tvName,
                        movie.tvRelease,
                      ),
                      isFromBanner: false,
                    ),
                    forRoot: true,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
