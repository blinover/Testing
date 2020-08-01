//
//  MultiTarget.swift
//  Testing
//
//  Created by Danil Blinov on 01.08.2020.
//  Copyright © 2020 Danil Blinov. All rights reserved.
//

import Foundation
import Alamofire
import Moya
import RxSwift

typealias Dict = [String: Any]

final class MultiMoyaProvider: MoyaProvider<MultiTarget> {
	typealias Target = MultiTarget
	
	private let jsonDecoder: JSONDecoder
	
	override init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
								requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
								stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider<Target>.neverStub,
								callbackQueue: DispatchQueue?,
								session: Session,
								plugins: [PluginType] = [],
								trackInflights: Bool = false) {
		self.jsonDecoder = JSONDecoder()
		super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, session: session, plugins: plugins, trackInflights: trackInflights)
	}
}

extension MultiMoyaProvider {
	func request(_ target: MultiTarget) -> Observable<Result<Dict, APIError>> {
		return Observable.create { [weak self] (observable) -> Disposable in
			let request = self?.request(target) { [weak self] (result) in
				switch result {
					case .success(let response):
						self?.handleSuccess(for: observable, target, response)
					case .failure(let error):
						self?.handleFailure(error, observable)
				}
			}
			return Disposables.create {
				request?.cancel()
			}
		}
	}
	
	private func handleSuccess(for observable: AnyObserver<Result<Dict, APIError>>, _ target: Target, _ response: Response) {
		guard let json = try? JSONSerialization.jsonObject(with: response.data, options: []) as? Dict else {
			observable.onNext(.failure(.invalidData))
			observable.onCompleted()
			return
		}
		
		if response.response?.statusCode == 401 {
			if target.path.contains("refresh") {
				observable.onNext(.failure(.tokenExpired))
			} else {
				observable.onError(NSError(domain: "", code: 401, userInfo: nil))
			}
			observable.onCompleted()
			return
		}
		
		if response.response?.statusCode != 200 {
			do {
				let error = try jsonDecoder.decode(ErrorApiModel.self, from: response.data)
				observable.onNext(.failure(.serverError(error.error)))
			} catch {
				observable.onNext(.failure(.invalidData))
			}
		} else  {
				observable.onNext(.success(json))
		}
		observable.onCompleted()
	}
	
	func handleFailure(_ error: Error, _ observable: AnyObserver<Result<Dict, APIError>>) {
		let status = Reachability.shared.status.value
		if status == .notReachable {
			observable.onNext(.failure(.noInternet))
		} else {
			observable.onNext(.failure(.requestFailed))
			observable.onError(error)
		}
		observable.onCompleted()
	}
}
