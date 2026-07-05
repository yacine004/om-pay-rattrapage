import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  String? _error;

  void _onSubmit() {
    setState(() => _error = null);
    try {
      context.read<AuthService>().requestOtp(_phoneController.text.trim());
      Navigator.of(context).pushNamed('/otp');
    } catch (e) {
      setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  children: [
                    TextSpan(text: 'Orange ', style: TextStyle(color: OmTheme.orange)),
                    TextSpan(text: 'Money'),
                  ],
                ),
              ),
              const Spacer(),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  children: [
                    TextSpan(text: 'Transférer ', style: TextStyle(color: OmTheme.orange)),
                    TextSpan(text: 'de l\'argent'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Envoyez rapidement et en toute sécurité de l'argent à un proche qui possède un compte Orange Money.",
                style: TextStyle(color: OmTheme.textMuted, fontSize: 14),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: OmTheme.card,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Bienvenue sur OM Pay !',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                    const SizedBox(height: 4),
                    const Text('Entrez votre numéro mobile pour vous connecter',
                        style: TextStyle(color: OmTheme.textMuted, fontSize: 13)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          decoration: BoxDecoration(
                            color: OmTheme.background,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: OmTheme.border),
                          ),
                          child: const Text('+221', style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 9,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Saisir mon numéro',
                              counterText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 8),
                      Text(_error!, style: const TextStyle(color: Colors.redAccent, fontSize: 13)),
                    ],
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _onSubmit,
                        child: const Text('Se connecter'),
                      ),
                    ),
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
