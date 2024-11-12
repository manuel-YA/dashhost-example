import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

String buildUrl(int number) {
  return "https://rickandmortyapi.com/api/character/$number";
}

Future<Map<String, dynamic>> fetchCharacter(int number) async {
  final url = buildUrl(number);
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load character');
  }
}

class DetailScreen extends StatelessWidget {
  final int number;
  const DetailScreen({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Character $number",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: Colors.purple),
        ),
        backgroundColor: Colors.transparent,
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.deepPurple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: FutureBuilder(
            future: fetchCharacter(number),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data;

                if (data == null) {
                  return const Center(child: Text("Error"));
                }
                Color badgeColor;
                switch (data['status']) {
                  case "Alive":
                    badgeColor = Colors.green;
                    break;
                  case "Dead":
                    badgeColor = Colors.red;
                    break;
                  default:
                    badgeColor = Colors.grey;
                }

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        data['name'],
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 4.0,
                              color: Colors.black26,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                data['image'],
                                width: 300,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: badgeColor.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                data['status'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Species: ${data['species']}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Gender: ${data['gender']}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Origin: ${data['origin']['name']}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Location: ${data['location']['name']}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "Error",
                    style: TextStyle(color: Colors.redAccent, fontSize: 24),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
