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
    
    var body: some View {
        NavigationStack {
                ZStack {
                    VStack {
                        HStack {
                            Text("Tracking your mood can be easy!")
                                .font(.system(size: 26))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top, 50)
                        }.padding(.horizontal,30)
                        
                        Spacer(minLength: 20)
                        HStack {
                            Image("homeImage")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 230)
                                .padding(.bottom, 50)
                        }
                        Spacer()
                        
                        NavigationLink(destination: StepTwo())  {
                            Text("Get Started")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("button"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .matchedGeometryEffect(id: "button", in: animationNamespace)
                        }.padding(.bottom,25)
                    }
                    .padding()
                    .background(Color("backColor"))
                }
                
            }
//        }
        
    }
}
#Preview {
    StepOne()
}
