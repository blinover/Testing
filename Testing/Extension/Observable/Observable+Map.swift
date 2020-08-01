//
//  Observable+Map.swift
//  Testing
//
//  Created by Danil Blinov on 01.08.2020.
//  Copyright © 2020 Danil Blinov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
	func map<T: Decodable>(to type: T.Type, haveHierarchy: Bool = false) -> Observable<Result<T, APIError>> {
		return flatMap { element -> Observable<Result<T, APIError>> in
			guard let value = element as? Dict else {
				throw NSError(domain: "test.ru", code: -101, userInfo: [NSLocalizedDescriptionKey: "Response is empty"])
			}

			if let obj = value.decode(as: T.self) {
				return .just(.success(obj))
			}

			throw NSError(domain: "test.ru", code: -101, userInfo: [NSLocalizedDescriptionKey: "Response is empty"])
		}
	}

//	func mapArray<T: Decodable>(to type: T.Type, keyPath: String = "data") -> Observable<[T]> {
//		return flatMap { element -> Observable<[T]> in
//			guard let value = element as? Dict else {
//				throw NSError(domain: "test.ru", code: -101, userInfo: [NSLocalizedDescriptionKey: "Response is empty"])
//			}
//
//			guard let objects = value.dictArray else {
//				throw NSError(domain: "test.ru", code: -101, userInfo: [NSLocalizedDescriptionKey: "\(keyPath) is empty"])
//			}
//			print("------------------")
//			print(objects)
//			let arr = objects.compactMap { $0.decode(as: T.self) }
//			return .just(arr)
//		}
//	}
}
