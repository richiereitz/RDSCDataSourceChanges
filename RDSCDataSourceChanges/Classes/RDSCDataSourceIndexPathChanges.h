//
//  RDSCDataSourceIndexPathChanges.h
//  Pods
//
//  Created by Reitzfeld, Richard on 7/6/16.
//
//

#import <Foundation/Foundation.h>





@interface RDSCDataSourceIndexPathChanges : NSObject

#pragma mark - deletedIndexPathRows
@property (nonatomic, readonly, nullable) NSArray<NSIndexPath*>* deletedIndexPathRows;
@property (nonatomic, readonly, nullable) NSIndexSet* deletedIndexPathSections;

#pragma mark - insertedIndexPathRows
@property (nonatomic, readonly, nullable) NSArray<NSIndexPath*>* insertedIndexPathRows;
@property (nonatomic, readonly, nullable) NSIndexSet* insertedIndexPathSections;

#pragma mark - Init Methods
-(nonnull instancetype)initWithDeletedIndexPathRows:(nullable NSArray<NSIndexPath*>*)deletedIndexPathRows
                           deletedIndexPathSections:(nullable NSIndexSet*)deletedIndexPathSections
                              insertedIndexPathRows:(nullable NSArray<NSIndexPath*>*)insertedIndexPathRows
                          insertedIndexPathSections:(nullable NSIndexSet*)insertedIndexPathSections NS_DESIGNATED_INITIALIZER;

-(nonnull instancetype)initWithDeletedIndexPathRows:(nullable NSArray<NSIndexPath*>*)deletedIndexPathRows
                           deletedIndexPathSections:(nullable NSIndexSet*)deletedIndexPathSections
                              insertedIndexPathRows:(nullable NSArray<NSIndexPath*>*)insertedIndexPathRows
                          insertedIndexPathSections:(nullable NSIndexSet*)insertedIndexPathSections
                  addedToDataSourceIndexPathChanges:(nullable RDSCDataSourceIndexPathChanges*)addedToDataSourceIndexPathChanges;

-(nonnull instancetype)initWithDataSourceIndexPathChanges:(nullable RDSCDataSourceIndexPathChanges*)dataSourceIndexPathChanges
                        addedToDataSourceIndexPathChanges:(nullable RDSCDataSourceIndexPathChanges*)addedToDataSourceIndexPathChanges;

#pragma mark - Apply Changes
-(void)applyChangesToTableView:(nonnull UITableView*)tableView
            deleteRowAnimation:(UITableViewRowAnimation)deleteRowAnimation
        deleteSectionAnimation:(UITableViewRowAnimation)deleteSectionAnimation
            insertRowAnimation:(UITableViewRowAnimation)insertRowAnimation
        insertSectionAnimation:(UITableViewRowAnimation)insertSectionAnimation;

@end
