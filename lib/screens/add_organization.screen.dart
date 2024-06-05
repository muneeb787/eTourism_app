import 'dart:io';

import 'package:alcertcertificationapp/Models/governing_bodies.model.dart';
import 'package:alcertcertificationapp/Provider/add_organization.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Components/custom_ElevatedButton.dart';
import '../Components/custom_InputTextField.dart';

class AddOrganizationScreen extends StatefulWidget {
  const AddOrganizationScreen({super.key});
  static const pageName = '/addOrganization';

  @override
  State<AddOrganizationScreen> createState() => _AddOrganizationScreenState();
}

class _AddOrganizationScreenState extends State<AddOrganizationScreen> {
  final _companyName = TextEditingController(),
      _address1 = TextEditingController(),
      _address2 = TextEditingController(),
      _postCode = TextEditingController(),
      _telePhone = TextEditingController(),
      _registrationNo = TextEditingController(),
      _email = TextEditingController(),
      _website = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final zipRegex =
  RegExp(r"^[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]$", caseSensitive: false);
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  int? govBodyId;
  File? companyLogo;
  File? governingLogo;
  XFile? xfilePick;
  final picker = ImagePicker();
  bool? selectedRadio; // Initialize with a default value
  void handleRadioValueChange(bool? value) {
    setState(() {
      selectedRadio = value ?? true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    print("init State");
    Provider.of<AddOrganizationProvider>(context, listen: false)
        .fetchGoverningBodies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final orgProvider = Provider.of<AddOrganizationProvider>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Company'),
      //   centerTitle: true,
      // ),
      backgroundColor: const Color(0xFF1C2129),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/onlylogo.png',
                    height: 50.h,
                    fit: BoxFit.fitWidth,
                  ),
                  Image.asset(
                    'assets/images/logotext.png',
                    height: 50.h,
                    fit: BoxFit.fitWidth,
                  )
                ],
              ),
              Container(
                width: double.infinity,
                height: size.height / 20,
                child: Center(
                    child: Text(
                      'Enter Your Organization Details',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 20.w),
                    )),
              ),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    // key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CustomInputField(
                                    validator: (v) {
                                      if (v!.isEmpty || v.length < 3) {
                                        return 'Enter a valid name';
                                      }
                                      return null;
                                    },
                                    controller: _companyName,
                                    hint: 'XYZ',
                                    icon: Icons.business,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Address 1',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CustomInputField(
                                    validator: (v) {
                                      if (v!.isEmpty || v.length < 10) {
                                        return 'Enter Minimum 10 characters Address';
                                      }
                                      return null;
                                    },
                                    controller: _address1,
                                    hint: 'XYZ XYZ',
                                    icon: Icons.location_on,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Address 2',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CustomInputField(
                                    validator: (v) {
                                      if (v!.isEmpty || v.length < 10) {
                                        return 'Enter Minimum 10 characters Address';
                                      }
                                      return null;
                                    },
                                    controller: _address2,
                                    hint: 'XYZ XYZ',
                                    icon: Icons.location_on,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Post Code',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CustomInputField(
                                    validator: (v) {
                                      if (v!.isEmpty || !zipRegex.hasMatch(v)) {
                                        return 'Enter Valid Zip Code';
                                      }
                                      return null;
                                    },
                                    controller: _postCode,
                                    hint: '25890',
                                    icon: Icons.post_add_outlined,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Telephone Number',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CustomInputField(
                                    controller: _telePhone,
                                    hint: '+1 (123) 123 1234',
                                    icon: Icons.phone_outlined,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Registration Number',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CustomInputField(
                                    validator: (v) => v!.isEmpty
                                        ? 'Enter registration Number'
                                        : v.length < 4
                                        ? 'Enter Valid registration No'
                                        : null,
                                    controller: _registrationNo,
                                    hint: 'xy 25891',
                                    icon: Icons.dialpad,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Email',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CustomInputField(
                                    validator: (v) => v!.isEmpty
                                        ? 'Enter Email'
                                        : !emailRegex.hasMatch(v)
                                        ? 'Enter valid email'
                                        : null,
                                    controller: _email,
                                    hint: 'xyz@gmail.com',
                                    icon: Icons.email_outlined,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Website',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CustomInputField(
                                    validator: (v) => null,
                                    controller: _website,
                                    hint: 'www.xyz.com',
                                    icon: Icons.public,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Governor Body',
                                style:
                                Theme.of(context).textTheme.displayMedium,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Consumer<AddOrganizationProvider>(
                                  builder: (context, provider, child) {
                                    if (provider.isLoading) {
                                      return Text("loading");
                                    } else {
                                      // print("object calling");
                                      // print(provider.governingBodies);
                                      // Now you can use isLoading or other properties/methods of your provider
                                      return DropdownButtonFormField(
                                        validator: (v) {
                                          if (v == null) {
                                            return 'Select Governor Body';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Select Governor Body',
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                          prefixIcon: Container(
                                            margin: const EdgeInsets.only(right: 2),
                                            padding: const EdgeInsets.only(),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              color: Color(0xFF37B8FC),
                                            ),
                                            height: 43,
                                            child: const Icon(
                                              Icons.three_p_sharp,
                                              color: Colors.white,
                                            ),
                                          ),
                                          contentPadding:
                                          const EdgeInsets.only(left: 10),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        dropdownColor: Colors.white,
                                        value:  (govBodyId),
                                        onChanged: (newValue) {
                                          print("newValue $newValue");
                                          setState(() {
                                            govBodyId = newValue;
                                          });
                                        },
                                        items: provider.governingBodies
                                            ?.map<DropdownMenuItem>((value) {
                                          print("value: ${value.id}");
                                          return DropdownMenuItem<int>(
                                            value: value.id,
                                            child: Text(
                                              value.name ?? '',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    }
                                  }),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Governering Body Logo',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  GestureDetector(
                                    child: governingLogo != null
                                        ? Container(
                                        height: size.height / 10,
                                        width: size.width / 5,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Color(0xFF37B8FC)),
                                        child: Image.file(
                                          governingLogo!,
                                          fit: BoxFit.fill,
                                        ))
                                        : ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                            fixedSize:
                                            Size(size.width, 45)),
                                        label: const Text(
                                          'Upload Your Logo',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        onPressed: () {
                                          getCompanyImage();
                                        },
                                        icon: const Icon(
                                          Icons.upload_file_sharp,
                                          size: 25,
                                        )),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Comapany Logo',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  GestureDetector(
                                    child: companyLogo != null
                                        ? Container(
                                        height: size.height / 10,
                                        width: size.width / 5,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Color(0xFF37B8FC)),
                                        child: Image.file(
                                          companyLogo!,
                                          fit: BoxFit.fill,
                                        ))
                                        : ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                            fixedSize:
                                            Size(size.width, 45)),
                                        label: const Text(
                                          'Upload Your Logo',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        onPressed: () {
                                          getCompanyImage();
                                        },
                                        icon: const Icon(
                                          Icons.upload_file_sharp,
                                          size: 25,
                                        )),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              CustomElevatedButton(
                                  width: size.width,
                                  text: 'Create',
                                  onPressed: () {
                                    print("$govBodyId govBodyId");
                                    print("${companyLogo?.path} companyLogo");
                                    orgProvider.requestAddOrganization(
                                      governing_body: govBodyId ?? 0,
                                      companyLogo: companyLogo,
                                      governingLogo: governingLogo,
                                    );
                                  }),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> getImage() async {
  //   final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     print(pickedFile.path);
  //     image = File(pickedFile.path);
  //   }
  //   notifyListeners();
  // }
  Future getCompanyImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    xfilePick = pickedFile;
    setState(
          () {
        if (xfilePick != null) {
          companyLogo = File(pickedFile!.path);
          governingLogo = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Icon(Icons.cloud_upload_outlined)));
        }
      },
    );
  }
}