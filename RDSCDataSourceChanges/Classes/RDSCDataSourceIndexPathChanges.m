//
//  RDSCDataSourceIndexPathChanges.m
//  Pods
//
//  Created by Reitzfeld, Richard on 7/6/16.
//
//

#import "RDSCDataSourceIndexPathChanges.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation RDSCDataSourceIndexPathChanges

#pragma mark - NSObject
-(instancetype)init
{
	return (self = [self initWithDeletedIndexPathRows:nil
							 deletedIndexPathSections:nil
								insertedIndexPathRows:nil
							insertedIndexPathSections:nil]);
}

#pragma mark - Init Methods
-(nonnull instancetype)initWithDeletedIndexPathRows:(nullable NSArray<NSIndexPath*>*)deletedIndexPathRows
						   deletedIndexPathSections:(nullable NSIndexSet*)deletedIndexPathSections
							  insertedIndexPathRows:(nullable NSArray<NSIndexPath*>*)insertedIndexPathRows
						  insertedIndexPathSections:(nullable NSIndexSet*)insertedIndexPathSections
{
	if (self = [super init])
	{
		_deletedIndexPathRows = [deletedIndexPathRows copy];
		_deletedIndexPathSections = [deletedIndexPathSections copy];
		_insertedIndexPathRows = [insertedIndexPathRows copy];
		_insertedIndexPathSections = [insertedIndexPathSections copy];
	}
	
	return self;
}

-(nonnull instancetype)initWithDeletedIndexPathRows:(nullable NSArray<NSIndexPath*>*)deletedIndexPathRows
						   deletedIndexPathSections:(nullable NSIndexSet*)deletedIndexPathSections
							  insertedIndexPathRows:(nullable NSArray<NSIndexPath*>*)insertedIndexPathRows
						  insertedIndexPathSections:(nullable NSIndexSet*)insertedIndexPathSections
				  addedToDataSourceIndexPathChanges:(nullable RDSCDataSourceIndexPathChanges*)addedToDataSourceIndexPathChanges
{
	RDSCDataSourceIndexPathChanges* dataSourceIndexPathChanges = [[RDSCDataSourceIndexPathChanges alloc] initWithDeletedIndexPathRows:deletedIndexPathRows
																											 deletedIndexPathSections:deletedIndexPathSections
																												insertedIndexPathRows:insertedIndexPathRows
																											insertedIndexPathSections:insertedIndexPathSections];
	
	return (self = [self initWithDataSourceIndexPathChanges:dataSourceIndexPathChanges
						  addedToDataSourceIndexPathChanges:addedToDataSourceIndexPathChanges]);
}

-(nonnull instancetype)initWithDataSourceIndexPathChanges:(nullable RDSCDataSourceIndexPathChanges*)dataSourceIndexPathChanges
						addedToDataSourceIndexPathChanges:(nullable RDSCDataSourceIndexPathChanges*)addedToDataSourceIndexPathChanges
{
	NSMutableArray<NSIndexPath*>* deletedIndexPathRows_final = [NSMutableArray array];
	NSMutableIndexSet* deletedIndexPathSections_final = [NSMutableIndexSet indexSet];
	NSMutableArray<NSIndexPath*>* insertedIndexPathRows_final = [NSMutableArray array];
	NSMutableIndexSet* insertedIndexPathSections_final = [NSMutableIndexSet indexSet];
	
	// dataSourceIndexPathChanges
	if (dataSourceIndexPathChanges.deletedIndexPathRows)
	{
		[deletedIndexPathRows_final addObjectsFromArray:dataSourceIndexPathChanges.deletedIndexPathRows];
	}
	
	if (dataSourceIndexPathChanges.deletedIndexPathSections)
	{
		[deletedIndexPathSections_final addIndexes:dataSourceIndexPathChanges.deletedIndexPathSections];
	}
	
	if (dataSourceIndexPathChanges.insertedIndexPathRows)
	{
		[insertedIndexPathRows_final addObjectsFromArray:dataSourceIndexPathChanges.insertedIndexPathRows];
	}
	
	if (dataSourceIndexPathChanges.insertedIndexPathSections)
	{
		[insertedIndexPathSections_final addIndexes:dataSourceIndexPathChanges.insertedIndexPathSections];
	}
	
	// addedToDataSourceIndexPathChanges
	if (addedToDataSourceIndexPathChanges.deletedIndexPathRows)
	{
		[deletedIndexPathRows_final addObjectsFromArray:addedToDataSourceIndexPathChanges.deletedIndexPathRows];
	}
	
	if (addedToDataSourceIndexPathChanges.deletedIndexPathSections)
	{
		[deletedIndexPathSections_final addIndexes:addedToDataSourceIndexPathChanges.deletedIndexPathSections];
	}
	
	if (addedToDataSourceIndexPathChanges.insertedIndexPathRows)
	{
		[insertedIndexPathRows_final addObjectsFromArray:addedToDataSourceIndexPathChanges.insertedIndexPathRows];
	}
	
	if (addedToDataSourceIndexPathChanges.insertedIndexPathSections)
	{
		[insertedIndexPathSections_final addIndexes:addedToDataSourceIndexPathChanges.insertedIndexPathSections];
	}
	
	return (self = [self initWithDeletedIndexPathRows:[deletedIndexPathRows_final copy]
							 deletedIndexPathSections:[deletedIndexPathSections_final copy]
								insertedIndexPathRows:[insertedIndexPathRows_final copy]
							insertedIndexPathSections:[insertedIndexPathSections_final copy]]);
}

#pragma mark - Apply Changes
-(void)applyChangesToTableView:(nonnull UITableView*)tableView
			deleteRowAnimation:(UITableViewRowAnimation)deleteRowAnimation
		deleteSectionAnimation:(UITableViewRowAnimation)deleteSectionAnimation
			insertRowAnimation:(UITableViewRowAnimation)insertRowAnimation
		insertSectionAnimation:(UITableViewRowAnimation)insertSectionAnimation
{
	kRUConditionalReturn(tableView == nil, YES);
	
	if (self.deletedIndexPathRows.count > 0)
	{
		[tableView deleteRowsAtIndexPaths:self.deletedIndexPathRows withRowAnimation:deleteRowAnimation];
	}
	
	if (self.deletedIndexPathSections.count > 0)
	{
		[tableView deleteSections:self.deletedIndexPathSections withRowAnimation:deleteSectionAnimation];
	}
	
	if (self.insertedIndexPathRows.count > 0)
	{
		[tableView insertRowsAtIndexPaths:self.insertedIndexPathRows withRowAnimation:insertRowAnimation];
	}
	
	if (self.insertedIndexPathSections.count > 0)
	{
		[tableView insertSections:self.insertedIndexPathSections withRowAnimation:insertSectionAnimation];
	}
}

@end

