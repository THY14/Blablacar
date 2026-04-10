import 'package:flutter/material.dart';
import 'data/repositories/location/location_repository.dart';
import 'data/repositories/ride/ride_repository.dart';
import 'data/repositories/ride_preference/ride_preference_repository.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/states/ride_preference_state.dart';
import 'ui/theme/theme.dart';

void runBlaApp({
  required LocationRepository locationRepository,
  required RideRepository rideRepository,
  required RidePreferenceRepository ridePreferenceRepository,
}) {
  final ridePreferenceState = RidePreferenceState(
    ridePreferenceRepository: ridePreferenceRepository,
  );

  runApp(
    BlaBlaApp(
      locationRepository: locationRepository,
      rideRepository: rideRepository,
      ridePreferenceState: ridePreferenceState,
    ),
  );
}

class BlaBlaApp extends StatelessWidget {
  final LocationRepository locationRepository;
  final RideRepository rideRepository;
  final RidePreferenceState ridePreferenceState;

  const BlaBlaApp({
    super.key,
    required this.locationRepository,
    required this.rideRepository,
    required this.ridePreferenceState,
  });

  @override
  Widget build(BuildContext context) {
    return _RepositoryProvider(
      locationRepository: locationRepository,
      rideRepository: rideRepository,
      ridePreferenceState: ridePreferenceState,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: blaTheme,
        home: Scaffold(body: HomeScreen()),
      ),
    );
  }
}

class _RepositoryProvider extends InheritedWidget {
  final LocationRepository locationRepository;
  final RideRepository rideRepository;
  final RidePreferenceState ridePreferenceState;

  const _RepositoryProvider({
    required this.locationRepository,
    required this.rideRepository,
    required this.ridePreferenceState,
    required super.child,
  });

  static _RepositoryProvider of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<_RepositoryProvider>();
    assert(provider != null, 'No _RepositoryProvider found in context');
    return provider!;
  }

  @override
  bool updateShouldNotify(_RepositoryProvider oldWidget) => false;
}

extension RepositoryProviderExtension on BuildContext {
  LocationRepository get locationRepository =>
      _RepositoryProvider.of(this).locationRepository;

  RideRepository get rideRepository =>
      _RepositoryProvider.of(this).rideRepository;

  RidePreferenceState get ridePreferenceState =>
      _RepositoryProvider.of(this).ridePreferenceState;
}