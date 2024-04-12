//
//  SelfTestVC.swift
//  dr_online
//
//  Created by Jayanth on 3/20/24.
//

import UIKit
import CoreML

class SelfTestVC: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var diseaseTV: UITextView!
    
    @IBOutlet weak var diseaselbl: UILabel!
    
    
    
    let model = predictdisease_1()
    
    
    @IBOutlet weak var sympselectScrollV: UIScrollView!
    @IBOutlet weak var predictBTN: UIButton!
    @IBOutlet weak var diseaseLBL: UILabel!
    @IBOutlet weak var symptomsScrollV: UIScrollView!
    @IBOutlet weak var outputTV: UITextView!
    var selectedsymptoms : [String] = []
    let symptomsArray = [
        "itching", "skin_rash", "nodal_skin_eruptions", "continuous_sneezing", "shivering",
        "chills", "joint_pain", "stomach_pain", "acidity", "ulcers_on_tongue",
        "muscle_wasting", "vomiting", "burning_micturition", "spotting_ urination", "fatigue",
        "weight_gain", "anxiety", "cold_hands_and_feets", "mood_swings", "weight_loss",
        "restlessness", "lethargy", "patches_in_throat", "irregular_sugar_level", "cough",
        "high_fever", "sunken_eyes", "breathlessness", "sweating", "dehydration",
        "indigestion", "headache", "yellowish_skin", "dark_urine", "nausea",
        "loss_of_appetite", "pain_behind_the_eyes", "back_pain", "constipation",
        "abdominal_pain", "diarrhoea", "mild_fever", "yellow_urine", "yellowing_of_eyes",
        "acute_liver_failure", "fluid_overload", "swelling_of_stomach", "swelled_lymph_nodes",
        "malaise", "blurred_and_distorted_vision"
    ]
    @IBAction func predictACT(_ sender: UIButton) {
        // Get the selected symptoms from the user
               let selectedSymptoms = outputTV.text.lowercased().split(separator: "\n").map { String($0) }
               
               // Perform disease prediction using ML model
               if let predictedDisease = predictDisease(symptoms: selectedSymptoms) {
                   // Display the predicted disease
                   outputTV.text = "Predicted Disease: \(predictedDisease)"
               } else {
                   outputTV.text = "Could not predict disease."
               }
           }
           
           func predictDisease(symptoms: [String]) -> String? {
               do {
                   // Prepare input for ML model
                   let input = predictdisease_1Input( itching: symptoms.contains("itching") ? 1 : 0,
                                                      skin_rash: symptoms.contains("skin_rash") ? 1 : 0,nodal_skin_eruptions: symptoms.contains("nodal_skin_eruptions") ? 1 : 0, continuous_sneezing: symptoms.contains("continuous_sneezing") ? 1 : 0, shivering: symptoms.contains("shivering") ? 1 : 0,chills: symptoms.contains("chills") ? 1 : 0, joint_pain:symptoms.contains("joint_pain") ? 1 : 0, stomach_pain: symptoms.contains("stomach_pain") ? 1 : 0, acidity:symptoms.contains("acidity") ? 1 : 0, ulcers_on_tongue: symptoms.contains("ulcers_on_tongue") ? 1 : 0, muscle_wasting:symptoms.contains("muscle_wasting") ? 1 : 0, vomiting:symptoms.contains("vomiting") ? 1 : 0, burning_micturition:symptoms.contains("burning_micturition") ? 1 : 0, spotting__urination:symptoms.contains("spotting__urination") ? 1 : 0, fatigue:symptoms.contains("fatigue") ? 1 : 0, weight_gain:symptoms.contains("itching") ? 1 : 0, anxiety:symptoms.contains("itching") ? 1 : 0, cold_hands_and_feets:symptoms.contains("itching") ? 1 : 0, mood_swings:symptoms.contains("itching") ? 1 : 0, weight_loss:symptoms.contains("itching") ? 1 : 0, restlessness: symptoms.contains("itching") ? 1 : 0, lethargy: symptoms.contains("itching") ? 1 : 0, patches_in_throat:symptoms.contains("itching") ? 1 : 0, irregular_sugar_level: symptoms.contains("itching") ? 1 : 0, cough: symptoms.contains("itching") ? 1 : 0, high_fever: symptoms.contains("itching") ? 1 : 0, sunken_eyes: symptoms.contains("itching") ? 1 : 0, breathlessness: symptoms.contains("itching") ? 1 : 0, sweating: symptoms.contains("itching") ? 1 : 0, dehydration: symptoms.contains("itching") ? 1 : 0, indigestion: symptoms.contains("itching") ? 1 : 0, headache: symptoms.contains("itching") ? 1 : 0, yellowish_skin: symptoms.contains("itching") ? 1 : 0, dark_urine: symptoms.contains("itching") ? 1 : 0, nausea: symptoms.contains("itching") ? 1 : 0, loss_of_appetite:  symptoms.contains("itching") ? 1 : 0, pain_behind_the_eyes: symptoms.contains("itching") ? 1 : 0, back_pain: symptoms.contains("itching") ? 1 : 0, constipation: symptoms.contains("itching") ? 1 : 0, abdominal_pain:symptoms.contains("itching") ? 1 : 0, diarrhoea: symptoms.contains("itching") ? 1 : 0, mild_fever: symptoms.contains("itching") ? 1 : 0, yellow_urine: symptoms.contains("itching") ? 1 : 0, yellowing_of_eyes: symptoms.contains("itching") ? 1 : 0, acute_liver_failure: symptoms.contains("itching") ? 1 : 0, fluid_overload:symptoms.contains("itching") ? 1 : 0, swelling_of_stomach:symptoms.contains("itching") ? 1 : 0, swelled_lymph_nodes: symptoms.contains("itching") ? 1 : 0, malaise:symptoms.contains("malaise") ? 1 : 0, blurred_and_distorted_vision: symptoms.contains("blurred_and_distorted_vision") ? 1 : 0)
                   
                   
                   let prediction = try model.prediction(input: input)
                   
                   
                   return prediction.prognosis
               } catch {
                   print("Error: \(error)")
                   return nil
               }
           }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSymptomLabels()
    }
    func addSymptomLabels() {
        var previousLabelMaxY: CGFloat = 0
        
        for symptom in symptomsArray {
            let label = createLabel(withText: symptom)
            let labelOriginY = previousLabelMaxY + 10
            label.frame = CGRect(x: 10, y: labelOriginY, width: sympselectScrollV.frame.width - 20, height: label.frame.height)
            let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(labelDoubleTapped))
            doubleTapGesture.numberOfTapsRequired = 2
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(doubleTapGesture)
            sympselectScrollV.addSubview(label)
            previousLabelMaxY = label.frame.maxY
        }
        sympselectScrollV.contentSize = CGSize(width: sympselectScrollV.frame.width, height: previousLabelMaxY + 10)
    }
    
    @objc func labelDoubleTapped(sender: UITapGestureRecognizer) {
        guard let labelsent = sender.view as? UILabel, let text = labelsent.text else { return }
        outputTV.text = outputTV.text + "\n" + text

        labelsent.removeFromSuperview()
    }
    func createLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0 // Allow label to wrap text
        label.sizeToFit() // Adjust label size to fit content within frame
        return label
    }
}
