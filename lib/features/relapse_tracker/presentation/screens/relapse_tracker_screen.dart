import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quittr/features/relapse_tracker/presentation/bloc/relapse_tracker_bloc.dart';
import 'package:quittr/features/relapse_tracker/presentation/widgets/bottom_model_sheet.dart';
import 'package:quittr/features/relapse_tracker/presentation/widgets/relapse_action_button.dart';
import '../widgets/progress_bar.dart';

class RelapseTrackerScreen extends StatelessWidget {
  const RelapseTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text("Panic Button"),
        icon: Icon(Icons.timer_outlined),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        backgroundColor: Theme.of(context).colorScheme.error.withAlpha(255),
        foregroundColor: Theme.of(context).colorScheme.onError,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_upload),
            onPressed: () {
              // TODO: Implement backup functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.emoji_events_outlined),
            onPressed: () {
              // TODO: Implement achievements
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // Main streak display
              Column(
                children: [
                  Text(
                    "You've been porn-free for:",
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.sizeOf(context).height * 0.015,
                    ),
                  ),
                  const SizedBox(height: 0),
                  Text(
                    "27 days",
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.sizeOf(context).height * 0.07,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "14hr 1m 55s",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RelapseActionButton(
                    icon: Icons.handshake_outlined,
                    label: 'Pledge',
                    onTap: () {
                      context
                          .read<RelapseTrackerBloc>()
                          .add(RelapseTrackerBottomSheetOpenEvent());
                      BottomModelSheet().showCompletionBottomSheet(context);
                    },
                  ),
                  RelapseActionButton(
                    icon: Icons.self_improvement_outlined,
                    label: 'Meditate',
                    onTap: () {
                      Navigator.pushNamed(context, '/meditate-screen');
                    },
                  ),
                  RelapseActionButton(
                    icon: Icons.refresh_outlined,
                    label: 'Reset',
                    onTap: () {
                      // TODO: Implement reset
                    },
                  ),
                  RelapseActionButton(
                    icon: Icons.more_horiz,
                    label: 'More',
                    onTap: () {
                      // TODO: Show more options
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Progress bars
              ProgressBar(
                label: 'Brain Rewiring',
                progress: 0.31,
                progressText: '31%',
              ),
              const SizedBox(height: 16),
              ProgressBar(
                label: '28 Day Challenge',
                progress: 0.0,
                progressText: '0%',
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAlias,
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withAlpha(80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                  ),
                  child: Column(
                    children: [
                      _RelapseMenuItem(
                        icon: Icons.monitor_heart,
                        iconColor: Colors.blue.shade900,
                        title: 'Side Effects',
                        onTap: () async {
                          Navigator.pushNamed(context, '/side-effects-screen');
                        },
                      ),
                      Divider(
                        height: 1,
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                      ),
                      _RelapseMenuItem(
                        icon: Icons.stacked_line_chart,
                        iconColor: Colors.green.shade900,
                        title: 'Motivation',
                        onTap: () =>
                            Navigator.pushNamed(context, "/motivation-screen"),
                      ),
                      Divider(
                        height: 1,
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                      ),
                      _RelapseMenuItem(
                        icon: Icons.air,
                        iconColor: Colors.orange.shade900,
                        title: 'Breathe Exercise',
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/breathing-exercise-screen',
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                      ),
                      _RelapseMenuItem(
                        icon: Icons.check,
                        iconColor: Colors.yellow.shade900,
                        title: 'Sucesss Stories',
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/recovery-journal',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class _RelapseMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;

  const _RelapseMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          left: 10,
          bottom: 2,
          top: 2,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (iconColor ?? Theme.of(context).colorScheme.primary)
                      .withAlpha(25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: iconColor ?? Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
