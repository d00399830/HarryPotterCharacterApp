//
//  CharacterInfoViewController.swift
//  project3
//
//  Created by Stratton McDonald on 11/14/21.
//

import UIKit

class CharacterInfoViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var dobLbl: UILabel!
    @IBOutlet var patronusLbl: UILabel!
    @IBOutlet var ancestryLbl: UILabel!
    @IBOutlet var lifeLbl: UILabel!
    
    
    var photo: Character! {
            didSet {
                if photo.wizard {
                    navigationItem.title = "Wizard"
                } else {
                    navigationItem.title = "Muggle"
                }
            }
        }
    var store: CharacterStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = photo.name
        if photo.dateOfBirth == "" {
            dobLbl.text = "Unknown"
        } else {
            dobLbl.text = photo.dateOfBirth
        }
        if photo.patronus == "" {
            patronusLbl.text = "Unknown"
        } else {
            patronusLbl.text = photo.patronus
        }
        if photo.ancestry == "" {
            ancestryLbl.text = "Unknown"
        } else {
            ancestryLbl.text = photo.ancestry
        }
        if photo.alive {
            lifeLbl.text = "Living"
        } else {
            lifeLbl.text = "Deceased"
        }
        var url = ""
        
        if photo.house == "Gryffindor" {
            navigationController?.navigationBar.backgroundColor = UIColor.red
            navigationController?.navigationBar.tintColor = UIColor.white
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
            url = "https://cdn11.bigcommerce.com/s-ydriczk/products/88361/images/91122/Harry-Potter-Gryffindor-Crest-Official-wall-mounted-cardboard-cutout-buy-now-at-star__95823.1507640354.450.659.jpg?c=2"
        } else if photo.house == "Slytherin" {
            navigationController?.navigationBar.tintColor = UIColor.black
            navigationController?.navigationBar.backgroundColor = UIColor.green
            url = "https://m.media-amazon.com/images/I/71jTE5obH-L._AC_SX466_.jpg"
        } else if photo.house == "Hufflepuff" {
            navigationController?.navigationBar.backgroundColor = UIColor.orange
            navigationController?.navigationBar.tintColor = UIColor.black
            url = "https://www.yourwdwstore.net/assets/images/3/30000/2000/100/32178.jpg"
        } else if photo.house == "Ravenclaw" {
            navigationController?.navigationBar.backgroundColor = UIColor.blue
            navigationController?.navigationBar.tintColor = UIColor.white
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
            url = "https://m.media-amazon.com/images/I/61iys32RuAL._AC_SY450_.jpg"
        } else if photo.wizard {
            url = "https://pbs.twimg.com/profile_images/1430531630368702473/SxB92OCS.jpg"
        } else {
            url = "https://www.betterthanpants.com/media/catalog/product/m/u/muggle--harry-potter-tshirt-large_1.png"
        }
        store.fetchImage(for: photo, house: url) { (result) -> Void in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showHouse":
            let destinationVC = segue.destination as! HouseViewController
            destinationVC.character = photo
            let backItem = UIBarButtonItem()
            backItem.title = photo.name
            navigationItem.backBarButtonItem = backItem
            

        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
}
