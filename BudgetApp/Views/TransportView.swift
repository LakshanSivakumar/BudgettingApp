//
//  TransportView.swift
//  BudgetApp
//
//  Created by Lakshan Sivakumar on 13/1/24.
//

import SwiftUI
struct TransportView: View {
    @State private var transportNote: String = ""
    @State private var amount = 0.0
    @State private var date = Date()
    @State private var amountFinal: Double = UserDefaults.standard.double(forKey: "Costs")
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            Form{
                HStack{
                    Text("Transport Amount:")
                    Spacer()
                    TextField("Cost", value:$amount, format: .currency(code: Locale.current.currency?.identifier ?? "SGD"))

                }
                HStack{
                    Text("Note:")
                    Spacer()
                    TextField("Note", text:$transportNote)
                }
                HStack{
                    DatePicker(
                        "Transaction Date", selection: $date, displayedComponents: [.date]
                    )
                }
                HStack{
                    Spacer()
                    Button("Submit"){
                        DataController().addTransport(transportNote: transportNote, amount: amount, date: date, context: managedObjContext)
                        dismiss()
                        amountFinal = amount + amountFinal
                        UserDefaults.standard.set(amountFinal, forKey: "Costs")

                    }
                    Spacer()
                }
            }
            
        }.navigationTitle("Transport")
    }
}

#Preview {
    TransportView()
        
}
