//
//  TupleExtentions.swift
//  contact-book
//
//  Created by admin on 23.01.22.
//

import Foundation

func == <T:Equatable> (tuple1:(T,T),tuple2:(T,T)) -> Bool
{
   return (tuple1.0 == tuple2.0) && (tuple1.1 == tuple2.1)
}
