import 'package:xml/xml.dart';

class QrInfo {
  String data;
  AadharInfo? aadharInfo;

  QrInfo({
    this.aadharInfo,
    required this.data,
  });
}

class AadharInfo {
  final String uid;
  final String name;
  final Address address;
  final String gender;
  final String dob;
  final String pinCode;

  AadharInfo({
    required this.uid,
    required this.name,
    required this.address,
    required this.gender,
    required this.dob,
    required this.pinCode,
  });

  static AadharInfo fromXml(final Iterable<XmlElement> json) => AadharInfo(
        uid: json
            .map((final chekListElement) => chekListElement.getAttribute('uid'))
            .join(),
        name: json
            .map(
              (final chekListElement) => chekListElement.getAttribute('name'),
            )
            .join(),
        address: Address(
          house: json
              .map(
                (final chekListElement) =>
                    chekListElement.getAttribute('house'),
              )
              .join(),
          street: json
              .map(
                (final chekListElement) =>
                    chekListElement.getAttribute('street'),
              )
              .join(),
          lm: json
              .map(
                (final chekListElement) => chekListElement.getAttribute('lm'),
              )
              .join(),
          vtc: json
              .map(
                (final chekListElement) => chekListElement.getAttribute('vtc'),
              )
              .join(),
          po: json
              .map(
                (final chekListElement) => chekListElement.getAttribute('po'),
              )
              .join(),
          dist: json
              .map(
                (final chekListElement) => chekListElement.getAttribute('dist'),
              )
              .join(),
          subdist: json
              .map(
                (final chekListElement) =>
                    chekListElement.getAttribute('subdist'),
              )
              .join(),
          state: json
              .map(
                (final chekListElement) =>
                    chekListElement.getAttribute('state'),
              )
              .join(),
        ),
        gender: json
            .map(
              (final chekListElement) => chekListElement.getAttribute('gender'),
            )
            .join(),
        dob: json
            .map((final chekListElement) => chekListElement.getAttribute('yob'))
            .join()
            .toString(),
        pinCode: json
            .map((final chekListElement) => chekListElement.getAttribute('uid'))
            .join(),
      );
}

class Address {
  final String house;
  final String street;
  final String lm;
  final String vtc;
  final String po;
  final String dist;
  final String subdist;
  final String state;

  Address({
    required this.house,
    required this.street,
    required this.lm,
    required this.vtc,
    required this.po,
    required this.dist,
    required this.subdist,
    required this.state,
  });

  @override
  String toString() =>
      '$house, $street, $lm, $vtc, $po, $dist, $subdist, $state';
}
