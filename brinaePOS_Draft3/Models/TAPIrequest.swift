//
//  ViewController.swift
//  SDKIntegration
//
//  Created by Joost van Dijk on 09/08/2022.
//

import UIKit
import TerminalAPIKit


class TAPIrequest:  ObservableObject{


    
    func createNexoRequest(amount: Double, terminal: Terminal) -> Data {
//        let orderRef = String.random(withLength: 6)
        let responseJSON : String = "r"
        let header = MessageHeader(
            protocolVersion: "3.0",
            messageClass: .service,
            messageCategory: .payment,
            messageType: .request,
            serviceIdentifier: String.random(withLength: 6),
            saleIdentifier: UUID().uuidString,
            poiIdentifier:  terminal.poiID
        )
        
        let saleData = SaleData(
            saleTransactionIdentifier:
                TransactionIdentifier(
                    transactionIdentifier: String.random(withLength: 6),
                    date: Date()
                )
            )
//                        saleToAcquirerData: "split.api=1&split.nrOfItems=3&split.totalAmount=1000&split.currencyCode=USD&split.item1.amount=900&split.item1.type=BalanceAccount&split.item1.account=\(Constants.balanceAccount)&split.item1.reference=payment-\(orderRef)&split.item2.amount=100&split.item2.type=Commission&split.item2.reference=Commission-\(orderRef)&split.item3.type=PaymentFee&split.item3.account=\(Constants.balanceAccount)&split.item3.reference=fees-\(orderRef)"
//        )
        
        let paymentTransaction = PaymentTransaction(
            amounts: Amounts(
                currency: "USD",
                requestedAmount: amount
            )
        )
        
        let paymentRequest = PaymentRequest(
            saleData: saleData,
            paymentTransaction: paymentTransaction
        )
        
        let message = Message(header: header, body: paymentRequest)
        let data = try! Coder.encode(message)
        
        var request = URLRequest(url: URL(string: "https://terminal-api-test.adyen.com/sync")!)
        request.httpMethod = "POST"
        request.httpBody = data
        request.addValue(Constants.apiKey, forHTTPHeaderField: "X-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
            }
            guard let data = data else {return}
            
            do {
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                }
            }
        }
        task.resume()
//        result = data
//        return result
    
        return data
    }
}
