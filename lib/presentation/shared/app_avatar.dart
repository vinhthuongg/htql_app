import 'dart:io';

import 'package:flutter/material.dart';
import 'package:htql_app/presentation/theme/app_color.dart';
import 'package:htql_app/services/avatar_storage_service.dart';

class AppAvatar extends StatefulWidget {
  const AppAvatar({
    super.key,
    required this.size,
    this.avatarFileName,
    this.borderWidth = 2,
  });

  final double size;
  final String? avatarFileName;
  final double borderWidth;

  @override
  State<AppAvatar> createState() => _AppAvatarState();
}

class _AppAvatarState extends State<AppAvatar> {
  Future<File?>? _avatarFuture;

  @override
  void initState() {
    super.initState();
    _syncAvatarFuture();
  }

  @override
  void didUpdateWidget(covariant AppAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.avatarFileName != widget.avatarFileName) {
      _syncAvatarFuture();
    }
  }

  void _syncAvatarFuture() {
    final avatarFileName = _avatarFileName;
    _avatarFuture = avatarFileName == null
        ? null
        : AvatarStorageService.instance.cacheAvatar(avatarFileName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      padding: EdgeInsets.all(widget.borderWidth),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColor.toyotaRed,
          width: widget.borderWidth,
        ),
      ),
      child: ClipOval(
        child: _avatarFuture == null
            ? _FallbackAvatar(size: widget.size)
            : FutureBuilder<File?>(
                future: _avatarFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return _AvatarLoader(size: widget.size);
                  }

                  final file = snapshot.data;
                  if (file == null) return _FallbackAvatar(size: widget.size);

                  return Image.file(
                    file,
                    width: widget.size,
                    height: widget.size,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _FallbackAvatar(size: widget.size);
                    },
                  );
                },
              ),
      ),
    );
  }

  String? get _avatarFileName {
    final fileName = widget.avatarFileName?.trim();
    if (fileName == null || fileName.isEmpty) return null;

    return fileName;
  }
}

class _FallbackAvatar extends StatelessWidget {
  const _FallbackAvatar({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: AppColor.white,
      child: Icon(Icons.person, color: AppColor.lightGrey, size: size * 0.58),
    );
  }
}

class _AvatarLoader extends StatelessWidget {
  const _AvatarLoader({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: AppColor.mutedCardColor(context),
      child: Center(
        child: SizedBox(
          width: size * 0.26,
          height: size * 0.26,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColor.toyotaRed,
          ),
        ),
      ),
    );
  }
}
