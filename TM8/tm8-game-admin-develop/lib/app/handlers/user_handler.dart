// Tipically used to get id but also handle case where id is null.
// This approach avoids having logout logic in multiple places.


// EXAMPLE

// class UserHandler {
//   static Future<String?> getUserId() async {
//     final secureStorageUserId = await sl<SecureStorage>().getUserId();
//     if (secureStorageUserId == null) {
//       try {
//         final user = await sl<UserSource>().getUser();
//         await storeUserDataToStorage(user);
//         return user.id;
//       } catch (e) {
//         sl<AppBloc>().add(const AppEvent.logOut());
//         return null;
//       }
//     } else {
//       return secureStorageUserId;
//     }
//   }

//   static Future<void> storeUserDataToStorage(UserModel user) async {
//     // important to store userId first
//     await sl<SecureStorage>().storeUserId(user.id);
//   }
// }
