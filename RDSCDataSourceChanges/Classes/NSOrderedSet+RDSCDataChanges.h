//
//  NSOrderedSet+RDSCDataChanges.h
//  Pods
//
//  Created by Reitzfeld, Richard on 7/6/16.
//
//

#import "NSOrderedSet+RDSCDataChangesBlocks.h"
#import <Foundation/Foundation.h>





@class RDSCDataSourceIndexPathChanges;





@interface NSOrderedSet<ObjectType> (SMDataChanges)

#pragma mark - Index Paths For Objects
+(nullable NSArray<NSIndexPath*>*)indexPathsFromSet:(nullable NSSet<ObjectType>*)set
indexPathForObjectBlock:(nonnull NSOrderedSet_RDSCDataChanges__indexPathForObjectBlock)indexPathForObjectBlock;

#pragma mark - RDSCDataSourceIndexPathChanges
+(nullable RDSCDataSourceIndexPathChanges*)deleteDataChangesFromOldOrderedSet:(nullable NSOrderedSet<ObjectType>*)oldOrderedSet
newOrderedSet:(nullable NSOrderedSet<ObjectType>*)newOrderedSet
indexPathForObjectBlock:(nonnull NSOrderedSet_RDSCDataChanges__indexPathForObjectBlock)indexPathForObjectBlock
indexPathSectionForOrderedSetBlock:(nonnull NSOrderedSet_RDSCDataChanges__indexPathSectionForOrderedSetBlock)indexPathSectionForOrderedSetBlock;

+(nullable RDSCDataSourceIndexPathChanges*)insertDataChangesFromOldOrderedSet:(nullable NSOrderedSet<ObjectType>*)oldOrderedSet
newOrderedSet:(nullable NSOrderedSet<ObjectType>*)newOrderedSet
indexPathForObjectBlock:(nonnull NSOrderedSet_RDSCDataChanges__indexPathForObjectBlock)indexPathForObjectBlock
indexPathSectionForOrderedSetBlock:(nonnull NSOrderedSet_RDSCDataChanges__indexPathSectionForOrderedSetBlock)indexPathSectionForOrderedSetBlock;

@end
