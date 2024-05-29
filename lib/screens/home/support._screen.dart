import 'package:ekissanadmin/screens/home/support_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SupportScreen extends StatelessWidget {
  final CollectionReference supportTopicsRef =
      FirebaseFirestore.instance.collection('support_topics');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Support'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: supportTopicsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final supportTopics = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: supportTopics.length,
            itemBuilder: (context, index) {
              final data = supportTopics[index].data() as Map<String, dynamic>;
              final topicEng = data['topicEng'] ?? '';
              final topicUrdu = data['topicUrdu'] ?? '';
              final descriptionEng = data['descriptionEng'] ?? '';
              final descriptionUrdu = data['descriptionUrdu'] ?? '';

              return Card(
                elevation: 3.0,
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ExpansionTile(
                  title: Text(
                    topicEng,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                                            child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description (English): $descriptionEng',
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Description (Urdu): $descriptionUrdu',
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.to(SupportFormScreen(supportId: supportTopics[index].id));
                                },
                                icon: Icon(Icons.edit),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(SupportFormScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

