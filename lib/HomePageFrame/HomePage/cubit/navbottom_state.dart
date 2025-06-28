part of 'navbottom_cubit.dart';



enum StatusNotification { inittial, loading, success, failure }


class NavbottomState extends Equatable {
  const NavbottomState({this.index = 0,this.statusNotification = StatusNotification.inittial});
  NavbottomState copyWith({
    int? index,
    StatusNotification? statusNotification
}){
    return NavbottomState(
      index: index ?? this.index,
      statusNotification: statusNotification ?? this.statusNotification
    );
  }
  final StatusNotification statusNotification;
  final int index;


  @override
  List<Object?> get props => [index,statusNotification];
}


