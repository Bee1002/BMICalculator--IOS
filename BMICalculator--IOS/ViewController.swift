//
//  ViewController.swift
//  BMICalculator--IOS
//
//  Created by Tardes on 6/6/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    /*@IBOutlet weak var shareResult: UIButton!*/
    
    var weight: Float = 60
    var height: Float = 150
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func onWeightChanged(_ sender: UIStepper) {
        weight = Float(sender.value)
        weightLabel.text = "\(Int(weight)) kg"
    }
    @IBAction func onHeightChanged(_ sender: UISlider) {
        height = sender.value
        heightLabel.text = "\(Int(height)) cm"
    }
    
    @IBAction func calculateButton(_ sender: Any) {
        let heightInMeter: Float = height / Float(100)
        let bmi: Float = weight / pow(heightInMeter, 2)
        resultLabel.text = "\(String(format: "%.2f", bmi))"
        
        // Determinar el estado según el IMC
        /* if bmi < 18.5 {
         statusLabel.text = "Delgado"
         statusLabel.textColor = UIColor.blue
         } else if bmi >= 18.5 && bmi < 25 {
         statusLabel.text = "Normal"
         statusLabel.textColor = UIColor.green
         } else {
         statusLabel.text = "Obeso"
         statusLabel.textColor = UIColor.red
         }*/
        
        // Otra manera de hacerlo con
        
        var bmiColor = UIColor.black
        var showAlert = false
        
        switch bmi {
        case ..<18.5:
            statusLabel.text = "Bajopeso"
            bmiColor = UIColor(named: "bmi-bajopeso")!
        case 18.5..<25:
            statusLabel.text = "Normal"
            bmiColor = UIColor(named: "bmi-peso-normal")!
        case 25..<30:
            statusLabel.text = "Sobrepeso"
            bmiColor = UIColor(named: "bmi-sobrepeso")!
        case 30..<35:
            statusLabel.text = "Obeso"
            bmiColor = UIColor(named: "bmi-obeso")!
            showAlert = true
        default:
            statusLabel.text = "Obesidad Extrema"
            bmiColor = UIColor(named: "bmi-obesidad-extrema")!
            showAlert = true
        }
        
        resultLabel.textColor = bmiColor
        
        if showAlert {
            let alert = UIAlertController(
                title: "Riesgo de salud",
                message: "Tu peso actual pone en grave riesgo tu vida. Busca ayuda medica cuanto antes.",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Mas informacion", style: .default, handler:
                                            { action in
                // He pulsado mas informacion
                let adviceSiteURL = "https://www.who.int/es/news-room/fact-sheets/detail/obesity-and-overweight"
                if let url = URL(string: adviceSiteURL),UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            } ))
            alert.addAction(UIAlertAction(title: "Cerrar", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
}
