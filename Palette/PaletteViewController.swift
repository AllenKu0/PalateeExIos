//
//  PaletteViewController.swift
//  Plalette
//
//  Created by imac-1682 on 2023/1/16.
//

import UIKit

class PaletteViewController: UIViewController {
    @IBOutlet weak var palateeView: UIView!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var redSlider: UISlider!
    
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var greenSlider: UISlider!
    
    @IBOutlet weak var blueTextField: UITextField!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var alphaTextFiled: UITextField!
    @IBOutlet weak var alphaSlider: UISlider!
    
    var redValue: Float = 0
    var greenValue: Float = 0
    var blueValue: Float = 0
    var alphaValue: Float = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    ///設定UI樣式
    func setUpUI(){
        setUpTextField(textField: redTextField, tag: 0)
        setUpTextField(textField: greenTextField, tag: 1)
        setUpTextField(textField: blueTextField, tag: 2)
        setUpTextField(textField: alphaTextFiled, tag: 3)
        
        setUpSlider(slider: redSlider, tag: 0)
        setUpSlider(slider: greenSlider, tag: 1)
        setUpSlider(slider: blueSlider, tag: 2)
        setUpSlider(slider: alphaSlider, tag: 3)
        
        palateeView.layer.borderWidth = 2.0
        palateeView.backgroundColor = .lightGray
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyBoard))
        view.addGestureRecognizer(tap)
    }
    
    
    /// Description
    /// - Parameters:
    ///   - textField: 要設定的TextField
    ///   - tag: textField的tag
    private func setUpTextField(textField: UITextField, tag: Int){
        textField.keyboardType = .numberPad
        textField.tag = tag
        textField.text = (tag == 3) ? "1" : "0"
    }
    
    /// Description
    /// - Parameters:
    ///   - slider: 要設定的slider
    ///   - tag: slider的tag
    private func setUpSlider(slider: UISlider, tag: Int){
        slider.tag = tag
        slider.value = (tag == 3) ? 1 : 0
    }
    
    @objc func closeKeyBoard(){
        view.endEditing(true)
    }
    
    func showAlert(title: String?, message: String?,confirmTitle :String,
                   confirm : (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message:message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
            confirm?()
        }
        alertController.addAction(confirmAction)
        present(alertController,animated: true)
    }
    
    /// Description
    /// - Parameter sender: textField變化時
    @IBAction func txtFieldChanged(_ sender: UITextField) {
        guard let text = sender.text , !(text.isEmpty) else{
            return
        }
        
        guard let textToFloat = Float(text),textToFloat <= 255 else {
            showAlert(title: "錯誤", message: "請輸入0-255之間的數值", confirmTitle: "關閉"){
                switch sender.tag{
                case 0:
                    sender.text = "0"
                    self.redSlider.value = 0
                case 1:
                    sender.text = "0"
                    self.greenSlider.value = 0
                case 2:
                    sender.text = "0"
                    self.blueSlider.value = 0
                case 3:
                    sender.text = "1"
                    self.alphaSlider.value = 1
                default :
                    break
                }
                self.initColor()
            }
            return
        }
        
        switch sender.tag{
        case 0:
            redValue = textToFloat
            redSlider.value = redValue
        case 1:
            greenValue = textToFloat
            greenSlider.value = greenValue
        case 2:
            blueValue = textToFloat
            blueSlider.value = blueValue
        case 3:
            alphaValue = textToFloat
            alphaSlider.value = alphaValue
        default :
            break
        }
        palateeView.backgroundColor = UIColor(red: CGFloat(redValue)/255,
                                              green: CGFloat(greenValue)/255,
                                              blue: CGFloat(blueValue)/255,
                                              alpha: CGFloat(alphaValue))
        
        view.backgroundColor = UIColor(red: CGFloat(redValue)/255,
                                       green: CGFloat(greenValue)/255,
                                       blue: CGFloat(blueValue)/255,
                                       alpha: CGFloat(alphaValue))
    }
    
    /// <#Description#>
    /// - Parameter sender: slider變化時
    @IBAction func sliderValueChange(_ sender: UISlider) {
        switch sender.tag{
        case 0:
            redValue = sender.value
            redTextField.text = "\(Int(sender.value))"
            redSlider.minimumTrackTintColor = UIColor(red: CGFloat(redValue)/255
                                                      , green: CGFloat(0)
                                                      , blue: CGFloat(0)
                                                      , alpha: CGFloat(1))
            
            redSlider.thumbTintColor = UIColor(red: CGFloat(redValue)/255
                                                      , green: CGFloat(0)
                                                      , blue: CGFloat(0)
                                                      , alpha: CGFloat(1))
        case 1:
            greenValue = sender.value
            greenTextField.text = "\(Int(sender.value))"
            greenSlider.minimumTrackTintColor = UIColor(red: CGFloat(0)
                                                        , green: CGFloat(greenValue)/255
                                                        , blue: CGFloat(0)
                                                        , alpha: CGFloat(1))
            
            greenSlider.thumbTintColor = UIColor(red: CGFloat(0)
                                                        , green: CGFloat(greenValue)/255
                                                        , blue: CGFloat(0)
                                                        , alpha: CGFloat(1))
        case 2:
            blueValue = sender.value
            blueTextField.text = "\(Int(sender.value))"
            blueSlider.minimumTrackTintColor = UIColor(red: CGFloat(0)
                                                       , green: CGFloat(0)
                                                       , blue: CGFloat(blueValue)/255
                                                       , alpha: CGFloat(1))
            
            blueSlider.thumbTintColor = UIColor(red: CGFloat(0)
                                                       , green: CGFloat(0)
                                                       , blue: CGFloat(blueValue)/255
                                                       , alpha: CGFloat(1))
        case 3:
            alphaValue = sender.value
            alphaTextFiled.text = String(format: "%.1f", sender.value)
            
        default :
            break
        }
        palateeView.backgroundColor = UIColor(red: CGFloat(redValue)/255,
                                              green: CGFloat(greenValue)/255,
                                              blue: CGFloat(blueValue)/255,
                                              alpha: CGFloat(alphaValue))
        
        view.backgroundColor = UIColor(red: CGFloat(redValue)/255,
                                       green: CGFloat(greenValue)/255,
                                       blue: CGFloat(blueValue)/255,
                                       alpha: CGFloat(alphaValue))
        
    }
    
    private func initColor(){
        self.view.backgroundColor = .white
        self.palateeView.backgroundColor = .lightGray
        
        redSlider.thumbTintColor = .white
        //
        greenSlider.thumbTintColor = .white
        //
        blueSlider.thumbTintColor = .white
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
