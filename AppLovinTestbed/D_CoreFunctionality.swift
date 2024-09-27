//
//  D_CoreFunctionality.swift
//  AppLovinTestbed
//
//  This display uses the core functionality of Amplitude. In this case, showing a banner ad.
//

import SwiftUI
import AppLovinSDK

struct D_CoreFunctionality: View {
    @State var showingAdd = false
    
    // Banner height on iPhone and iPad is 50 and 90, respectively
    let height: CGFloat = (UIDevice.current.userInterfaceIdiom == .pad) ? 90 : 50
    // Stretch to the width of the screen for banners to be fully functional
    let width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        if (MyVariables.onLoad) {
            ExampleSwiftUIWrapper().frame(width: width, height: height)
        }
        ZStack {
            Color.pink
                .ignoresSafeArea() // Ignore just for the color
                .overlay(
                    VStack(spacing: 20) {
                        Button(action: {
                            self.showingAdd.toggle()
                        }) {
                            Text("Show Banner AD")
                        }.sheet(isPresented: $showingAdd) {
                            ExampleSwiftUIWrapper().frame(width: width, height: height)
                        }
                    })
        }.onAppear {
            
        }
    }
}

struct ExampleSwiftUIWrapperMREC: UIViewRepresentable
{
    func makeUIView(context: Context) -> MAAdView
        {
            let adView = MAAdView(adUnitIdentifier: "XXX", adFormat: MAAdFormat.mrec)
            adView.delegate = context.coordinator
            
            // Set background or background color for banners to be fully functional
            adView.backgroundColor =  UIColor.systemPink

            // Load the first Ad
            adView.loadAd()
            
            return adView
        }
        
        func updateUIView(_ uiView: MAAdView, context: Context) {}
        
        func makeCoordinator() -> Coordinator
        {
            Coordinator()
        }
}

extension ExampleSwiftUIWrapperMREC
{
    class Coordinator: NSObject, MAAdViewAdDelegate
    {
        // MARK: MAAdDelegate Protocol
        
        func didLoad(_ ad: MAAd) {}
        
        func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {}
        
        func didClick(_ ad: MAAd) {}
        
        func didFail(toDisplay ad: MAAd, withError error: MAError) {}
        
        // MARK: MAAdViewAdDelegate Protocol
        
        func didExpand(_ ad: MAAd) {}
        
        func didCollapse(_ ad: MAAd) {}
        
        // MARK: Deprecated Callbacks
        
        func didDisplay(_ ad: MAAd) { /* use this for impression tracking */ }
        func didHide(_ ad: MAAd) { /* DO NOT USE - THIS IS RESERVED FOR FULLSCREEN ADS ONLY AND WILL BE REMOVED IN A FUTURE SDK RELEASE */ }
    }
}


struct ExampleSwiftUIWrapper: UIViewRepresentable
{
    func makeUIView(context: Context) -> MAAdView
    {
        let adView = MAAdView(adUnitIdentifier: "XXX")
        adView.delegate = context.coordinator

        // Set background or background color for banners to be fully functional
        adView.backgroundColor = UIColor.blue

        // Load the first Ad
        adView.loadAd()
        
        //print(adView)
        return adView
    }

    func updateUIView(_ uiView: MAAdView, context: Context) {}

    func makeCoordinator() -> Coordinator
    {
        Coordinator()
    }
}

extension ExampleSwiftUIWrapper
{
    class Coordinator: NSObject, MAAdViewAdDelegate
    {
        // MARK: MAAdDelegate Protocol

        func didLoad(_ ad: MAAd) {}

        func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {}

        func didClick(_ ad: MAAd) {}

        func didFail(toDisplay ad: MAAd, withError error: MAError) {}

        // MARK: MAAdViewAdDelegate Protocol

        func didExpand(_ ad: MAAd) {}

        func didCollapse(_ ad: MAAd) {}

        // MARK: Deprecated Callbacks

        func didDisplay(_ ad: MAAd) { /* use this for impression tracking */ }
        func didHide(_ ad: MAAd) { /* DO NOT USE - THIS IS RESERVED FOR FULLSCREEN ADS ONLY AND WILL BE REMOVED IN A FUTURE SDK RELEASE */ }
    }
}

private func showBanner(width: CGFloat, height: CGFloat) {
    ExampleSwiftUIWrapper().frame(width: width, height: height)
}

struct D_CoreFunctionality_Previews: PreviewProvider {
    static var previews: some View {
        D_CoreFunctionality()
    }
}
