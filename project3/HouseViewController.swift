//
//  HouseViewController.swift
//  project3
//
//  Created by Stratton McDonald on 11/18/21.
//

import UIKit

class HouseViewController: UIViewController {
    
    @IBOutlet var founderLbl: UILabel!
    @IBOutlet var colorLbl: UILabel!
    @IBOutlet var animalLbl: UILabel!
    @IBOutlet var traitLbl: UILabel!
    @IBOutlet var founderIV: UIImageView!
    
    var character: Character!{
        didSet {
            navigationItem.title = character.house
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var url = ""
        
        if character.house == "Gryffindor" {
            url = "https://static.wikia.nocookie.net/harrypotter/images/3/31/Founders_gryffindor1.jpg/revision/latest?cb=20180611200439"
            founderLbl.text = "Godric Gryffindor"
            colorLbl.text = "Red"
            animalLbl.text = "Gryffin"
            traitLbl.text = "Courage"
        } else if character.house == "Slytherin" {
            url = "https://static.wikia.nocookie.net/harrypotter/images/6/60/PM_SalazarSlytherin_Founders.jpg/revision/latest?cb=20180611201037"
            founderLbl.text = "Salazar Slytherin"
            colorLbl.text = "Green"
            animalLbl.text = "Snake"
            traitLbl.text = "Cunning"
        } else if character.house == "Hufflepuff" {
            url = "https://static.wikia.nocookie.net/harrypotter/images/d/d6/PM_HelgaHufflepuff_Founders.jpg/revision/latest?cb=20180611201502"
            founderLbl.text = "Helga Hufflepuff"
            colorLbl.text = "Yellow"
            animalLbl.text = "Badger"
            traitLbl.text = "Hard Working"
        } else if character.house == "Ravenclaw" {
            url = "https://static.wikia.nocookie.net/harrypotter/images/1/1c/PM_RowenaRavenclaw_Founders.jpg/revision/latest?cb=20180611200720"
            founderLbl.text = "Rowena Ravenclaw"
            colorLbl.text = "Blue"
            animalLbl.text = "Raven"
            traitLbl.text = "Intelligence"
        } else if character.wizard {
            url = "https://pbs.twimg.com/profile_images/1430531630368702473/SxB92OCS.jpg"
            founderLbl.text = "Zoidberg?"
            colorLbl.text = "Beige?"
            animalLbl.text = "Santa"
            traitLbl.text = "Stupidity"
        } else {
            url = "https://www.betterthanpants.com/media/catalog/product/m/u/muggle--harry-potter-tshirt-large_1.png"
            founderLbl.text = "Zoidberg?"
            colorLbl.text = "Beige?"
            animalLbl.text = "Santa"
            traitLbl.text = "Stupidity"
        }
        print(url)
        CharacterStore.AllCharacters.fetchImage(for: character, house: url) { (result) -> Void in
            switch result {
            case let .success(image):
                self.founderIV.image = image
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
        
    
}
