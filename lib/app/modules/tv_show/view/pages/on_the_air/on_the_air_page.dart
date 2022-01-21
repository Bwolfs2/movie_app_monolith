import '../../../../../coffsy_design_system/common/utils/app_constant.dart';
import '../../../../../coffsy_design_system/common/utils/argument.dart';
import '../../../../../coffsy_design_system/common/utils/sizes.dart';
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

import '../../../domain/entities/on_the_air.dart';
import '../../../domain/errors/tv_show_failures.dart';
import 'on_the_air_store.dart';

class OnTheAirPage extends StatefulWidget {
  @override
  _OnTheAirPageState createState() => _OnTheAirPageState();
}

class _OnTheAirPageState extends State<OnTheAirPage> {
  final store = Modular.get<OnTheAirStore>();
  @override
  void initState() {
    super.initState();
    store.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Air'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: store.load,
        showChildOpacityTransition: false,
        child: ScopedBuilder<OnTheAirStore, Failure, List<OnTheAir>>.transition(
          onError: (context, error) {
            if (error is NoDataFound) {
              return const Center(child: Text('No On The Air Found'));
            }

            if (error is TvOnTheAirNoInternetConnection) {
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
              final onTheAir = state[index];
              return CardMovies(
                image: onTheAir.posterPath,
                title: onTheAir.tvName ?? 'No TV Name',
                vote: onTheAir.voteAverage.toString(),
                releaseDate: onTheAir.tvRelease ?? 'No TV Release',
                overview: onTheAir.overview,
                genre: onTheAir.genreIds.take(3).map((id) => GenreChip(id: id)).toList(),
                onTap: () {
                  Modular.to.pushNamed(
                    './detail_movies',
                    arguments: ScreenArguments(
                      screenData: ScreenData(
                        onTheAir.id,
                        onTheAir.title,
                        onTheAir.overview,
                        onTheAir.releaseDate,
                        onTheAir.genreIds,
                        onTheAir.voteAverage,
                        onTheAir.popularity,
                        onTheAir.posterPath,
                        onTheAir.backdropPath,
                        onTheAir.tvName,
                        onTheAir.tvRelease,
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
