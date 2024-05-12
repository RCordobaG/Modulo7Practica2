//
//  FavViewController.swift
//  MarvelApp
//
//  Created by Rodrigo Córdoba on 12/05/24.
//

import UIKit
import SDWebImage

class FavViewController: UIViewController {
    
    var keyLoader = KeyLoader.shared
    var characterManager : CharacterServiceManager?
    var selectedCharacter : Character?
    
    var favList : [FavoriteCharacter] = []
    
    var favManager : FavCharManager?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var FavCharacterCollectionView: UICollectionView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //print(keyLoader.getAPIParams())
        //print(keyLoader.getQueryString())
        
        FavCharacterCollectionView.delegate = self
        FavCharacterCollectionView.dataSource = self
        
        
        favManager = FavCharManager(context: context)
        
        favList = favManager?.getFavs() ?? []
        print(favList)
        print(favList[0].name)
        
        print(favList.count)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension FavViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favList.count
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCharacter = characterManager?.getCharacter(at: indexPath.item)
        self.performSegue(withIdentifier: "showCharDetail", sender: Self.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetailViewController
        destination.character = selectedCharacter
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CharacterCell
        print(indexPath.row)
        cell.characterName.text = favList[indexPath.row].name
        let url = URL(string: (favList[indexPath.row].thumbnail)!)
        cell.characterImage.sd_setImage(with: url)
        
        return cell
    }
}

extension FavViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        ////        size of scrollview content
//                print("contentSize.height", scrollView.contentSize.height)
        ////        screen's available space for scrollview element
//                print("bounds.height:", scrollView.bounds.height)
        ////        contentOffset y = contentSize.height - bounds.height
//                print("contentOffset y:", scrollView.contentOffset.y)
         
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollviewHeight = scrollView.bounds.height

        if (offsetY > (contentHeight - scrollviewHeight)) && (!characterManager!.maxItemsLoaded && !characterManager!.isLoading ){
            print("calling API...")
            self.characterManager!.isLoading = true
            let queryString = keyLoader.getQueryString(limit: Constants.numberOfItemsRequested, offset: self.characterManager!.offset)
                print("qs:",queryString)

            self.characterManager!.loadCharacterData(queryString: queryString){
                DispatchQueue.main.async {
                    self.FavCharacterCollectionView.reloadData()
                    print("char com:",self.characterManager!.countCharacter())
                    print("actual offset: ", self.characterManager!.offset)
                    self.characterManager!.offset = self.characterManager!.countCharacter()
                    print("new offset: ", self.characterManager!.offset)
                    self.characterManager!.isLoading = false
                }
            }
        }
        else{
            print("Don't call API...")
        }
    }
}
