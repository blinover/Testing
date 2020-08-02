//
//  HeroService.swift
//  Testing
//
//  Created by Danil Blinov on 01.08.2020.
//  Copyright © 2020 Danil Blinov. All rights reserved.
//

import Moya
import ReactiveMoya
import RxSwift

final class HeroService {
	private let apiManager = ApiManager(configuration: Enviorment())
	
	func getHero(by id: Int) -> Observable<Result<HeroApiModel, APIError>> {
		return apiManager.request(HeroApiTarget.hero(id: id)).map(to: HeroApiModel.self)
	}
}
