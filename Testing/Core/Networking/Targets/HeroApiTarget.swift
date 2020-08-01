//
//  HeroApiService.swift
//  Testing
//
//  Created by Danil Blinov on 01.08.2020.
//  Copyright © 2020 Danil Blinov. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum HeroApiTarget {
	case heroes
	case hero(id: Int)
}

extension HeroApiTarget: TargetType {
	var baseURL: URL { return URL(string: "https://swapi.dev/api")! }
	
	var path: String {
		switch self {
			case .heroes:
			return "/people/"
			case .hero(let id):
			return "/people/\(id)/"
		}
	}
	
	var method: Moya.Method {
		switch self {
			case .hero, .heroes:
				return .get
		}
	}
	
	var sampleData: Data {
		return Data()
	}
	
	var task: Task {
		switch self {
			case .hero, .heroes:
				return .requestPlain
		}
	}
	
	var headers: [String : String]? {
		return ["Content-type": "application/json"]
	}
	
	
}
