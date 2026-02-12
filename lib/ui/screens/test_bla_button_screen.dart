import 'package:blabla/ui/widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';

class TestBlaButtonScreen extends StatelessWidget {
  const TestBlaButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BlaButton Test")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Primary
            BlaButton(
              text: "Primary",
              onPressed: () {
                debugPrint("Primary clicked");
              },
            ),

            const SizedBox(height: 16),

            // Secondary
            BlaButton(
              text: "Secondary",
              type: BlaButtonType.secondary,
              onPressed: () {
                debugPrint("Secondary clicked");
              },
            ),

            const SizedBox(height: 16),

            // With icon
            BlaButton(
              text: "Search",
              icon: Icons.search,
              onPressed: () {},
            ),

            const SizedBox(height: 16),

            // Disabled
            const BlaButton(
              text: "Disabled",
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}
