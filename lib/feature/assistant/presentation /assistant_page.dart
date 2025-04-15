import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../widget/animated_mic_button.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AssistantPage extends StatefulWidget {
  const AssistantPage({Key? key}) : super(key: key);

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  bool _isListening = false;
  String _responseText = "Fantastic. How would you rate your pain score today on a scale of 0 to 10?";

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              _buildAppBar(),

              // Main Content
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background Gradient
                    _buildGradientBackground(),

                    // Main Content Column
                    Column(
                      children: [
                        // AI Assistant Label
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: _buildAssistantLabel(),
                        ),

                        // Content Area with Fixed Layout
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: SizedBox(
                                  height: constraints.maxHeight,
                                  child: Column(
                                    children: [
                                      // Orb - Positioned higher
                                      const SizedBox(height: 40),
                                      _buildOrb(),

                                      // Response Text
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                                          child: Text(
                                            _responseText,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 24,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // Bottom Controls - Fixed at bottom
                        Container(
                          height: 120, // Increased height for the mic button
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _buildControls(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back_ios, size: 24),
          ),
          const SizedBox(width: 16),
          const Text(
            "AI Assistant",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.8,
          colors: [
            Colors.blue.shade100.withOpacity(0.5),
            Colors.purple.shade100.withOpacity(0.5),
            Colors.cyan.shade100.withOpacity(0.2),
          ],
          stops: const [0.1, 0.4, 1.0],
        ),
      ),
    );
  }

  Widget _buildAssistantLabel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade100.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.auto_awesome,
            size: 16,
            color: Colors.blue.shade800,
          ),
          const SizedBox(width: 4),
          const Text(
            "AI Assistant",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrb() {
    return Hero(
      tag: "heroTag",
      child: SizedBox(
        width: 200,
        height: 200,
        child: Lottie.asset(
          'assets/lottie/ai_assistant.json',
          width: 200,
          height: 200,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Keyboard Button
        _buildControlButton(
          icon: Icons.keyboard,
          onTap: () {},
          backgroundColor: Colors.white,
          iconColor: Colors.black,
        ),

        // Microphone Button - Using the new AnimatedMicButton widget
        AnimatedMicButton(
          isListening: _isListening,
          onTap: _toggleListening,
          primaryColor: Colors.blue,
          circleColor: Colors.blue,
        ),

        // Close Button
        _buildControlButton(
          icon: Icons.close,
          onTap: () {},
          backgroundColor: Colors.grey.shade800,
          iconColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color backgroundColor,
    required Color iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
      ),
    );
  }
}