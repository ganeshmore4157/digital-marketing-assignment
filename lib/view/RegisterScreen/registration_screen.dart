import 'package:digital_marketing_assignment/view/LoginPage/login_screen.dart';
import 'package:flutter/material.dart';

enum LoginMode { mobile, email }

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();
  
  String _selectedCountryCode = '+91';
  String _selectedDay = 'DD';
  String _selectedMonth = 'MM';
  String _selectedYear = 'YYYY';
  String _selectedSubCast = 'Select Sub Cast';
  String _selectedGender = 'Male';
  String _selectedProfileFor = 'My Self';
  bool _obscurePassword = true;

  // Error messages for dropdowns
  String? _dobError;
  String? _subCastError;

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateDropdowns() {
    bool isValid = true;

    // Validate Date of Birth
    if (_selectedDay == 'DD' || _selectedMonth == 'MM' || _selectedYear == 'YYYY') {
      setState(() {
        _dobError = 'Please select complete date of birth';
      });
      isValid = false;
    } else {
      setState(() {
        _dobError = null;
      });
    }

    // Validate Sub Cast
    if (_selectedSubCast == 'Select Sub Cast') {
      setState(() {
        _subCastError = 'Please select your sub cast';
      });
      isValid = false;
    } else {
      setState(() {
        _subCastError = null;
      });
    }

    return isValid;
  }

  void _handleRegistration() {
    // Clear previous dropdown errors
    setState(() {
      _dobError = null;
      _subCastError = null;
    });

    // Validate form and dropdowns
    bool formValid = _formKey.currentState!.validate();
    bool dropdownsValid = _validateDropdowns();

    if (formValid && dropdownsValid) {
      // Handle successful registration
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all mandatory fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label *',
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              suffixIcon: suffixIcon,
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    bool showError = false,
    String? errorMessage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label *',
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: showError && errorMessage != null
                  ? Colors.red
                  : Colors.grey[300]!,
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            ),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: const TextStyle(fontSize: 14)),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
        if (showError && errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 12),
            child: Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text(
              'Login',
              style: TextStyle(
                color: Color(0xFFD81B60),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top illustration with text
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  // Illustration
                  Center(
                    child: Image.asset("assets/register.png", height: 150),
                  ),
                  const SizedBox(height: 20),
                  // Text
                  const Text(
                    'Your story is waiting',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Text(
                    'to happen!!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Create Your Profile here..',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            // Form section
            Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // First Name
                    _buildTextField(
                      label: 'First Name',
                      hint: 'Enter First Name',
                      controller: _firstNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter first name';
                        }
                        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                          return 'Please enter valid name (letters only)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Middle Name
                    _buildTextField(
                      label: 'Middle Name',
                      hint: 'Enter Middle Name',
                      controller: _middleNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter middle name';
                        }
                        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                          return 'Please enter valid name (letters only)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Last Name
                    _buildTextField(
                      label: 'Last Name',
                      hint: 'Enter Last Name',
                      controller: _lastNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter last name';
                        }
                        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                          return 'Please enter valid name (letters only)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Email ID
                    _buildTextField(
                      label: 'Email ID',
                      hint: 'Enter Email ID',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email ID';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter valid email ID';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Mobile Number
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mobile Number *',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: _selectedCountryCode,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 12,
                                  ),
                                ),
                                items: ['+91', '+1', '+44'].map((String code) {
                                  return DropdownMenuItem<String>(
                                    value: code,
                                    child: Text(code,
                                        style: const TextStyle(fontSize: 14)),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCountryCode = value!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: TextFormField(
                                  controller: _mobileController,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Mobile Number',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14,
                                    ),
                                    border: InputBorder.none,
                                    counterText: '',
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 15,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter mobile number';
                                    }
                                    if (value.length != 10) {
                                      return 'Mobile number must be 10 digits';
                                    }
                                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                      return 'Please enter valid mobile number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Date of Birth
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Enter Date of Birth *',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _dobError != null
                                        ? Colors.red
                                        : Colors.grey[300]!,
                                  ),
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: _selectedDay,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 12,
                                    ),
                                  ),
                                  items: [
                                    'DD',
                                    ...List.generate(31, (i) => '${i + 1}')
                                  ].map((String day) {
                                    return DropdownMenuItem<String>(
                                      value: day,
                                      child: Text(day,
                                          style: const TextStyle(fontSize: 14)),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedDay = value!;
                                      _dobError = null;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _dobError != null
                                        ? Colors.red
                                        : Colors.grey[300]!,
                                  ),
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: _selectedMonth,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 12,
                                    ),
                                  ),
                                  items: [
                                    'MM',
                                    ...List.generate(12, (i) => '${i + 1}')
                                  ].map((String month) {
                                    return DropdownMenuItem<String>(
                                      value: month,
                                      child: Text(month,
                                          style: const TextStyle(fontSize: 14)),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedMonth = value!;
                                      _dobError = null;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _dobError != null
                                        ? Colors.red
                                        : Colors.grey[300]!,
                                  ),
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: _selectedYear,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 12,
                                    ),
                                  ),
                                  items: [
                                    'YYYY',
                                    ...List.generate(
                                      80,
                                      (i) => '${2024 - i}',
                                    )
                                  ].map((String year) {
                                    return DropdownMenuItem<String>(
                                      value: year,
                                      child: Text(year,
                                          style: const TextStyle(fontSize: 14)),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedYear = value!;
                                      _dobError = null;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (_dobError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 12),
                            child: Text(
                              _dobError!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Select Sub Cast
                    _buildDropdown(
                      label: 'Select Your Sub Cast',
                      value: _selectedSubCast,
                      items: [
                        'Select Sub Cast',
                        'Maratha',
                        'Kunbi',
                        '96K Kokanastha',
                        'Deshastha',
                        'Other'
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedSubCast = value!;
                          _subCastError = null;
                        });
                      },
                      showError: _subCastError != null,
                      errorMessage: _subCastError,
                    ),
                    const SizedBox(height: 20),

                    // Gender Selection
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Gender *',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedGender = 'Male';
                                  });
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: _selectedGender == 'Male'
                                          ? const Color(0xFFD81B60)
                                          : Colors.grey[300]!,
                                      width: _selectedGender == 'Male' ? 2 : 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Radio<String>(
                                        value: 'Male',
                                        groupValue: _selectedGender,
                                        activeColor: const Color(0xFFD81B60),
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedGender = value!;
                                          });
                                        },
                                      ),
                                      const Text(
                                        'Male',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedGender = 'Female';
                                  });
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: _selectedGender == 'Female'
                                          ? const Color(0xFFD81B60)
                                          : Colors.grey[300]!,
                                      width:
                                          _selectedGender == 'Female' ? 2 : 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Radio<String>(
                                        value: 'Female',
                                        groupValue: _selectedGender,
                                        activeColor: const Color(0xFFD81B60),
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedGender = value!;
                                          });
                                        },
                                      ),
                                      const Text(
                                        'Female',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Profile Created For
                    _buildDropdown(
                      label: 'Profile created for',
                      value: _selectedProfileFor,
                      items: [
                        'My Self',
                        'Son',
                        'Daughter',
                        'Brother',
                        'Sister',
                        'Friend',
                        'Relative'
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedProfileFor = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    // Password
                    _buildTextField(
                      label: 'Enter Your Password',
                      hint: 'Password',
                      controller: _passwordController,
                      obscureText: _obscurePassword,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _handleRegistration,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD81B60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'REGISTER NOW',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}