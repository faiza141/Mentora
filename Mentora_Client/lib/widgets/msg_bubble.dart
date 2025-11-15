import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chat_app/services/theme_service.dart';
import '../models/chatmsg.dart';

class MessageBubble extends StatelessWidget {
  final ChatModel message;
  final VoidCallback? onRegenerate;

  const MessageBubble({Key? key, required this.message, this.onRegenerate})
    : super(key: key);

  // Copy message
  void _copyMessage(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Message copied to clipboard'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF333333),
      ),
    );
  }

  // Regenerate response function
  void _regenerateResponse(BuildContext context) {
    if (onRegenerate != null) {
      onRegenerate!();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Regenerating response...'),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF333333),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeService.currentTheme;
    final txtColor = ThemeService.getTextColor(theme);
    final bubbleColor = message.isUser
        ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
        : Theme.of(context).colorScheme.surface.withOpacity(0.9);

    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: message.isUser
                    ? (theme == AppTheme.cyberpunk || theme == AppTheme.forest
                          ? Colors.black
                          : Colors.white)
                    : txtColor,
                fontSize: 15,
              ),
            ),
            if (!message.isUser) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.report, size: 18),
                    color: txtColor.withOpacity(0.7),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    tooltip: 'Report',
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.refresh, size: 18),
                    color: txtColor.withOpacity(0.7),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => _regenerateResponse(context),
                    tooltip: 'Regenerate',
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 18),
                    color: txtColor.withOpacity(0.7),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => _copyMessage(context, message.text),
                    tooltip: 'Copy',
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
