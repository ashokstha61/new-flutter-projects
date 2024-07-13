abstract class CommonState{}
class CommonInitialState extends CommonState{}
class CommonLoadingState extends CommonState{}
class CommonSuccessState<TYPE> extends CommonState{
  final TYPE data; 
  CommonSuccessState({required this.data});
}
class CommonErrorState extends CommonState{
  final String message;
  CommonErrorState({required this.message});
}