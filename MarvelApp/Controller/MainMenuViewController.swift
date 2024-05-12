//
//  MainMenuViewController.swift
//  MarvelApp
//
//  Created by Rodrigo Córdoba on 12/05/24.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var linkTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTextView()
    }
    
    func updateTextView(){
        let path = "https://marvel.com"
        let text = linkTextView.text ?? ""
        let attributedString = NSAttributedString.makeHyperlink(for: path, in: text, as: "here")
        linkTextView.attributedText = attributedString
    }
    
}
