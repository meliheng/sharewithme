import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/auth/domain/extension/user_extension.dart';
import 'package:sharewithme/auth/presentation/avatar_widget.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/constants/style_constant.dart';
import 'package:sharewithme/user/application/user_cubit/user_cubit.dart';
import 'package:sharewithme/user/application/user_cubit/user_state.dart';

class UserCard extends StatefulWidget {
  final UserEntity userEntity;

  const UserCard({
    super.key,
    required this.userEntity,
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  late UserCubit userCubit;
  @override
  void initState() {
    super.initState();
    userCubit = UserCubit(userEntity: widget.userEntity);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      bloc: userCubit,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.1,
                  blurRadius: 1,
                  offset: const Offset(1, 2),
                ),
              ],
            ),
            height: 80,
            child: Row(
              children: [
                CircularAvatarWithEditIcon(
                  imagePath: widget.userEntity.avatar,
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userEntity.username,
                      style: StyleConstant.kBlackBold18,
                    ),
                    if (!widget.userEntity.isFollower &&
                        widget.userEntity.isFollowing)
                      Text(
                        StringC.kNotFollowYou,
                        style: StyleConstant.kBlack12,
                      )
                  ],
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorConstant.kPrimaryBlue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        spreadRadius: 0.1,
                        blurRadius: 1,
                        offset:
                            const Offset(1, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: const Text(
                    '370',
                    style: StyleConstant.kWhite12,
                  ),
                ),
                const Spacer(),
                if (widget.userEntity.isFollowing)
                  CustomIconButton(
                    icon: Icons.delete,
                    color: Colors.red,
                    onPressed: () {
                      userCubit.unFollow(context);
                    },
                  )
                else
                  CustomIconButton(
                    icon: Icons.add,
                    color: ColorConstant.kPrimaryBlue,
                    onPressed: () {
                      userCubit.follow();
                    },
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
