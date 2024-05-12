//
//  DetailViewController.swift
//  MarvelApp
//
//  Created by Rodrigo Córdoba on 11/05/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    var character : Character!
    var detail : CharacterDetail!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var newChar : FavoriteCharacter?
    
    var favManager : FavCharManager?

    @IBOutlet weak var thumbnail: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var url: UILabel!
    
    @IBOutlet weak var charDescr: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favManager = FavCharManager(context: context)
        
        let characterDetail = CharacterDetail(name: character.name, thumbnail: character.thumbnail.url, descr: character.description, URL: character.resourceURI)
        // Do any additional setup after loading the view.
        
        name.text = characterDetail.name
        url.text = characterDetail.URL
        charDescr.text = characterDetail.descr
        
        self.title = characterDetail.name
        
        let url = URL(string: (character.thumbnail.url))
        thumbnail.sd_setImage(with: url)
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addFav(_ sender: Any) {
        favManager?.createChar(name: character.name, url: character.urls.description, thumbnail: character.thumbnail.url, description: character.description)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
