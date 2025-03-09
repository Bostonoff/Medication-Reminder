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
                            currentPage = 1
                            showPagination = true
                        }
                    }, overlayImageName:""
                )
            } else {
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
                                currentPage = 2
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
                        secondaryTextThree: "c",
                        action: {
                            withAnimation {
                                currentPage = 3
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
                        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "dateColor")
                        UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.5)
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
                        .font(.system(size: 25))
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
            .frame(maxWidth: .infinity, alignment: .top)
            Spacer()
            
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
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
            .background(Color("backColor"))
    }
    func imageSize(for name: String) -> CGFloat {
        switch name {
        case "homeImage": return 200
        case "dayMed": return 100
        case "shieldCheck": return 100
        default: return 250
        }
    }
}

#Preview {
    OnboardingView(hasSeenOnboarding: .constant(false))
}

//import SwiftUI
//
//struct OnboardingView: View {
//    @Binding var hasSeenOnboarding: Bool
//    @State private var currentPage = 0
//
//    var body: some View {
//        VStack {
//            if currentPage == 0 {
//                PageView(
//                    title: "Tracking your mood can be easy!",
//                    description: nil,
//                    imageName: "homeImage",
//                    buttonText: "Get Started",
//                    iconsWithTexts: [],
//                    action: {
//                        withAnimation {
//                            currentPage = 1
//                        }
//                    }
//                )
//            } else {
//                TabView(selection: $currentPage) {
//                    PageView(
//                        title: "Your privacy matters",
//                        description: "Your data is safe with us. We value your privacy!",
//                        imageName: nil, // Нет изображения
//                        buttonText: "Next",
//                        iconsWithTexts: [
//                            ("lock.shield.fill", "Your journal is private and secure!"),
//                            ("shield.lefthalf.filled", "We use advanced encryption.")
//                        ],
//                        action: {
//                            withAnimation {
//                                currentPage = 2
//                            }
//                        }
//                    )
//                    .tag(1)
//                    
//                    PageView(
//                        title: "Safety First",
//                        description: "Please take bipolar disorder seriously!",
//                        imageName: nil, // Нет изображения
//                        buttonText: "Next",
//                        iconsWithTexts: [
//                            ("cross.case.fill", "Consult with your doctor."),
//                            ("heart.fill", "Your well-being matters."),
//                            ("stethoscope", "Medical advice is key.")
//                        ],
//                        action: {
//                            withAnimation {
//                                currentPage = 3
//                            }
//                        }
//                    )
//                    .tag(2)
//                    
//                    PageView(
//                        title: "Never miss a dose!",
//                        description: "Allow notifications, and we’ll help you stay on track with your medications.",
//                        imageName: "pills.fill",
//                        buttonText: "Accept",
//                        iconsWithTexts: [], // Нет иконок
//                        action: {
//                            withAnimation {
//                                hasSeenOnboarding = true
//                            }
//                        }
//                    )
//                    .tag(3)
//                }
//                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
//                .onAppear {
//                    UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "dateColor")
//                    UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.5)
//                }
//            }
//        }
//        .padding(.top, 30)
//        .background(Color("backColor"))
//    }
//}
//
//struct PageView: View {
//    var title: String
//    var description: String?
//    var imageName: String?
//    var buttonText: String
//    var iconsWithTexts: [(icon: String, text: String)] // Массив иконок с текстом
//    var action: () -> Void
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Text(title)
//                .font(.system(size: 24, weight: .bold))
//                .multilineTextAlignment(.center)
//
//            if let description = description, !description.isEmpty {
//                Text(description)
//                    .font(.body)
//                    .multilineTextAlignment(.center)
//            }
//
//            VStack(spacing: 15) {
//                ForEach(iconsWithTexts, id: \.icon) { item in
//                    HStack {
//                        Image(systemName: item.icon)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: 50)
//                        Text(item.text)
//                            .font(.body)
//                            .multilineTextAlignment(.leading)
//                            .padding(.leading, 10)
//                        Spacer()
//                    }
//                    .padding(.horizontal)
//                }
//            }
//
//            if let imageName = imageName {
//                Image(systemName: imageName)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 200)
//            }
//
//            Button(action: action) {
//                Text(buttonText)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color("button"))
//                    .foregroundColor(.white)
//                    .cornerRadius(20)
//            }
//            .padding(.horizontal)
//            .padding(.bottom, 100)
//        }
//        .padding(.top, 20)
//        .background(Color("backColor"))
//    }
//}
//
//#Preview {
//    OnboardingView(hasSeenOnboarding: .constant(false))
//}
    
