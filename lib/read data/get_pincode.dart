import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetPinCode extends StatelessWidget {
  final String value;
  const GetPinCode({required this.value});
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('criminals');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(value).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            dynamic valll = Text('${data['address']} ');
            return valll;
          }
          return Text('loading...');
        }));
  }
}
