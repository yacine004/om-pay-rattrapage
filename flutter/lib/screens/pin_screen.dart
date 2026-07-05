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

  static const _keypad = ['2', '4', '8', '7', '3', '0', '6', '5', '1', '9'];

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
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  children: [
                    TextSpan(text: 'Orange ', style: TextStyle(color: OmTheme.orange)),
                    TextSpan(text: 'Money'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  children: [
                    TextSpan(text: 'Transférer ', style: TextStyle(color: OmTheme.orange)),
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
                Text(_error!, style: const TextStyle(color: Colors.redAccent, fontSize: 13)),
              ],
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ..._keypad.map((key) => _KeypadButton(label: key, onTap: () => _pressDigit(key))),
                    const SizedBox.shrink(),
                    _KeypadButton(label: '⌫', filled: true, onTap: _backspace),
                  ],
                ),
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

  const _KeypadButton({required this.label, required this.onTap, this.filled = false});

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
