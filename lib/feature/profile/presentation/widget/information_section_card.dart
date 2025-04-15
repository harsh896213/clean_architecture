import 'package:flutter/material.dart';

import '../../../../core/common/widgets/button/button_factory.dart';

class InformationSectionCard extends StatelessWidget {
  final String title;
  final List<Map<String, String>> infoItems;
  final VoidCallback onEdit;

  const InformationSectionCard({
    super.key,
    required this.title,
    required this.infoItems,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final buttonFactory = ButtonFactory();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: buttonFactory.createIconButton(
                  icon: Icons.edit,
                  onPressed: onEdit,
                  iconSize: 20,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          ...infoItems.map((item) => _buildInfoRow(item['label']!, item['value']!)),

          const SizedBox(height: 16),
          const Divider(thickness: 1, color: Color(0xFFEEEEEE)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label on the left
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}