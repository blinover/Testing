//
//  Dictionary.swift
//  Testing
//
//  Created by Danil Blinov on 01.08.2020.
//  Copyright © 2020 Danil Blinov. All rights reserved.
//

import Foundation

extension Dictionary {
	func decode<T: Decodable>(as type: T.Type) -> T? {
		guard let data = data else { return nil }
		do {
			return try data.decode(as: type)
		} catch {
			return nil
		}
	}
	
	var data: Data? {
		guard JSONSerialization.isValidJSONObject(self) else { return nil }
		return try? JSONSerialization.data(withJSONObject: self, options: [])
	}
}
