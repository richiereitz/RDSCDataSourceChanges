//
//  NSSet+RDSCSetDifferences.m
//  Pods
//
//  Created by Reitzfeld, Richard on 7/6/16.
//
//

#import "NSSet+RDSCSetDifferences.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation NSSet (RDSCSetDifferences)

+(nullable NSSet*)objectsDeletedFromObjects:(nonnull NSSet*)fromObjects
                                     toObjects:(nonnull NSSet*)toObjects
{
  kRUConditionalReturn_ReturnValueNil(fromObjects == nil, YES);
  kRUConditionalReturn_ReturnValueNil(toObjects == nil, YES);
  
  kRUConditionalReturn_ReturnValue(fromObjects.count == 0, NO, [NSSet set]);
  kRUConditionalReturn_ReturnValue(toObjects.count == 0, NO, fromObjects);
  
  NSMutableSet* deletedObjects = [NSMutableSet setWithSet:fromObjects];
  [deletedObjects minusSet:toObjects];
  
  return [self setWithSet:deletedObjects];
}

+(nullable NSSet*)objectsInsertedFromObjects:(nonnull NSSet*)fromObjects
                                      toObjects:(nonnull NSSet*)toObjects
{
  kRUConditionalReturn_ReturnValueNil(fromObjects == nil, YES);
  kRUConditionalReturn_ReturnValueNil(toObjects == nil, YES);
  
  kRUConditionalReturn_ReturnValue(toObjects.count == 0, NO, [NSSet set]);
  kRUConditionalReturn_ReturnValue(fromObjects.count == 0, NO, toObjects);
  
  NSMutableSet* insertedObjects = [NSMutableSet setWithSet:toObjects];
  [insertedObjects minusSet:fromObjects];
  
  return [self setWithSet:insertedObjects];
}

@end
