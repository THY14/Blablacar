import 'package:flutter/material.dart';
import '../../../../model/ride/locations.dart';
import '../../../dummy_data/dummy_data.dart';
import '../../theme/theme.dart';

class LocationPickerScreen extends StatefulWidget {
  final Location initialLocation;

  const LocationPickerScreen({
    super.key,
    required this.initialLocation,
  });

  @override
  State<LocationPickerScreen> createState() =>
      _LocationPickerScreenState();
}

class _LocationPickerScreenState
    extends State<LocationPickerScreen> {

  late TextEditingController _searchController;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController =
        TextEditingController(text: widget.initialLocation.name);
    _query = widget.initialLocation.name;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Location> get _filteredLocations {
    if (_query.isEmpty) return [];

    return fakeLocations.where((location) {
      final nameMatch =
          location.name.toLowerCase().contains(_query.toLowerCase());
      final countryMatch =
          location.country.name.toLowerCase().contains(_query.toLowerCase());

      return nameMatch || countryMatch;
    }).toList();
  }

  void _onLocationSelected(Location location) {
    Navigator.of(context).pop(location);
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _query = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose location"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .pop(widget.initialLocation);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search city or country",
                filled: true,
                fillColor: BlaColors.greyLight,
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _clearSearch,
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
            ),
          ),
          Expanded(
            child: _query.isEmpty
                ? const Center(
                    child: Text(
                      "search...",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.separated(
                    itemCount: _filteredLocations.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final location =
                          _filteredLocations[index];

                      return ListTile(
                        title: Text(location.name),
                        subtitle:
                            Text(location.country.name),
                        onTap: () =>
                            _onLocationSelected(location),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
