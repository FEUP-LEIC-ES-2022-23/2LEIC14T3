class User {
  String uid;
  String firstName;
  String lastName;
  String username;
  String email;
  String phone;
  String description;
  String photoURL;
  int nReviews;

  User({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    this.phone = "",
    this.photoURL = "",
    this.description = "",
    this.nReviews = 0,
  });
}

User userFromMap(Map<String, dynamic> data){
  User user = User(
      uid: data['uid'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      username: data['username'],
      email: data['email'],
      phone: data['phone'],
      description: data['description'],
      photoURL: data['photoURL'],
      nReviews: data['nReviews'],
  );
  return user;
}