import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';


// cho chức năng tìm kiếm ( dùng để set thời gian để tìm kiếm )
EventTransformer<Event> debounce<Event>(Duration duration) =>
        (events, mapper) => events.debounce(duration).switchMap(mapper);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}
