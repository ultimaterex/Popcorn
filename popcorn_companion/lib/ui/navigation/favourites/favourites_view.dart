import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouritesView extends ConsumerWidget {
  const FavouritesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        child: Center(
      child: Text("Favourites", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
    ));
  }
}
