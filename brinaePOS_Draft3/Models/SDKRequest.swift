//
//  SDKRequest.swift
//  brinaePOS_Draft3
//
//  Created by Brinae Bain on 5/19/23.
//

import Foundation
import UIKit
import AdyenPOS
import TerminalAPIKit


class SDKRequest: UIViewController {

    
    private lazy var paymentService = PaymentService(delegate: self)


    func createNYC1Request() {
        
        Task {
            try await paymentService.resetSession()
            let transactionRequest = try Payment.Request(data: createSDKNexoRequest(amount: 8.46))
            let paymentInterface = try await paymentService.getPaymentInterface(with: .cardReader)
            
            let result = await paymentService.performTransaction(with: transactionRequest,
                                                                 paymentInterface: paymentInterface,
                                                                 presentationMode: .presentingViewController(self,
                                                                                                             logo: nil))
            print("Result", try! JSONSerialization.jsonObject(with: result))
            
        }
        
    }


    private func createSDKNexoRequest(amount: Double) -> Data {
        let header = MessageHeader(
               protocolVersion: "3.0",
               messageClass: .service,
               messageCategory: .payment,
               messageType: .request,
               serviceIdentifier: String.random(withLength: 6),
               saleIdentifier: UUID().uuidString,
               poiIdentifier: try! paymentService.installationId
           )
        
        let saleData = SaleData(
            saleTransactionIdentifier:
                TransactionIdentifier(
                    transactionIdentifier: String.random(withLength: 6),
                    date: Date()
                ),
            saleToAcquirerData: "eyJ0ZW5kZXJPcHRpb24iOiAiQWxsb3dQYXJ0aWFsQXV0aG9yaXNhdGlvbiJ9"
        )
        
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
        
        return data
    }


    func didSelectManageDevices() {
        let viewController = DeviceManagementViewController(paymentService: paymentService)
        present(viewController, animated: true)
    }
}


extension SDKRequest: PaymentServiceDelegate {

    func register(with setupToken: String) async throws -> String {
        let requestBody = [
            "merchantAccount": Constants.merchantAccount,
            "store": Constants.storeId,
            "setupToken": setupToken
        ] as [String: String]

        var request = URLRequest(url: URL(string: "https://checkout-test.adyen.com/checkout/possdk/v67/sessions")!)
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        request.addValue(Constants.apiKey, forHTTPHeaderField: "X-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, _) = try await URLSession.shared.data(for: request)

        let jsonResponse = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        return jsonResponse["sdkData"] as! String
    }

}
