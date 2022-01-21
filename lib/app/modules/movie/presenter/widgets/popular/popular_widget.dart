import '../../../../../coffsy_design_system/common/utils/app_constant.dart';
import '../../../../../coffsy_design_system/common/utils/argument.dart';
import '../../../../../coffsy_design_system/common/utils/sizes.dart';
import '../../../../../coffsy_design_system/widgets/card/card_home.dart';
import '../../../../../coffsy_design_system/widgets/error/error_widget.dart';
import '../../../../../coffsy_design_system/widgets/error/no_internet_widget.dart';
import '../../../../../coffsy_design_system/widgets/shimmer/shimmer_card.dart';
import '../../../../../core/error/failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/errors/movie_failures.dart';
import 'popular_store.dart';

class PopularWidget extends StatefulWidget {
  const PopularWidget({Key? key}) : super(key: key);

  @override
  _PopularWidgetState createState() => _PopularWidgetState();
}

class _PopularWidgetState extends State<PopularWidget> {
  final store = Modular.get<PopularStore>();
  @override
  void initState() {
    super.initState();
    store.load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Popular',
              style: TextStyle(
                fontSize: Sizes.dp14(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: Sizes.dp16(context),
              ),
              onPressed: () {
                Modular.to.pushNamed('/dashboard/movie_module/movie_popular', forRoot: true);
              },
            ),
          ],
        ),
      ),
      Container(
        width: Sizes.width(context),
        height: Sizes.width(context) / 1.8,
        child: ScopedBuilder<PopularStore, Failure, List<Movie>>.transition(
          store: store,
          onError: (context, error) {
            if (error is MoviePopularNoInternetConnection) {
              return NoInternetWidget(
                message: AppConstant.noInternetConnection,
                onPressed: () async => await store.load(),
              );
            }
            return CustomErrorWidget(message: error?.errorMessage);
          },
          onLoading: (context) => const ShimmerCard(),
          onState: (context, state) => state.isEmpty
              ? const SizedBox.shrink()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.length > 5 ? 5 : state.length,
                  itemBuilder: (context, index) {
                    final movies = state[index];
                    return CardHome(
                      image: movies.posterPath,
                      title: movies.title,
                      rating: movies.voteAverage,
                      onTap: () {
                        Modular.to.pushNamed(
                          './detail_movies',
                          arguments: ScreenArguments(
                            screenData: ScreenData(
                              movies.id,
                              movies.title,
                              movies.overview,
                              movies.releaseDate,
                              movies.genreIds,
                              movies.voteAverage,
                              movies.popularity,
                              movies.posterPath,
                              movies.backdropPath,
                              movies.tvName,
                              movies.tvRelease,
                            ),
                            isFromMovie: true,
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
    ]);
  }
}
