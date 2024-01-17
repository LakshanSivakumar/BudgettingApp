//
//  TransactionHistory.swift
//  BudgetApp
//
//  Created by Lakshan Sivakumar on 15/1/24.
//

import SwiftUI

struct TransactionHistory: View {
    @FetchRequest(sortDescriptors:[SortDescriptor(\.date, order:.reverse)]) var transport: FetchedResults<Transport>
    @Environment(\.managedObjectContext) var managedObjContext
    var body: some View {
        List{
            ForEach(transport) {
                transport in
                NavigationLink(destination: editHistory(transport: transport)){
                    VStack(alignment:.leading, spacing: 6){
                        let amounts = String(format: "%0.2f", transport.amount)
                        Text(amounts)
                            HStack{
                                Text(transport.transportNote!)
                                    .bold()
                                Text(transport.date!, style:.date)
                        }
                    }
                }
                    
            }.onDelete(perform: deleteTransaction)
        }
        }
    private func deleteTransaction(offsets: IndexSet){
        withAnimation{
            offsets.map{transport[$0]}.forEach(managedObjContext.delete)
            DataController().save(context: managedObjContext)
        }
    }
    }



#Preview {
    TransactionHistory()
}
