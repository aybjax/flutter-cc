import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/build_context_x.dart';
import '../../../device_contacts/domain/entities/device_contact_entity.dart';
import '../../../device_contacts/presentation/cubit/device_contacts_cubit.dart';
import '../../../device_contacts/presentation/cubit/device_contacts_state.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';

@RoutePage()
class HomePage extends StatefulWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<SettingsCubit>()..load()),
        BlocProvider(create: (_) => getIt<DeviceContactsCubit>()),
      ],
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

  List<DeviceContactEntity> _favoriteContacts(List<DeviceContactEntity> contacts) {
    final starredContacts = contacts
        .where((contact) => contact.isFavorite)
        .toList(growable: false);
    if (starredContacts.isNotEmpty) {
      return starredContacts.take(8).toList(growable: false);
    }

    return contacts.take(4).toList(growable: false);
  }

  List<DeviceContactEntity> _filterContacts(
    List<DeviceContactEntity> contacts,
  ) {
    return contacts
        .where((contact) => contact.matchesQuery(_searchQuery))
        .toList(growable: false);
  }

  void _loadDeviceContactsIfNeeded({bool force = false}) {
    context.read<DeviceContactsCubit>().loadContacts(force: force);
  }

  List<_ChatThread> _chatThreads(SettingsState state) {
    final localName = _currentDisplayName(state);

    return [
      _ChatThread(
        name: 'Sarah Jenkins',
        lastMessage: 'Ready when the server is up. Send me the room.',
        timeLabel: '2m',
        unreadCount: 2,
        isOnline: true,
        palette: const [Color(0xFFFFE1D4), Color(0xFFF8B486)],
      ),
      const _ChatThread(
        name: 'David Park',
        lastMessage: 'Pushed the latest UI polish for the call screen.',
        timeLabel: '15m',
        unreadCount: 0,
        isOnline: true,
        palette: [Color(0xFFFFD8B2), Color(0xFFFFA35D)],
      ),
      const _ChatThread(
        name: 'Maya Rodriguez',
        lastMessage: 'Let us sync once the signaling server is reachable.',
        timeLabel: '1h',
        unreadCount: 0,
        isOnline: false,
        palette: [Color(0xFFFFE1C9), Color(0xFFD9B188)],
      ),
      _ChatThread(
        name: localName,
        lastMessage: 'Your saved profile will be used for the next call.',
        timeLabel: 'Now',
        unreadCount: 1,
        isOnline: true,
        palette: const [Color(0xFFFFE7B7), Color(0xFFFFC15C)],
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

  String _tabTitle(BuildContext context) {
    return switch (_selectedTabIndex) {
      1 => context.l10n.peopleTitle,
      2 => context.l10n.callsTitle,
      _ => context.l10n.messagesTitle,
    };
  }

  String _tabSubtitle(BuildContext context) {
    return switch (_selectedTabIndex) {
      1 => context.l10n.peopleSubtitle,
      2 => context.l10n.callsSubtitle,
      _ => context.l10n.homeSubtitle,
    };
  }

  String _searchHint(BuildContext context) {
    return switch (_selectedTabIndex) {
      1 => context.l10n.searchPeopleHint,
      2 => context.l10n.searchCallsHint,
      _ => context.l10n.searchConversationsHint,
    };
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
        final people = _people(state);
        final favorites = people.where((person) => person.isFavorite).toList();
        final filteredPeople = people
            .where(
              (person) => person.name.toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  ),
            )
            .toList();
        final filteredFavorites = favorites
            .where(
              (person) => person.name.toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  ),
            )
            .toList();
        final filteredThreads = _chatThreads(state)
            .where(
              (thread) =>
                  thread.name.toLowerCase().contains(
                        _searchQuery.toLowerCase(),
                      ) ||
                  thread.lastMessage.toLowerCase().contains(
                        _searchQuery.toLowerCase(),
                      ),
            )
            .toList();
        final filteredCalls = _recentCalls(context)
            .where(
              (call) =>
                  call.name.toLowerCase().contains(
                        _searchQuery.toLowerCase(),
                      ) ||
                  call.statusLabel.toLowerCase().contains(
                        _searchQuery.toLowerCase(),
                      ),
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
                      140,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1024),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _HeaderSection(
                              title: _tabTitle(context),
                              subtitle: _tabSubtitle(context),
                              displayName: _currentDisplayName(state),
                              onEditPressed: () => _showSetupSheet(context, cubit),
                              onAvatarPressed: () =>
                                  _showSetupSheet(context, cubit),
                            ),
                            const SizedBox(height: 24),
                            _SearchField(
                              hintText: _searchHint(context),
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            if (_selectedTabIndex == 0)
                              _ChatsTabContent(
                                serverUrl: _signalingUrlController.text.isEmpty
                                    ? state.settings.signalingUrl
                                    : _signalingUrlController.text,
                                serverReachable: state.serverReachable,
                                threads: filteredThreads,
                                onCheckPressed: isBusy
                                    ? null
                                    : () => cubit.checkServer(
                                          _signalingUrlController.text,
                                        ),
                                onOpenSetup: () => _showSetupSheet(context, cubit),
                              ),
                            if (_selectedTabIndex == 1)
                              _PeopleTabContent(
                                favorites: filteredFavorites,
                                people: filteredPeople,
                              ),
                            if (_selectedTabIndex == 2)
                              _CallsTabContent(calls: filteredCalls),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: isBusy
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
            backgroundColor: const Color(0xFF2B6EF2),
            foregroundColor: Colors.white,
            extendedPadding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            elevation: 6,
            icon: state.isSaving
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.video_call_rounded, size: 22),
            label: Text(
              context.l10n.startVideoCallCta,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedTabIndex,
            onDestinationSelected: (index) {
              if (index == 3) {
                _showSetupSheet(context, cubit);
                return;
              }

              setState(() {
                _selectedTabIndex = index;
              });
            },
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.chat_bubble_outline_rounded),
                label: context.l10n.chatsTab,
              ),
              NavigationDestination(
                icon: const Icon(Icons.groups_rounded),
                label: context.l10n.peopleTab,
              ),
              NavigationDestination(
                icon: const Icon(Icons.call_outlined),
                label: context.l10n.callsTab,
              ),
              NavigationDestination(
                icon: const Icon(Icons.settings_outlined),
                label: context.l10n.settingsTab,
              ),
            ],
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
                            serverReachable: state.serverReachable,
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
                                          final navigator = Navigator.of(context);
                                          final messenger =
                                              ScaffoldMessenger.of(this.context);
                                          final saved =
                                              await cubit.saveSettings(
                                            displayName:
                                                _displayNameController.text,
                                            signalingUrl:
                                                _signalingUrlController.text,
                                            startWithVideo: sheetVideo,
                                          );

                                          if (!saved || !mounted) {
                                            return;
                                          }

                                          navigator.pop();
                                          messenger
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(
                                              SnackBar(
                                                content:
                                                    Text(l10n.saveSuccess),
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
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0B1633),
                      height: 1,
                    ),
              ),
              const SizedBox(height: 8),
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
        _ProfileAvatarButton(
          label: displayName,
          onPressed: onAvatarPressed,
        ),
      ],
    );
  }
}

