import 'package:flutter/material.dart';
import 'package:letswatch/components/movie-hor-loading.dart';
import 'package:letswatch/components/movie-list-item.dart';
import 'package:letswatch/models/movie-api.dart';
import 'package:letswatch/services/movies.dart';

class LatestMovies extends StatelessWidget {
  final String options = '?limit=10&sort_by=year';

  Future<List<Movies>> _loadMoviesByYear() async {
    List<Movies> movies = await MoviesService.listOfAllMovies(options);
    return movies;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadMoviesByYear(),
      builder: (BuildContext context, AsyncSnapshot<List<Movies>> snapshot) {
        if (snapshot.data == null) {
          return MovieHorLoading();
        } else {
          return Container(
            height: 320.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: snapshot.data
                  .map((movie) => MoveListItem(movie: movie))
                  .toList(),
            ),
          );
        }
      },
    );
  }
}
