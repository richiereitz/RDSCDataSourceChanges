//
//  NSSet+RDSCSetDifferences.h
//  Pods
//
//  Created by Reitzfeld, Richard on 7/6/16.
//
//

#import <Foundation/Foundation.h>





@interface NSSet<ObjectType> (RDSCSetDifferences)

+(nullable instancetype)objectsDeletedFromObjects:(nonnull NSSet<ObjectType>*)fromObjects
toObjects:(nonnull NSSet<ObjectType>*)toObjects;

+(nullable instancetype)objectsInsertedFromObjects:(nonnull NSSet<ObjectType>*)fromObjects
toObjects:(nonnull NSSet<ObjectType>*)toObjects;

@end
