import 'package:flutter/foundation.dart';
import '../../data/repositories/ride_preference/ride_preference_repository.dart';
import '../../model/ride_pref/ride_pref.dart';

///
/// Global state for ride preferences.
/// Manages the current selected preference and the history.
/// Notifies listeners whenever the state changes.
///
class RidePreferenceState extends ChangeNotifier {
  final RidePreferenceRepository ridePreferenceRepository;

  RidePreference? _currentPreference;
  late List<RidePreference> _preferenceHistory;

  RidePreferenceState({required this.ridePreferenceRepository}) {
    // Load initial history from repository on creation
    _preferenceHistory = List.from(
      ridePreferenceRepository.getPreferenceHistory(),
    );
  }

  /// The currently selected ride preference (null if none selected yet)
  RidePreference? get currentPreference => _currentPreference;

  /// History of past ride preferences (most recent last)
  List<RidePreference> get preferenceHistory =>
      List.unmodifiable(_preferenceHistory);

  /// Selects a new preference.
  /// Does nothing if identical to the current one.
  void selectPreference(RidePreference preference) {
    if (preference == _currentPreference) return;

    _currentPreference = preference;
    _preferenceHistory.add(preference);
    ridePreferenceRepository.savePreference(preference);

    notifyListeners();
  }
}