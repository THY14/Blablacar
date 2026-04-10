import '../../../data/dummy_data.dart';
import '../../../model/ride/locations.dart';
import 'location_repository.dart';

class LocationRepositoryMock implements LocationRepository {
  @override
  List<Location> getAvailableLocations() => fakeLocations;
}