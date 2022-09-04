//
//  WikiData.swift
//  WhatFlower
//
//  Created by Noman Ashraf on 8/20/22.
//
/*
struct WikiData: Codable {
    var query: Query
}
struct Query: Codable {
    var pageids: [String]
    var pages: [String : Pages]
}
struct PageIds: Codable, Hashable {
    var id: [String]
}
struct Pages: Codable {
    var extract: String
}
 */
struct WikiData: Codable {
    let query: Query
}
struct Query: Codable {
    let pages: [String:Results]
}
struct Results:Codable { //This is the data you are interested in
    let pageid: Int
    let extract: String
    let title: String
    let thumbnail: ImageDetails
}
struct ImageDetails:Codable { //This is the data you are interested in
    let source: String
}
