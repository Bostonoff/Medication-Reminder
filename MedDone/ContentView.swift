//
//  ContentView.swift
//  MediMind
//
//  Created by Mukhammad Bustonov on 01/03/25.
//
import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query var medicines: [Medicationas]
    
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    var body: some View {
        if hasCompletedOnboarding {
            if medicines.isEmpty {
                HomeView()
            } else {
                Example()
            }
        } else {
            StepOne()
        }
      
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//import SwiftUI
//
//struct ContentView: View {
//    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
//
//    var body: some View {
//        if !hasSeenOnboarding {
//            HomeView()
//        } else {
//            OnboardingView(hasSeenOnboarding: $hasSeenOnboarding)
//        }
//    }
//}
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//import SwiftUI
//
//struct HomeView: View {
//    @State private var currentTextIndex = 0
//    let motivationalTexts = [
//        "Still you don't add any kind of medications, plz add your medications and see your progress here.",
//        "Stay positive and consistent, you're making progress every day!",
//        "Take care of your health, your future self will thank you!",
//        "Remember, small steps lead to big changes. Keep going!",
//        "Every dose brings you closer to a healthier tomorrow!"
//    ]
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                ZStack(alignment: .topLeading) {
//                    RoundedRectangle(cornerRadius: 30)
//                        .fill(Color("purple"))
//                        .frame(height: 320)
//                        .edgesIgnoringSafeArea(.top)
//                    
//                    HStack {
//                        Text("Home page")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .padding(.leading, 16)
//                        
//                        Spacer()
//                        
//                        NavigationLink(destination: CalendarPage()) {
//                            Image(systemName: "calendar")
//                                .foregroundColor(.white)
//                                .font(.title2)
//                                .padding(.trailing, 16)
//                        }
//                    }
//                    VStack{
//                        
//                        
//                        Image("homeImage")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: 150)
//                        
//                        
//                        Text("MedMind")
//                            .font(.title2)
//                            .bold()
//                            .foregroundColor(.white)
//                        
//                        
//                        
//                        
//                    }
//                    .frame(maxWidth: .infinity)
//                    .padding(.top, 30)
//                    
//                }
//                
//                Spacer()
//                
//                
//                VStack{
//                    
//                    HStack {
//                        NavigationLink(destination: AddMedicationPage()) {
//                            Image(systemName: "plus.circle.fill")
//                                .font(.system(size: 50))
//                                .foregroundColor(Color("button"))
//                        }
//                        Text("Add Medication")
//                            .font(.title2)
//                            .bold()
//                            .foregroundColor(Color("button"))
//                        
//                        
//                        
//                    }
//                    //                .buttonStyle(PlainButtonStyle())
//                    Spacer().frame(height: 40)
//                    VStack {
//                        Text(motivationalTexts[currentTextIndex])
//                            .font(.footnote)
//                            .foregroundColor(.gray)
//                            .multilineTextAlignment(.center)
//                            .fixedSize(horizontal: false, vertical: true)
//                            .padding(.horizontal, 25)
//                            .frame(height: 0)
//                    }
//                }
//                .frame(maxWidth: .infinity, alignment: .top)
//                .padding(.bottom, 100)
//                Spacer()
//            }
//           
//            
//            .onAppear {
//                Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
//                    currentTextIndex = (currentTextIndex + 1) % motivationalTexts.count
//                }
//            }
//        }
//    }
//}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
