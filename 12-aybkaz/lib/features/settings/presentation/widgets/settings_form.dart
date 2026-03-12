import 'package:flutter/material.dart';

import '../../../../core/utils/build_context_x.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({
    super.key,
    required this.displayNameController,
    required this.signalingUrlController,
    required this.startWithVideo,
    required this.onStartWithVideoChanged,
    required this.isBusy,
    required this.serverReachable,
  });

  final TextEditingController displayNameController;
  final TextEditingController signalingUrlController;
  final bool startWithVideo;
  final ValueChanged<bool> onStartWithVideoChanged;
  final bool isBusy;
  final bool? serverReachable;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final serverIsReachable = serverReachable;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.homeTitle,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.homeSubtitle,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF475569),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: displayNameController,
              enabled: !isBusy,
              decoration: InputDecoration(
                labelText: context.l10n.displayNameLabel,
                hintText: context.l10n.displayNameHint,
                prefixIcon: const Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: signalingUrlController,
              enabled: !isBusy,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                labelText: context.l10n.serverUrlLabel,
                hintText: context.l10n.serverUrlHint,
                helperText: context.l10n.serverUrlHelper,
                prefixIcon: const Icon(Icons.lan_outlined),
              ),
            ),
            const SizedBox(height: 12),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              value: startWithVideo,
              onChanged: isBusy ? null : onStartWithVideoChanged,
              title: Text(context.l10n.startWithVideoLabel),
            ),
            if (serverIsReachable != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: serverIsReachable
                      ? const Color(0xFFDCFCE7)
                      : const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      serverIsReachable
                          ? Icons.check_circle
                          : Icons.error_outline,
                      size: 18,
                      color: serverIsReachable
                          ? const Color(0xFF166534)
                          : const Color(0xFFB91C1C),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        serverIsReachable
                            ? context.l10n.serverOnline
                            : context.l10n.serverOffline,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: serverIsReachable
                              ? const Color(0xFF166534)
                              : const Color(0xFFB91C1C),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
