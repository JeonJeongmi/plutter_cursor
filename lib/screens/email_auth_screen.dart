import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class EmailAuthScreen extends StatefulWidget {
  @override
  _EmailAuthScreenState createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _verificationCodeController = TextEditingController();
  bool _isEmailSent = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _verificationCodeController.dispose();
    super.dispose();
  }

  void _sendVerificationCode() async {
    if (_emailController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      
      try {
        bool success = await AuthService.sendVerificationCode(_emailController.text);
        
        setState(() {
          _isLoading = false;
        });
        
        if (success) {
          setState(() {
            _isEmailSent = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('인증코드가 이메일로 전송되었습니다.'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('인증코드 전송에 실패했습니다.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('오류가 발생했습니다: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _verifyCode() async {
    if (_verificationCodeController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      
      try {
        bool success = await AuthService.verifyCode(
          _emailController.text,
          _verificationCodeController.text,
        );
        
        setState(() {
          _isLoading = false;
        });
        
        if (success) {
          // 인증 성공 시 로그인 처리
          final authResponse = await AuthService.signInWithEmail(_emailController.text);
          
          if (authResponse != null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('로그인에 실패했습니다.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('인증코드가 올바르지 않습니다.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('오류가 발생했습니다: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '로그인',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              
              // Instagram 로고
              SvgPicture.asset(
                'assets/images/instagram_logo.svg',
                height: 50,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).brightness == Brightness.dark 
                    ? Colors.white 
                    : Colors.black, 
                  BlendMode.srcIn
                ),
              ),
              
              const SizedBox(height: 40),
              
              // 이메일 입력 필드
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerTheme.color ?? Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: '이메일',
                    hintStyle: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    border: InputBorder.none,
                  ),
                ),
              ),
              
              const SizedBox(height: 12),
              
              // 인증코드 입력 필드 (이메일 전송 후에만 표시)
              if (_isEmailSent) ...[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).dividerTheme.color ?? Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextField(
                    controller: _verificationCodeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '인증코드 6자리',
                      hintStyle: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
              ],
              
              const SizedBox(height: 20),
              
              // 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : (_isEmailSent ? _verifyCode : _sendVerificationCode),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0095F6),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          _isEmailSent ? '로그인' : '인증코드 전송',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // 안내 텍스트
              Text(
                _isEmailSent
                    ? '이메일로 받은 6자리 인증코드를 입력해주세요.'
                    : '이메일을 입력하면 인증코드가 전송됩니다.',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
