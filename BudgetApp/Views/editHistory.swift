//
//  editHistory.swift
//  BudgetApp
//
//  Created by Lakshan Sivakumar on 17/1/24.
//

import SwiftUI

struct editHistory: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    var transport: FetchedResults<Transport>.Element
    
    @State private var name = ""
    @State private var amount: Double = 0
    var body: some View {
        Form{
            Section{
                TextField("\(transport.transportNote!)", text: $name)
                    .onAppear(){
                        name = transport.transportNote!
                        amount = transport.amount
                    }
                VStack{
                    TextField("Amount:", value:$amount, format: .currency(code: Locale.current.currency?.identifier ?? "SGD"))
                }
                .padding()
                HStack{
                    Spacer()
                    Button("Submit"){
                        DataController().editTransport(transport: transport, transportNote: name, amount: amount, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}


