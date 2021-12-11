//
//  ContentView.swift
//  Final Project
//
//  Created by Ashton Hess on 12/10/21.
//

import SwiftUI
import Swift

struct ContentView: View {
    
    //@ObservedObject var amountInput = NumbersOnly()
    //@ObservedObject var costInput = NumbersOnly()
    
    @State var selectedView = 0
    
    @State var amountTextField: Double = 0.0
    
    @State var costTextField: Double = 0.0
    
    @State var buyRecords: [BuyRecord] = []
    
    @State var metricsBTC: Double = 0
    
    @State var metricsTotalSpend: Double = 0
    
    @State var metricsAverageCost: Double = 0
    
    let icons = [
        "house",
        "book"
    ]
    
    var body: some View {
//        NavigationView{
            VStack{
                ZStack{
                    switch selectedView{
                    case 0:
                        NavigationView{
                            VStack{
                                
                                
                                
                                VStack{
                                    Text("Add Buy:")
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                    HStack{
                                        Text("      Amount (BTC): ")
                                        TextField("Type here...", value: $amountTextField, format: .number)
                                            .textFieldStyle(.roundedBorder)
                                            .keyboardType(.decimalPad)
                                        Button(action: {
                                            UIApplication.shared.endEditing()
                                            
                                        }) {
                                            Text("Done      ")
                                        }
                                    }
                                    HStack{
                                        Text("      Cost ($USD): ")
                                        TextField("Type here...", value: $costTextField, format: .number)
                                            .textFieldStyle(.roundedBorder)
                                            .keyboardType(.decimalPad)
                                        Button(action: {
                                            UIApplication.shared.endEditing()
                                            
                                        }) {
                                            Text("Done      ")
                                        }
                                        
                                    }
                                    
                                    HStack{
//                                        Spacer()
//                                        Button(action: {
//
//
//                                        }) {
//                                            Text("Clear")
//                                        }
//                                        Spacer()
                                        Button(action: {
                                            let insertAmount = amountTextField
                                            let insertCost = costTextField
                                            let addBuyObj: BuyRecord = BuyRecord(buyAmount: insertAmount, buyCost: insertCost)
                                            print(addBuyObj.buyAmount)
                                            print(addBuyObj.buyCost)
                                        
                                            buyRecords.append(addBuyObj)
                                            //print(buyRecords[0].buyAmount)
                                            //print(buyRecords[0].buyCost)
                                            
                                            updateMetrics()
                                            
                                            
                                            
                                        }) {
                                            Text("Add")
                                        }
//                                        Spacer()
                                    }
                                }
//
                                Divider()
                                    .padding(50)
//
                                VStack{
                                    Text("Metrics:")
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                    HStack{
                                        Text("Bitcoin Amount (BTC):")
                                        Text("\(metricsBTC)")
//                                        Text("\(buyRecords[0].buyAmount)")
                                        
                                    }
                                    HStack{
                                        Text("Total Spent ($USD):")
                                        Text("\(metricsTotalSpend)")
                                    }
                                    HStack{
                                        
                                        Text("Average Cost ($USD):")
                                        Text("\(metricsAverageCost)")
                                    }
                                }
                            }
                            .navigationTitle("BTC Cost-Average")
                            
                           
                        }
                    default:
                        NavigationView{
                            VStack{
                                Text("Created by Ashton Hess 2021")
                                    .fontWeight(.bold)
                                    .font(.title2)
                                Text("By inputting each time you have bought Bitcoin along with the amount bought and price paid, this application calculates your average buy price. This could also be used to keep track of average buy price for many other assets. In the future, core data will be implemented to save local user buy history. Restart application to start over.")
                                
                            }
                            .navigationTitle("About Screen")
                        }
                    
                    }
                }
            
            Spacer()
            Divider()
                Spacer()
            HStack{
                ForEach(0..<2, id: \.self){number in
                    Spacer()
                    Button(action:{
                        self.selectedView = number
                        
                    }, label: {
                        Image(systemName: icons[number])
                            .font(.system(size:25,
                                          weight: .regular,
                                          design: .default))
                            
                    })
                    Spacer()
                }
            }
//        }
    }
    }
    
    
    func updateMetrics(){
        
        var totalBTC: Double = 0
        var totalSpent: Double = 0
        var averageCost: Double = 0
        
        for x in buyRecords {
            totalBTC+=x.buyAmount
            totalSpent+=x.buyCost
            
        }
        
        
        averageCost = totalSpent/totalBTC
        
        metricsBTC = totalBTC
        metricsTotalSpend = totalSpent
        metricsAverageCost = averageCost
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



extension UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
