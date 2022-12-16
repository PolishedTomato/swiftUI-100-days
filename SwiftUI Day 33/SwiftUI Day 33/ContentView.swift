//
//  ContentView.swift
//  SwiftUI Day 33
//
//  Created by Deye Lei on 10/23/22.
//

import SwiftUI

//custom modifier
struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            //.clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    @State private var status = false
    @State private var dragAmount = CGSize.zero
    
    @State private var letters = Array("SwiftUI")
    @State private var isShowingRed = false
    var body: some View {
        VStack {
            Button("Tap me"){
                
                    status.toggle()
                
            }
            .frame(width: 200, height: 200)
            .background(status ? .red : .blue)
            .animation(.default, value: status)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: status ? 60 : 0))
            .animation(.interpolatingSpring(stiffness: 50, damping: 1), value: status)
            
            //dragging a view and return to its original location when release
            LinearGradient(gradient: Gradient(colors: [.green, .yellow]), startPoint: .leading, endPoint: .trailing)
                .frame(width: 200, height: 200)
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged { x in
                            withAnimation{
                                dragAmount = x.translation
                            }
                            
                        }
                        .onEnded { _ in
                            withAnimation{
                                dragAmount = .zero}
                            
                        }
                )
            
            //the delay animation make this animation look really interesting.
            // it has larger delay for latter letter so when we drag it, it has the effect of following the letter before it.
            HStack(spacing: 0) {
                        ForEach(0..<letters.count, id: \.self) { num in
                            Text(String(letters[num]))
                                .padding(5)
                                .font(.title)
                                .background(status ? .blue : .red)
                                .offset(dragAmount)
                                .animation(.default.delay(Double(num) / 5), value: dragAmount)
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { dragAmount = $0.translation }
                            .onEnded { _ in
                                dragAmount = .zero
                                status.toggle()
                            }
                    )
            
            ZStack {
                        Rectangle()
                            .fill(.blue)
                            .frame(width: 200, height: 200)

                        if isShowingRed {
                            Rectangle()
                                .fill(.red)
                                .frame(width: 200, height: 200)
                                .transition(.pivot)
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            isShowingRed.toggle()
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
