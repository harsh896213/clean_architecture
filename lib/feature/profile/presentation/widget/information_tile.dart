import 'package:flutter/material.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/theme/text_styles.dart';
import 'package:pva/feature/profile/domain/entities/info.dart';

class InformationTile extends StatelessWidget {
  final List<Info> infos;

  const InformationTile({required this.infos, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Column(
          children: [
            InfoTile(info: infos[index],),
            Divider(thickness: .5,)
          ],
        ),
        itemCount: infos.length,
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final Info info;
  const InfoTile({required this.info,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(info.title, style: context.textTheme.labelLarge,),
        Text(info.value, style: context.textTheme.labelLarge,),
      ],
    );
  }
}

