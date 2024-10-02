import 'package:flutter_test/flutter_test.dart';
import 'package:tcs_dff_shared_library/validators/validators.dart';

void main() {
  group('Multi Validator (Field & Pattern)', () {
    final multiValidator = MultiValidator(
      [
        RequiredValidator(errorText: 'Email Required'),
        EmailValidator(errorText: 'Invalid Email'),
      ],
    );

    test('pass with and without email for required validator', () {
      expect(multiValidator.call('ram@gmail.com'), null);
      expect(multiValidator.call(''), 'Email Required');
    });

    test('pass valid and invalid email for email validator', () {
      expect(multiValidator.call('ram@gmail.com'), null);
      expect(multiValidator.call('ramgmail.com'), 'Invalid Email');
      expect(multiValidator.call('ram@gmail'), 'Invalid Email');
      expect(multiValidator.call('ram.com'), 'Invalid Email');
    });
  });

  group('Required Validator', () {
    final requiredValidator = RequiredValidator(errorText: 'Name Required');

    test('pass no name', () {
      expect(requiredValidator.call(''), 'Name Required');
    });

    test('pass name', () {
      expect(requiredValidator.call('Ram'), null);
    });
  });

  group('Minimum Length Validator', () {
    final minLengthValidator = MinLengthValidator(
      8,
      errorText: 'Password length should be atleast 8',
    );

    test('pass invalid password (empty & less than minimum length)', () {
      expect(
        minLengthValidator.call(''),
        'Password length should be atleast 8',
      );
      expect(
        minLengthValidator.call('Ram@542'),
        'Password length should be atleast 8',
      );
    });

    test('pass valid password (greater than equal to minimum length)', () {
      expect(minLengthValidator.call('Ram@5427'), null);
    });
  });

  group('Maximum Length Validator', () {
    final maxLengthValidator = MaxLengthValidator(
      10,
      errorText: 'Description length maximum upto 10',
    );

    test('pass invalid description (greater than maximum length)', () {
      expect(
        maxLengthValidator.call('Test description'),
        'Description length maximum upto 10',
      );
    });

    test('pass valid description (less than equal to maximum length)', () {
      expect(maxLengthValidator.call('Test short'), null);
    });
  });

  group('Length Range Validator', () {
    final lengthRangeValidator = LengthRangeValidator(
      min: 4,
      max: 12,
      errorText: 'Username length should be between 4 & 12',
    );

    test('pass invalid username (empty & less than min & more than max)', () {
      expect(
        lengthRangeValidator.call(''),
        'Username length should be between 4 & 12',
      );
      expect(
        lengthRangeValidator.call('ram'),
        'Username length should be between 4 & 12',
      );
      expect(
        lengthRangeValidator.call('ramkumar@2671'),
        'Username length should be between 4 & 12',
      );
    });

    test('pass valid username', () {
      expect(lengthRangeValidator.call('ramkumar'), null);
    });
  });

  group('Range Validator', () {
    final rangeValidator = RangeValidator(
      min: 20,
      max: 40,
      errorText: 'Age should be between 20 & 40',
    );

    test('pass invalid age (numeric & alphanumeric)', () {
      expect(rangeValidator.call('18'), 'Age should be between 20 & 40');
      expect(rangeValidator.call('a8'), 'Age should be between 20 & 40');
    });

    test('pass valid age exclusive min and max', () {
      expect(rangeValidator.call('35'), null);
    });

    test('pass valid age inclusive min and max', () {
      expect(rangeValidator.call('20'), null);
      expect(rangeValidator.call('40'), null);
    });
  });

  group('Date Validator', () {
    final dateValidator = DateValidator(errorText: 'Invalid Date');

    test('pass invalid date (empty & not empty)', () {
      expect(dateValidator.call(''), 'Invalid Date');
      expect(dateValidator.call('8 Nov 2023'), 'Invalid Date');
    });

    test('pass valid date', () {
      expect(dateValidator.call('08/11/2023'), null);
    });
  });

  group('Match Value Validator', () {
    final matchValueValidator = MatchValueValidator(
      'password',
      errorText: 'Invalid Confirm Password',
    );

    test('pass invalid confirm password (not empty)', () {
      expect(matchValueValidator.call('wpassword'), 'Invalid Confirm Password');
    });

    test('pass valid confirm password', () {
      expect(matchValueValidator.call('password'), null);
    });
  });

  group('Match Length Validator', () {
    final matchLengthValidator = MatchLengthValidator(
      6,
      errorText: 'Invalid Pin Code',
    );

    test('pass invalid pin code (empty & not empty)', () {
      expect(matchLengthValidator.call(''), 'Invalid Pin Code');
      expect(matchLengthValidator.call('70015'), 'Invalid Pin Code');
    });

    test('pass valid pin code', () {
      expect(matchLengthValidator.call('700156'), null);
    });
  });

  group('Pattern Validator', () {
    final patternValidator =
        PatternValidator(r'^[0-9]{16}$', errorText: 'Invalid Card Number');

    test('pass invalid card number (less than & greater than 16 digit)', () {
      expect(patternValidator.call('8738271873'), 'Invalid Card Number');
      expect(patternValidator.call('87382718736927347'), 'Invalid Card Number');
    });

    test('pass valid card number', () {
      expect(patternValidator.call('8738271873692734'), null);
    });
  });

  group('Email Validator', () {
    final emailValidator = EmailValidator(errorText: 'Invalid Email');

    test('pass invalid email with username', () {
      expect(emailValidator.call('abc'), 'Invalid Email');
    });
    test('pass invalid email with space', () {
      expect(emailValidator.call('ab c@gmail.com'), 'Invalid Email');
    });

    test('pass invalid email with username, @ symbol', () {
      expect(emailValidator.call('abc@'), 'Invalid Email');
    });

    test('pass invalid email with username, @ symbol, domain name', () {
      expect(emailValidator.call('abc@gmail'), 'Invalid Email');
    });

    test('pass invalid email with username, top-level domain like .com', () {
      expect(emailValidator.call('abc.com'), 'Invalid Email');
    });

    test('pass valid email', () {
      expect(emailValidator.call('abc@gmail.com'), null);
      expect(emailValidator.call('abc982@gmail.com'), null);
    });
  });

  group('Mobile Validator', () {
    final mobileValidator = MobileValidator(errorText: 'Invalid Mobile Number');

    test('pass invalid mobile number (less than & greater than 10 digit', () {
      expect(mobileValidator.call('908297'), 'Invalid Mobile Number');
      expect(mobileValidator.call('91829762798'), 'Invalid Mobile Number');
    });

    test('pass invalid mobile number (not start with 6, 7, 8, 9)', () {
      expect(mobileValidator.call('0790829799'), 'Invalid Mobile Number');
      expect(mobileValidator.call('5790829799'), 'Invalid Mobile Number');
    });

    test('pass invalid mobile number (contains “.” or “,”)', () {
      expect(mobileValidator.call('079082,799'), 'Invalid Mobile Number');
      expect(mobileValidator.call('5.90829799'), 'Invalid Mobile Number');
    });

    test('pass invalid mobile number (all digits are same)', () {
      expect(mobileValidator.call('8888888888'), 'Invalid Mobile Number');
      expect(mobileValidator.call('5555555555'), 'Invalid Mobile Number');
    });

    test('pass valid mobile number with 10 digit', () {
      expect(mobileValidator.call('6297627987'), null);
      expect(mobileValidator.call('7297627987'), null);
      expect(mobileValidator.call('8297627987'), null);
      expect(mobileValidator.call('9297627987'), null);
    });
  });

  group('Pan Validator', () {
    final panValidator = PanValidator(errorText: 'Invalid Pan Number');

    test('pass invalid pan number with case sensitive', () {
      expect(panValidator.call('23ZAABN18J'), 'Invalid Pan Number');
      expect(panValidator.call('BNZAA2318JM'), 'Invalid Pan Number');
      expect(panValidator.call('BNZAA 23184'), 'Invalid Pan Number');
    });

    test('pass invalid pan number with case insensitive', () {
      expect(panValidator.call('23ZaaBn18j'), 'Invalid Pan Number');
      expect(panValidator.call('bnZAa 2318jM'), 'Invalid Pan Number');
    });

    test('pass valid pan number', () {
      expect(panValidator.call('BNZAA2318J'), null);
    });
  });

  group('Aadhaar Validator', () {
    final aadharValidator =
        AadhaarValidator(errorText: 'Invalid Aadhaar Number');

    test('pass invalid aadhaar number (less than & greater than 12 digit)', () {
      expect(aadharValidator.call('36759834601'), 'Invalid Aadhaar Number');
      expect(aadharValidator.call('3675983460129'), 'Invalid Aadhaar Number');
    });

    test('pass invalid aadhaar number starting with 0 and 1', () {
      expect(aadharValidator.call('017598346012'), 'Invalid Aadhaar Number');
    });

    test('pass invalid aadhaar number (alphabet & special characters)', () {
      expect(aadharValidator.call('367598AF60#2'), 'Invalid Aadhaar Number');
      expect(aadharValidator.call('367598AF60A2'), 'Invalid Aadhaar Number');
    });

    test('pass invalid aadhaar number (all digits are same)', () {
      expect(aadharValidator.call('999999999999'), 'Invalid Aadhaar Number');
      expect(aadharValidator.call('000000000000'), 'Invalid Aadhaar Number');
    });

    test('pass valid aadhaar number', () {
      expect(aadharValidator.call('367598346012'), null);
    });
  });

  group('Aadhaar VID Validator', () {
    final aadharVidValidator =
        AadhaarVIDValidator(errorText: 'Invalid Aadhaar VID');

    test('pass invalid aadhaar vid (less than & greater than 16 digit)', () {
      expect(aadharVidValidator.call('36759834601'), 'Invalid Aadhaar VID');
      expect(
        aadharVidValidator.call('367598346012979723'),
        'Invalid Aadhaar VID',
      );
    });

    test('pass invalid aadhaar vid (all digits are same)', () {
      expect(
        aadharVidValidator.call('9999999999999999'),
        'Invalid Aadhaar VID',
      );
      expect(
        aadharVidValidator.call('0000000000000000'),
        'Invalid Aadhaar VID',
      );
    });

    test('pass valid aadhaar vid', () {
      expect(aadharVidValidator.call('3675983460128675'), null);
    });
  });

  group('Account Validator', () {
    final accountValidator =
        AccountValidator(errorText: 'Invalid Account Number');

    test('pass invalid account number with less than 9 digits', () {
      expect(accountValidator.call('36759834'), 'Invalid Account Number');
    });

    test('pass invalid account number with greater than 18 digits', () {
      expect(
        accountValidator.call('36759834782619371623'),
        'Invalid Account Number',
      );
    });

    test('pass invalid account number with whitespaces', () {
      expect(
        accountValidator.call(' 934517865'),
        'Invalid Account Number',
      );
    });

    test('pass invalid account number with special characters', () {
      expect(
        accountValidator.call('913681280_'),
        'Invalid Account Number',
      );
    });

    test('pass valid account number between 9 to 18 digits', () {
      expect(accountValidator.call('635802010014976'), null);
      expect(accountValidator.call('654294563'), null);
    });

    test('pass valid account number with alphabets', () {
      expect(
        accountValidator.call('UBIN0563587'),
        null,
      );
    });
  });

  group('Card Validator', () {
    final cardValidator = CardValidator(errorText: 'Invalid Card Number');

    test('pass invalid card number (less than & greater than 16 digit)', () {
      expect(cardValidator.call('8738271873'), 'Invalid Card Number');
      expect(cardValidator.call('87382718736927347'), 'Invalid Card Number');
    });

    test('pass invalid card number (alphabets & special characters)', () {
      expect(cardValidator.call('415627##60458897'), 'Invalid Card Number');
      expect(cardValidator.call('415627AK60458897'), 'Invalid Card Number');
      expect(cardValidator.call('41562##6045889KU'), 'Invalid Card Number');
    });

    test('pass valid card number', () {
      expect(cardValidator.call('8738271873692734'), null);
    });
  });

  group('Mpin Validator', () {
    final mpinValidator = MpinValidator(errorText: 'Invalid Mpin');

    test('pass invalid mpin (less than & greater than 6 digit)', () {
      expect(mpinValidator.call('8738'), 'Invalid Mpin');
      expect(mpinValidator.call('873827187'), 'Invalid Mpin');
    });

    test('pass invalid mpin (3 consecutive digits same)', () {
      expect(mpinValidator.call('425558'), 'Invalid Mpin');
      expect(mpinValidator.call('444558'), 'Invalid Mpin');
      expect(mpinValidator.call('444218'), 'Invalid Mpin');
      expect(mpinValidator.call('124555c'), 'Invalid Mpin');
    });

    test('pass invalid mpin (3 consecutive digits sequence)', () {
      expect(mpinValidator.call('425673'), 'Invalid Mpin');
      expect(mpinValidator.call('456558'), 'Invalid Mpin');
    });

    test('pass invalid mpin (atleast 3 unique digits)', () {
      expect(mpinValidator.call('454554'), 'Invalid Mpin');
    });

    test('pass valid mpin', () {
      expect(mpinValidator.call('873827'), null);
      expect(mpinValidator.call('877977'), null);
    });
  });

  group('Password Validator', () {
    final passwordValidator = PasswordValidator(errorText: 'Invalid Password');

    test('pass invalid password (less than 8 digit)', () {
      expect(passwordValidator.call('Ak2h#'), 'Invalid Password');
    });

    test('pass invalid password (atleast 1 capital letter)', () {
      expect(passwordValidator.call('ak2h#u35'), 'Invalid Password');
    });

    test('pass invalid password (atleast 1 small letter)', () {
      expect(passwordValidator.call('AK22#535'), 'Invalid Password');
    });

    test('pass invalid password (atleast 1 special character)', () {
      expect(passwordValidator.call('Ak2h2732'), 'Invalid Password');
    });

    test('pass invalid password (atleast 1 number)', () {
      expect(passwordValidator.call('Ak@hu!_W'), 'Invalid Password');
    });

    test('pass valid password', () {
      expect(passwordValidator.call('Ak@Hu26W'), null);
      expect(passwordValidator.call('Gdh1!Fd&3uy'), null);
    });
  });

  group('IFSC Code Validator', () {
    final ifscCodeValidator = IfscCodeValidator(errorText: 'Invalid IFSC Code');

    test('pass invalid ifsc code (less than & greater than 11 digit)', () {
      expect(ifscCodeValidator.call('hdYh0sH'), 'Invalid IFSC Code');
      expect(ifscCodeValidator.call('hdYh0sHTs8wU9'), 'Invalid IFSC Code');
    });

    test('pass invalid ifsc code (first 4 characters alphabets)', () {
      expect(ifscCodeValidator.call('a9yh0si7s8p'), 'Invalid IFSC Code');
      expect(ifscCodeValidator.call('a98Y0uR9Y2m'), 'Invalid IFSC Code');
    });

    test('pass invalid ifsc code (5th character zero)', () {
      expect(ifscCodeValidator.call('atyh9si7s8p'), 'Invalid IFSC Code');
    });

    test('pass invalid ifsc code (last 6 characters alphanumeric)', () {
      expect(ifscCodeValidator.call('aUyh0si/s8p'), 'Invalid IFSC Code');
      expect(ifscCodeValidator.call('a98Y0uR9@0*'), 'Invalid IFSC Code');
    });

    test('pass valid ifsc code', () {
      expect(ifscCodeValidator.call('atyh0si7s8p'), null);
      expect(ifscCodeValidator.call('hdYh0sH7s8T'), null);
    });
  });

  group('Name Validator', () {
    final nameValidator = NameValidator(errorText: 'Invalid Name');

    test('pass invalid name (special characters)', () {
      expect(nameValidator.call('Ayue# Kumar&'), 'Invalid Name');
      expect(nameValidator.call('Ayue#Ku(_ar&'), 'Invalid Name');
    });

    test('pass invalid name (emoji)', () {
      expect(nameValidator.call('Ayush Kumar😊'), 'Invalid Name');
    });

    test('pass valid name', () {
      expect(nameValidator.call('Ayush Kumar'), null);
      expect(nameValidator.call('Ayush'), null);
    });
  });

  group('Address Validator', () {
    final addressValidator = AddressValidator(errorText: 'Invalid Address');

    test('pass invalid address (special characters)', () {
      expect(
        addressValidator.call('20/1, Kuntal Kumar# Delhi-2989272'),
        'Invalid Address',
      );
      expect(addressValidator.call('Ayue#Ku(_ar&'), 'Invalid Address');
    });

    test('pass invalid address (emoji)', () {
      expect(
        addressValidator.call('20/1, Kuntal Kumar Das Lane 😊'),
        'Invalid Address',
      );
    });

    test('pass valid address', () {
      expect(
        addressValidator.call('20/1, Kuntal Kumar Das Lane, Delhi-2989272'),
        null,
      );
      expect(addressValidator.call(' Kuntal Kumar Das Lane,'), null);
      expect(addressValidator.call('Kuntal Kumar Das Lane. Ts'), null);
    });
  });
}
