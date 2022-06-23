//
//  ViewController.swift
//  CT
//
//  Created by Development on 23.06.2022.
//

import UIKit

class ColorsTraceViewController: UIViewController {

    @IBOutlet var colorButtons: [UIButton]!
    
    private lazy var handler: ColorsTraceHandler? = {
        let handler = ColorsTraceHandler(colors: colorButtons, colorWasChanged: { color in
            self.updateNavigationItemSelectedColor(color)
        })
        return handler
    }()
       
    private func updateSelectedColorBarItem(with color: UIColor? = nil) -> UIBarButtonItem? {
        guard color != nil else {
            return nil
        }
        
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 32.0, height: 32.0))
        view.layer.cornerRadius = view.frame.width * 0.5
        view.backgroundColor = color

        return UIBarButtonItem(customView: view)
    }
    
    private func updateNavigationItemSelectedColor(_ color: UIColor? = nil) {
        self.navigationItem.leftBarButtonItem = updateSelectedColorBarItem(with: color)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateNavigationItemSelectedColor()
    }

}

extension ColorsTraceViewController {
    
    @IBAction func buttonWasTapped(_ sender: UIButton) {
        handler?.colorWasChanged(sender)
    }
    
}

