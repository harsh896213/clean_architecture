import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/theme/text_styles.dart';
import 'package:pva/feature/profile/domain/entities/info.dart';
import 'package:pva/feature/profile/presentation/widget/information_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                  imageUrl:
                      "https://images.pexels.com/photos/6616204/pexels-photo-6616204.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
            ),
            Text("Harsh Rajan",textAlign: TextAlign.start, style: context.textTheme.titleLarge?.copyWith(fontSize: 24),),
            Text("harsh@gmail.com", style: context.textTheme.bodyLarge,),
           Container(
             padding: EdgeInsets.symmetric(horizontal: 16),
             child: Column(
               spacing: 10,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text("Personal Information", style: context.textTheme.titleLarge?.copyWith(fontSize: 20),),
                 InformationTile(infos: [
                   Info(title: "Date of Birth", value: "April 15, 1985"),
                   Info(title: "Blood Type", value: "o+"),
                   Info(title: "height", value: "178 cm"),
                   Info(title: "weight", value: "75 kg")
                 ],),
                 Text("Emergency Contact", style: context.textTheme.titleLarge?.copyWith(fontSize: 20),),
                 InformationTile(infos: [
                   Info(title: "Name", value: "Sarah Chen"),
                   Info(title: "Relationship", value: "Spouse"),
                   Info(title: "Phone", value: "+91 23838928"),
                 ],),
                 Text("Medical History", style: context.textTheme.titleLarge?.copyWith(fontSize: 20),),
                 InformationTile(infos: [
                   Info(title: "Allergies", value: "Pencillin"),
                   Info(title: "Condition", value: "High Bp"),
                   Info(title: "Past surgery", value: "Heart Operation"),
                 ],),
               ],
             ),
           )
          ],
        ),
      )),
    );
  }
}
