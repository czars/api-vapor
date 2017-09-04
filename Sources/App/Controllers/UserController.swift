//
//  UserController.swift
//  api-honestbee
//
//  Created by Paul.Chou on 2017/9/4.
//
//

import Vapor
import HTTP
import Fluent

final class UserController {
	func name(_ req: Request) throws -> ResponseRepresentable {
		print("print name")
		let user = try req.parameters.next(User.self)
		print(user)
		return try JSON(node: ["name": user.name])
	}
	
	func email(_ req: Request) throws -> ResponseRepresentable {
		let user = try req.parameters.next(User.self)
		return try JSON(node: ["email": user.email])
	}
	
	func index(_ req: Request) throws -> ResponseRepresentable {
		return try User.all().makeJSON()
	}
	
	func show(_ req: Request, user: User) throws -> ResponseRepresentable {
		return user
	}
	
	func store(_ req: Request) throws -> ResponseRepresentable {
		let user = try req.user()
		try user.save()
		return user
	}
}
extension UserController: ResourceRepresentable {
	func makeResource() -> Resource<User> {
		return Resource(
			index: index, //list
			store: store,
			show: show
		)
	}	
}


extension Request {
	/// Create a post from the JSON body
	/// return BadRequest error if invalid
	/// or no JSON
	func user() throws -> User {
		guard let json = json else { throw Abort.badRequest }
		return try User(json: json)
	}
}
