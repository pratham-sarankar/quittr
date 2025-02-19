import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quittr/features/relapse_tracker/presentation/bloc/relapse_tracker_bloc.dart';
import 'package:quittr/features/relapse_tracker/presentation/widgets/bottom_model_sheet.dart';
import '../widgets/progress_bar.dart';

class RelapseTrackerScreen extends StatelessWidget {
  const RelapseTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // Header with icons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [],
              ),
              const SizedBox(height: 24),
              // Main streak display
              Column(
                children: [
                  Text(
                    "You've been porn-free for:",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "27 days",
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
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
                  _buildActionButton(
                    context,
                    icon: Icons.handshake_outlined,
                    label: 'Pledge',
                    onTap: () {
                      context
                          .read<RelapseTrackerBloc>()
                          .add(RelapseTrackerBottomSheetOpenEvent());
                      BottomModelSheet()
                          .showCompletionBottomSheet(context)
                          .then((_) {
                        // Reset state when sheet closes
                        context
                            .read<RelapseTrackerBloc>()
                            .add(RelapseTrackerBottomSheetOpenEvent());
                      });
                    },
                  ),
                  _buildActionButton(
                    context,
                    icon: Icons.self_improvement_outlined,
                    label: 'Meditate',
                    onTap: () {
                      Navigator.pushNamed(context, '/meditate-screen');
                    },
                  ),
                  _buildActionButton(
                    context,
                    icon: Icons.refresh_outlined,
                    label: 'Reset',
                    onTap: () {
                      // TODO: Implement reset
                    },
                  ),
                  _buildActionButton(
                    context,
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
              const SizedBox(height: 24),
              // Panic button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.timer_outlined),
                    const SizedBox(width: 8),
                    Text(
                      'Panic Button',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
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

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
