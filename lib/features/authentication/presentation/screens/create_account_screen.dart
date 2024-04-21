import 'package:attendance_management_app/shared/models/institution_model.dart';
import 'package:attendance_management_app/features/authentication/domain/providers/auth_repo_provider.dart';
import 'package:attendance_management_app/features/authentication/domain/repository/auth_repo.dart';
import 'package:attendance_management_app/features/authentication/presentation/providers/create_user_state_provider.dart';
import 'package:attendance_management_app/features/authentication/presentation/providers/gender_provider.dart';
import 'package:attendance_management_app/features/authentication/presentation/providers/states/user_type_state.dart';
import 'package:attendance_management_app/features/authentication/presentation/providers/title_provider.dart';
import 'package:attendance_management_app/features/authentication/presentation/widgets/title_selection_dialog.dart';
import 'package:attendance_management_app/shared/core/api_endpoints.dart';
import 'package:attendance_management_app/shared/services/dio_service/domain/models/api_exception_model.dart';
import 'package:attendance_management_app/shared/services/dio_service/domain/models/api_response_model.dart';
import 'package:attendance_management_app/shared/services/dio_service/domain/repository/api_service_repo.dart';
import 'package:attendance_management_app/shared/services/dio_service/providers/api_service_provider.dart';
import 'package:attendance_management_app/shared/utilities/toast_utils.dart';
import 'package:attendance_management_app/shared/utilities/validator.dart';
import 'package:attendance_management_app/shared/widgets/custom_text_form_field.dart';
import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../../../shared/widgets/dialogs/loading_dialog.dart';
import '../widgets/gender_selection_dialog.dart';

