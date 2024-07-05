import 'package:note_app/data/entity/note_entity.dart';
import 'package:note_app/data/observer_data.dart';

abstract class NoteGroupObserverData extends SingleStreamObserverData<List<NoteGroupEntity>> {}

abstract class NoteObserverData extends SingleStreamObserverData<List<NoteEntity>> {}

abstract class NoteCountObserverData extends SingleStreamObserverData<int> {}
