import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/services/theme_service.dart';
import 'dart:convert';
import 'chat.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  //final _otpController = TextEditingController();

  bool _isLoading = false;

  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasSpecialChar = false;
  bool _showPasswordRequirements = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
  }

  void _validatePassword() {
    final password = _passwordController.text;
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasLowercase = password.contains(RegExp(r'[a-z]'));
      _hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      _showPasswordRequirements = password.isNotEmpty;
    });
  }

  bool _isPasswordValid() {
    return _hasMinLength && _hasUppercase && _hasLowercase && _hasSpecialChar;
  }

  // Replace this with your backend signup API URL
  final String _signupUrl = "http://localhost:8080/signup";

  Future<void> _signUpUser() async {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    //final otp = _otpController.text.trim();

    // Input validation
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showSnackBar("Please fill in all fields");
      return;
    }

    if (!_isPasswordValid()) {
      _showSnackBar("Password does not meet requirements");
      return;
    }

    if (password != confirmPassword) {
      _showSnackBar("Passwords do not match");
      return;
    }

    // if (otp.isEmpty) {
    //   _showSnackBar("Please enter OTP");
    //   return;
    // }

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse(_signupUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "firstName": _firstNameController.text.trim(),
          "lastName": _lastNameController.text.trim(),
          "email": email,
          "password": password,
          //"otp": otp,
        }),
      );

      setState(() => _isLoading = false);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["success"] == true) {
          _showSnackBar("Signup Successful!");

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ChatScreen()),
          );
        } else {
          _showSnackBar(data["message"] ?? "Signup failed");
        }
      } else {
        _showSnackBar("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar("Error connecting to server");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeService.currentTheme;
    final txtColor = ThemeService.getTextColor(theme);
    final inputColor = ThemeService.getInputColor(theme);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: ThemeService.getGradient(theme)),

        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/logo.svg', height: 80),
                const SizedBox(height: 32),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: txtColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                //First Name Field
                TextField(
                  controller: _firstNameController,
                  style: TextStyle(
                    color:
                        theme == AppTheme.light ||
                            theme == AppTheme.valentine ||
                            theme == AppTheme.aqua
                        ? Colors.black
                        : Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter first name',
                    filled: true,
                    fillColor: inputColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: const TextStyle(color: Color(0xFF888888)),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Last Name Field
                TextField(
                  controller: _lastNameController,
                  style: TextStyle(
                    color:
                        theme == AppTheme.light ||
                            theme == AppTheme.valentine ||
                            theme == AppTheme.aqua
                        ? Colors.black
                        : Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter last name',
                    filled: true,
                    fillColor: inputColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: const TextStyle(color: Color(0xFF888888)),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Email Field
                TextField(
                  controller: _emailController,
                  style: TextStyle(
                    color:
                        theme == AppTheme.light ||
                            theme == AppTheme.valentine ||
                            theme == AppTheme.aqua
                        ? Colors.black
                        : Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter email',
                    filled: true,
                    fillColor: inputColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: const TextStyle(color: Color(0xFF888888)),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Password Field
                TextField(
                  controller: _passwordController,
                  style: TextStyle(
                    color:
                        theme == AppTheme.light ||
                            theme == AppTheme.valentine ||
                            theme == AppTheme.aqua
                        ? Colors.black
                        : Colors.white,
                  ),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Set Password',
                    filled: true,
                    fillColor: inputColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: const TextStyle(color: Color(0xFF888888)),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                if (_showPasswordRequirements) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: inputColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password Requirements:',
                          style: TextStyle(
                            color: txtColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),

                        _buildRequirement(
                          'At least 8 characters',
                          _hasMinLength,
                          txtColor,
                        ),
                        _buildRequirement(
                          'One uppercase letter (A-Z)',
                          _hasUppercase,
                          txtColor,
                        ),
                        _buildRequirement(
                          'One lowercase letter (a-z)',
                          _hasLowercase,
                          txtColor,
                        ),
                        _buildRequirement(
                          'One special character (!@#\$%^&*)',
                          _hasSpecialChar,
                          txtColor,
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                // Confirm Password Field
                TextField(
                  controller: _confirmPasswordController,
                  style: TextStyle(
                    color:
                        theme == AppTheme.light ||
                            theme == AppTheme.valentine ||
                            theme == AppTheme.aqua
                        ? Colors.black
                        : Colors.white,
                  ),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    filled: true,
                    fillColor: inputColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: const TextStyle(color: Color(0xFF888888)),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // OTP Field
                // TextField(
                //   controller: _otpController,
                //   style: TextStyle(
                //     color:
                //         theme == AppTheme.light ||
                //             theme == AppTheme.valentine ||
                //             theme == AppTheme.aqua
                //         ? Colors.black
                //         : Colors.white,
                //   ),
                //   decoration: InputDecoration(
                //     hintText: 'Enter OTP',
                //     filled: true,
                //     fillColor: inputColor,
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(25),
                //       borderSide: BorderSide.none,
                //     ),
                //     hintStyle: const TextStyle(color: Color(0xFF888888)),
                //     contentPadding: const EdgeInsets.symmetric(
                //       horizontal: 24,
                //       vertical: 16,
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 24),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _signUpUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeService.getButtonColor(theme),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'SIGN UP',
                            style: TextStyle(
                              color:
                                  theme == AppTheme.cyberpunk ||
                                      theme == AppTheme.forest
                                  ? Colors.black87
                                  : Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 48),

                Text(
                  'T&C',
                  style: TextStyle(
                    color: txtColor.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.removeListener(_validatePassword);
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    //_otpController.dispose();
    super.dispose();
  }

  Widget _buildRequirement(String text, bool isMet, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.cancel,
            size: 18,
            color: isMet ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: textColor.withOpacity(0.9), fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
