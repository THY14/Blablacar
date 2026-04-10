import '../../../data/dummy_data.dart';
import '../../../model/ride_pref/ride_pref.dart';
import 'ride_preference_repository.dart';

class RidePreferenceRepositoryMock implements RidePreferenceRepository {
  final List<RidePreference> _history = List.from(fakeRidePrefs);

  @override
  List<RidePreference> getPreferenceHistory() => List.unmodifiable(_history);

  @override
  void savePreference(RidePreference preference) => _history.add(preference);
}