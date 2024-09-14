part of 'ano_card_cubit.dart';

@unfreezed
class AnoCardState with _$AnoCardState {
  const factory AnoCardState.initial() = _Initial;

  const factory AnoCardState.activeSuccess() = _ActiveSuccess;
  factory AnoCardState.activeFailed({String? message}) = _ActiveFailed;
}
