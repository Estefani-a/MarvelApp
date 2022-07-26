//
//  CharactersDetailViewController.swift
//  MarvelApp
//
//  Created by Estefania Sassone on 11/07/2022.
//

import UIKit

class CharactersDetailViewController: UIViewController {
    
    var character: Character? {
        didSet {
            guard let character = character else { return }
            
            guard let characterImageUrl = character.thumbnail.path else { return }
            let thumbnailExtension = character.thumbnail.thumbnailExtension.rawValue
            
            characterImg.loadImage(urlString: characterImageUrl + "." + thumbnailExtension)
        }
    }
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var characterImg: ImageViewCache!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView(){
        lblName.text = character?.name
        lblDescription.text = character?.description
        
    }
    
    private func setupNavUI() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack)), animated: true)
    
    }
    
    @objc func handleBack() {
        navigationController?.popViewController(animated: true)
    }

}
