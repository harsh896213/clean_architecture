import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height:20),
      itemBuilder: (context, index) => ListTile(
        onTap: () => context.push("/details"),
      leading: CachedNetworkImage(
          height: 140,
          width: 140,
          imageUrl:
          "https://images.pexels.com/photos/20879653/pexels-photo-20879653/free-photo-of-ethiopians-taking-part-in-an-orthodox-religious-festival.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
      ),
      title: Text("Data"),
    ), itemCount: 9,);
  }
}
