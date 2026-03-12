import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/build_context_x.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import '../widgets/settings_form.dart';

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

        return Scaffold(
          body: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFF3F7F6),
                  Color(0xFFE7F0EC),
                  Color(0xFFFDF7ED),
                ],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 960),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF0F766E), Color(0xFF155E75)],
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x220F766E),
                                blurRadius: 28,
                                offset: Offset(0, 14),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.l10n.appTitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                context.l10n.homeSubtitle,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(color: const Color(0xFFD7F3EF)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        SettingsForm(
                          displayNameController: _displayNameController,
                          signalingUrlController: _signalingUrlController,
                          startWithVideo: _startWithVideo,
                          onStartWithVideoChanged: (value) {
                            setState(() {
                              _startWithVideo = value;
                            });
                          },
                          isBusy: isBusy,
                          serverReachable: state.serverReachable,
                        ),
                        const SizedBox(height: 18),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            OutlinedButton.icon(
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
                              label: Text(context.l10n.checkServerAction),
                            ),
                            FilledButton.icon(
                              onPressed: isBusy
                                  ? null
                                  : () async {
                                      final saved = await cubit.saveSettings(
                                        displayName:
                                            _displayNameController.text,
                                        signalingUrl:
                                            _signalingUrlController.text,
                                        startWithVideo: _startWithVideo,
                                      );

                                      if (!saved || !context.mounted) {
                                        return;
                                      }

                                      await context.router.push(
                                        const CallRoomRoute(),
                                      );
                                    },
                              icon: state.isSaving
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Icon(Icons.video_call),
                              label: Text(context.l10n.joinCallAction),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.l10n.howItWorksTitle,
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  context.l10n.howItWorksBody,
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: const Color(0xFF475569),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
