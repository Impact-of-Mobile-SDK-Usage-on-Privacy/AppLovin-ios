//
//  C_Initialize.swift
//  AppLovinTestbed
//
//  This display enables the Amplitude SDK to be initialized. If further user data is to be provided, this is set in the initSDK method.
//

import SwiftUI
import AppLovinSDK

struct C_Initialize: View {
    
    @EnvironmentObject var sdk: SDK
    @StateObject var progress = InitBox()

    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea() // Ignore just for the color
                .overlay(
                    VStack(spacing: 20) {
                        Button(action: {progress.displayAlert(sdk: sdk)}, label: {
                            VStack {
                                Image(systemName: "cursorarrow.click.2")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 144))
                                Text("Initialize")
                                    .font(.system(size: 40))
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                            }
                        })
                        Spacer()
                            .frame(height: 100)
                        Button(action: {
                            print("Floating Button Click")
                        }, label: {
                            NavigationLink(destination: D_CoreFunctionality()) {
                                VStack {
                                    Image(systemName: "arrowshape.turn.up.right.fill")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 144))
                                    Text("Go to Banner AD")
                                        .font(.system(size: 40))
                                        .fontWeight(.heavy)
                                        .foregroundColor(.white)
                                }
                            }
                        })
                    })
        }.onAppear {
            if (MyVariables.onLoad) {
                progress.displayAlert(sdk: sdk)
            }
        }.alert(isPresented: $progress.isDisplayingAlert) { () -> Alert in
            Alert(title: Text("Initialize"), message: Text("Init SDK"), dismissButton: .cancel())
        }
    }
}

private func initSDK(sdk: SDK) {
    if sdk.sdk != nil {
        print(sdk.sdk!.settings)
        
        sdk.sdk!.mediationProvider = "max"
        sdk.sdk!.userIdentifier = "XXX"
        sdk.sdk!.initializeSdk { (configuration: ALSdkConfiguration) in

        }
        sdk.sdk!.settings.isVerboseLoggingEnabled = true
        if (MyVariables.sendAdditionalData) {
            sdk.sdk!.targetingData.email = "user@email.com";
            sdk.sdk!.targetingData.gender = ALGender.male;
            sdk.sdk!.targetingData.interests = ["beer, party, concerts"];
            sdk.sdk!.targetingData.phoneNumber = "01799956361";
            sdk.sdk!.settings.setExtraParameterForKey("uid2_token", value: "VALUE")
        }
    } else {
        // Please make sure to set the mediation provider value to "max" to ensure proper functionality
        ALSdk.shared()!.mediationProvider = "max"

        ALSdk.shared()!.userIdentifier = "XXX"
        ALSdk.shared()!.initializeSdk { (configuration: ALSdkConfiguration) in
            // Start loading ads
        }
        ALSdk.shared()!.settings.isVerboseLoggingEnabled = true
        if (MyVariables.sendAdditionalData) {
            ALSdk.shared()!.targetingData.email = "user@email.com";
            ALSdk.shared()!.targetingData.gender = ALGender.male;
            ALSdk.shared()!.targetingData.interests = ["beer, party, concerts"];
            ALSdk.shared()!.targetingData.phoneNumber = "01799956361";
            
            let settings = ALSdk.shared()?.settings
            settings?.setExtraParameterForKey("YYY", value: "XXX")
        }
    }
}

struct C_Initialize_Previews: PreviewProvider {
    static var previews: some View {
        C_Initialize()
    }
}

class InitBox: ObservableObject {
    @Published var isDisplayingAlert = false
    
    func displayAlert(sdk: SDK) {
        print("init SDK via button");
        initSDK(sdk: sdk);
        // update Published property.
        isDisplayingAlert = true
      }
}