@RoutePage()
class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  @override
  void initState() {
    super.initState();
    getInstitutes = getInstitutions();
  }

  Future<List<Institution>> getInstitutions() async {
    ApiService api = ref.read(apiServiceMethodsProvider);

    var response = await api.get(ApiEndpoints.institutions, false, null);
    switch (response) {
      case SuccessResponse<Response, ApiException>(value: final institutions):
        var models = (institutions.data as List)
            .map((json) => Institution.fromJson(json))
            .toList();
        return models;

      case ErrorResponse<Response, ApiException>(exception: final _):
        return [];
    }
  }

  late Future<List<Institution>> getInstitutes;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController matricController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController facultyController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  Institution? institution;

  @override
  Widget build(BuildContext context) {
    GenderEnum gender = ref.watch(genderTypeProvider);
    TitleEnum title = ref.watch(titleTypeProvider);
    UserType user = ref.watch(createAccountUserTypeProvider);
    Future signUp(UserType userType) async {
      Map<String, dynamic> data = {
        "title": title.name,
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "user": {
          "username": usernameController.text,
          "email": emailController.text,
          "password": passwordController.text
        },
        "gender": gender.name,
        "phone_number": phoneController.text,
        "institution": institution!.id,
        "faculty": facultyController.text,
        "department": departmentController.text
      };
      if (userType == UserType.student) {
        data["matric_no"] = matricController.text;
      }
      print(data);
      AuthenticationRepository authService = ref.watch(authRepoProvider);
      try {
        LoadingDialog.show(context);
        var _ = await authService.createUser(data, userType);

        if (!mounted) return;
        context.router.pop();

        ToastService.success(
            context, "account created succesfully, login to continue!");
        //print(response);
      } on ErrorResponse catch (exception, _) {
        context.router.pop();

        print(exception.exception);
        ToastService.error(context, exception.exception.error.toString());
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: user == UserType.lecturer
            ? 'Create Lecturer account'
            : 'Create Student account',
        prefixIcon: GestureDetector(
          onTap: () {
            context.router.pop();
          },
          child: const Icon(
            Icons.keyboard_arrow_left_rounded,
            size: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(24),
                const CustomText(
                  title: "Title",
                ),
                verticalSpace(8),
                GestureDetector(
                  onTap: () {
                    SelectTitleDialog.show(context, ref);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.appLight40)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          title: title == TitleEnum.none
                              ? "Select title"
                              : title.name,
                          color: AppColors.appLight100,
                          size: 16,
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                          color: AppColors.appLight100,
                        )
                      ],
                    ),
                  ),
                ),
                verticalSpace(18),
                const CustomText(
                  title: "First Name",
                ),
                verticalSpace(8),
                CustomTextFormField(
                  hintText: "John Doe",
                  validator: (val) => Validator.validateName(val),
                  controller: firstNameController,
                ),
                verticalSpace(18),
                const CustomText(
                  title: "Last Name",
                ),
                verticalSpace(8),
                CustomTextFormField(
                  hintText: "John Doe",
                  validator: (val) => Validator.validateName(val),
                  controller: lastNameController,
                ),
                verticalSpace(18),
                const CustomText(
                  title: "Gender",
                ),
                verticalSpace(8),
                GestureDetector(
                  onTap: () {
                    SelectGenderDialog.show(context, ref);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.appLight40)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          title: gender == GenderEnum.none
                              ? "Select gender"
                              : gender.name,
                          color: AppColors.appLight100,
                          size: 16,
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                          color: AppColors.appLight100,
                        )
                      ],
                    ),
                  ),
                ),
                verticalSpace(18),
                const CustomText(
                  title: "Email",
                ),
                verticalSpace(8),
                CustomTextFormField(
                  hintText: "John Doe",
                  validator: (val) => Validator.validateEmail(val),
                  controller: emailController,
                ),
                verticalSpace(18),
                const CustomText(
                  title: "Phone Number",
                ),
                verticalSpace(8),
                CustomTextFormField(
                  hintText: "John Doe",
                  validator: (val) => Validator.validatePhoneNumber(val),
                  controller: phoneController,
                ),
                verticalSpace(18),
                Visibility(
                    visible: user == UserType.student,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          title: "Matric Number",
                        ),
                        verticalSpace(8),
                        CustomTextFormField(
                          hintText: "John Doe",
                          validator: (val) =>
                              Validator.validateMaxiMin(val, 6, 6),
                          keyboardType: TextInputType.number,
                          controller: matricController,
                        ),
                        verticalSpace(18),
                      ],
                    )),
                const CustomText(
                  title: "Username",
                ),
                verticalSpace(8),
                CustomTextFormField(
                  hintText: "John Doe",
                  validator: (val) => Validator.validateName(val),
                  controller: usernameController,
                ),
                verticalSpace(18),
                const CustomText(
                  title: "Institution",
                ),
                verticalSpace(8),
                DropdownSearch<Institution>(
                  validator: (val) {
                    if (val == null) {
                      return 'Please select an institution';
                    }

                    return null; //
                  },
                  dropdownButtonProps: const DropdownButtonProps(
                      icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: AppColors.medium300,
                  )),
                  popupProps: const PopupProps.modalBottomSheet(
                      title: Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 8),
                        child: CustomText(
                          title: "Institutions",
                          textAlign: TextAlign.center,
                          size: 18,
                          weight: FontWeight.w500,
                        ),
                      ),
                      modalBottomSheetProps: ModalBottomSheetProps()),
                  itemAsString: (Institution u) => u.name!,

                  //dropdownSearchDecoration: InputDecoration(labelText: "Name"),
                  asyncItems: (String filter) async {
                    return getInstitutes;
                  },
                  dropdownBuilder: (context, institution) {
                    return CustomText(
                      title: institution?.name ?? "",
                    );
                  },
                  onChanged: (Institution? data) {
                    institution = data;
                    print(data);
                  },
                ),
                verticalSpace(18),
                const CustomText(
                  title: "Faculty",
                ),
                verticalSpace(8),
                CustomTextFormField(
                  hintText: "Science",
                  validator: (val) => Validator.validateName(val),
                  controller: facultyController,
                ),
                verticalSpace(18),
                const CustomText(
                  title: "Department",
                ),
                verticalSpace(8),
                CustomTextFormField(
                  hintText: "John Doe",
                  validator: (val) => Validator.validateName(val),
                  controller: departmentController,
                ),
                verticalSpace(18),
                const CustomText(
                  title: "Password (for account access)",
                ),
                verticalSpace(8),
                CustomTextFormField(
                  obscureText: true,
                  validator: (val) => Validator.validatePassword(val),
                  controller: passwordController,
                  hintText: "******",
                ),
                verticalSpace(32),
                GeneralButton(
                  buttonText: "Create account",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      // Do something with the validated and saved values
                      if (title == TitleEnum.none) {
                        print("select title");
                      } else if (gender == GenderEnum.none) {
                        print("select gender");
                      } else {
                        signUp(user);
                      }
                    }
                  },
                  height: 48,
                ),
                verticalSpace(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      title: "Already have an account?",
                      weight: FontWeight.w400,
                      size: 16,
                      color: AppColors.medium300,
                    ),
                    horizontalSpace(16),
                    GestureDetector(
                      onTap: () {
                        context.router.replaceNamed("/login");
                      },
                      child: const CustomText(
                        title: "Login",
                        weight: FontWeight.w600,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                verticalSpace(heightSizer(24, context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
