//
//  FavCharManager.swift
//  MarvelApp
//
//  Created by Rodrigo Córdoba on 12/05/24.
//

import Foundation
import CoreData

class FavCharManager{
    private var favList : [FavoriteCharacter] = []
    private var context : NSManagedObjectContext
    
    init(context : NSManagedObjectContext){
        self.context = context
    }
    
    func fetch(){
        do{
            self.favList = try self.context.fetch(FavoriteCharacter.fetchRequest())
        }
        catch let error{
            print("Error: ", error)
        }
    }
    
    //CRUD: Create
    func createChar(name: String, url : String, thumbnail : String, description : String){
        
        let newChar = FavoriteCharacter(context: context)
        newChar.name = name
        newChar.details = description
        newChar.url = url
        newChar.thumbnail = thumbnail
        
        do{
            try context.save()
            return //newChar
        }
        catch let error{
            print("Error saving character: ", error)
            //return nil
        }
        
    }
    
    //CRUD: Read
    func countFavs() -> Int{
        return favList.count
    }
    
    func getFavs() -> [FavoriteCharacter]{
        if let charList = try? self.context.fetch(FavoriteCharacter.fetchRequest()){
            return charList
        }
        else{
            return []
        }
    }
    
    /*
    
    func getFavByID(uuid: UUID) -> Note?{
        do{
            let fetchRequest = NSFetchRequest<FavoriteCharacter>(entityName: "FavoriteCharacter")
            fetchRequest.predicate = NSPredicate(format: "id = %@", uuid as CVarArg)
            self.favList = try self.context.fetch(fetchRequest)
            return favList.first
        }
        catch let error{
            print("Error retrieving character with ID: ",uuid)
            print("Error: ", error)
            return nil
        }
        
    }
    
    
    //CRUD: Update
    func updateNoteDB(currentNote : Note, title: String, body: String, date: Date, fontSize : Int16, fontColor : String) -> Note?{
        
        let note = Note(context: context)
        note.id = UUID()
        note.title = title
        note.body = body
        note.date = date
        note.fontSize = fontSize
        note.fontColor = fontColor
        
        do{
            try context.save()
        }
        catch let error{
            print("Error updating note: ", error)
        }
        
        return note
    }
     */
    
    //CRUD: Delete
    func deleteNoteDB(char : FavoriteCharacter) -> Bool{
        self.context.delete(char)
        
        do{
            try context.save()
            return true
        }
        catch let error{
            print("Error deleting character: ",error)
            return false
        }
    }
}
