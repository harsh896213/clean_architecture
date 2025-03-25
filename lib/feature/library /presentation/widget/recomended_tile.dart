import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/image_path/image_path.dart';
import 'package:pva/core/theme/app_pallete.dart';
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
        width: context.width *.7,
        height: 323,
        margin: EdgeInsets.only(right: 20),
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
                height: 168,
                decoration: ShapeDecoration(
                    color: AppPallete.iconBg,
                    shape:
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)))),
                alignment: Alignment.center,
                child: SvgPicture.asset(ImagePath.document, width: 21, height: 26,),
              )
            }
            else...{
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    child: CachedNetworkImage(
                        height: 168,
                        width: 300,
                        fit: BoxFit.fill,
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
            Padding(padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              child: Column(
                children: [
                  Text(
                    resource.title,
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8,),
                  Text(
                      resource.desc,
                      maxLines: 2,
                      style: context.textTheme.bodySmall?.copyWith(
                          color: context.theme.secondaryHeaderColor)),
                  const SizedBox(height: 12,),
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
