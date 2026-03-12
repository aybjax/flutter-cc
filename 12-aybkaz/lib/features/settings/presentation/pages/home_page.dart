import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/build_context_x.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';

@RoutePage()
class HomePage extends StatefulWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SettingsCubit>()..load(),
      child: this,
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _displayNameController;
  late final TextEditingController _signalingUrlController;

  bool _didHydrate = false;
  bool _startWithVideo = true;
  int _selectedTabIndex = 0;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _displayNameController = TextEditingController();
    _signalingUrlController = TextEditingController();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _signalingUrlController.dispose();
    super.dispose();
  }

  List<_FavoriteContact> _favorites(BuildContext context, SettingsState state) {
    final localName = _currentDisplayName(state);

    return [
      _FavoriteContact(
        name: localName,
        palette: const [Color(0xFFFFE1D4), Color(0xFFF8B486)],
        isOnline: true,
      ),
      const _FavoriteContact(
        name: 'David',
        palette: [Color(0xFFFFD8B2), Color(0xFFFFA35D)],
        isOnline: true,
      ),
      const _FavoriteContact(
        name: 'Elena',
        palette: [Color(0xFFFFE1DC), Color(0xFFF3B18A)],
        isOnline: false,
      ),
      const _FavoriteContact(
        name: 'Michael',
        palette: [Color(0xFFFFE7B7), Color(0xFFFFC15C)],
        isOnline: true,
      ),
    ];
  }

  List<_RecentCall> _recentCalls(BuildContext context) {
    final l10n = context.l10n;

    return [
      _RecentCall(
        name: 'Alex Johnson',
        statusLabel: l10n.incomingStatus,
        timeLabel: '2m ago',
        isOnline: true,
        type: _RecentCallType.voice,
      ),
      _RecentCall(
        name: 'Maya Rodriguez',
        statusLabel: l10n.missedStatus,
        timeLabel: '1h ago',
        isOnline: false,
        type: _RecentCallType.video,
      ),
      _RecentCall(
        name: 'Jessica Chen',
        statusLabel: l10n.outgoingStatus,
        timeLabel: 'Yesterday',
        isOnline: true,
        type: _RecentCallType.video,
      ),
      _RecentCall(
        name: 'Robert Wilson',
        statusLabel: l10n.incomingStatus,
        timeLabel: 'Oct 12',
        isOnline: false,
        type: _RecentCallType.voice,
      ),
    ];
  }

  String _currentDisplayName(SettingsState state) {
    final typed = _displayNameController.text.trim();
    if (typed.isNotEmpty) {
      return typed;
    }

    final saved = state.settings.displayName.trim();
    if (saved.isNotEmpty) {
      return saved;
    }

    return 'You';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (!_didHydrate && !state.isLoading) {
          _displayNameController.text = state.settings.displayName;
          _signalingUrlController.text = state.settings.signalingUrl;
          _startWithVideo = state.settings.startWithVideo;
          _didHydrate = true;
          setState(() {});
        }

        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          context.read<SettingsCubit>().clearError();
        }
      },
      builder: (context, state) {
        final cubit = context.read<SettingsCubit>();
        final isBusy =
            state.isLoading || state.isSaving || state.isCheckingServer;
        final favorites = _favorites(context, state);
        final recentCalls = _recentCalls(context)
            .where(
              (call) =>
                  call.name.toLowerCase().contains(_searchQuery.toLowerCase()),
            )
            .toList();

        return Scaffold(
          backgroundColor: const Color(0xFFF4F5F7),
          body: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFF6F7FA), Color(0xFFF1F3F8)],
              ),
            ),
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 900;

                  return SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      isWide ? 36 : 24,
                      24,
                      isWide ? 36 : 24,
                      24,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1024),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _HeaderSection(
                              title: context.l10n.messagesTitle,
                              subtitle: context.l10n.homeSubtitle,
                              displayName: _currentDisplayName(state),
                              onEditPressed: () {
                                _showSetupSheet(context, cubit);
                              },
                              onAvatarPressed: () {
                                _showSetupSheet(context, cubit);
                              },
                            ),
                            const SizedBox(height: 28),
                            _SearchField(
                              hintText: context.l10n.searchConversationsHint,
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value;
                                });
                              },
                            ),
                            const SizedBox(height: 18),
                            _ServerStatusCard(
                              serverUrl: _signalingUrlController.text.isEmpty
                                  ? state.settings.signalingUrl
                                  : _signalingUrlController.text,
                              isReachable: state.serverReachable,
                              onCheckPressed: isBusy
                                  ? null
                                  : () => cubit.checkServer(
                                      _signalingUrlController.text,
                                    ),
                            ),
                            const SizedBox(height: 34),
                            Text(
                              context.l10n.favoritesTitle.toUpperCase(),
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    color: const Color(0xFF6E7C97),
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: 18),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (final contact in favorites) ...[
                                    _FavoriteContactAvatar(contact: contact),
                                    const SizedBox(width: 20),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(height: 34),
                            Text(
                              context.l10n.recentCallsTitle.toUpperCase(),
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    color: const Color(0xFF6E7C97),
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: 18),
                            Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F3F8),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                children: [
                                  for (
                                    var i = 0;
                                    i < recentCalls.length;
                                    i++
                                  ) ...[
                                    _RecentCallTile(call: recentCalls[i]),
                                    if (i != recentCalls.length - 1)
                                      const SizedBox(height: 12),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          bottomNavigationBar: _BottomBar(
            selectedIndex: _selectedTabIndex,
            isLoading: state.isSaving,
            onTabSelected: (index) {
              if (index == 3) {
                _showSetupSheet(context, cubit);
                return;
              }

              setState(() {
                _selectedTabIndex = index;
              });
            },
            onStartCall: isBusy
                ? null
                : () async {
                    final saved = await cubit.saveSettings(
                      displayName: _displayNameController.text,
                      signalingUrl: _signalingUrlController.text,
                      startWithVideo: _startWithVideo,
                    );

                    if (!saved || !context.mounted) {
                      return;
                    }

                    await context.router.push(const CallRoomRoute());
                  },
          ),
        );
      },
    );
  }

  Future<void> _showSetupSheet(
    BuildContext context,
    SettingsCubit cubit,
  ) async {
    final l10n = context.l10n;
    var sheetVideo = _startWithVideo;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return BlocProvider.value(
          value: cubit,
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              final isBusy =
                  state.isSaving || state.isCheckingServer || state.isLoading;
              final serverReachable = state.serverReachable;

              return StatefulBuilder(
                builder: (context, setModalState) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                      16,
                      16,
                      16,
                      MediaQuery.of(context).viewInsets.bottom + 16,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(34),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x260B1633),
                            blurRadius: 36,
                            offset: Offset(0, 16),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 56,
                              height: 6,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD8DEEA),
                                borderRadius: BorderRadius.circular(99),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            l10n.settingsSheetTitle,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.settingsSheetSubtitle,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: const Color(0xFF6E7C97)),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _displayNameController,
                            decoration: InputDecoration(
                              labelText: l10n.displayNameLabel,
                              hintText: l10n.displayNameHint,
                              prefixIcon: const Icon(Icons.person_outline),
                            ),
                          ),
                          const SizedBox(height: 14),
                          TextField(
                            controller: _signalingUrlController,
                            decoration: InputDecoration(
                              labelText: l10n.serverUrlLabel,
                              hintText: l10n.serverUrlHint,
                              helperText: l10n.serverUrlHelper,
                              prefixIcon: const Icon(Icons.hub_outlined),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SwitchListTile.adaptive(
                            contentPadding: EdgeInsets.zero,
                            value: sheetVideo,
                            onChanged: isBusy
                                ? null
                                : (value) {
                                    setState(() {
                                      _startWithVideo = value;
                                    });
                                    setModalState(() {
                                      sheetVideo = value;
                                    });
                                  },
                            title: Text(l10n.startWithVideoLabel),
                          ),
                          const SizedBox(height: 10),
                          _SheetStatusRow(
                            serverReachable: serverReachable,
                            unknownLabel: l10n.serverStatusUnknown,
                            onlineLabel: l10n.serverOnline,
                            offlineLabel: l10n.serverOffline,
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: isBusy
                                      ? null
                                      : () => cubit.checkServer(
                                          _signalingUrlController.text,
                                        ),
                                  icon: state.isCheckingServer
                                      ? const SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Icon(Icons.wifi_find),
                                  label: Text(l10n.checkServerAction),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: FilledButton(
                                  onPressed: isBusy
                                      ? null
                                      : () async {
                                          final saved = await cubit
                                              .saveSettings(
                                                displayName:
                                                    _displayNameController.text,
                                                signalingUrl:
                                                    _signalingUrlController
                                                        .text,
                                                startWithVideo: sheetVideo,
                                              );

                                          if (!saved || !context.mounted) {
                                            return;
                                          }

                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(this.context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(
                                              SnackBar(
                                                content: Text(l10n.saveSuccess),
                                              ),
                                            );
                                        },
                                  child: state.isSaving
                                      ? const SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(l10n.saveAction),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection({
    required this.title,
    required this.subtitle,
    required this.displayName,
    required this.onEditPressed,
    required this.onAvatarPressed,
  });

  final String title;
  final String subtitle;
  final String displayName;
  final VoidCallback onEditPressed;
  final VoidCallback onAvatarPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0B1633),
                  height: 1,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF6E7C97),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        _SoftCircleButton(
          icon: Icons.edit_outlined,
          foregroundColor: const Color(0xFF2B6EF2),
          backgroundColor: const Color(0xFFE7EEF9),
          onPressed: onEditPressed,
        ),
        const SizedBox(width: 12),
        _ProfileAvatarButton(label: displayName, onPressed: onAvatarPressed),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.hintText, required this.onChanged});

  final String hintText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE9EDF3),
        borderRadius: BorderRadius.circular(28),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 34,
            color: Color(0xFF98A5BD),
          ),
          hintStyle: const TextStyle(color: Color(0xFF73829E), fontSize: 18),
        ),
      ),
    );
  }
}

