import 'package:aeroplane/ui/pages/profile/update_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/user_details.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);
  static String routeName = "/UserProfile";

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Color orange = Color(int.parse("FF6700", radix: 16)).withOpacity(1.0);
  Color divider = Color(int.parse("777F88", radix: 16)).withOpacity(1.0);
  TextEditingController emailController = TextEditingController();
  Color secondaryText = Color(int.parse("777F88", radix: 16)).withOpacity(1.0);
  String email = '';
  String name = '';
  String hobby = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  static final userId = FirebaseAuth.instance.currentUser!.uid;
  Future<void> fetchData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot document =
    await firestore.collection('users').doc(userId).get();

    if (document.exists) {
      var data = document.data() as Map<String, dynamic>;
      setState(() {
        email = data['email'] ?? '';
        name = data['name'] ?? '';
        hobby = data['hobby'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title:  Text(
            "Profile",
            style:GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            )
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(
                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UpdateUserProfile()),
                        );
                      },
                      child: const Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.mode_edit_outline_outlined,
                    size: 18,
                    color: Colors.deepOrange,
                  ),
                ],
              ),
              UserDetails(
                type: 'Name',
                value: name,
                rightValue: 60,
                secondaryText: secondaryText,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 100, right: 32, bottom: 15),
                child: Divider(
                  color: divider,
                  thickness: 1,
                ),
              ),
              UserDetails(
                type: 'Email',
                value: email,
                rightValue: 62,
                secondaryText: secondaryText,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 32, bottom: 15),
                child: Divider(
                  color: divider,
                  thickness: 1,
                ),
              ),
              UserDetails(
                type: 'Hobby',
                value: hobby,
                rightValue: 26,
                secondaryText: secondaryText,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 32, bottom: 15),
                child: Divider(
                  color: divider,
                  thickness: 1,
                ),
              ),
              ElevatedButton(onPressed:
              () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
              }
              ,
                  child:
                  Container(
                    width: 200,
                    height: 50,
                    child: const Center(child: Text("Logout",style: TextStyle(fontSize: 20),)),
                  )
              )
            ],
          ),
        ),

      ),
    );
  }
}


