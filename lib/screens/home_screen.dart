import 'package:flutter/material.dart';
import 'package:flutter_peliculas/providers/movie_provider.dart';
import 'package:flutter_peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final moviesProvides = Provider.of<MovieProvider>(context);
    // print(moviesProvides.onDisplayMovies);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {  }, 
            icon: const Icon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            children:  [
              CardSwiper(movies: moviesProvides.onDisplayMovies),
              //Slider  de pliculas
             MovieSlider(
                movies: moviesProvides.popularMovies,
                title: 'Populares!!', 
                onNextPage: () => moviesProvides.getPopularMovies(),
              ),
            ],
          ),
      )
    );
  }
}