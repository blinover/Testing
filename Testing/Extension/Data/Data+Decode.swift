//
//  Data+Decode.swift
//  Testing
//
//  Created by Danil Blinov on 01.08.2020.
//  Copyright © 2020 Danil Blinov. All rights reserved.
//

import Foundation

extension Data {
	
	func decode<T: Decodable>(as type: T.Type) throws -> T? {
		do {
			let decoder = JSONDecoder()
			return try decoder.decode(type, from: self)
		} catch {
			throw error
		}
	}
	
}
