//
//  B_InquireConsent.swift
//  AppLovinTestbed
//
//  This display is intended for granting and revoking consent. Consent is granted in the displayAlert method and consent is not granted in the displayAlert3 method.
//

import SwiftUI
import AppLovinSDK

struct B_InquireConsent: View {
    
    @EnvironmentObject var sdk: SDK
    @StateObject var progress = ConsentBox()
    
    var body: some View {
        ZStack {
            Color.purple
                .ignoresSafeArea() // Ignore just for the color
                .overlay(
                    VStack(spacing: 20) {
                        Button(action: progress.displayAlert, label: {
                            VStack {
                                Image(systemName: "cursorarrow.click.2")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 80))
                                Text("Give consent manually")
                                    .font(.system(size: 20))
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                            }
                        })
                        Spacer()
                            .frame(height: 20)
                        Button(action: progress.displayAlert3, label: {
                            VStack {
                                Image(systemName: "cursorarrow.click.2")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 80))
                                Text("Refuse consent manually")
                                    .font(.system(size: 20))
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                            }
                        })
                        Button(action: {
                            print("Go to initialize view")
                        }, label: {
                            NavigationLink(destination: C_Initialize()) {
                                HStack {
                                    Image(systemName: "arrowshape.turn.up.right.fill")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 80))
                                    Text("Initialize")
                                        .font(.system(size: 40))
                                        .fontWeight(.heavy)
                                        .foregroundColor(.white)
                                }
                            }
                        })
                    })

        }.onAppear {
            if (MyVariables.onLoad) {
                progress.displayAlert2();
            }
        }.alert(isPresented: $progress.isDisplayingAlert) { () -> Alert in
            Alert(title: Text("Give consent"), message: Text("Giving consent"), dismissButton: .cancel())
        }.alert(isPresented: $progress.isDisplayingAlert2) { () -> Alert in
            Alert(title: Text("Refuse consent"), message: Text("Refusing consent"), dismissButton: .cancel())
        }
    }
}

struct B_InquireConsent_Previews: PreviewProvider {
    static var previews: some View {
        B_InquireConsent()
    }
}

class ConsentBox: ObservableObject {
    @Published var isDisplayingAlert = false
    @Published var isDisplayingAlert2 = false;
    
    func displayAlert() {
        ALPrivacySettings.setHasUserConsent(true);
        print("Give consent");
        // update Published property.
        isDisplayingAlert = true

      }
    
    func displayAlert3() {
        ALPrivacySettings.setHasUserConsent(false);
        print("Give no consent");
        // update Published property.
        isDisplayingAlert2 = true
    }
    
    func displayAlert2() {
        ALPrivacySettings.setHasUserConsent(MyVariables.userConsent);
        print("Give consent");
        // update Published property.
        isDisplayingAlert = true
      }
}
