
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../view_models/screen/implements/question_viewmodel_state.dart';
import '../view_models/screen/interfaces/iquestion_viewmodel.dart';

List<SingleChildWidget> viewModelProviders = [
  ChangeNotifierProvider<IQuestionViewModel>(
    create: (_) => QuestionViewModel(),
  ),
];
