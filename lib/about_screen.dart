import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Dashhost"),
        leading: IconButton(
          icon: const Icon(Icons.navigate_before),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "DISCLAIMER:",
              style: TextStyle(fontSize: 24),
            ),
            Text(
                'Rick and Morty is created by Justin Roiland and Dan Harmon for Adult Swim.\nThe data and images are used without claim of ownership and belong to their respective owners.\nThis API is open source and uses a BSD license'),
          ],
        ),
      ),
    );
  }
}
