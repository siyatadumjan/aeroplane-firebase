import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateUserProfile extends StatefulWidget {
  const UpdateUserProfile({Key? key}) : super(key: key);
  static String routeName = "/UpdateUserProfile";

  @override
  State<UpdateUserProfile> createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile> {

  static final userId = FirebaseAuth.instance.currentUser!.uid;

  final docUser = FirebaseFirestore.instance.collection('users').doc(userId);
  String nameValue = "";
  String passwordValue = "";
  String emailValue = "";
  String email = '';
  String name = '';

  Color orange = Color(int.parse("FF6700", radix: 16)).withOpacity(1.0);
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController hobby = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot document =
    await firestore.collection('users').doc(userId).get();

    if (document.exists) {
      var data = document.data() as Map<String, dynamic>;
      setState(() {
        emailController.text = data['email'] ?? '';
        nameController.text = data['name'] ?? '';
        hobby.text = data['hobby'].toString();
      });
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    nameController.dispose();
    hobby.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            // Add your logic here
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 85),
              child: Center(
                child: Text(
                  " Profile",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.mode_edit_outline_outlined,
                      size: 18,
                      color: Colors.deepOrange,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: name,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: email,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12, left: 15, top: 30),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(const Size(350, 50)),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
                        ),
                        onPressed: () {
                          // Validate phone number
                          String phoneNumber = hobby.text.trim();
                          if ( int.tryParse(phoneNumber) == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Hobby is empty')),
                            );
                            return;
                          }

                          String email = emailController.text.trim();
                          if (!_isValidEmail(email)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invalid email format.')),
                            );
                            return;
                          }

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          );
                          Future.delayed(const Duration(seconds: 2), () {
                            try {
                              docUser.update({
                                'name': nameController.text,
                                'email': email,
                                'hobby': phoneNumber,
                              }).then((_) {
                                Navigator.pop(context); // Close the rotating box alert
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Profile updated successfully!')),
                                );
                              }).catchError((error) {
                                Navigator.pop(context); // Close the rotating box alert
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Failed to update: $error')),
                                );
                              });
                            } catch (error) {
                              Navigator.pop(context); // Close the rotating box alert
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('An error occurred while updating the profile: $error')),
                              );
                            }
                          });
                        },
                        child: const Text("Update Profile"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12, left: 15, top: 10),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(const Size(350, 50)),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const UpdatePassword()),
                          // );
                        },
                        child: const Text("Update Password"),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  bool _isValidEmail(String email) {
    final emailRegExp = RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegExp.hasMatch(email);
  }
}
