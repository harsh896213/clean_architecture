import 'package:flutter/material.dart';

import '../../../../core/common/widgets/button/action_button.dart';

class CareTeamMemberCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String role;
  final String? specialization;
  final String? qualifications;
  final String? experience;
  final String? availability;
  final String? email;
  final String? contact;
  final String? badge;
  final bool showMessageButton;
  final bool showCallButton;
  final IconData? messageIcon;
  final IconData? callIcon;
  final String? messageSvgPath;
  final String? callSvgPath;

  const CareTeamMemberCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.role,
    this.specialization,
    this.qualifications,
    this.experience,
    this.availability,
    this.email,
    this.contact,
    this.badge,
    this.showMessageButton = true,
    this.showCallButton = false,
    this.messageIcon = Icons.message,
    this.callIcon = Icons.call,
    this.messageSvgPath = null,
    this.callSvgPath = null,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 5,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Member image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                        child: const Icon(Icons.person,
                            size: 40, color: Colors.grey),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (badge != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8E1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            badge!,
                            style: const TextStyle(
                              color: Color(0xFFF9A825),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                      // Name
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      if (specialization != null)
                        Text(
                          specialization!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),

                      if (email != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Row(
                            children: [
                              const Text(
                                'Email: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  email!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),

                      if (contact != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              const Text(
                                'Contact: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                contact!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Qualifications
                      if (qualifications != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            qualifications!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),

                      // Experience
                      if (experience != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            experience!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),

                      // Availability
                      if (availability != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            availability!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                if (showMessageButton || showCallButton)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (showMessageButton)
                        MessageButton(
                          onPressed: () {},
                          icon: messageIcon,
                          svgPath: messageIcon == null ? messageSvgPath : null,
                        ),
                      if (showMessageButton && showCallButton)
                        const SizedBox(width: 16),
                      if (showCallButton)
                        CallButton(
                          onPressed: () {},
                          icon: callIcon,
                          svgPath: callIcon == null ? callSvgPath : null,
                        ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
