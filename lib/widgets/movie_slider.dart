import 'package:flutter/material.dart';

import '../models/movie.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({super.key,
    required this.movies,
    required this.onNextPage,
    this.title
  });

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = new ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   scrollController.addListener(() {
      if (scrollController.position.pixels +500 >= scrollController.position.maxScrollExtent - 500){
         widget.onNextPage();
      }
   });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    if (this.widget.movies.length == 0) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
            child: CircularProgressIndicator()
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
          Padding(padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(this.widget.title!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
                itemCount: widget.movies.length,
                itemBuilder: (_,int index) => _MoviePoster(movie: widget.movies[index],heroId: '${widget.title}-${index}-${widget.movies[index].id}',)
            ),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  const _MoviePoster({super.key,
    required this.movie,
    required this.heroId
  });

  final Movie  movie;
  final String heroId;

  @override
  Widget build(BuildContext context) {

    movie.heroId = heroId;

    return Container(
      width: 130,
      height: 190,
      margin:EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(
                        context, 'details',arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fulPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover
                ),
              ),
            ),
          ),
          SizedBox(height: 5,),
          Text(movie.title,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),

        ],
      ),
    );
  }
}

