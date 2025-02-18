import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quittr/features/relapse_tracker/presentation/bloc/relapse_tracker_bloc.dart';
import 'package:quittr/features/relapse_tracker/presentation/widgets/bottom_model_sheet.dart';
import 'package:quittr/features/relapse_tracker/presentation/widgets/streak_counter.dart';

class RelapseTrackerScreen extends StatelessWidget {
  const RelapseTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //added this beacuse the ui was proper
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const StreakCounter(
                            days: 0, // Will be replaced with actual streak
                            subtitle: 'Current Streak',
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const StreakCounter(
                                days: 0, // Will be replaced with best streak
                                subtitle: 'Best Streak',
                              ),
                              const StreakCounter(
                                days:
                                    0, // Will be replaced with total clean days
                                subtitle: 'Total Clean Days',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, '/meditate-screen');

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
                        child: SvgPicture.asset(
                          'assets/images/icons/pledge_hand_icon.svg',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/meditate-screen');
                        },
                        child: SvgPicture.asset(
                          'assets/images/icons/meditate_icon.svg',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            // Calendar view will go here
            // Progress insights will go here
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Show relapse logging dialog
        },
        label: const Text('Log Relapse'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
