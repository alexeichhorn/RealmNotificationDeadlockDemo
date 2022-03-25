//
//  ContentView.swift
//  RealmNotificationDeadlockDemo
//
//  Created by Alexander Eichhorn on 25.03.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                BackgroundListener.shared.startListening()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
