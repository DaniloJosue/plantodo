class Task {
  String id;
  String title;
  String description;
  String projectId; 
  
  // Jerarquía
  String? parentId; 
  List<Task> subtasks; 
  
  // Atributos 
  List<String> tags;
  bool isFlagged; 
  
  // Lógica de completado
  bool isCompleted;
  bool autoCompleteWhenSubtasksDone;
  
  // Formato visual para hijas
  bool showDescriptionAsChecklist; 

  // Constructor con listas mutables por defecto
  Task({
    required this.id,
    required this.title,
    required this.description,
    this.projectId = 'id_proyecto_fijo', // Apunta al proyecto genérico por defecto
    this.parentId, // Si se omite, es null (tarea padre)
    List<Task>? subtasks, // Recibe null o una lista
    List<String>? tags,   // Recibe null o una lista
    this.isFlagged = false,
    this.isCompleted = false,
    this.autoCompleteWhenSubtasksDone = false,
    this.showDescriptionAsChecklist = false,
  })  : subtasks = subtasks ?? [], // Si es null, asigna una lista vacía modificable
        tags = tags ?? [];         // Si es null, asigna una lista vacía modificable

  // Métodos auxiliares para facilitar la lógica externa
  bool get isChildTask => parentId != null;
  bool get isParentTask => parentId == null;

  // Método para validar que no se agreguen subtareas a una hija
  void addSubtask(Task newSubtask) {
    if (isChildTask) {
      throw Exception("Las tareas hijas no pueden contener otras subtareas.");
    }
    subtasks.add(newSubtask);
  }
}