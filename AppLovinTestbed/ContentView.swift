//
//  ContentView.swift
//  AppLovinTestbed
//
//  This file implements the start screen. It is possible to view the configuration and start the study.
//

import SwiftUI

struct ContentView: View {
    
    @State var sdkStudy = false
    @State private var showingPopover = false

    var body: some View {
            ZStack {
                VStack {
                    Button(action: {
                        MyVariables.onLoad = true;
                    }) {
                        Text("Execute on appearance / on load")
                            .font(.system(size: 20))
                            .fontWeight(.heavy)
                            .foregroundColor(.pink)
                    }
                    Spacer()
                    
                    Button(action: {
                        MyVariables.sendAdditionalData = true;
                    }) {
                        Text("Send additional data, like gender and email")
                            .font(.system(size: 20))
                            .fontWeight(.heavy)
                            .foregroundColor(.green)
                    }
                    Spacer()
                    Button(action: {
                        MyVariables.userConsent = true;
                    }) {
                        Text("Give consent")
                            .font(.system(size: 20))
                            .fontWeight(.heavy)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    Button(action: {
                        showingPopover = true;
                    }) {
                        Text("Show configuration")
                            .font(.system(size: 20))
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            
                    }
                    .popover(isPresented: $showingPopover) {
                        var sb = """
                        Execute on appearance: \(MyVariables.onLoad)\n
                        Send additional data: \(MyVariables.sendAdditionalData)\n
                        Give consent: \(MyVariables.userConsent)
                        """
                        
                        Text(sb)
                            .font(.headline)
                            .padding()
                        }
                    Spacer()
                    VStack(spacing: 20) {
                        Button(action: {
                            self.sdkStudy.toggle()
                        }) {
                            Image(systemName: "figure.wave")
                                .foregroundColor(Color.pink)
                                .font(.system(size: 130))
                            Text("Start study")
                                .font(.system(size: 40))
                                .fontWeight(.heavy)
                                .foregroundColor(.pink)
                        }.sheet(isPresented: $sdkStudy) {
                            A_InitialState()
                        }
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