class _ServerStatusCard extends StatelessWidget {
  const _ServerStatusCard({
    required this.serverUrl,
    required this.isReachable,
    required this.onCheckPressed,
  });

  final String serverUrl;
  final bool? isReachable;
  final VoidCallback? onCheckPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final statusText = switch (isReachable) {
      true => l10n.serverOnline,
      false => l10n.serverOffline,
      null => l10n.serverStatusUnknown,
    };
    final statusColor = switch (isReachable) {
      true => const Color(0xFF22C55E),
      false => const Color(0xFFFF5A5A),
      null => const Color(0xFF9EABC0),
    };

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C0B1633),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusText,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0B1633),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  serverUrl,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF7A879E),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          TextButton.icon(
            onPressed: onCheckPressed,
            icon: const Icon(Icons.wifi_find_rounded),
            label: Text(context.l10n.checkServerAction),
          ),
        ],
      ),
    );
  }
}

class _FavoriteContactAvatar extends StatelessWidget {
  const _FavoriteContactAvatar({required this.contact});

  final _FavoriteContact contact;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 82,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 74,
                height: 74,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: contact.palette),
                  border: Border.all(
                    color: const Color(0xFF2B6EF2).withValues(alpha: 0.9),
                    width: 3,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  _initials(contact.name),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF0B1633),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: contact.isOnline
                        ? const Color(0xFF22C55E)
                        : const Color(0xFF9EABC0),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            contact.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: const Color(0xFF15203A),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ').where((part) => part.isNotEmpty);
    final letters = parts.take(2).map((part) => part[0]).join();
    return letters.toUpperCase();
  }
}

