//
//  HelloController.swift
//  api-honestbee
//
//  Created by Paul.Chou on 2017/9/4.
//
//
import Vapor
import HTTP

final class HelloController {
	func sayHello(_ req: Request) throws -> ResponseRepresentable {
		guard let name = req.data["name"]?.string else {
			throw Abort(.badRequest)
		}
		
		return "Hello, \(name)"
	}
	
	func getJson(_ req: Request) throws -> ResponseRepresentable {
		return try JSON(node: [
			"number": 123,
			"string": "test",
			"array": try JSON(node: [
				0, 1, 2, 3
				]),
			"dict": try JSON(node: [
				"name": "Vapor",
				"lang": "Swift"
				])
			])
	}
	
	
}
