//Copyright 2018 Idealnaya rabota LLC
//Licensed under Multy.io license.
//See LICENSE for details

import UIKit
//import MultyCoreLibrary

class FastOperationsPresenter: NSObject, QrDataProtocol {

    var fastOperationsVC: FastOperationsViewController?
    
    var addressSendTo = ""
    var amountInCrypto = 0.0
    var blockchain: Blockchain?
    
    func qrData(string: String, tag: String?) {
        let storyboard = UIStoryboard(name: "Send", bundle: nil)
        let destVC = storyboard.instantiateViewController(withIdentifier: "sendStart") as! SendStartViewController
        destVC.presenter.transactionDTO.update(from: string)
        
        self.fastOperationsVC?.navigationController?.pushViewController(destVC, animated: true)
    }
    
}
