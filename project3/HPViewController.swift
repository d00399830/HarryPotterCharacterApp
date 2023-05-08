//
//  ViewController.swift
//  project3
//
//  Created by Stratton McDonald on 11/8/21.
//

import UIKit

class HPViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet private var collectionView: UICollectionView!
    
    let characterDataSource = CharacterDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = characterDataSource
        collectionView.delegate = self
        
        CharacterStore.AllCharacters.fetchCharacters {
                (photosResult) in

                switch photosResult {
                case let .success(character):
                    self.characterDataSource.characters = character
                    print("Successfully found \(character.count) characters!")
                case let .failure(error):
                    print("Error fetching characters: \(error)")
                    self.characterDataSource.characters.removeAll()
                }
            self.collectionView.reloadSections(IndexSet(integer: 0))
            }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {

        let character = characterDataSource.characters[indexPath.row]

        // Download the image data, which could take some time
        CharacterStore.AllCharacters.fetchImage(for: character, house: "") { (result) -> Void in

            // The index path for the photo might have changed between the
            // time the request started and finished, so find the most
            // recent index path
            guard let characterIndex = self.characterDataSource.characters.firstIndex(of: character),
                case let .success(image) = result else {
                    return
            }
            let characterIndexPath = IndexPath(item: characterIndex, section: 0)

            // When the request finishes, find the current cell for this photo
            if let cell = self.collectionView.cellForItem(at: characterIndexPath)
                                                         as? CharacterCollectionViewCell {
                cell.update(displaying: image)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showCharacter":
            if let selectedIndexPath =
                    collectionView.indexPathsForSelectedItems?.first {

                let character = characterDataSource.characters[selectedIndexPath.row]

                let destinationVC = segue.destination as! CharacterInfoViewController
                destinationVC.photo = character
                destinationVC.store = CharacterStore.AllCharacters
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
    }
}

