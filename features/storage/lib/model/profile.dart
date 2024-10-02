class Profile {
  late String emailId;
  late String name;
  late String primarySkill;
  late String contactNumber;

  Profile(this.emailId, this.name, this.primarySkill, this.contactNumber);

  Map<String, dynamic> toJson() => {
        'emailId': emailId,
        'name': name,
        'primarySkill': primarySkill,
        'contactNumber': contactNumber
      ,};

  Profile.fromJson(final Map<String, dynamic> data) {
    emailId = data['emailId'] as String;
    name = data['name'] as String;
    primarySkill = data['primarySkill'] as String;
    contactNumber = data['contactNumber'] as String;
  }
}
