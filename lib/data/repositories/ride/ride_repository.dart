import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';

abstract class RideRepository {
  List<Ride> getRides();
  List<Ride> getRidesFor(RidePreference preference);
}