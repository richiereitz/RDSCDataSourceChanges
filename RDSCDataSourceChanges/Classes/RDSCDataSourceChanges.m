//
//  RDSCDataSourceChanges.m
//  Pods
//
//  Created by Reitzfeld, Richard on 7/6/16.
//
//

#import "RDSCDataSourceChanges.h"





@implementation RDSCDataSourceChanges

#pragma mark - NSObject
-(instancetype)init
{
  return (self = [self initWithDeletedObjects:nil
                              insertedObjects:nil]);
}

#pragma mark - Init Methods
-(nonnull instancetype)initWithDeletedObjects:(nullable NSSet*)deletedObjects
                              insertedObjects:(nullable NSSet*)insertedObjects
{
  if (self = [super init])
  {
    _deletedObjects = [deletedObjects copy];
    _insertedObjects = [insertedObjects copy];
  }
  
  return self;
}

@end
