import 'package:dspeliculas/providers/movies_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/credits_response.dart';

class CastingCard extends StatelessWidget {

  final int movieId;

  const CastingCard({super.key,
    required this.movieId});

  @override
  Widget build(BuildContext context) {

    final movieProvider = Provider.of<MoviesProviders>(context,listen: false);

    return FutureBuilder(

      future: movieProvider.getMovieCast(movieId),
        builder: (_,AsyncSnapshot<List<Cast>> snapshop) {
          if (!snapshop.hasData) {
            return Container(
              constraints: BoxConstraints(maxWidth: 150),
              margin: EdgeInsets.only(bottom: 30),
              width: double.infinity,
              height: 180,
              child: CupertinoActivityIndicator(),
            );
          }

          final List<Cast> cast = snapshop.data!;



          return Container(
              margin: EdgeInsets.only(bottom: 30),
              width: double.infinity,
              height: 180,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, int index) => _CastCard(actor: cast[index]),
              )
          );
        }
    );

  }
}

class _CastCard extends StatelessWidget {

  final Cast actor;

  const _CastCard({super.key,
    required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
      children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(actor.fullProfilePath),
                height: 140,
                width: 100,
                fit: BoxFit.cover,
              ),
          ),
          SizedBox(height: 5,),
          Text(actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
       ],
    )
    );
  }
}

