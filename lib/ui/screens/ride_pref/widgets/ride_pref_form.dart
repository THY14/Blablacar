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

  @override
  void initState() {
    super.initState();
    departure = widget.initRidePref?.departure;
    arrival = widget.initRidePref?.arrival;
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    requestedSeats = 1; 
  }

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
  void _switchLocation() {
  setState(() {
    final temp = departure;
    departure = arrival;
    arrival = temp;
  });
}
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Departure 
        RidePrefField(
          icon: Icons.trip_origin,
          text: departure?.name.isNotEmpty == true ? departure!.name : 'From',
          onPressed: () => _pickLocation(
            initialLocation: departure ?? Location(name: '', country: Country.none),
            onSelected: (loc) => departure = loc,
          ),
          endWidget: IconButton(
          icon: Icon(Icons.swap_vert, color: BlaColors.primary),
          onPressed: _switchLocation, )
          
        ),  
        const Divider(height: 1),
        // Arrival 
        RidePrefField(
          icon: Icons.location_on,
          text: arrival?.name.isNotEmpty == true ? arrival!.name : 'To',
          onPressed: () => _pickLocation(
            initialLocation: arrival ?? Location(name: '', country: Country.none),
            onSelected: (loc) => arrival = loc,
          ),
        ),
        const Divider(height: 1),
        RidePrefField(
          icon: Icons.calendar_today,
          text: DateTimeUtils.formatDateTime(departureDate), 
          onPressed: _pickDate,
        ), 
        const Divider(height: 1),
        RidePrefField(
          icon: Icons.person,
          text: '1 seat', 
          onPressed: () {
                    },
        ),
      ],
    );
  }
}