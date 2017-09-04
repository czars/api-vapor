//
//  ProfileRouteCollection.swift
//  api-honestbee
//
//  Created by Paul.Chou on 2017/9/4.
//
//

import Vapor

final class ProfileCollection: RouteCollection {
	func build(_ builder: RouteBuilder) throws {
		let users = builder.grouped("user")
		let userController = UserController()
		users.get("name", String.parameter, handler: userController.name)
		users.get("email", String.parameter, handler: userController.email)
		
		
	}
}
