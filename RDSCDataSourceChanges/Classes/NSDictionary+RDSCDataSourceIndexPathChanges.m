//
//  NSDictionary+RDSCDataSourceIndexPathChanges.m
//  Pods
//
//  Created by Reitzfeld, Richard on 7/6/16.
//
//

#import "NSDictionary+RDSCDataSourceIndexPathChanges.h"
#import "NSOrderedSet+RDSCDataChanges.h"
#import "RDSCDataSourceIndexPathChanges.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation NSDictionary (RDSCDataSourceIndexPathChanges)

+(nullable RDSCDataSourceIndexPathChanges*)dataChangesFromOldDataSectionMapping:(nullable NSDictionary<id,NSOrderedSet<id>*>*)dataSectionMapping_old
                                                           newDataSectionMapping:(nullable NSDictionary<id,NSOrderedSet<id>*>*)dataSectionMapping_new
                                              indexPathSectionForSectionKeyBlock:(nonnull NSDictionary_RDSCDataSourceIndexPathChanges__indexPathSectionForSectionKeyBlock)indexPathSectionForSectionKeyBlock
                                                      indexPathRowForObjectBlock:(nonnull NSDictionary_RDSCDataSourceIndexPathChanges__indexPathRowForObjectBlock)indexPathRowForObjectBlock
{
  kRUConditionalReturn_ReturnValueNil(indexPathSectionForSectionKeyBlock == nil, YES);
  kRUConditionalReturn_ReturnValueNil(indexPathRowForObjectBlock == nil, YES);
  
  __block RDSCDataSourceIndexPathChanges* dataSourceIndexPathChanges = nil;
  
  //Delete removed sections
  [dataSectionMapping_old enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull sectionKey_old, NSOrderedSet<id> * _Nonnull sectionObjects_old, BOOL * _Nonnull stop) {
    
    NSOrderedSet* sectionObjects_new = [dataSectionMapping_new objectForKey:sectionKey_old];
    
    NSInteger indexPathSection_old = indexPathSectionForSectionKeyBlock(sectionKey_old,
                                                                        dataSectionMapping_old);
    kRUConditionalReturn(indexPathSection_old == NSNotFound, YES);
    
    RDSCDataSourceIndexPathChanges* dataSourceIndexPathChanges_new = [NSOrderedSet deleteDataChangesFromOldOrderedSet:sectionObjects_old
                                                                                                         newOrderedSet:sectionObjects_new
                                                                                               indexPathForObjectBlock:^NSIndexPath * _Nonnull(id  _Nonnull object)
                                                                    {
                                                                      NSInteger indexPathRow_old = indexPathRowForObjectBlock(object,
                                                                                                                              sectionObjects_old,
                                                                                                                              sectionKey_old,
                                                                                                                              dataSectionMapping_old);
                                                                      return [NSIndexPath indexPathForRow:indexPathRow_old inSection:indexPathSection_old];
                                                                    }
                                                                                    indexPathSectionForOrderedSetBlock:^NSInteger(NSOrderedSet * _Nonnull orderedSet)
                                                                    {
                                                                      return indexPathSection_old;
                                                                    }];
    
    dataSourceIndexPathChanges = [[RDSCDataSourceIndexPathChanges alloc]initWithDataSourceIndexPathChanges:dataSourceIndexPathChanges
                                                                       addedToDataSourceIndexPathChanges:dataSourceIndexPathChanges_new];
  }];
  
  //Insert new sections
  [dataSectionMapping_new enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull sectionKey_new, NSOrderedSet<id> * _Nonnull sectionObjects_new, BOOL * _Nonnull stop) {
    
    NSOrderedSet* sectionObjects_old = [dataSectionMapping_old objectForKey:sectionKey_new];
    
    NSInteger indexPathSection_new = indexPathSectionForSectionKeyBlock(sectionKey_new,
                                                                        dataSectionMapping_new);
    kRUConditionalReturn(indexPathSection_new == NSNotFound, YES);
    
    RDSCDataSourceIndexPathChanges* dataSourceIndexPathChanges_new = [NSOrderedSet insertDataChangesFromOldOrderedSet:sectionObjects_old
                                                                                                         newOrderedSet:sectionObjects_new
                                                                                               indexPathForObjectBlock:^NSIndexPath * _Nonnull(id  _Nonnull object)
                                                                    {
                                                                      NSInteger indexPathRow_new = indexPathRowForObjectBlock(object,
                                                                                                                              sectionObjects_new,
                                                                                                                              sectionKey_new,
                                                                                                                              dataSectionMapping_new);
                                                                      kRUConditionalReturn_ReturnValueNil(indexPathRow_new == NSNotFound, YES);
                                                                      
                                                                      return [NSIndexPath indexPathForRow:indexPathRow_new inSection:indexPathSection_new];
                                                                    }
                                                                                    indexPathSectionForOrderedSetBlock:^NSInteger(NSOrderedSet * _Nonnull orderedSet)
                                                                    {
                                                                      return indexPathSection_new;
                                                                    }];
    
    dataSourceIndexPathChanges = [[RDSCDataSourceIndexPathChanges alloc]initWithDataSourceIndexPathChanges:dataSourceIndexPathChanges
                                                                       addedToDataSourceIndexPathChanges:dataSourceIndexPathChanges_new];
    
  }];
  
  return dataSourceIndexPathChanges;
}

@end
