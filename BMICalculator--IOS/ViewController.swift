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
    @IBOutlet weak var shareButton: UIButton!
    
    var gradientView: GradientView?
    
    var weight: Float = 60
    var height: Float = 150
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        // setupGradientBackground()
        setupAnimations()
    }
    
    override func viewWillLayoutSubviews() {
        setupGradientBackground()
    }
    
    private func setupUI() {
        // Configure share button
        shareButton.layer.cornerRadius = 10
        shareButton.clipsToBounds = true
        shareButton.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
        shareButton.tintColor = .white
        shareButton.layer.borderWidth = 1
        shareButton.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        
        // Configure labels with better contrast
        [weightLabel, heightLabel].forEach { label in
            label?.textColor = UIColor(white: 1.0, alpha: 0.9)
            label?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            label?.layer.shadowColor = UIColor.black.cgColor
            label?.layer.shadowOffset = CGSize(width: 0, height: 1)
            label?.layer.shadowOpacity = 0.8
            label?.layer.shadowRadius = 0
        }
        
        // Configure result label with stronger contrast
        resultLabel.textColor = .white
        resultLabel.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        resultLabel.layer.shadowColor = UIColor.black.cgColor
        resultLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
        resultLabel.layer.shadowOpacity = 0.8
        resultLabel.layer.shadowRadius = 2
        resultLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        // Configure status label
        statusLabel.textColor = .white
        statusLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        statusLabel.layer.shadowColor = UIColor.black.cgColor
        statusLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
        statusLabel.layer.shadowOpacity = 0.8
        statusLabel.layer.shadowRadius = 2
    }
    
    private func setupGradientBackground() {
        if let gradientView = gradientView {
            gradientView.removeFromSuperview()
        }
        gradientView = GradientView(frame: view.bounds)
        gradientView!.startColor = UIColor(red: 0.1, green: 0.1, blue: 0.3, alpha: 1.0)
        gradientView!.middleColor = UIColor(red: 0.2, green: 0.1, blue: 0.4, alpha: 1.0)
        gradientView!.endColor = UIColor(red: 0.3, green: 0.1, blue: 0.5, alpha: 1.0)
        view.insertSubview(gradientView!, at: 0)
    }
    
    private func setupAnimations() {
        // Add subtle floating animation to result label
        let floatingAnimation = CABasicAnimation(keyPath: "transform.translation.y")
        floatingAnimation.duration = 2.0
        floatingAnimation.fromValue = -5
        floatingAnimation.toValue = 5
        floatingAnimation.autoreverses = true
        floatingAnimation.repeatCount = .infinity
        resultLabel.layer.add(floatingAnimation, forKey: "floating")
        
        // Add pulse animation to status label
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 1.5
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = 1.05
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .infinity
        statusLabel.layer.add(pulseAnimation, forKey: "pulse")
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
        
        // Animate result label with stronger effect
        UIView.animate(withDuration: 0.3, animations: {
            self.resultLabel.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.resultLabel.alpha = 0.8
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.resultLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.resultLabel.alpha = 1.0
            }
        }
        
        resultLabel.text = "\(String(format: "%.2f", bmi))"
        
        // Determinar el estado según el IMC
        var bmiColor = UIColor.red
        var showAlert = false
        
        switch bmi {
        case ..<18.5:
            statusLabel.text = "Bajopeso"
            bmiColor = UIColor(red: 0.4, green: 0.8, blue: 1.0, alpha: 1.0) // Azul claro
        case 18.5..<25:
            statusLabel.text = "Normal"
            bmiColor = UIColor(red: 0.4, green: 1.0, blue: 0.4, alpha: 1.0) // Verde brillante
        case 25..<30:
            statusLabel.text = "Sobrepeso"
            bmiColor = UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0) // Amarillo
        case 30..<35:
            statusLabel.text = "Obeso"
            bmiColor = UIColor(red: 1.0, green: 0.6, blue: 0.0, alpha: 1.0) // Naranja
            showAlert = true
        default:
            statusLabel.text = "Obesidad Extrema"
            bmiColor = UIColor(red: 1.0, green: 0.3, blue: 0.3, alpha: 1.0) // Rojo
            showAlert = true
        }
        
        // Animate status label color change with glow effect
        UIView.animate(withDuration: 0.3) {
            self.resultLabel.textColor = bmiColor
            self.statusLabel.textColor = bmiColor
            self.statusLabel.layer.shadowColor = bmiColor.cgColor
            self.statusLabel.layer.shadowOpacity = 0.8
        }
        
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
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        let bmiText = "Mi IMC es \(resultLabel.text ?? "0") - \(statusLabel.text ?? "")"
        let activityViewController = UIActivityViewController(activityItems: [bmiText], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
}
