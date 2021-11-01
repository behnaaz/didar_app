class User {
  final String uid;
  final String? email;

  User(this.uid, this.email);

  String asString() {
    return "User: uid=" + this.uid + ", email=" + this.email!;
  }
}
