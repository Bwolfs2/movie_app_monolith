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

import '../../../domain/entities/tv_popular_show.dart';
import '../../../domain/errors/tv_show_failures.dart';
import 'tv_show_popular_store.dart';

class TvShowPopularWidget extends StatefulWidget {
  const TvShowPopularWidget({Key? key}) : super(key: key);

  @override
  _TvShowPopularWidgetState createState() => _TvShowPopularWidgetState();
}

class _TvShowPopularWidgetState extends State<TvShowPopularWidget> {
  final store = Modular.get<TvShowPopularStore>();
  @override
  void initState() {
    super.initState();
    store.load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Text(
                'Popular',
                style: TextStyle(
                  fontSize: Sizes.dp14(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: Sizes.dp16(context),
                ),
                onPressed: () {
                  Modular.to.pushNamed('./tv_popular', forRoot: true);
                },
              ),
            ],
          ),
        ),
        Container(
          width: Sizes.width(context),
          height: Sizes.width(context) / 1.8,
          child: ScopedBuilder<TvShowPopularStore, Failure, List<TvPopularShow>>.transition(
            onError: (context, error) {
              if (error is NoDataFound) {
                return const Center(child: Text('No Trailers Found'));
              }
              if (error is TvShowPopularNoInternetConnection) {
                return NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () async {
                    await store.load();
                  },
                );
              }

              return CustomErrorWidget(message: error?.errorMessage);
            },
            onLoading: (context) => const ShimmerCard(),
            onState: (context, state) => ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: state.length > 5 ? 5 : state.length,
              itemBuilder: (context, index) {
                final tvPopularShow = state[index];
                return CardHome(
                  image: tvPopularShow.posterPath,
                  title: tvPopularShow.tvName ?? 'No TV Name',
                  rating: tvPopularShow.voteAverage,
                  onTap: () {
                    Modular.to.pushNamed(
                      './detail_movies',
                      arguments: ScreenArguments(
                        screenData: ScreenData(
                          tvPopularShow.id,
                          tvPopularShow.title,
                          tvPopularShow.overview,
                          tvPopularShow.releaseDate,
                          tvPopularShow.genreIds,
                          tvPopularShow.voteAverage,
                          tvPopularShow.popularity,
                          tvPopularShow.posterPath,
                          tvPopularShow.backdropPath,
                          tvPopularShow.tvName,
                          tvPopularShow.tvRelease,
                        ),
                        isFromMovie: false,
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
      ],
    );
  }
}
