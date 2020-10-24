//
//  ContentView.swift
//  GameInSwiftUI
//
//  Created by Ramill Ibragimov on 24.10.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var time = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var count = 50
    @State private var level = 50
    @State private var buttonP = 0
    @State private var showAlert = false
    @State var title = ""
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Press the button")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color.white)
                Text("\(count)")
                    .font(.title)
                    .foregroundColor(Color.white)
                Spacer()
                Button(action: {
                    addPress()
                }, label: {
                    Text("\(buttonP)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .frame(width: 150, height: 150, alignment: .center)
                        .background(Color.green)
                        .clipShape(Circle())
                }).alert(isPresented: $showAlert, content: {
                    Alert(title: Text(title), message: Text("Reset or Move to next level"), primaryButton: .default(Text("Reset"), action: {
                        reset()
                    }), secondaryButton: .default(Text("Next Level"), action: {
                        next()
                    }))
                })
                Spacer()
            }.padding()
        }.onReceive(time, perform: { _ in
            minusNum()
        })
    }
    
    private func addPress() {
        buttonP += 1
    }
    
    private func minusNum() {
        if count != 0 {
            count -= 1
        } else {
            if buttonP > level / 2 {
                title = "You won!"
                showAlert = true
            } else {
                title = "You lose!"
                showAlert = true
            }
        }
    }
    
    private func reset() {
        count = 50
        buttonP = 0
        showAlert = false
    }
    
    private func next() {
        buttonP = 0
        level += 10
        count = level
        showAlert = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
