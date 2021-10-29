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
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var eraseButton: UIButton!
    @IBOutlet weak var ACButton: UIButton!
    @IBOutlet var operatorButtons: [UIButton]!
    @IBOutlet weak var pointDecimalButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    
    
    
    private let model = CountOnMeModel()
    
    var expressionHaveResult: Bool {
        //        if let textV = textView.text.firstIndex(of: "="){
//            return true
//        }
          return textView.text.firstIndex(of: "=") != nil
 }
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    private func cornerRad(button: UIButton){
            button.layer.cornerRadius = 20
        }
    
    // Round angle style of buttons
    private func buttonStyle(){
        for button in numberButtons{
        cornerRad(button: button)
        }
        for button in operatorButtons{
        cornerRad(button: button)
        }
        cornerRad(button: eraseButton)
        cornerRad(button: ACButton)
        cornerRad(button: pointDecimalButton)
        cornerRad(button: equalButton)
    }
    
    
    // MARK: - viewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonStyle()
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult {
            textView.text = ""
        }
        
        textView.text.append(numberText)
        model.addElement(element: numberText)
    }
    
    // Add operaor, decimal, clear
    func tappedButton(_ sender: UIButton) {
        let buttonTapped = sender.tag
        if model.operatorChecking() {
            switch buttonTapped {
            case 1:
                textView.text.append(" - ")
                model.addOperator(element: "-")
            case 2:
                textView.text.append(" + ")
                model.addOperator(element: "+")
            case 3:
                textView.text.append(" x ")
                model.addOperator(element: "x")
            case 4:
                textView.text.append(" / ")
                model.addOperator(element: "/")
            case 5:
                textView.text.append(".")
                
            case 6:
                textView.text = ""
                //model.
            default:
            alert(message: model.alertText)
            }
            
        } else {
            alert(message: model.alertText)
        }
    }
    
    @IBAction func erasedButton(_ sender: UIButton) {
        model.elements.removeLast()
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard model.expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard model.expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
            }
        
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "/": result = left / right
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        textView.text.append(" = \(operationsToReduce.first!)")
    }
    
    func alert(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

}

