import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../theme.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final List<String> _digits = ['', '', '', ''];
  String? _error;

  // keypad is constructed explicitly in the widget tree below; no field required

  void _pressDigit(String digit) {
    final index = _digits.indexOf('');
    if (index == -1) return;
    setState(() => _digits[index] = digit);

    if (index == 3) {
      _tryLogin(_digits.join());
    }
  }

  void _backspace() {
    for (int i = _digits.length - 1; i >= 0; i--) {
      if (_digits[i] != '') {
        setState(() => _digits[i] = '');
        break;
      }
    }
  }

  void _tryLogin(String pin) {
    if (context.read<AuthService>().verifyPin(pin)) {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    } else {
      setState(() => _error = 'Code secret invalide.');
      Future.delayed(const Duration(milliseconds: 800), () {
        if (!mounted) return;
        setState(() {
          _digits.setAll(0, ['', '', '', '']);
          _error = null;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: 'Orange ',
                      style: TextStyle(color: OmTheme.orange),
                    ),
                    TextSpan(text: 'Money'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: 'Transférer ',
                      style: TextStyle(color: OmTheme.orange),
                    ),
                    TextSpan(text: 'de l\'argent'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "SMS d'authentification vérifié ! Veuillez saisir votre code secret Orange Money !",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _digits.map((d) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: OmTheme.orange.withOpacity(d.isEmpty ? 0.25 : 1),
                    ),
                  );
                }).toList(),
              ),
              if (_error != null) ...[
                const SizedBox(height: 8),
                Text(
                  _error!,
                  style: const TextStyle(color: Colors.redAccent, fontSize: 13),
                ),
              ],
              const SizedBox(height: 24),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _KeypadButton(label: '1', onTap: () => _pressDigit('1')),
                      _KeypadButton(label: '2', onTap: () => _pressDigit('2')),
                      _KeypadButton(label: '3', onTap: () => _pressDigit('3')),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _KeypadButton(label: '4', onTap: () => _pressDigit('4')),
                      _KeypadButton(label: '5', onTap: () => _pressDigit('5')),
                      _KeypadButton(label: '6', onTap: () => _pressDigit('6')),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _KeypadButton(label: '7', onTap: () => _pressDigit('7')),
                      _KeypadButton(label: '8', onTap: () => _pressDigit('8')),
                      _KeypadButton(label: '9', onTap: () => _pressDigit('9')),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 68, height: 68),
                      _KeypadButton(label: '0', onTap: () => _pressDigit('0')),
                      _KeypadButton(
                        label: '⌫',
                        filled: true,
                        onTap: _backspace,
                      ),
                    ],
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

class _KeypadButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool filled;

  const _KeypadButton({
    required this.label,
    required this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: filled ? OmTheme.orange : OmTheme.card,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: filled ? const Color(0xFF1A1A1A) : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
