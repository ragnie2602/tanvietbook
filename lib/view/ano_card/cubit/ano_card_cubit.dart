import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/repository/remote/repository.dart';
import '../../../di/di.dart';
import '../../../model/api/base_response.dart';

part 'ano_card_state.dart';
part 'ano_card_cubit.freezed.dart';

class AnoCardCubit extends Cubit<AnoCardState> {
  final AppRepository _appRepository = getIt.get();
  AnoCardCubit() : super(const AnoCardState.initial());

  activeAnoCard({
    required String cardId,
    required String key,
  }) async {
    final response =
        await _appRepository.activeAnoCard(cardId: cardId, key: key);
    if (response.status == ResponseStatus.success) {
      emit(const AnoCardState.activeSuccess());
    } else {
      emit(AnoCardState.activeFailed());
    }
  }
}
