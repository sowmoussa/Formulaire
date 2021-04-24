//
//  DetailsController.swift
//  Formulaire
//
//  Created by Moussa SOW on 20/04/2021.
//

import UIKit

class DetailsController: UIViewController {

    @IBOutlet weak var detailsV: UITextView!
    var profil: Profil?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if profil != nil {
            setup(profil!)
        }
        // Do any additional setup after loading the view.
    }
    
    func setup(_ profil: Profil) {
        detailsV.text = """
            Je suis \(profil.name) \(profil.surname)
            \(profil.name)
            \(profil.gender) \(profil.kids)
            \(profil.city)
            \(profil.weight)
            Situation: \(status(value: profil.situation))
            """
    }
    
    func status(value: Int) -> String {
        switch value {
            case 0: return "Célibataire"
            case 1: return "Marié"
            case 2: return "Divorcé"
            default: return "Veuf"
        }
    }

}
