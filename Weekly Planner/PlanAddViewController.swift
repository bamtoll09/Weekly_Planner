//
//  PlanAddViewController.swift
//  Weekly Planner
//
//  Created by Sunrin on 2017. 1. 3..
//  Copyright © 2017년 Bamtoll. All rights reserved.
//

import UIKit

class PlanAddViewController: UIViewController {
    
    let cancelButton = UIBarButtonItem(
        barButtonSystemItem: .cancel,
        target: nil,
        action: #selector(cancelButtonDidTap)
    )
    let saveButton = UIBarButtonItem(
        barButtonSystemItem: .save,
        target: nil,
        action: #selector(saveButtonDidTap)
    )
    let textField: UITextField = UITextField()
    let textView: UITextView = UITextView()
    
    var isRelease = false
    
    // When View Loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set SubView
        self.cancelButton.target = self
        self.saveButton.target = self
        self.textField.borderStyle = .roundedRect
        self.textView.layer.borderColor = UIColor.lightGray.cgColor
        self.textView.layer.borderWidth = 0.25
        self.textView.layer.cornerRadius = 5
        
        // Set Nav-Item
        self.navigationItem.title = "Add Your Plan!"
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = saveButton
        self.view.backgroundColor = .white
        
        
        // Set View
        
        // Add SubView
        self.view.addSubview(self.textField)
        self.view.addSubview(self.textView)
        
        // Test
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set SubView
        self.textField.frame = CGRect(
            x: 10,
            y: 74,
            width: self.view.frame.size.width - 20,
            height: 40
        )
        self.textView.frame = CGRect(
            x: 10,
            y: 124,
            width: self.view.frame.size.width - 20,
            height: 200
        )
    }
    
    func cancelButtonDidTap() {
        let alertController = UIAlertController(
            title: "Cancel",
            message: "Do you really want to cancel?",
            preferredStyle: .alert
        )
        let yes = UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        })
        let no = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertController.addAction(no)
        alertController.addAction(yes)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func saveButtonDidTap() {
        //self.dismiss(animated: true, completion: nil)
        
        if self.textField.text!.isEmpty {
            shake(_view: self.textField)
        } else {
            
        }
    }
    
    func shake(_view:UIView)
    {
        UIView.animate(withDuration: 0.05,
                       animations: { _view.frame.origin.x -= 10 },
                       completion: {_ in
                        UIView.animate(withDuration: 0.05,
                                       animations: { _view.frame.origin.x += 20 },
                                       completion: {_ in
                                        UIView.animate(withDuration: 0.05,
                                                       animations: { _view.frame.origin.x -= 15 },
                                                       completion: {_ in
                                                        UIView.animate(withDuration: 0.05,
                                                                       animations: { _view.frame.origin.x += 10 },
                                                                       completion: {_ in
                                                                        UIView.animate(withDuration: 0.05,
                                                                                       animations: { _view.frame.origin.x -= 5 },
                                                                                       completion: {_ in
                                                                                        _view.becomeFirstResponder()
                                                                        })
                                                        })
                                        })
                        })
        })
    }
    
}
