//
//  RUOrderedDictionary+RDSCDataSourceIndexPathChanges.m
//  Pods
//
//  Created by Reitzfeld, Richard on 7/6/16.
//
//

#import "RUOrderedDictionary+RDSCDataSourceIndexPathChanges.h"
#import "NSDictionary+RDSCDataSourceIndexPathChanges.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>





@implementation RUOrderedDictionary (RDSCDataSourceIndexPathChanges)

+(nullable RDSCDataSourceIndexPathChanges*)dataChangesFromOldOrderedDataSectionMapping:(nullable RUOrderedDictionary<id,NSOrderedSet<id>*>*)dataSectionMapping_old
                                                           newOrderedDataSectionMapping:(nullable RUOrderedDictionary<id,NSOrderedSet<id>*>*)dataSectionMapping_new
                                                indexPathSectionForSectionKeyIndexBlock:(nonnull RUOrderedDictionary_RDSCDataSourceIndexPathChanges__indexPathSectionForSectionKeyIndexBlock)indexPathSectionForSectionKeyIndexBlock
                                                        indexPathRowForObjectIndexBlock:(nonnull RUOrderedDictionary_RDSCDataSourceIndexPathChanges__indexPathRowForObjectIndexBlock)indexPathRowForObjectIndexBlock
{
  NSOrderedSet<NSString*>* sectionKeys_sorted_old = [dataSectionMapping_old.allKeys copy];
  NSOrderedSet<NSString*>* sectionKeys_sorted_new = [dataSectionMapping_new.allKeys copy];
  
  NSOrderedSet<NSString*>* (^sectionKeys_sorted_dataSectionMapping)(NSDictionary<NSString*,NSOrderedSet<id>*>* _Nonnull dataSectionMapping) =
  ^NSOrderedSet<NSString*>*(NSDictionary<NSString*,NSOrderedSet<id>*>* _Nonnull dataSectionMapping){
    
    if (dataSectionMapping == dataSectionMapping_old)
    {
      return sectionKeys_sorted_old;
    }
    else if (dataSectionMapping == dataSectionMapping_new)
    {
      return sectionKeys_sorted_new;
    }
    NSAssert(false, @"unhandled");
    return nil;
  };
  
  RDSCDataSourceIndexPathChanges* dataSourceIndexPathChanges =
  [NSDictionary<NSString*,id> dataChangesFromOldDataSectionMapping:dataSectionMapping_old
                                                newDataSectionMapping:dataSectionMapping_new
                                   indexPathSectionForSectionKeyBlock:^NSInteger(NSString* _Nonnull sectionKey,
                                                                                 NSDictionary<NSString*,NSOrderedSet<id>*>* _Nonnull dataSectionMapping)
   {
     NSUInteger sectionKeyIndex = [sectionKeys_sorted_dataSectionMapping(dataSectionMapping) indexOfObject:sectionKey];
     kRUConditionalReturn_ReturnValue(sectionKeyIndex == NSNotFound, YES, NSNotFound);
     
     NSAssert(kRUClassOrNil(dataSectionMapping, RUOrderedDictionary) != nil, @"dataSectionMapping %@ should be of class RUOrderedDictionary, instead is %@",dataSectionMapping,[dataSectionMapping class]);
     
     return indexPathSectionForSectionKeyIndexBlock(sectionKeyIndex,(RUOrderedDictionary*)dataSectionMapping);
   }
                                           indexPathRowForObjectBlock:^NSInteger(id  _Nonnull object,
                                                                                 NSOrderedSet<id> * _Nonnull sectionObjects,
                                                                                 NSString * _Nonnull sectionKey,
                                                                                 NSDictionary<NSString *,NSOrderedSet<id> *> * _Nonnull dataSectionMapping)
   {
     NSUInteger objectIndex = [sectionObjects indexOfObject:object];
     kRUConditionalReturn_ReturnValue(objectIndex == NSNotFound, YES, NSNotFound);
     
     NSUInteger sectionKeyIndex = [sectionKeys_sorted_dataSectionMapping(dataSectionMapping) indexOfObject:sectionKey];
     kRUConditionalReturn_ReturnValue(sectionKeyIndex == NSNotFound, YES, NSNotFound);
     
     NSAssert(kRUClassOrNil(dataSectionMapping, RUOrderedDictionary) != nil, @"dataSectionMapping %@ should be of class RUOrderedDictionary, instead is %@",dataSectionMapping,[dataSectionMapping class]);
     
     return indexPathRowForObjectIndexBlock(objectIndex,sectionKeyIndex,(RUOrderedDictionary*)dataSectionMapping);
   }];
  
  return dataSourceIndexPathChanges;
}

@end
