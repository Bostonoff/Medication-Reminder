//
//  GetStartedView.swift
//  MediMind
//
//  Created by Mukhammad Bustonov on 05/03/25.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var hasSeenOnboarding: Bool
    @State private var currentPage = 0
    @State private var showPagination = false
    var body: some View {
        VStack {
            // Show the Get Started page first
            if currentPage == 0 {
                PageView(
                    title: "Tracking your mood can be easy!",
                    description: "",
                    imageName: "homeImage",
                    buttonText: "Get Started",
                    icon: "",
                    iconTwo: "",
                    iconThree: "",
                    iconFour: "",
                    secondaryTextOne: "",
                    secondaryTextTwo: "",
                    secondaryTextThree: "",
                    action: {
                        withAnimation {
                            // Move to the second page when the "Get Started" button is clicked
                            currentPage = 1
                            showPagination = true // After clicking, show pagination
                        }
                    }, overlayImageName:""
                )
            } else {
                // Show the TabView and pagination after the first page is clicked
                TabView(
                    selection: $currentPage
                ) {
                    PageView(
                        title: "Your privacy matters",
                        description: "Your data is safe with us. We value your privacy!",
                        imageName: "shieldCheck",
                        buttonText: "Next",
                        icon: "shield-exclamation",
                        iconTwo: "",
                        iconThree: "",
                        iconFour: "",
                        secondaryTextOne: "Your Journal is Private and Secure!",
                        secondaryTextTwo: "The app does not share your journal's contnet with external servers or third parties!",
                        secondaryTextThree: "",
                        action: {
                            withAnimation {
                                currentPage = 2 // Move to the third page
                            }
                        },
                        overlayImageName: ""
                    )
                    .tag(1)
                    
                    PageView(
                        title: "Safety First",
                        description: "Please take bipolar disorder seriously!",
                        imageName: "",
                        buttonText: "Next",
                        icon: "",
                        iconTwo: "casePlus",
                        iconThree: "casePlus",
                        iconFour: "phone",
                        secondaryTextOne: "Consult with your doctor if you are experiencing any symptoms of an illness",
                        secondaryTextTwo: "This app is for informational purposes only and does not replace medical treatment",
                        secondaryTextThree: "In an emergency, dial 911 or your local emergency number immediately!",
                        action: {
                            withAnimation {
                                currentPage = 3 // Move to the fourth page
                            }
                        },
                        overlayImageName: ""
                    )
                    .tag(2)

                    PageView(
                        title: "Never miss a dose!",
                        description: "Allow notifications, and we’ll help you stay on track with your medications.",
                        imageName: "dayMed",
                        buttonText: "Accept",
                        icon: "",
                        iconTwo: "",
                        iconThree: "",
                        iconFour: "",
                        secondaryTextOne: "",
                        secondaryTextTwo: "",
                        secondaryTextThree: "",
                    
                        action: {
                            withAnimation {
                                hasSeenOnboarding = true
                                print("hasSeenOnboarding after change: \(hasSeenOnboarding)")
                            }
                        },
                        overlayImageName: "pills"
                    )
                    .tag(3)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle())
                Spacer()
                .onAppear {
                    UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "dateColor") // Active dot color
                    UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.5) // Inactive dot color
                }
            }
        }
        .padding(.top, 30)
        .background(Color("backColor"))
    }
}
    
struct PageView: View {
    var title: String
    var description: String
    var imageName: String
    var buttonText: String
    var icon: String
    var iconTwo: String
    var iconThree: String
    var iconFour: String
    var secondaryTextOne: String
    var secondaryTextTwo: String
    var secondaryTextThree: String
    var action: () -> Void
    var overlayImageName: String? = nil

    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                HStack{
                    Text(title)
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                }
//                Spacer()
//                    .multilineTextAlignment(.center)
//                    .frame(maxWidth: .infinity, alignment: .center) // Ensure max width is taken up and text is centered
//                       .padding(.horizontal)
                
                if !description.isEmpty {
                    Text(description)
                        .font(.body)
                        .multilineTextAlignment(.center)
//                        .padding(.horizontal)
                }
                Spacer()
                if !secondaryTextOne.isEmpty {
                    HStack{
                        if !icon.isEmpty{
                            Image(icon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                            
//                            Spacer()
                        }
                        else {
                            Image(iconThree)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 43)
//                            Spacer()
                        }
                        Text(secondaryTextOne)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.leading,10)
                           
//                            .padding()
                        Spacer()
                    }
                    Spacer()
                }
                
                Spacer()
                if !secondaryTextTwo.isEmpty {
                    HStack{
                        if !icon.isEmpty{
                            Image(icon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
//                            Spacer()
                        }
                        if !iconTwo.isEmpty{
                            Image(iconTwo)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                            
//                            Spacer()
                        }
                        Text(secondaryTextTwo)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 10)
                            .padding(.leading,10)
//                            .padding(.leading)
                        Spacer()
//                            .padding(.trailing)
                    }
                                }
                Spacer()
                if !secondaryTextThree.isEmpty {
                    HStack{
                        if !iconFour.isEmpty{
                            Image(iconFour)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                            Spacer()
                        }
                        Text(secondaryTextThree)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 10)
//                            .padding(.leading,10)
//                            .padding(.leading)
                        Spacer()
                    }
                                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .top) // Текст прижимаем к верху
            Spacer()
            // Основное изображение + наложенная картинка
            if !imageName.isEmpty {
                ZStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: imageSize(for: imageName))
                    if let overlay = overlayImageName {
                        Image(overlay)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .offset(x: 60, y: 60)
                            .frame(maxWidth: .infinity, alignment: .top)
                    }
                    
                }
                Spacer()
            }
            Spacer()
                .frame(maxWidth: .infinity, alignment: .top)
//            Spacer()
            Button(action: action) {
                
                Text(buttonText)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("button"))
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .padding(.horizontal)
            .padding(.bottom, 100)
        }.edgesIgnoringSafeArea(.all)
        .frame(maxHeight: .infinity, alignment: .top) // Всё сдвигаем вверх
        .padding(.top, 20)
        .background(Color("backColor"))
    }
    func imageSize(for name: String) -> CGFloat {
        switch name {
        case "homeImage": return 200
        case "dayMed": return 100
        case "shieldCheck": return 100
        default: return 250 // Значение по умолчанию
        }
    }
}

#Preview {
    OnboardingView(hasSeenOnboarding: .constant(false))
}
