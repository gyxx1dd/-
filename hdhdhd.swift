import SwiftUI

struct EditExerciseView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ExerciseViewModel
    var exercise: Exercise

    @State private var name: String
    @State private var repetitions: String
    @State private var selectedType: ExerciseType
    @State private var selectedDate: Date

    init(viewModel: ExerciseViewModel, exercise: Exercise) {
        self.viewModel = viewModel
        self.exercise = exercise
        _name = State(initialValue: exercise.name)
        _repetitions = State(initialValue: String(exercise.repetitions))
        _selectedType = State(initialValue: exercise.type)
        _selectedDate = State(initialValue: exercise.date)
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Назва вправи", text: $name)
                TextField("Кількість повторень", text: $repetitions)
                    .keyboardType(.numberPad)

                Picker("Тип вправи", selection: $selectedType) {
                    ForEach(ExerciseType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }

                DatePicker("Дата", selection: $selectedDate, displayedComponents: .date)

                Button("Зберегти") {
                    if let reps = Int(repetitions) {
                        viewModel.editExercise(exercise: exercise, newName: name, newRepetitions: reps, newType: selectedType, newDate: selectedDate)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Редагувати вправу")
        }
    }
}
