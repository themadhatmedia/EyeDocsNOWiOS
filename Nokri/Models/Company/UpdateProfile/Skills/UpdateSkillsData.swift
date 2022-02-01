//
//  UpdateSkillsData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/15/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation
struct UpdateSkillsData{
    
    var employesField :UpdateSkillEmployerField!
    var establish : UpdateSkillEstablish!
    var skillsField : UpdateSkillField!
    var skillsSelected : [AddSkillCandSkillSelected]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let employesFieldData = dictionary["employes_field"] as? [String:Any]{
            employesField = UpdateSkillEmployerField(fromDictionary: employesFieldData)
        }
        if let establishData = dictionary["establish"] as? [String:Any]{
            establish = UpdateSkillEstablish(fromDictionary: establishData)
        }
        if let skillsFieldData = dictionary["skills_field"] as? [String:Any]{
            skillsField = UpdateSkillField(fromDictionary: skillsFieldData)
        }
        skillsSelected = [AddSkillCandSkillSelected]()
        if let skillsSelectedArray = dictionary["skills_selected"] as? [[String:Any]]{
            for dic in skillsSelectedArray{
                let value = AddSkillCandSkillSelected(fromDictionary: dic)
                skillsSelected.append(value)
            }
        }
    }
  
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if employesField != nil{
            dictionary["employes_field"] = employesField.toDictionary()
        }
        if establish != nil{
            dictionary["establish"] = establish.toDictionary()
        }
        if skillsField != nil{
            dictionary["skills_field"] = skillsField.toDictionary()
        }
        if skillsSelected != nil{
            dictionary["skills_selected"] = skillsSelected
        }
        return dictionary
    }
    
}
