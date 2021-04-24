//
//  ViewController.swift
//  Formulaire
//
//  Created by Moussa SOW on 20/04/2021.
//

import UIKit

struct Profil {
    var name: String
    var surname: String
    var situation: Int
    var gender: Bool
    var kids: Int
    var weight: Double
    var date: Date
    var city: String
}

class ViewController: UIViewController {

    @IBOutlet weak var namePF: UITextField!
    @IBOutlet weak var surnamePF: UITextField!
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var genderSwitch: UISwitch!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var kidsLabel: UILabel!
    @IBOutlet weak var kidsStepper: UIStepper!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var cities = ["Dakar", "Rufisque", "Thies", "Nguekokh", "Matam", "Kedougou", "Fouta", "Mbao"]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
        namePF.delegate = self
        surnamePF.delegate = self
        datePicker.preferredDatePickerStyle = .automatic
        datePicker.datePickerMode = .date
        pickerView.delegate = self
        pickerView.dataSource = self
        weightSlider.minimumValue = 0
        weightSlider.maximumValue = 200
        weightSlider.value = 50
        updates()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let new = segue.destination as? DetailsController {
                new.profil = sender as? Profil
            }
        }
    }
    
    func updates() {
        genderLabel.text = genderSwitch.isOn ? "Homme" : "Femme"
        let intKids = Int(kidsStepper.value)
        kidsLabel.text = "\(intKids) enfant"
        let weightString = String(format: "%.2f", weightSlider.value)
        weightLbl.text = "Poids: \(weightString) kg"
    }
    @objc func close() {
        view.endEditing(true)
    }
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        print(segmented.selectedSegmentIndex)
    }
    @IBAction func datePick(_ sender: UIDatePicker) {
        print(datePicker.date)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        updates()
    }
    @IBAction func stepperChanged(_ sender: UIStepper) {
        updates()
    }
    @IBAction func switchChanged(_ sender: UISwitch) {
        updates()
    }
    @IBAction func validateAction(_ sender: Any) {
        if let name = namePF.text , name != "" {
            if let surname = surnamePF.text, surname != "" {
                let profil = Profil(
                    name: name,
                    surname: surname,
                    situation: segmented.selectedSegmentIndex,
                    gender: genderSwitch.isOn,
                    kids: Int(kidsStepper.value),
                    weight: Double(weightSlider.value),
                    date: datePicker.date,
                    city: cities[pickerView.selectedRow(inComponent: 0)])
                self.performSegue(withIdentifier: "detail", sender: profil)
            }else {
                print("Aucun prénom entré")
            }
        } else {
            print("Aucun nom entré")
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        close()
        return true
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
}
