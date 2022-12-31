//
//  ProspectView.swift
//  HotProspects
//
//  Created by Deye Lei on 12/30/22.
//

import Foundation
import SwiftUI
import CodeScanner

struct ProspectView: View {
    enum FilterType{
        case none, uncontacted, contacted
    }
    
    let filterType: FilterType
    
    @EnvironmentObject var prospects: Prospects
    
    var title: String{
        switch(filterType){
        case .none: return "Everyone"
        case .contacted: return "Contacted"
        case .uncontacted: return "Uncontacted"
        }
    }
    
    var filterProspects: [Prospect]{
        switch(filterType){
        case .none: return prospects.people
        case .contacted: return prospects.people.filter{
            $0.isContacted == true
        }
        case .uncontacted: return prospects.people.filter{$0.isContacted == false}
        }
    }
    
    @State var showScanner = false
    
    func handleScan(result : Result<ScanResult, ScanError>){
        showScanner = false
        
        switch result{
        case .success(let resultStr):
            let details = resultStr.string.components(separatedBy: "\n")
            
            guard details.count == 2 else {return}
            
            let newProspect = Prospect()
            newProspect.name = details[0]
            newProspect.email = details[1]
            prospects.people.append(newProspect)
            print("Add success")
        case .failure(let error):
            print("scan faield \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(filterProspects) {
                    prospect in
                    HStack{
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.email)
                            .foregroundColor(.secondary)
                    }
                    .swipeActions {
                        if prospect.isContacted{
                            Button{
                                prospects.toggleContacted(target: prospect)
                            } label: {
                                Label("uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.red)
                        }
                        else{
                            Button{
                                prospects.toggleContacted(target: prospect)
                            } label: {
                                Label("contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                                    
                            }
                            .tint(.green)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button {
                    showScanner = true
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
            }
            .sheet(isPresented: $showScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
                
            }
        }
    }
}

struct ProspectView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectView(filterType: .none)
            .environmentObject(Prospects())
    }
}
