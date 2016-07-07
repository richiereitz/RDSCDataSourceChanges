//
//  RDSCDataSourceChanges.h
//  Pods
//
//  Created by Reitzfeld, Richard on 7/6/16.
//
//

#import <Foundation/Foundation.h>





@interface RDSCDataSourceChanges<ObjectType> : NSObject

#pragma mark - Objects
@property (nonatomic, readonly, nullable) NSSet<ObjectType>* deletedObjects;
@property (nonatomic, readonly, nullable) NSSet<ObjectType>* insertedObjects;

#pragma mark - Init Methods
-(nonnull instancetype)initWithDeletedObjects:(nullable NSSet<ObjectType>*)deletedObjects
insertedObjects:(nullable NSSet<ObjectType>*)insertedObjects NS_DESIGNATED_INITIALIZER;

@end
