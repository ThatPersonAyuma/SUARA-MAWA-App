import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suara_mawa/screens/auth/controller/auth_service.dart';
import 'package:suara_mawa/utils/app_colors.dart';
import 'package:suara_mawa/utils/photo_galery.dart';
import 'package:suara_mawa/utils/user_controller.dart';
import 'package:suara_mawa/widgets/shared_main_screen.dart';

class UpdateProfilePage extends ConsumerStatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  ConsumerState<UpdateProfilePage> createState() {
    return _UpdateProfilePageState();
  }
}

class _UpdateProfilePageState extends ConsumerState<UpdateProfilePage> {
  File? selectedImage;
  final _formKey = GlobalKey<FormState>();
  final idPhoneRegex = RegExp(r'^(\+62|62|0)8[1-9][0-9]{7,11}$');
  final textStyle = const TextStyle(color: Colors.black, fontSize: 16);
  final errorStyle = const TextStyle(color: Colors.red, fontSize: 16);
  late final TextEditingController nomorHPController;
  late final TextEditingController? nimController;
  late final TextEditingController? nikController;
  late final UserModel userModel;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    File? image = await pickImage(context);
    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    userModel = ref.read(userControllerProvider);
    final initialValue = userModel.user?.phoneNumber ?? '';
    nomorHPController = TextEditingController(text: initialValue);

    if (userModel.mahasiswaDetail != null) {
      nimController = TextEditingController(text: userModel.mahasiswaDetail?.nim ?? '');
    } else {
      nimController = null;
    }

    if (userModel.penindakDetail != null) {
      nikController = TextEditingController(text: userModel.penindakDetail?.nik ?? '');
    } else if (userModel.adminDetail != null) {
      nikController = TextEditingController(text: userModel.adminDetail?.nik ?? '');
    } else {
      nikController = null;
    }
  }

  @override
  void dispose() {
    nomorHPController.dispose();
    nimController?.dispose();
    nikController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(ref),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color.fromARGB(170, 0, 0, 0),
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(45),
                            child: selectedImage != null
                                ? Image.file(
                                    selectedImage!,
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                      "${const String.fromEnvironment('SERVER_BASE_URL', defaultValue: '')}/users/${ref.watch(userControllerProvider.select((um) => um.user?.name))}/profile/photo",
                                      headers: {
                                        'Authorization':
                                            "Bearer ${ref.watch(userControllerProvider.select((um) => um.token))}",
                                      },
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        TextButton(
                          onPressed: _pickImage,
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blue,
                            textStyle: const TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          child: const Text("Edit"),
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          style: textStyle,
                          inputFormatters: [
                            TextInputFormatter.withFunction((oldValue, newValue) {
                              if (RegExp(
                                r'^\+?[0-9]*$',
                              ).hasMatch(newValue.text)) {
                                return newValue;
                              }
                              return oldValue;
                            }),
                          ],
                          decoration: InputDecoration(
                            hintStyle: textStyle,
                            hintText: 'Nomor Telepon',
                            labelStyle: textStyle,
                            labelText: 'Nomor Telepon',
                            errorStyle: errorStyle,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          ),
                          controller: nomorHPController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan nomor telepon';
                            }
                            if (!idPhoneRegex.hasMatch(value)) {
                              return 'Cek kembali nomor telepon';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        if (userModel.mahasiswaDetail != null)
                          MahasiswaDetailForm(controller: nimController!),
                        if (userModel.penindakDetail != null)
                          PenindakDetailForm(controller: nikController!),
                        if (userModel.adminDetail != null)
                          AdminDetailForm(controller: nikController!),
                        
                        const SizedBox(height: 20),
                        
                        SizedBox(
                          width: double.infinity, // Expands to full available width
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() => _isLoading = true);
                                      try {
                                        final authService = AuthService();

                                        // 1. Upload Profile Photo if selected
                                        if (selectedImage != null) {
                                          final (success, message) =
                                              await authService.uploadProfilePhoto(selectedImage!);
                                          if (!success) {
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    message ?? 'Gagal mengunggah foto profil',
                                                  ),
                                                ),
                                              );
                                            }
                                            return;
                                          }
                                          // Evict cached image to force refresh on load
                                          final imageUrl = "${const String.fromEnvironment('SERVER_BASE_URL', defaultValue: '')}/users/${userModel.user?.name}/profile/photo";
                                          await NetworkImage(
                                            imageUrl,
                                            headers: {
                                              'Authorization': "Bearer ${userModel.token}",
                                            },
                                          ).evict();
                                        }

                                        // 2. Update Phone Number if it has changed
                                        final currentPhone = userModel.user?.phoneNumber ?? '';
                                        final newPhone = nomorHPController.text.trim();
                                        if (newPhone != currentPhone) {
                                          final (success, message) =
                                              await authService.appendNomorHP(newPhone);
                                          if (!success) {
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    message ?? 'Gagal memperbarui nomor telepon',
                                                  ),
                                                ),
                                              );
                                            }
                                            return;
                                          }
                                        }

                                        // 3. Refresh user state
                                        final (refreshSuccess, refreshMessage) =
                                            await authService.checkAuth(ref);
                                        if (context.mounted) {
                                          if (refreshSuccess) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Profil berhasil diperbarui'),
                                              ),
                                            );
                                            Navigator.pop(context);
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Profil diperbarui, namun gagal menyelaraskan data: $refreshMessage',
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      } catch (e) {
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Terjadi kesalahan: $e'),
                                            ),
                                          );
                                        }
                                      } finally {
                                        if (mounted) {
                                          setState(() => _isLoading = false);
                                        }
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,     // Background color
                              foregroundColor: Colors.white,    // Text and icon color
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text("Perbarui", style: TextStyle()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IdentityTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const IdentityTextField({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label wajib diisi';
        }
        return null;
      },
    );
  }
}

class MahasiswaDetailForm extends StatelessWidget {
  final TextEditingController controller;
  const MahasiswaDetailForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.black54, fontSize: 16);
    return TextFormField(
      style: textStyle,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(
        hintStyle: textStyle,
        hintText: 'NIM',
        labelStyle: textStyle,
        labelText: 'NIM (Tidak dapat diubah)',
        errorStyle: TextStyle(color: Colors.red, fontSize: 16),
        filled: true,
        fillColor: Color(0xFFF0F2F5),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2.0),
        ),
      ),
      controller: controller,
      readOnly: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkan NIM';
        }
        return null;
      },
    );
  }
}

class PenindakDetailForm extends StatelessWidget {
  final TextEditingController controller;
  const PenindakDetailForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return IdentityTextField(controller: controller, label: 'NIK');
  }
}

class AdminDetailForm extends StatelessWidget {
  final TextEditingController controller;
  const AdminDetailForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return IdentityTextField(controller: controller, label: 'NIK');
  }
}
