import 'package:flutter/material.dart';

/// Minimal homepage used as navigation target from the login screen.
/// You can replace or expand this with your real Homepage implementation.
class HomePage extends StatelessWidget {
	const HomePage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Home')),
			body: const Center(
				child: Text('Welcome to the Home page', style: TextStyle(fontSize: 18)),
			),
		);
	}
}
