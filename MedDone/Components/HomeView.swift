//
//  HomeView.swift
//  MediMind
//
//  Created by Mukhammad Bustonov on 05/03/25.
//

import SwiftUI

struct HomeView: View {
    @State private var currentTextIndex = 0
    let motivationalTexts = [
        "Stay on track with your medications. Tap 'Add Medication' to begin!",
        "Take care of your health, your future self will thank you!",
        "Remember, small steps lead to big changes. Keep going!",
        "Every dose brings you closer to a healthier Tomorrow!"
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color("purple"))
                        .frame(height: 320)
                        .edgesIgnoringSafeArea(.top)
                    
                    HStack {
//                        Text("Home page")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .padding(.leading, 16)
                        
                        Spacer()
                        
//                        NavigationLink(destination: CalendarPage()) {
//                            Image(systemName: "calendar")
//                                .foregroundColor(.white)
//                                .font(.title2)
//                                .padding(.trailing, 16)
//                        }
                    }
                    VStack{
                        
                        Text("MedDone")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                        
                        Image("homeImage")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                        
                        
                       
                        
                        
                        
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 30)
                    
                }
                
                Spacer()
                
                
                VStack{
                    
                    VStack(spacing:20) {
                        NavigationLink(destination: AddMedicationPage()) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 50))
                                .foregroundColor(Color("button"))
                        }
                        Text("Add Medication")
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color("button"))
                        
                        
                        
                    }
                    //                .buttonStyle(PlainButtonStyle())
                    Spacer().frame(height: 40)
                    VStack {
                        Text(motivationalTexts[currentTextIndex])
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.horizontal, 40)
                            .frame(height: 0)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.bottom, 100)
                Spacer()
            }.background(Color("backColor"))
            .navigationBarBackButtonHidden(true)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
                    currentTextIndex = (currentTextIndex + 1) % motivationalTexts.count
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
