//
//  Hapic.swift
//  SwiftUI Day 86
//
//  Created by Deye Lei on 1/10/23.
//

import Foundation
import SwiftUI
import CoreHaptics

struct Hapic: View {
    @State var engine:CHHapticEngine?
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    func startEngine(){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        
        do{
            engine = try CHHapticEngine()
            try engine?.start()
            print("success")
        }
        catch{
            print("can't initalize a engine")
            print(error)
        }
    }
    
    func hapicOnSuccess(){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    var body: some View {
        Text("Hello world")
            .onAppear(perform: startEngine)
            .onTapGesture(perform: complexSuccess)
    }
}

struct Hapic_Previews: PreviewProvider {
    static var previews: some View {
        Hapic()
    }
}
