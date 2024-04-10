//
//  SelfTestVC.swift
//  dr_online
//
//  Created by Jayanth on 3/20/24.
//

import UIKit

class SelfTestVC: UIViewController, UITextFieldDelegate {
    
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
        
        // ML part implementation
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
