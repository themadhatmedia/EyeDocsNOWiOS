//
//  AddSkillCanData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/14/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct AddSkillCanData{
    
    var skillsField : AddSkillCandSkillField!
    var skillsSelected : [AddSkillCandSkillSelected]!
    var skillsFieldValues : AddSkillCanFieldValue!
    
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let skillsFieldData = dictionary["skills_field"] as? [String:Any]{
            skillsField = AddSkillCandSkillField(fromDictionary: skillsFieldData)
        }
        if let skillsFieldValuesData = dictionary["skills_field_values"] as? [String:Any]{
            skillsFieldValues = AddSkillCanFieldValue(fromDictionary: skillsFieldValuesData)
        }
        skillsSelected = [AddSkillCandSkillSelected]()
        if let skillsSelectedArray = dictionary["skills_selected"] as? [[String:Any]]{
            for dic in skillsSelectedArray{
                let value = AddSkillCandSkillSelected(fromDictionary: dic)
                skillsSelected.append(value)
            }
        }
     
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if skillsField != nil{
            dictionary["skills_field"] = skillsField.toDictionary()
        }
        
        if skillsFieldValues != nil{
            dictionary["skills_field_values"] = skillsFieldValues.toDictionary()
        }
        
        if skillsSelected != nil{
            var dictionaryElements = [[String:Any]]()
            for skillsSelectedElement in skillsSelected {
                dictionaryElements.append(skillsSelectedElement.toDictionary())
            }
            dictionary["skills_selected"] = dictionaryElements
        }
        return dictionary
    }
    
}
