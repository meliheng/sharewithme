import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/constants/style_constants.dart';

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
  @override
  Widget build(BuildContext context) {
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
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                'https://media.licdn.com/dms/image/D4D03AQE2jB39V6eapQ/profile-displayphoto-shrink_800_800/0/1673728867434?e=1709769600&v=beta&t=5O61Q2CYMQFeyWheBeZ0vtPOoTCkgmzn-JtenmG7dmk',
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "Melo",
              style: StyleContants.blackBold18,
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: ColorConstants.primaryBlue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    spreadRadius: 0.1,
                    blurRadius: 1,
                    offset: const Offset(1, 2), // changes position of shadow
                  ),
                ],
              ),
              child: const Text(
                '370',
                style: StyleContants.white12,
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorConstants.primaryBlue,
              ),
              child: IconButton(
                constraints: const BoxConstraints(),
                color: Colors.white,
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
