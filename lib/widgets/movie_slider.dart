import 'package:flutter/material.dart';
import 'package:flutter_peliculas/models/models.dart';

class MovieSlider extends StatefulWidget {
   
  const MovieSlider({Key? key, required this.movies, this.title, required this.onNextPage}) : super(key: key);
    final List<Movie> movies;
    final String? title;
 final Function onNextPage;

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 510) {
      widget.onNextPage();
      }

    });
    
  }

  @override
  void dispose() {
    
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [

          if( widget.title != null )
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:  Text( 
                  widget.title!, 
                  style: const TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.w700
                    ))
            ),

          const SizedBox(height: 5,),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (  _ , int index) =>  _MoviePoster( widget.movies[index])
            ),
          ),

        ]
        ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  const _MoviePoster( this.movie); 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric( horizontal: 10),
      child: Column(
        children:  [

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                fit: BoxFit.cover,
                width: 130,
                height: 190,
                ),
            ),
          ),
            const SizedBox(height: 5,),
             Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,              
              )

        ]
        ),
    );
  }
}