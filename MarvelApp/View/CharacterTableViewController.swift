//
//  CharacterTableViewController.swift
//  MarvelApp
//
//  Created by Estefania Sassone on 22/07/2022.
//

import UIKit

class CharacterTableViewController: UITableViewController {
    
    var characters = [Character]()
    let cellIdentifier = "Cell"
    var character: Character?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CharactersTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        fetchCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationUI()
    }
    
    private func setupNavigationUI() {
        
        title = "Characters"
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = .red
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]

    }
    
    private func fetchCharacters(){
        var onError: (APIError) -> Void = {
            error in
            print("No se ha podido hacer la peticion")
        }
        
        var onSucces: (CharacterResponse) -> Void = {
            [weak self] response in
            self?.characters = response.data.characters
            self?.displayArray()
        }
        APIClient.shared.getCharacters(onSuccess: onSucces , onError: onError)
    }

    private func displayArray(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        let charactersDetailViewController = CharactersDetailViewController()
        charactersDetailViewController.character = character
        navigationController?.pushViewController(charactersDetailViewController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = characters[indexPath.row] //item
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CharactersTableViewCell
        cell.character = character
        
        return cell
    }

}
