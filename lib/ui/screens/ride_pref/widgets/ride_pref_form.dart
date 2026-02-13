import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../location_picker/location_picker_screen.dart';
import 'ride_pref_filed.dart';
import '../../../theme/theme.dart';
import '../../../../utils/date_time_util.dart';

class RidePrefForm extends StatefulWidget {
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  Location? arrival;
  late DateTime departureDate;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------
  @override
  void initState() {
    super.initState();

    departure = widget.initRidePref?.departure;
    arrival = widget.initRidePref?.arrival;
    departureDate =
        widget.initRidePref?.departureDate ?? DateTime.now();
    requestedSeats =
        widget.initRidePref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  Future<void> _pickLocation({
    required Location initialLocation,
    required Function(Location) onSelected,
  }) async {
    final result = await Navigator.of(context).push<Location>(
      MaterialPageRoute(
        builder: (_) => LocationPickerScreen(
          initialLocation: initialLocation,
        ),
      ),
    );

    if (result != null) {
      setState(() => onSelected(result));
    }
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() => departureDate = pickedDate);
    }
  }

  void _changeSeats(int delta) {
    setState(() {
      requestedSeats = (requestedSeats + delta).clamp(1, 8);
    });
  }

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RidePrefField(
          icon: Icons.trip_origin,
          text: departure?.name.isNotEmpty == true
              ? departure!.name
              : 'From',
          onPressed: () => _pickLocation(
            initialLocation: departure ??
                Location(name: '', country: Country.none),
            onSelected: (loc) => departure = loc,
          ),
        ),

        const Divider(height: 1),

        RidePrefField(
          icon: Icons.location_on,
          text: arrival?.name.isNotEmpty == true
              ? arrival!.name
              : 'To',
          onPressed: () => _pickLocation(
            initialLocation: arrival ??
                Location(name: '', country: Country.none),
            onSelected: (loc) => arrival = loc,
          ),
        ),

        const Divider(height: 1),

        RidePrefField(
          icon: Icons.calendar_today,
          text: formatDate(departureDate),
          onPressed: _pickDate,
        ),

        const Divider(height: 1),

        RidePrefField(
          icon: Icons.person,
          text: '$requestedSeats seat(s)',
          onPressed: () {},
          endWidget: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => _changeSeats(-1),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _changeSeats(1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