class _RecentCallTile extends StatelessWidget {
  const _RecentCallTile({required this.call});

  final _RecentCall call;

  @override
  Widget build(BuildContext context) {
    final icon = switch (call.type) {
      _RecentCallType.voice => Icons.call_outlined,
      _RecentCallType.video => Icons.video_call_outlined,
    };
    final statusColor = switch (call.statusLabel) {
      'Missed' || 'Пропущенный' => const Color(0xFFFF5A5A),
      _ => const Color(0xFF6E7C97),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: call.palette),
                ),
                alignment: Alignment.center,
                child: Text(
                  _initials(call.name),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF0B1633),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Positioned(
                right: -1,
                bottom: -1,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: call.isOnline
                        ? const Color(0xFF22C55E)
                        : const Color(0xFF9EABC0),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  call.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF0B1633),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      call.type == _RecentCallType.voice
                          ? Icons.call_received_rounded
                          : Icons.video_call_outlined,
                      size: 16,
                      color: statusColor,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        '${call.statusLabel} • ${call.timeLabel}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(icon, color: const Color(0xFF93A1B8), size: 30),
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ').where((part) => part.isNotEmpty);
    final letters = parts.take(2).map((part) => part[0]).join();
    return letters.toUpperCase();
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.selectedIndex,
    required this.isLoading,
    required this.onTabSelected,
    required this.onStartCall,
  });

  final int selectedIndex;
  final bool isLoading;
  final ValueChanged<int> onTabSelected;
  final VoidCallback? onStartCall;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0xFFF6F7FA),
        border: Border(top: BorderSide(color: Color(0xFFD8DEEA))),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: FilledButton.icon(
                  onPressed: onStartCall,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF2B6EF2),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    minimumSize: const Size.fromHeight(72),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  icon: isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.video_call_rounded, size: 28),
                  label: Text(
                    l10n.startVideoCallCta,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _NavItem(
                    label: l10n.chatsTab,
                    icon: Icons.chat_bubble_outline_rounded,
                    isSelected: selectedIndex == 0,
                    onTap: () => onTabSelected(0),
                  ),
                  _NavItem(
                    label: l10n.peopleTab,
                    icon: Icons.groups_rounded,
                    isSelected: selectedIndex == 1,
                    onTap: () => onTabSelected(1),
                  ),
                  _NavItem(
                    label: l10n.callsTab,
                    icon: Icons.call_outlined,
                    isSelected: selectedIndex == 2,
                    onTap: () => onTabSelected(2),
                  ),
                  _NavItem(
                    label: l10n.settingsTab,
                    icon: Icons.settings_outlined,
                    isSelected: selectedIndex == 3,
                    onTap: () => onTabSelected(3),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? const Color(0xFF2B6EF2)
        : const Color(0xFF97A4BC);

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: color,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SoftCircleButton extends StatelessWidget {
  const _SoftCircleButton({
    required this.icon,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.onPressed,
  });

  final IconData icon;
  final Color foregroundColor;
  final Color backgroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: 60,
          height: 60,
          child: Icon(icon, color: foregroundColor, size: 30),
        ),
      ),
    );
  }
}

