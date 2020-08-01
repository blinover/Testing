//
//  HeroApiMode.swift
//  Testing
//
//  Created by Danil Blinov on 01.08.2020.
//  Copyright © 2020 Danil Blinov. All rights reserved.
//

import Foundation

struct HeroApiModel: Decodable {
	let birthYear, eyeColor: String?
	let films: [String]?
	let gender, hairColor, height: String?
	let homeworld: String?
	let mass: String?
	let name: String
	let skinColor, created, edited: String?
	let species, starships: [String]?
	let url: String?
	let vehicles: [String]?
	let founded: Int?
	let members: [String]?
	
	enum CodingKeys: String, CodingKey {
		case birthYear = "birth_year"
		case eyeColor = "eye_color"
		case films, gender
		case hairColor = "hair_color"
		case height, homeworld, mass, name
		case skinColor = "skin_color"
		case created, edited, species, starships, url, vehicles, founded, members
	}
}
