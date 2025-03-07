//import SwiftUI
//
//struct AdmedicationPage: View {
//    @StateObject private var viewModel = MedicationViewModel()
//    @State private var navigateToDetailsPage = false
//    @State private var showValidationModal: Bool = false
//
//    let options = [
//        ("capsule", "Capsule"),
//        ("tablets", "Tablets"),
//        ("liquid", "Liquid")
//    ]
//
//    var body: some View {
//        NavigationView { // Wrap in NavigationView
//            ScrollView {
//                VStack(alignment: .leading, spacing: 20) {
//                    // Medication Name Field
//                    TextField("Medication Name", text: $viewModel.medicationName)
//                        .padding()
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                    // Description Field
//                    TextField("Description", text: $viewModel.description)
//                        .padding()
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                    // Dose Amount Field
//                    TextField("Dose Amount", text: $viewModel.doseAmount)
//                        .padding()
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                    // Frequency Picker
//                    Picker("Frequency", selection: $viewModel.selectedFrequency) {
//                        ForEach(["Every Day", "Cyclically", "Specific Days of the Week", "Every Few Days", "As Needed"], id: \.self) { frequency in
//                            Text(frequency)
//                        }
//                    }
//                    .padding()
//                    .pickerStyle(MenuPickerStyle())
//
//                    Button(action: {
//                        // Validation before saving
//                        if viewModel.medicationName.isEmpty || viewModel.description.isEmpty || viewModel.selectedFrequency.isEmpty || viewModel.doseAmount.isEmpty {
//                            showValidationModal = true
//                        } else {
//                            navigateToDetailsPage.toggle() // Triggers the navigation
//                        }
//                    }) {
//                        Text("Save")
//                            .padding()
//                            .foregroundColor(.white)
//                            .background(
//                                Color.red
//                            )
//                            .cornerRadius(10)
//                            .frame(maxWidth: .infinity)
//                            .padding(.top)
//                    }
//                    .disabled(viewModel.medicationName.isEmpty || viewModel.description.isEmpty || viewModel.selectedFrequency.isEmpty || viewModel.doseAmount.isEmpty)
//
//                    // Navigation Link to MedDetailsPage
//                    NavigationLink(
//                        destination: MedDetailsPage(medication: Medication(
//                            name: viewModel.medicationName,
//                            description: viewModel.description,
//                            doseAmount: viewModel.doseAmount,
//                            frequency: viewModel.selectedFrequency,
//                            time: viewModel.selectedTime,
//                            durationList: viewModel.durationList,
//                            type: options[viewModel.selectedOption].0
//                        )),
//                        isActive: $navigateToDetailsPage
//                    ) {
//                        EmptyView() // This ensures that the button triggers the navigation
//                    }
//                }
//                .padding()
//            }
//            .alert(isPresented: $showValidationModal) {
//                Alert(title: Text("Validation Error"), message: Text("Please fill in all required fields"), dismissButton: .default(Text("OK")))
//            }
//        }
//    }
//}
//
//#Preview {
//    AdmedicationPage()
//}
