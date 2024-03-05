//
//  MainViewModel.swift
//  SampleAppSwiftUI
//
//  See LICENSE folder for this sample’s licensing information.
//

import Foundation
import AdyenPOS
import TerminalAPIKit

class MainViewModel: ObservableObject {
    
    /// Create an instance of PaymentService with the PaymentService(delegate:) initializer and pass the delegate object
    /// Make sure you keep a strong reference to the payment service instance so that it is retained for the duration of the transaction
    /// Also make sure your delegate is strongly referenced, because the PaymentService keeps a weak reference to the delegate
    lazy var paymentService = PaymentService(delegate: self)
    
    /// Initialize the transaction using the Adyen iOS SDK
    func initializeTransaction(
        paymentInterface: PaymentInterfaceType,
        presentationMode: TransactionPresentationMode
    ) async {
        do {
            /// Get the installationId from the payment service
            let installationId = try paymentService.installationId
            print("InstallationId \(installationId)" )
            /// Generate a request using the installationId
            let request = generateRequest(installationId: installationId)
            print("Request \(request)")
            /// Get the payment interface from the payment service
            let paymentInterface = try await paymentService.getPaymentInterface(with: paymentInterface)
            print("paymentInterface \(paymentInterface)")
            /// Perform the transaction using the generated request, payment interface, and view presentation mode
            let response = try await paymentService.performTransaction(
                with: Payment.Request(
                    data: Coder.encode(request)
                ),
                paymentInterface: paymentInterface,
                presentationMode: .viewModifier
            )
            print("response \(response)")
            let poiResponse = try Coder.decode(Message<PaymentResponse>.self, from: response)
            print("poiResponse \(poiResponse)")
            /// Use the Terminal API response
            print(String(decoding: response, as: UTF8.self))
        }
        catch {
            print(error)
        }
    }
    
    /// Initialize the POS SDK
    @Sendable
    func initializePOSSDK() async {
        /// Set the `DeviceManagerDelegate` delegate if you want to use your own implementation of NYC1 device management
        paymentService.deviceManager.delegate = self
        
        /// To speed up initiating transactions, you can use the warm-up function
        /// This function checks for a session and any configuration changes, and prepares the proximity reader on the iPhone
        try? await paymentService.warmUp()
    }
    
    
    /// Generate a Terminal API request, in this example we are generating a PaymentRequest
    func generateRequest(installationId: String) -> Message<PaymentRequest> {
        
        let header: MessageHeader = .init(
            protocolVersion: "3.0",
            messageClass: .service,
            messageCategory: .payment,
            messageType: .request,
            serviceIdentifier: String(UUID().uuidString.prefix(6)),
            saleIdentifier: UUID().uuidString,
            poiIdentifier: installationId
        )
        
        let paymentRequest: PaymentRequest = .init(
            saleData: .init(
                saleTransactionIdentifier: .init(
                    transactionIdentifier: UUID().uuidString,
                    date: .init()
                ),
                saleToAcquirerData: "authorisationType=PreAuth&tenderOption=AllowPartialAuthorisation"
//                saleToAcquirerData: ("split.api=1&split.nrOfItems=3&split.totalAmount=1000&split.currencyCode=USD&split.item1.amount=900&split.item1.type=BalanceAccount&split.item1.account=\(Constants.balanceAccount)&split.item1.reference=payment-1234&split.item2.amount=100&split.item2.type=Commission&split.item2.reference=Commission-1234&split.item3.type=PaymentFee&split.item3.account=\(Constants.balanceAccount)&split.item3.reference=fees-1234")
            ),
            paymentTransaction: .init(
                amounts: .init(
                    currency: "USD",
                    requestedAmount: 12.46
                )
            )
        )
        return Message(header: header, body: paymentRequest)
    }
}

struct SessionsResponse: Decodable {
    let sdkData: String
}

extension MainViewModel: PaymentServiceDelegate {
    func register(with setupToken: String) async throws -> String {
        /// Make a call to your backend to trigger a `/sessions` request, supplying the provided `setupToken`
        /// You should not call the `/sessions` endpoint from the POS app, only from your backend
        guard let url = URL(string: "https://checkout-test.adyen.com/checkout/possdk/v68/sessions") else { return "" }
        var request = URLRequest(url: url)
        let parameters: [String: Any] = [
            "merchantAccount": Constants.merchantAccount,
            "store": Constants.storeId,
            "setupToken": setupToken
            ]
        
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.addValue(Constants.apiKey, forHTTPHeaderField: "X-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("request \(request)")
        let (data, _) = try await URLSession.shared.data(for: request)
        print(String(decoding: data, as: UTF8.self))
        let response = try JSONDecoder().decode(SessionsResponse.self, from: data)
        print("sessions response \(response)")
        return response.sdkData
    }
}
/// Conforming to protocol "DeviceManagerDelegate" is only necessary when implementing NYC1 device management from scratch, and not when using our pre-built "DeviceManagementView" component (or when using it in conjunction with your own implementation)
extension MainViewModel: DeviceManagerDelegate {
    
    func onDeviceDiscovered(device: AdyenPOS.Device, by manager: DeviceManager) { }
    
    func onDeviceDiscoveryFailed(with error: Error, by manager: DeviceManager) { }
    
    func onDeviceConnected(with error: Error?, to manager: DeviceManager) { }
    
    func onDeviceDisconnected(from manager: DeviceManager) { }
}
