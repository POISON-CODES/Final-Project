import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mainapp/constants/constants.dart' show Buckets;
import 'package:url_launcher/url_launcher.dart';
import 'package:mainapp/custom/widgets/custom_global_widgets.dart';
import 'package:mainapp/features/auth/cubit/auth_cubit.dart';
import 'package:mainapp/features/companies/cubit/company_cubit.dart';
import 'package:mainapp/features/configurations/cubit/configuration_cubit.dart';
import 'package:mainapp/features/files/cubit/file_cubit.dart';
import 'package:mainapp/features/forms/cubit/form_cubit.dart' as form_cubit;
import 'package:mainapp/features/forms/page/form_pages.dart';
import 'package:mainapp/features/master_data/pages/master_data_form_page.dart';
import 'package:mainapp/models/models.dart';

part 'company_details.dart';
part 'edit_company.dart';
part 'create_new_company.dart';
