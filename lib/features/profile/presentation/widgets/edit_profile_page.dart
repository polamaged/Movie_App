import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_images.dart';
import 'package:movies_app/core/widgets/custom_Text_form_field_withobs.dart';
import 'package:movies_app/core/widgets/custom_app_bar.dart';
import 'package:movies_app/core/widgets/custom_buttom.dart';
import 'package:movies_app/features/profile/presentation/cubits/edit_profile/editprofile_cubit.dart';
import 'package:movies_app/features/profile/presentation/widgets/avatar_item.dart';
import 'package:movies_app/features/profile/presentation/widgets/circle_avatar.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String selectedAvatar = Assets.imagesAvatar1;

  final List<String> avatars = [
    Assets.imagesAvatar1,
    Assets.imagesAvatar2,
    Assets.imagesAvatar3,
    Assets.imagesAvatar4,
    Assets.imagesAvatar5,
    Assets.imagesAvatar6,
    Assets.imagesAvatar7,
    Assets.imagesAvatar8,
    Assets.imagesAvatar9,
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();


void initState()  {
    super.initState();
  loadUser();
  }

  Future<void> loadUser() async {
  var user = await context.read<EditprofileCubit>().getUserData();

  nameController.text = user.name;
  phoneController.text = user.phoneNumber.toString();
  selectedAvatar = user.avatar;

  setState(() {});
}
  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // مهم للـ Keyboard
      body: BlocListener<EditprofileCubit, EditprofileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            // يرجع UserModels الجديد للصفحة السابقة
            Navigator.pop(context, state.user);
          } else if (state is EditprofileFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomAppBar(title: 'Pick Avatar'),
                SizedBox(height: 37),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: const Color(0xff282A28),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (_) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(24),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                              ),
                          itemCount: avatars.length,
                          itemBuilder: (_, index) {
                            final avatar = avatars[index];
                            return AvatarItem(
                              image: avatar,
                              isSelected: selectedAvatar == avatar,
                              onTap: () {
                                setState(() {
                                  selectedAvatar = avatar;
                                });
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Center(
                    child: CustomCircleAvatar(
                      imagePath: selectedAvatar,
                      radius: 100,
                    ),
                  ),
                ),
                SizedBox(height: 35),
                CustomTextFormFieldWithObs(
                  controller: nameController,
                  obscureText: false,
                  prefixIcon: Icon(Icons.person, color: Colors.white),
                  HintText: 'Ex: John',
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 20),
                CustomTextFormFieldWithObs(
                  controller: phoneController,
                  obscureText: false,
                  prefixIcon: Icon(Icons.phone_sharp, color: Colors.white),
                  HintText: 'Ex: 01000000000',
                  textInputType: TextInputType.phone,
                ),
                SizedBox(height: 30),
                CustomButtom(
                  onPressed: () {
                    
                  },
                  text: 'Delete Account',
                  color: Colors.red,
                  textColor: Colors.white,
                  borderColor: Colors.red,
                ),
                SizedBox(height: 18),
                CustomButtom(
                  onPressed: () {
                    // ابعت البيانات لـ Cubit
                    context.read<EditprofileCubit>().updateProfile(
                      name: nameController.text,
                      phone: phoneController.text,
                      avatar: selectedAvatar,
                    );
                  },
                  text: 'Update Data',
                  color: Color(0xffF6BD00),
                  textColor: Colors.black,
                  borderColor: Color(0xffF6BD00),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


