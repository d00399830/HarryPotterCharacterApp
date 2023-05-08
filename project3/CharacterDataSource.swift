//
//  CharacterDataSource.swift
//  project3
//
//  Created by Stratton McDonald on 11/13/21.
//

import UIKit

class CharacterDataSource: NSObject, UICollectionViewDataSource {
    var characters = [Character]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let identifier = "PhotoCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CharacterCollectionViewCell
        cell.update(displaying: nil)

        return cell
    }
}