class _ChatsTabContent extends StatelessWidget {
  const _ChatsTabContent({
    required this.serverUrl,
    required this.serverReachable,
    required this.threads,
    required this.onCheckPressed,
    required this.onOpenSetup,
  });

  final String serverUrl;
  final bool? serverReachable;
  final List<_ChatThread> threads;
  final VoidCallback? onCheckPressed;
  final VoidCallback onOpenSetup;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ServerPrepCard(
          serverUrl: serverUrl,
          serverReachable: serverReachable,
          onCheckPressed: onCheckPressed,
          onOpenSetup: onOpenSetup,
        ),
        const SizedBox(height: 26),
        _SectionLabel(title: context.l10n.conversationsTitle),
        const SizedBox(height: 14),
        _SoftPanel(
          child: Column(
            children: [
              for (var i = 0; i < threads.length; i++) ...[
                _ChatThreadTile(thread: threads[i]),
                if (i != threads.length - 1) const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _PeopleTabContent extends StatelessWidget {
  const _PeopleTabContent({
    required this.favorites,
    required this.people,
  });

  final List<_PersonContact> favorites;
  final List<_PersonContact> people;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(title: context.l10n.favoritesTitle),
        const SizedBox(height: 14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final person in favorites) ...[
                _FavoriteContactAvatar(person: person),
                const SizedBox(width: 18),
              ],
            ],
          ),
        ),
        const SizedBox(height: 26),
        _SectionLabel(title: context.l10n.allPeopleTitle),
        const SizedBox(height: 14),
        _SoftPanel(
          child: Column(
            children: [
              for (var i = 0; i < people.length; i++) ...[
                _PersonTile(person: people[i]),
                if (i != people.length - 1) const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _CallsTabContent extends StatelessWidget {
  const _CallsTabContent({
    required this.calls,
  });

  final List<_RecentCall> calls;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(title: context.l10n.recentCallsTitle),
        const SizedBox(height: 14),
        _SoftPanel(
          child: Column(
            children: [
              for (var i = 0; i < calls.length; i++) ...[
                _RecentCallTile(call: calls[i]),
                if (i != calls.length - 1) const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.hintText,
    required this.onChanged,
  });

  final String hintText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE9EDF3),
        borderRadius: BorderRadius.circular(22),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 26,
            color: Color(0xFF98A5BD),
          ),
          hintStyle: const TextStyle(
            color: Color(0xFF73829E),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _ServerPrepCard extends StatelessWidget {
  const _ServerPrepCard({
    required this.serverUrl,
    required this.serverReachable,
    required this.onCheckPressed,
    required this.onOpenSetup,
  });

  final String serverUrl;
  final bool? serverReachable;
  final VoidCallback? onCheckPressed;
  final VoidCallback onOpenSetup;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final statusText = switch (serverReachable) {
      true => l10n.serverOnline,
      false => l10n.serverOffline,
      null => l10n.serverStatusUnknown,
    };
    final statusColor = switch (serverReachable) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.serverPrepTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.serverPrepBody,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      statusText,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: const Color(0xFF0B1633),
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 2),
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
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              OutlinedButton.icon(
                onPressed: onCheckPressed,
                icon: const Icon(Icons.wifi_find_rounded),
                label: Text(l10n.checkServerAction),
              ),
              TextButton.icon(
                onPressed: onOpenSetup,
                icon: const Icon(Icons.tune_rounded),
                label: Text(l10n.openSetupAction),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: const Color(0xFF6E7C97),
            letterSpacing: 1.2,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

class _SoftPanel extends StatelessWidget {
  const _SoftPanel({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3F8),
        borderRadius: BorderRadius.circular(24),
      ),
      child: child,
    );
  }
}

class _FavoriteContactAvatar extends StatelessWidget {
  const _FavoriteContactAvatar({
    required this.person,
  });

  final _PersonContact person;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 74,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: person.palette),
                  border: Border.all(
                    color: const Color(0xFF2B6EF2).withValues(alpha: 0.9),
                    width: 3,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  _initials(person.name),
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
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: person.isOnline
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
            person.firstName,
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
}

class _PersonTile extends StatelessWidget {
  const _PersonTile({
    required this.person,
  });

  final _PersonContact person;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: person.palette),
                ),
                alignment: Alignment.center,
                child: Text(
                  _initials(person.name),
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
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: person.isOnline
                        ? const Color(0xFF22C55E)
                        : const Color(0xFF9EABC0),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  person.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: const Color(0xFF0B1633),
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${person.role} • ${person.isOnline ? context.l10n.onlineLabel : context.l10n.offlineLabel}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF6E7C97),
                      ),
                ),
              ],
            ),
          ),
          Icon(
            person.isFavorite ? Icons.star_rounded : Icons.person_outline_rounded,
            color: person.isFavorite
                ? const Color(0xFFF29C62)
                : const Color(0xFF97A4BC),
            size: 22,
          ),
        ],
      ),
    );
  }
}

