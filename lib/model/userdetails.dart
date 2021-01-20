class UserDetails {
  final String uid;
  final String email;

  UserDetails({
    this.uid,
    this.email,
  });
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
    };
  }

  factory UserDetails.fromJson(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    } else {
      return UserDetails(
        uid: data['uid'],
        email: data['email'],
      );
    }
  }
}
