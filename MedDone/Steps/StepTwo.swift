import SwiftUI

struct StepTwo: View {
    @State private var currentPage = 0
    @Namespace private var animationNamespace
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "button")
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(named: "button")?.withAlphaComponent(0.3) ?? UIColor.gray.withAlphaComponent(0.3)
    }
    
    
    var body: some View {
        if hasCompletedOnboarding {
            HomeView()
        } else {
            ZStack {
                VStack {
                    
                    if currentPage == 0 {
                        VStack {
                            Text("Your Privacy Matters")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 10)
                            
                            Text("Your data is safe with us. We value your privacy!")
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 50)
                            
                            HStack {
                                Image("shield-exclamation")
                                Text("Your journal is private and secure")
                                    .font(.body)
                                    .padding(.leading, 10)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer().frame(height: 50)
                            
                            HStack {
                                Image("shield-exclamation")
                                Text("The app does not share your journal's content with external servers or third parties!")
                                    .font(.body)
                                    .padding(.leading, 10)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Spacer().frame(height: 120)
                        VStack{
                            Image("shieldCheck")
                            
                        }
                    }
                    
                    else if currentPage == 1 {
                        VStack {
                            Text("Safety First")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 10)
                            
                            Text("Please take bipolar disorder seriously!")
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 50)
                            
                            HStack {
                                Image("medCase")
                                Text("Consult with your doctor if you are experiencing any symptoms of an illness")
                                    .font(.body)
                                    .padding(.leading, 10)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer().frame(height: 50)
                            
                            HStack {
                                Image("medCase")
                                Text("This app is for informational purposes only and does not replace medical treatment")
                                    .font(.body)
                                    .padding(.leading, 10)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer().frame(height: 50)
                            
                            HStack {
                                Image("phone")
                                Text("In an emergency, dial 911 or your local emergency number immediately!")
                                    .font(.body)
                                    .padding(.leading, 10)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }
                    }
                    else if currentPage == 2 {
                        VStack {
                            Text("Never miss a dose!")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 10)
                            
                            Text("Allow notifications, and we’ll help you stay on track with your medications")
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 50)
                            Spacer().frame(height: 120)
                            ZStack {
                                Image("dayMed")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 150)
                                Image("pills")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 150)
                                    .offset(x: 85, y: 85)
                            }
                            
                        }
                        
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        PageControl(currentPage: $currentPage)
                            .frame(height: 10)
                        Spacer()
                    }
                    .padding()
                    
                    VStack {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                if currentPage < 2 {
                                    currentPage += 1
                                }else {
                                    print("Setting onboarding completed to true")
                                    hasCompletedOnboarding = true
                                    
                                }
                            }
                        }) {
                            Text(currentPage == 2 ? "Accept" : "Next")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("button"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                    .padding(.bottom, 20)
                    
                }   
                .padding()
                .navigationBarBackButtonHidden(true)
                NavigationLink(destination: HomeView(), isActive: $hasCompletedOnboarding) {
                    EmptyView()
                }
            }.background(Color("backColor"))
        }
    }
}
struct PageControl: View {
    @Binding var currentPage: Int
    let numberOfPages = 3
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? Color("button") : Color.gray.opacity(0.3))
                    .frame(width: 10, height: 10)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentPage = index
                        }
                    }
            }
        }
    }
}

#Preview {
    StepTwo()
}
