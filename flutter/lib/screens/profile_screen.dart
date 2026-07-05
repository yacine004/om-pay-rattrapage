import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _darkMode = true;
  bool _scannerEnabled = true;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 36,
                backgroundColor: OmTheme.card,
                child: Icon(Icons.person, color: OmTheme.textMuted, size: 36),
              ),
              const SizedBox(height: 12),
              Text(auth.currentUser?.fullName ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(auth.currentUser?.phoneNumber ?? '', style: const TextStyle(color: OmTheme.textMuted)),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(color: OmTheme.card, borderRadius: BorderRadius.circular(14)),
                child: Column(
                  children: [
                    _SettingRow(
                      icon: Icons.dark_mode_outlined,
                      label: 'Sombre',
                      value: _darkMode,
                      onChanged: (v) => setState(() => _darkMode = v),
                    ),
                    const Divider(color: OmTheme.border, height: 1),
                    _SettingRow(
                      icon: Icons.qr_code_scanner,
                      label: 'Scanner',
                      value: _scannerEnabled,
                      onChanged: (v) => setState(() => _scannerEnabled = v),
                    ),
                    const Divider(color: OmTheme.border, height: 1),
                    const ListTile(
                      leading: Icon(Icons.language, color: Colors.white),
                      title: Text('Langue', style: TextStyle(color: Colors.white)),
                      trailing: Text('Français', style: TextStyle(color: OmTheme.textMuted)),
                    ),
                    const Divider(color: OmTheme.border, height: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            context.read<AuthService>().logout();
                            Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                          },
                          icon: const Icon(Icons.power_settings_new),
                          label: const Text('Se déconnecter'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Text('OMPAY Version - 1.1.0 (35)', style: TextStyle(color: OmTheme.textMuted, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      trailing: Switch(value: value, activeColor: OmTheme.orange, onChanged: onChanged),
    );
  }
}
