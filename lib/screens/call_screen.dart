import 'dart:io';
import 'package:flutter/material.dart';
import '../models/contact.dart';

class CallScreen extends StatefulWidget {
  final Contact contact;

  const CallScreen({super.key, required this.contact});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool _isMuted = false;
  bool _isSpeakerOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E), // Dark background for call
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              'Calling...',
              style: TextStyle(fontSize: 24, color: Colors.white.withOpacity(0.7)),
            ),
            const SizedBox(height: 16),
            Text(
              widget.contact.name,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              widget.contact.phoneNumber,
              style: const TextStyle(fontSize: 20, color: Colors.white54),
            ),
            const Spacer(),
            CircleAvatar(
              radius: 100,
              backgroundImage: widget.contact.imageUrl != null ? FileImage(File(widget.contact.imageUrl!)) as ImageProvider : null,
              backgroundColor: Colors.grey.shade800,
              child: widget.contact.imageUrl == null
                  ? const Icon(Icons.person, size: 100, color: Colors.white)
                  : null,
            ),
            const Spacer(),
            // Call Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildControlButton(
                  icon: _isMuted ? Icons.mic_off : Icons.mic,
                  label: 'Mute',
                  isActive: _isMuted,
                  onTap: () => setState(() => _isMuted = !_isMuted),
                ),
                _buildControlButton(
                  icon: _isSpeakerOn ? Icons.volume_up : Icons.volume_down,
                  label: 'Speaker',
                  isActive: _isSpeakerOn,
                  onTap: () => setState(() => _isSpeakerOn = !_isSpeakerOn),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // End Call Button
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(Icons.call_end, color: Colors.white, size: 50),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({required IconData icon, required String label, required bool isActive, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.grey.shade800,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.black : Colors.white,
              size: 36,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
