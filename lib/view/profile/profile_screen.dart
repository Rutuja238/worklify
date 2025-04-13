// // // // import 'package:flutter/material.dart';
// // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // import 'package:worklify_app/services/auth_service.dart';

// // // // class ProfileScreen extends StatelessWidget {
// // // //   const ProfileScreen({super.key});

// // // //   void _logout(BuildContext context) async {
// // // //     await AuthService().signOut();
// // // //     Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final user = FirebaseAuth.instance.currentUser;

// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: const Text("Profile"),
// // // //         backgroundColor: Colors.deepOrange,
// // // //       ),
// // // //       body: Padding(
// // // //         padding: const EdgeInsets.all(24.0),
// // // //         child: Column(
// // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // //           children: [
// // // //             const Center(child: Icon(Icons.account_circle, size: 100)),
// // // //             const SizedBox(height: 24),
// // // //             Text("👤 Name: ${user?.displayName ?? "N/A"}", style: const TextStyle(fontSize: 18)),
// // // //             const SizedBox(height: 12),
// // // //             Text("📧 Email: ${user?.email ?? "N/A"}", style: const TextStyle(fontSize: 18)),
// // // //             const Spacer(),
// // // //             SizedBox(
// // // //               width: double.infinity,
// // // //               child: ElevatedButton(
// // // //                 onPressed: () => _logout(context),
// // // //                 style: ElevatedButton.styleFrom(
// // // //                   backgroundColor: Colors.deepOrange,
// // // //                   padding: const EdgeInsets.symmetric(vertical: 14),
// // // //                   shape: RoundedRectangleBorder(
// // // //                     borderRadius: BorderRadius.circular(10),
// // // //                   ),
// // // //                 ),
// // // //                 child: const Text("Logout", style: TextStyle(fontSize: 16)),
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // // import 'package:flutter/material.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';

// // // class ProfileScreen extends StatelessWidget {
// // //   final User user;

// // //   const ProfileScreen({Key? key, required this.user}) : super(key: key);

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: const Text('Personal Details')),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(20),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             CircleAvatar(
// // //               radius: 50,
// // //               backgroundImage: NetworkImage(user.photoURL ?? 'https://www.example.com/default-avatar.png'),
// // //             ),
// // //             const SizedBox(height: 20),
// // //             Text('Name: ${user.displayName}', style: Theme.of(context).textTheme.titleLarge),
// // //             const SizedBox(height: 10),
// // //             Text('Email: ${user.email}', style: Theme.of(context).textTheme.bodyLarge),
// // //             const SizedBox(height: 20),
// // //             ElevatedButton(
// // //               onPressed: () {
// // //                 // Handle Edit Profile if needed
// // //               },
// // //               child: const Text('Edit Profile'),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }


// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/widgets.dart';

// // class ProfileScreen extends StatelessWidget {
// //   final User user; // Add this field

// //   const ProfileScreen({Key? key, required this.user}) : super(key: key); // Constructor

// //   @override
// //   Widget build(BuildContext context) {
// //     // Use the `user` object here
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Profile of ${user.displayName}')),
// //       body: Center(child: Text('User email: ${user.email}')),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key, required user});

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Profile"),
//         leading: BackButton(),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           UserAccountsDrawerHeader(
//             accountName: Text(
//               user?.displayName ?? "User",
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             accountEmail: Text(user?.email ?? "user@example.com"),
//             currentAccountPicture: CircleAvatar(
//               backgroundImage: user?.photoURL != null
//                   ? NetworkImage(user!.photoURL!)
//                   : const AssetImage('assets/default_avatar.png') as ImageProvider,
//             ),
//             decoration: BoxDecoration(
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.settings),
//             title: const Text('Settings'),
//             onTap: () {
//               // Add settings navigation here
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.logout),
//             title: const Text('Logout'),
//             onTap: () async {
//               await FirebaseAuth.instance.signOut();
//               Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key, required user});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user?.displayName ?? "User"),
            accountEmail: Text(user?.email ?? "user@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : const AssetImage('assets/default_avatar.png') as ImageProvider,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (_) => false);
            },
          ),
        ],
      ),
    );
  }
}
