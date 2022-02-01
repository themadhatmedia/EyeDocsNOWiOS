//
//  Protocols.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 8/7/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation
import UIKit

protocol DegreeTextFieldDelegate:class {
    func nokri_didUpdateText(indexPath: IndexPath, txtDegreetTitle: UITextField?,txtDegreeInstitute: UITextField?, txtDegreetGrade: UITextField?, txtDegreePercent: UITextField?,txtDegreeStart: UITextField?,txtDegreeEnd: UITextField?, degreDetail:String)
}

protocol JobExperienceFieldDelegate:class {
    func nokri_didUpdateText(indexPath: IndexPath, txtOrganizationName: UITextField?,txtRole: UITextField?,txtDegreeStart: UITextField?,txtDegreeEnd: UITextField?, degreDetail:String,isChecked:String)
}

protocol JobCertificationFieldDelegate:class {
    func nokri_didUpdateText(indexPath: IndexPath, txtCertificationTitle: UITextField?,txtCerticationDuration: UITextField?,txtCertificationStart: UITextField?,txtCertificationEnd: UITextField?, degreDetail:String,txtCertificationInstitute:UITextField?)
}
