import '../../../../core/models/dynamic_field_model.dart';

class ListCameraDynamicFieldsUsecase {
  ListCameraDynamicFieldsUsecase();

  List<DynamicFieldModel> call() => [
        DynamicFieldModel(
          code: 'name',
          label: 'Nome',
          placeholder: 'Digite o nome',
        ),
      ];
}
