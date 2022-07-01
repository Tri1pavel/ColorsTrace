//
//  ViewController.swift
//  CT
//
//  Created by Development on 23.06.2022.
//

import UIKit

class ColorsTraceViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    @IBOutlet var colorButtons: [UIButton]!
    @IBOutlet var undoBarButtonItem: UIBarButtonItem!
    @IBOutlet var redoBarButtonItem: UIBarButtonItem!
        
    private lazy var colorSelectionHandler: ColorSelectionHandler? = {
        let handler = ColorSelectionHandler(colors: colorButtons) { [weak self] color in
            self?.updateSelectedColorBarButtonItem(with: color)
            self?.colorCanvasHandler?.colorWasChanged(color)
        }
        return handler
    }()
    
    private lazy var colorCanvasHandler: ColorCanvasHandler? = {
        let handler = ColorCanvasHandler(canvas: colorView) { [weak self] isUndoEnabled, isRedoEnabled in
            self?.undoBarButtonItem.isEnabled = isUndoEnabled
            self?.redoBarButtonItem.isEnabled = isRedoEnabled
        }
        return handler
    }()
           
    private func updateSelectedColorBarButtonItem(with color: UIColor? = nil) {
        var barButtonItem: UIBarButtonItem?
        
        defer {
            self.navigationItem.leftBarButtonItem = barButtonItem
        }
        
        guard color != nil else {
            return
        }
        
        let size = 32.0
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: size, height: size))
        view.layer.cornerRadius = size * 0.5
        view.backgroundColor = color
        
        barButtonItem = UIBarButtonItem(customView: view)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateSelectedColorBarButtonItem()
    }

}

extension ColorsTraceViewController {
    
    @IBAction func buttonWasTapped(_ sender: UIButton) {
        colorSelectionHandler?.wasChanged(sender)
    }
    
    @IBAction func undoPressed(_ sender: UIBarButtonItem) {
        colorCanvasHandler?.undo()
    }
    
    @IBAction func redoPressed(_ sender: UIBarButtonItem) {
        colorCanvasHandler?.redo()
    }
    
}

