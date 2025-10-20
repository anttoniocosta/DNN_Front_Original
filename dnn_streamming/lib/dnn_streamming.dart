library dnn_streamming;

import 'package:dnn_dependencies/get_export.dart';

import 'package:dnn_streamming/modules/controller/streamming_controller.dart';

export './modules/binding/streamming_binding.dart';

export './modules/controller/streamming_controller.dart';

export './modules/models/call_model.dart';

export './modules/pages/home.dart';
export './modules/pages/streamming_page.dart';

export './modules/components/local_user_video.dart';
export './modules/components/remote_user_video.dart';

final streammingController = Get.find<StreammingController>();
