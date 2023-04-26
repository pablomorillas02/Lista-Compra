import 'orden.dart';
import 'stack.dart';

class UndoManager {
  final _undoPila = Stack<Orden>();
  final _redoPila = Stack<Orden>();

  UndoManager._();

  static final UndoManager instance = UndoManager._();

  void add({required Orden orden}) {
    _undoPila.push(orden);
    _redoPila.clear();
  }

  void undo() {
    if (!_undoPila.isEmpty) {
      final command2Undo = _undoPila.pop();
      command2Undo.undo();
      _redoPila.push(command2Undo);
    }
  }

  void redo() {
    if (!_redoPila.isEmpty) {
      final command2Redo = _redoPila.pop();
      command2Redo.redo();
      _undoPila.push(command2Redo);
    }
  }

  @override
  String toString() {
    return 'Commands to undo: $_undoPila\nCommands to redo: $_redoPila';
  }
}
