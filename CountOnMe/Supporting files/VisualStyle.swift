//
//  VisualStyle.swift
//  CountOnMe
//
//  Created by Melissa Briere on 24/11/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

struct VisualStyle {
    
    func buttonStyle(button: UIButton, redCS: CGFloat, greenCS: CGFloat, blueCS: CGFloat){

// Shadow and Radius
        button.layer.shadowColor = UIColor(red: redCS, green: greenCS, blue: blueCS, alpha: 1.0).cgColor
        button.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 2.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 20.0
    }
    
    func buttonStyleSetting(arrayNumbers: [UIButton], arrayOperator: [UIButton], erase: UIButton, ac: UIButton, decimal: UIButton, equal: UIButton){
        for button in arrayNumbers{
            self.buttonStyle(button: button, redCS: 0.71, greenCS: 0.74, blueCS: 0.78)
        }
        for button in arrayOperator{
            self.buttonStyle(button: button, redCS: 84/255, greenCS: 157/255, blueCS: 209/255)
        }
        self.buttonStyle(button: erase, redCS: 48/255, greenCS: 71/255, blueCS: 132/255)
        self.buttonStyle(button: ac, redCS: 48/255, greenCS: 71/255, blueCS: 132/255)
        self.buttonStyle(button: decimal, redCS: 0.71, greenCS: 0.74, blueCS: 0.78)
        self.buttonStyle(button: equal, redCS: 48/255, greenCS: 71/255, blueCS: 132/255)
    }
   
     
    func backgroundStyle (ofView: UIView) {
            let colorTop =  UIColor(red: 68.0/255.0, green: 92.0/255.0, blue: 137.0/255.0, alpha: 1.0).cgColor
            let colorBottom = UIColor(red: 34.0/255.0, green: 48.0/255.0, blue: 75.0/255.0, alpha: 1.0).cgColor
                        
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = ofView.bounds
                    
            ofView.layer.insertSublayer(gradientLayer, at:0)
        }
    }
    