class _ProfileAvatarButton extends StatelessWidget {
  const _ProfileAvatarButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFC58F), Color(0xFFF29C62)],
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          _initials(label),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: const Color(0xFF0B1633),
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ').where((part) => part.isNotEmpty);
    final letters = parts.take(2).map((part) => part[0]).join();
    return letters.isEmpty ? 'P' : letters.toUpperCase();
  }
}

class _SheetStatusRow extends StatelessWidget {
  const _SheetStatusRow({
    required this.serverReachable,
    required this.unknownLabel,
    required this.onlineLabel,
    required this.offlineLabel,
  });

  final bool? serverReachable;
  final String unknownLabel;
  final String onlineLabel;
  final String offlineLabel;

  @override
  Widget build(BuildContext context) {
    final label = switch (serverReachable) {
      true => onlineLabel,
      false => offlineLabel,
      null => unknownLabel,
    };
    final color = switch (serverReachable) {
      true => const Color(0xFF22C55E),
      false => const Color(0xFFFF5A5A),
      null => const Color(0xFF9EABC0),
    };

    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF6E7C97),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _FavoriteContact {
  const _FavoriteContact({
    required this.name,
    required this.palette,
    required this.isOnline,
  });

  final String name;
  final List<Color> palette;
  final bool isOnline;
}

class _RecentCall {
  const _RecentCall({
    required this.name,
    required this.statusLabel,
    required this.timeLabel,
    required this.isOnline,
    required this.type,
  }) : palette = const [Color(0xFFFFE1C9), Color(0xFFD9B188)];

  final String name;
  final String statusLabel;
  final String timeLabel;
  final bool isOnline;
  final _RecentCallType type;
  final List<Color> palette;
}

enum _RecentCallType { voice, video }
