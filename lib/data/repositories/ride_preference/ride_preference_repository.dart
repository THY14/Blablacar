import '../../../model/ride_pref/ride_pref.dart';

abstract class RidePreferenceRepository {
  List<RidePreference> getPreferenceHistory();
  void savePreference(RidePreference preference);
}