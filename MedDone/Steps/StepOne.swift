//
//  StepOne.swift
//  MedDone
//
//  Created by Mukhammad Bustonov on 08/03/25.
//

import SwiftUI

struct StepOne: View {
    @Namespace private var animationNamespace
    @State private var isNavigating = false
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    var body: some View {
        if hasCompletedOnboarding {
            HomeView()
        }else{
            NavigationView {
                ZStack {
                    VStack {
                        HStack {
                            Text("Tracking your mood can be easy!")
                                .font(.system(size: 26))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top, 50)
                        }
                        
                        Spacer(minLength: 20)
                        HStack {
                            Image("homeImage")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 230)
                                .padding(.bottom, 50)
                        }
                        Spacer()
                        
                        NavigationLink(destination: StepTwo(), isActive: $isNavigating) {
                            Text("Get Started")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("button"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        isNavigating = true
                                    }
                                }
                        }.padding(.bottom,25)
                    }
                    .padding()
                    .background(Color("backColor"))
                }
                
            }
        }
        
    }
}
#Preview {
    StepOne()
}
