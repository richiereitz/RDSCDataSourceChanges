//
//  NSOrderedSet+RDSCDataChanges.m
//  Pods
//
//  Created by Reitzfeld, Richard on 7/6/16.
//
//

#import "NSOrderedSet+RDSCDataChanges.h"
#import "NSSet+RDSCSetDifferences.h"
#import "RDSCDataSourceIndexPathChanges.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation NSOrderedSet (RDSCDataChanges)

#pragma mark - Index Paths For Objects
+(nullable NSArray<NSIndexPath*>*)indexPathsFromSet:(nullable NSSet*)set
							indexPathForObjectBlock:(nonnull NSOrderedSet_RDSCDataChanges__indexPathForObjectBlock)indexPathForObjectBlock
{
	NSMutableArray<NSIndexPath*>* indexPathsForObjects = [NSMutableArray array];
	
	[set enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
		
		NSIndexPath* indexPath = indexPathForObjectBlock(obj);
		BOOL indexPath_add = (indexPath != nil);
		NSAssert(indexPath_add, @"no indexPath for obj: %@",obj);
		if (indexPath_add)
		{
			[indexPathsForObjects addObject:indexPath];
		}
		else
		{
			//Aborts if no index path available
			*stop = YES;
		}
		
	}];
	
	kRUConditionalReturn_ReturnValueNil(indexPathsForObjects.count != set.count, YES);
	
	return [indexPathsForObjects copy];
}

#pragma mark - RDSCDataSourceIndexPathChanges
+(nullable RDSCDataSourceIndexPathChanges*)deleteDataChangesFromOldOrderedSet:(nullable NSOrderedSet*)oldOrderedSet
																newOrderedSet:(nullable NSOrderedSet*)newOrderedSet
													  indexPathForObjectBlock:(nonnull NSOrderedSet_RDSCDataChanges__indexPathForObjectBlock)indexPathForObjectBlock
										   indexPathSectionForOrderedSetBlock:(nonnull NSOrderedSet_RDSCDataChanges__indexPathSectionForOrderedSetBlock)indexPathSectionForOrderedSetBlock
{
	kRUConditionalReturn_ReturnValueNil(indexPathForObjectBlock == nil, YES);
	kRUConditionalReturn_ReturnValueNil(indexPathSectionForOrderedSetBlock == nil, YES);
	
	/*
	 If there are new objects, we need to determine the deleted objects, and turn to index paths
	 */
	if (newOrderedSet.count > 0)
	{
		NSSet* deletedObjects = [NSSet objectsDeletedFromObjects:[oldOrderedSet set]
													   toObjects:[newOrderedSet set]];
		
		NSArray<NSIndexPath*>* indexPathsToDelete = [self indexPathsFromSet:deletedObjects indexPathForObjectBlock:indexPathForObjectBlock];
		
		return [[RDSCDataSourceIndexPathChanges alloc]initWithDeletedIndexPathRows:[indexPathsToDelete copy]
														  deletedIndexPathSections:nil
															 insertedIndexPathRows:nil
														 insertedIndexPathSections:nil];
	}
	/*
	 If there were no new objects, but are old ones, we need to delete an index path section
	 */
	else if (oldOrderedSet.count > 0)
	{
		NSInteger indexPathSection = indexPathSectionForOrderedSetBlock(oldOrderedSet);
		
		BOOL indexPathSection_add = (indexPathSection != NSNotFound);
		kRUConditionalReturn_ReturnValueNil(indexPathSection_add == NSNotFound, YES);
		
		return [[RDSCDataSourceIndexPathChanges alloc]initWithDeletedIndexPathRows:nil
														  deletedIndexPathSections:[NSIndexSet indexSetWithIndex:indexPathSection]
															 insertedIndexPathRows:nil
														 insertedIndexPathSections:nil];
	}
	/*
	 If there were no new or old objects, no changes to the index path section
	 */
	else
	{
		return nil;
	}
}

+(nullable RDSCDataSourceIndexPathChanges*)insertDataChangesFromOldOrderedSet:(nullable NSOrderedSet*)oldOrderedSet
																newOrderedSet:(nullable NSOrderedSet*)newOrderedSet
													  indexPathForObjectBlock:(nonnull NSOrderedSet_RDSCDataChanges__indexPathForObjectBlock)indexPathForObjectBlock
										   indexPathSectionForOrderedSetBlock:(nonnull NSOrderedSet_RDSCDataChanges__indexPathSectionForOrderedSetBlock)indexPathSectionForOrderedSetBlock
{
	kRUConditionalReturn_ReturnValueNil(indexPathForObjectBlock == nil, YES);
	kRUConditionalReturn_ReturnValueNil(indexPathSectionForOrderedSetBlock == nil, YES);
	
	/*
	 If there are old objects, we need to determine the inserted objects, and turn to index paths
	 */
	if (oldOrderedSet.count > 0)
	{
		NSSet* insertedObjects = [NSSet objectsInsertedFromObjects:[oldOrderedSet set]
														 toObjects:[newOrderedSet set]];
		
		NSArray<NSIndexPath*>* indexPathsToInsert = [self indexPathsFromSet:insertedObjects indexPathForObjectBlock:indexPathForObjectBlock];
		
		return [[RDSCDataSourceIndexPathChanges alloc]initWithDeletedIndexPathRows:nil
														  deletedIndexPathSections:nil
															 insertedIndexPathRows:[indexPathsToInsert copy]
														 insertedIndexPathSections:nil];
	}
	/*
	 If there were no old objects, but are new ones, we need to insert an index path section
	 */
	else if (newOrderedSet.count > 0)
	{
		NSInteger indexPathSection = indexPathSectionForOrderedSetBlock(newOrderedSet);
		
		BOOL indexPathSection_add = (indexPathSection != NSNotFound);
		kRUConditionalReturn_ReturnValueNil(indexPathSection_add == NSNotFound, YES);
		
		return [[RDSCDataSourceIndexPathChanges alloc]initWithDeletedIndexPathRows:nil
														  deletedIndexPathSections:nil
															 insertedIndexPathRows:nil
														 insertedIndexPathSections:[NSIndexSet indexSetWithIndex:indexPathSection]];
	}
	/*
	 If there were no new or old objects, no changes to the index path section
	 */
	else
	{
		return nil;
	}
}

@end