class _ChatThreadTile extends StatelessWidget {
  const _ChatThreadTile({
    required this.thread,
  });

  final _ChatThread thread;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: thread.palette),
                ),
                alignment: Alignment.center,
                child: Text(
                  _initials(thread.name),
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
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: thread.isOnline
                        ? const Color(0xFF22C55E)
                        : const Color(0xFF9EABC0),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        thread.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: const Color(0xFF0B1633),
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                    Text(
                      thread.timeLabel,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: const Color(0xFF97A4BC),
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  thread.lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF6E7C97),
                      ),
                ),
              ],
            ),
          ),
          if (thread.unreadCount > 0) ...[
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF2B6EF2),
                borderRadius: BorderRadius.circular(99),
              ),
              child: Text(
                '${thread.unreadCount}',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _RecentCallTile extends StatelessWidget {
  const _RecentCallTile({
    required this.call,
  });

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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 54,
                height: 54,
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
                  width: 14,
                  height: 14,
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
          const SizedBox(width: 14),
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
                const SizedBox(height: 4),
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
          Icon(icon, color: const Color(0xFF93A1B8), size: 24),
        ],
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
          width: 48,
          height: 48,
          child: Icon(icon, color: foregroundColor, size: 22),
        ),
      ),
    );
  }
}

class _ProfileAvatarButton extends StatelessWidget {
  const _ProfileAvatarButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 48,
        height: 48,
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
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
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

class _PersonContact {
  const _PersonContact({
    required this.name,
    required this.role,
    required this.isOnline,
    required this.palette,
    this.isFavorite = false,
  });

  final String name;
  final String role;
  final bool isOnline;
  final List<Color> palette;
  final bool isFavorite;

  String get firstName => name.split(' ').first;
}

class _ChatThread {
  const _ChatThread({
    required this.name,
    required this.lastMessage,
    required this.timeLabel,
    required this.unreadCount,
    required this.isOnline,
    required this.palette,
  });

  final String name;
  final String lastMessage;
  final String timeLabel;
  final int unreadCount;
  final bool isOnline;
  final List<Color> palette;
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

String _initials(String name) {
  final parts = name.trim().split(' ').where((part) => part.isNotEmpty);
  final letters = parts.take(2).map((part) => part[0]).join();
  return letters.isEmpty ? 'P' : letters.toUpperCase();
}
