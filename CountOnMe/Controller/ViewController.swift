//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - outlets
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var resultView: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var eraseButton: UIButton!
    @IBOutlet weak var ACButton: UIButton!
    @IBOutlet var operatorButtons: [UIButton]!
    @IBOutlet weak var pointDecimalButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    
    // Import the model
    private let model = CountOnMeModel()

    // Import the style
    let styleButton = VisualStyle()
    
    func operationViewLink() {
        textView.text = model.calculText
    }
    func resultViewLink() {
        // because label is optional
        if let resultPrint = self.resultView {
            resultPrint.text = model.resultText
        }
    }
    
    // MARK: - viewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // set style
        styleButton.buttonStyleSetting(arrayNumbers: numberButtons, arrayOperator: operatorButtons, erase: eraseButton, ac: ACButton, decimal: pointDecimalButton, equal: equalButton)
        let bgStyle = VisualStyle()
        bgStyle.backgroundStyle(ofView: mainView)
        
        // refresh display
        textView.text = ""
        resultView.text = ""
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - actions
    
    // Add numbers
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        model.tappedNumber(number: numberText)
        operationViewLink()
        resultViewLink()
        
    }
    
    // Add operaor, decimal, clear
    @IBAction func tappedButton(_ sender: UIButton) {
        let buttonTapped = sender.tag
        
        if model.canAddOperator && model.expressionIsCorrect {
            model.tappedOperator(buttonTapped: buttonTapped)
            operationViewLink()
            resultViewLink()
        } else {
            alert(message: model.alertText)
        }
    }
    
    @IBAction func decimalButton(_ sender: UIButton) {
        model.tappedDecimale()
        operationViewLink()
    }
    
    
    // Erase last entrie
    @IBAction func erasedButton(_ sender: UIButton) {
    
        if !model.expressionHaveResult {
            model.tappedErase()
            operationViewLink()
            resultViewLink()
        } else {
            model.alertText = AlertText.AlertCases.haveEnoughtElements.rawValue
            alert(message: model.alertText)
            return
        }
        
    }
    
    // Clear All
    @IBAction func allClear(_ sender: UIButton) {
        model.tappedAllClear()
        operationViewLink()
        resultViewLink()
        
    }
    

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        
        if model.expressionHaveResult {
            model.alertText = AlertText.AlertCases.haveEnoughtElements.rawValue
            alert(message: model.alertText)
        } else if model.expressionIsCorrect && model.expressionHaveEnoughElement {
            model.printResult()
            operationViewLink()
            resultViewLink()
        } else {
            alert(message:model.alertText)
        }
        
    }
    
    func alert(message: String) {
        let alertVC = UIAlertController(title: "Erreur!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

}


