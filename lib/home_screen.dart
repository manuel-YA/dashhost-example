import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            color: Colors.deepPurple,
          ),
          title: const Text(
            "Rick & Morty Character DB",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                context.go('/about');
              },
              icon: const Icon(Icons.info_outline, color: Colors.white),
            ),
          ],
          elevation: 0,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: 826,
          padding: const EdgeInsets.all(8.0),
          itemBuilder: (context, i) {
            final index = i + 1;
            return GestureDetector(
              onTap: () {
                context.go('/character/$index');
              },
              child: Card(
                color: Colors.white.withOpacity(0.1),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  title: Text(
                    "Character #$index",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                  tileColor: Colors.white.withOpacity(0.05),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
