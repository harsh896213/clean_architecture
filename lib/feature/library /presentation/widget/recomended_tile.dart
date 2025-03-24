import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/theme/shadow.dart';
import 'package:pva/core/theme/text_styles.dart';
import 'package:pva/feature/library%20/domain/entities/resource.dart';
import 'package:pva/feature/library%20/presentation/widget/author_type.dart';

class RecommendationTile extends StatelessWidget {
  final Resource resource;

  const RecommendationTile({required this.resource, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> context.push("/library/video"),
      child: Container(
        width: 250,
        height: 340,
        margin: EdgeInsets.only(right: 10),
        decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
         shadows: cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(resource.documentType.name == "article")...{
              Container(
                height: 200,
                decoration: ShapeDecoration(
                    color: Colors.grey,
                    shape:
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)))),
                alignment: Alignment.center,
                child: Icon(Icons.file_present, size: 20,color: Colors.blue,),
              )
            }
            else...{
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    child: CachedNetworkImage(
                        height: 200,
                        fit: BoxFit.fitHeight,
                        imageUrl: resource.videoInfo?.thumbnail ?? ""),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                          ),
                      ),
                      child: Text("12:00", style: TextStyle( color: Colors.black),),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    top: 50,
                    right: 50,
                    left: 50,

                      child: Icon(Icons.play_circle,color: Colors.white, size: 30,)),
                ],
              )
            },
            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                spacing: 8,
                children: [
                  Text(
                    resource.title,
                    style: context.textTheme.titleMedium,
                  ),
                  Text(
                      resource.desc,
                      maxLines: 2,
                      style: context.textTheme.bodySmall
                  ),
                  AuthorType(
                    author: resource.author,
                    type: resource.documentType,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
