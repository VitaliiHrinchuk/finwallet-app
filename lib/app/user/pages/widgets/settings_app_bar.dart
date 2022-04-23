import 'package:finwallet_app/app/auth/bloc/auth/auth_bloc.dart';
import 'package:finwallet_app/common/widgets/app_bar/gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    return GradientAppBar(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Settings",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 10),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                String email = state is AuthAuthenticated ? state.user.email : '';
                return Text(
                  email,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                );
              },
            )
          ],
        ),
        firstColor: Color(0xFFFEB692),
        secondColor: Color(0xFFEA5455)
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}
