import 'package:digital_marketing_assignment/view-model/login_view_controller.dart';
import 'package:digital_marketing_assignment/view/RegisterScreen/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

enum LoginMode { mobile, email }

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginMode _selectedMode = LoginMode.mobile;
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  final LoginViewController _controller = Get.put(LoginViewController());
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.mobileController.dispose();
    _controller.emailController.dispose();
    _controller.passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // Validate the form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedMode == LoginMode.mobile) {
      // Navigate to OTP screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPScreen(
            phoneNumber: '+91${_controller.mobileController.text}',
          ),
        ),
      );
    } else {
      _controller.loginApi(context, showSuccessPopup: true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ई-मेल लॉगिन प्रक्रिया...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF003366),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title:  Text(
          'लॉगिन करा',
          style: GoogleFonts.karma(color: Colors.white, fontSize: 18),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Radio buttons for mode selection
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<LoginMode>(
                        contentPadding: EdgeInsets.zero,
                        title:  Text(
                          'मोबाईल नंबर',
                          style: GoogleFonts.karma(fontSize: 14),
                        ),
                        value: LoginMode.mobile,
                        groupValue: _selectedMode,
                        activeColor: const Color(0xFFD81B60),
                        onChanged: (LoginMode? value) {
                          setState(() {
                            _selectedMode = value!;
                            _formKey.currentState?.reset();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<LoginMode>(
                        contentPadding: EdgeInsets.zero,
                        title:  Text(
                          'ई-मेल आयडी',
                          style: GoogleFonts.karma(fontSize: 14),
                        ),
                        value: LoginMode.email,
                        groupValue: _selectedMode,
                        activeColor: const Color(0xFFD81B60),
                        onChanged: (LoginMode? value) {
                          setState(() {
                            _selectedMode = value!;
                            _formKey.currentState?.reset();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Description text
                if (_selectedMode == LoginMode.mobile)
                   Text(
                    'लॉगिन करण्यासाठी तुमचा नोंदणीकृत मोबाईल नंबर टाकून ओटीपी घ्या पासवर्ड सह लॉगिन करा.',
                    style: GoogleFonts.karma(fontSize: 13, color: Colors.black54),
                  )
                else
                   Text(
                    'तुमचा नोंदणीकृत ई-मेल आयडी घेवे टाका.',
                    style: GoogleFonts.karma(fontSize: 13, color: Colors.black54),
                  ),
                const SizedBox(height: 25),

                // Input fields based on selected mode
                if (_selectedMode == LoginMode.mobile) ...[
                  // Mobile number field
                   Text(
                    'मोबाईल नंबर *',
                    style: GoogleFonts.karma(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child:  Text(
                            '+91',
                            style: GoogleFonts.karma(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _controller.mobileController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 15,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'कृपया मोबाईल नंबर टाका';
                              }
                              if (value.length != 10) {
                                return 'मोबाईल नंबर 10 अंकी असावा';
                              }
                              if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                return 'फक्त संख्या वापरा';
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.phone_outlined, color: Colors.grey[400]),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                   Text(
                    'तुमचा नोंदणीकृत मोबाईल नंबर येथे टाका.',
                    style: GoogleFonts.karma(fontSize: 12, color: Colors.black45),
                  ),
                ] else ...[
                  // Email field
                   Text(
                    'ई-मेल आयडी *',
                    style: GoogleFonts.karma(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: TextFormField(
                      controller: _controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                        suffixIcon: Icon(Icons.email_outlined, color: Colors.grey[400]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'कृपया ई-मेल आयडी टाका';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'वैध ई-मेल आयडी टाका';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                   Text(
                    'तुमचा नोंदणीकृत ई-मेल आयडी येथे टाका.',
                    style: GoogleFonts.karma(fontSize: 12, color: Colors.black45),
                  ),
                  const SizedBox(height: 25),

                  // Password field
                   Text(
                    'पासवर्ड *',
                    style: GoogleFonts.karma(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: TextFormField(
                      controller: _controller.passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.grey[400],
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'कृपया पासवर्ड टाका';
                        }
                        if (value.length < 6) {
                          return 'पासवर्ड किमान 6 अक्षरांचा असावा';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle forgot password
                      },
                      child:  Text(
                        'पासवर्ड विसरलात का?',
                        style: GoogleFonts.karma(
                          color: Color(0xFFD81B60),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 30),

                // Login button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD81B60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      _selectedMode == LoginMode.mobile ? 'ओटीपी पाठवा' : 'लॉगिन करा',
                      style:  GoogleFonts.karma(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Divider with text
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[400])),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'किंवा',
                        style: GoogleFonts.karma(color: Colors.grey[600], fontSize: 13),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey[400])),
                  ],
                ),

                const SizedBox(height: 20),

                // Alternative login button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _selectedMode = _selectedMode == LoginMode.mobile
                            ? LoginMode.email
                            : LoginMode.mobile;
                        _formKey.currentState?.reset();
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFD81B60), width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      _selectedMode == LoginMode.mobile
                          ? 'पासवर्ड सह लॉगिन करा'
                          : 'ओटीपी सह लॉगिन करा',
                      style: GoogleFonts.karma(
                        fontSize: 16,
                        color: Color(0xFFD81B60),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'तुम्ही नवीन सदस्य आहात का? ',
                      style: GoogleFonts.karma(fontSize: 13, color: Colors.black54),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child:  Text(
                        'विनामूल्य नोंदणी करा',
                        style: GoogleFonts.karma(
                          fontSize: 13,
                          color: Color(0xFFD81B60),
                          fontWeight: FontWeight.w500,
                        ),
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
}

// OTP Screen
class OTPScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  bool _isOTPComplete() {
    return _otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  void _handleLogin() {
    if (!_isOTPComplete()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('कृपया सर्व ओटीपी अंक टाका'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String otp = _otpControllers.map((c) => c.text).join();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('OTP सत्यापित करत आहे: $otp')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF003366),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title:  Text(
          'लॉगिन करा',
          style: GoogleFonts.karma(color: Colors.white, fontSize: 18),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Radio buttons (disabled on OTP screen)
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Radio<bool>(
                          value: true,
                          groupValue: true,
                          activeColor: const Color(0xFFD81B60),
                          onChanged: null,
                        ),
                         Text(
                          'मोबाईल नंबर',
                          style: GoogleFonts.karma(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Radio<bool>(
                          value: false,
                          groupValue: true,
                          onChanged: null,
                        ),
                         Text(
                          'ई-मेल आयडी',
                          style: GoogleFonts.karma(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Mobile number display
               Text(
                'मोबाईल नंबर',
                style: GoogleFonts.karma(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.phoneNumber,
                        style:  GoogleFonts.karma(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(Icons.phone_outlined, color: Colors.grey[400]),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // OTP message
               Text(
                'ओटीपी टाका *',
                style: GoogleFonts.karma(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              // OTP input fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 60,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: TextField(
                        controller: _otpControllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style:  GoogleFonts.karma(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 3) {
                            _focusNodes[index + 1].requestFocus();
                          } else if (value.isEmpty && index > 0) {
                            _focusNodes[index - 1].requestFocus();
                          }
                          setState(() {}); // Update button state
                        },
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),
               Text(
                'तुमचा नोंदणीकृत मोबाईल नंबरवर पाठवलेली ओटीपी येथे टाका.',
                style: GoogleFonts.karma(fontSize: 12, color: Colors.black45),
              ),
              const SizedBox(height: 40),

              // Login button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isOTPComplete()
                        ? const Color(0xFFD81B60)
                        : Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child:  Text(
                    'लॉगिन करा',
                    style: GoogleFonts.karma(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Divider with text
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[400])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'किंवा',
                      style: GoogleFonts.karma(color: Colors.grey[600], fontSize: 13),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey[400])),
                ],
              ),

              const SizedBox(height: 20),

              // Alternative login button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFD81B60), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child:  Text(
                    'पासवर्ड सह लॉगिन करा',
                    style: GoogleFonts.karma(
                      fontSize: 16,
                      color: Color(0xFFD81B60),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Sign up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    'तुम्ही नवीन सदस्य आहात का? ',
                    style: GoogleFonts.karma(fontSize: 13, color: Colors.black54),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                    child:  Text(
                      'विनामूल्य नोंदणी करा',
                      style: GoogleFonts.karma(
                        fontSize: 13,
                        color: Color(0xFFD81B60),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}