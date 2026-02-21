// =============================================================================
// typing_indicator.dart — Shows who is currently typing
// =============================================================================

import 'package:flutter/material.dart';
import '../l10n/generated/app_localizations.dart';

// ---------------------------------------------------------------------------
// TypingIndicator — Displays typing status for room members
// ---------------------------------------------------------------------------

/// Shows a subtle animation and text when one or more users are typing.
///
/// Collapses to zero height when nobody is typing, avoiding layout jumps
/// by using an [AnimatedSize] wrapper.
class TypingIndicator extends StatelessWidget {
  /// The list of usernames currently typing.
  final List<String> typingUsers;

  const TypingIndicator({super.key, required this.typingUsers});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: typingUsers.isEmpty
          ? const SizedBox.shrink()
          : Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  // Animated dots to indicate typing
                  _AnimatedDots(),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _buildTypingText(l10n),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  /// Builds the "X is typing..." text for one or more users.
  String _buildTypingText(AppLocalizations l10n) {
    if (typingUsers.length == 1) {
      return l10n.typing(typingUsers.first);
    }

    // Multiple users typing — show first name + count
    // Alternative: could list all names up to a limit
    final others = typingUsers.length - 1;
    return '${typingUsers.first} and $others other(s) are typing...';
  }
}

// ---------------------------------------------------------------------------
// _AnimatedDots — Three bouncing dots animation
// ---------------------------------------------------------------------------

class _AnimatedDots extends StatefulWidget {
  @override
  State<_AnimatedDots> createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<_AnimatedDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            // Stagger each dot's animation by 0.2
            final delay = index * 0.2;
            final value = (_controller.value + delay) % 1.0;

            // Bounce: scale up in the first half, down in the second
            final scale = value < 0.5 ? 1.0 + value : 2.0 - value;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Transform.scale(
                scale: scale * 0.6 + 0.4, // range: 0.4 to 1.0
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: color.withAlpha((255 * (scale * 0.5 + 0.3)).toInt()),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
