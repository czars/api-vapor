//
//  User.swift
//  api-honestbee
//
//  Created by Paul.Chou on 2017/9/4.
//
//

import Vapor
import FluentProvider
import HTTP

final class User: Model {
	let storage = Storage()
	
	var name: String
	var email: String
	
	init(name: String, email: String) {
		self.name = name
		self.email = email
	}
	
	// MARK: Fluent Serialization
	
	/// Initializes the Post from the
	/// database row
	init(row: Row) throws {
		name = try row.get("name")
		email = try row.get("email")
	}
	
	// Serializes the Post to the database
	func makeRow() throws -> Row {
		var row = Row()
		try row.set("name", name)
		try row.set("email", email)
		return row
	}
}

extension User: Preparation {
	/// Prepares a table/collection in the database
	/// for storing Posts
	static func prepare(_ database: Database) throws {
		try database.create(self) { builder in
			builder.id()
			builder.string("name")
			builder.string("email")
		}
	}
	
	/// Undoes what was done in `prepare`
	static func revert(_ database: Database) throws {
		try database.delete(self)
	}
}

// MARK: JSON

// How the model converts from / to JSON.
// For example when:
//     - Creating a new Post (POST /posts)
//     - Fetching a post (GET /posts, GET /posts/:id)
//
extension User: JSONConvertible {
	convenience init(json: JSON) throws {
		try self.init(
			name: json.get("name"),
			email: json.get("email")
		)
	}
	
	func makeJSON() throws -> JSON {
		var json = JSON()
		try json.set("id", id)
		try json.set("name", name)
		try json.set("email", email)
		return json
	}
}

extension User: ResponseRepresentable { }


//extension User: Updateable {
//	// Updateable keys are called when `post.update(for: req)` is called.
//	// Add as many updateable keys as you like here.
//	public static var updateableKeys: [UpdateableKey<User>] {
//		return [
//			// If the request contains a String at key "content"
//			// the setter callback will be called. user.email = email
//			UpdateableKey("name", String.self) { user, name in
//				user.name = name
//			},
//			
//			UpdateableKey("eamil", String.self) { user, email in
//				user.email = email
//			}
//		]
//	}
//}
