//
//  ViewController.swift
//  CT
//
//  Created by Development on 23.06.2022.
//

import UIKit

class ColorsTraceViewController: UIViewController {

    @IBOutlet var colorButtons: [UIButton]!
    
    @IBAction func buttonWasTapped(_ sender: UIButton) {
        guard !sender.isSelected else {
            // Deselect button that previously was selected
            sender.isSelected.toggle()
            return
        }
        
        // Deselect all buttons
        colorButtons.forEach { $0.isSelected = false }
        // Select the button that was tapped
        sender.isSelected.toggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

