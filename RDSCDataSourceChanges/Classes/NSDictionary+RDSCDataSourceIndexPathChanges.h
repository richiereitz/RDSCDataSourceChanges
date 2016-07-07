//
//  NSDictionary+RDSCDataSourceIndexPathChanges.h
//  Pods
//
//  Created by Reitzfeld, Richard on 7/6/16.
//
//

#import <Foundation/Foundation.h>





@class RDSCDataSourceIndexPathChanges;





@interface NSDictionary<SectionKeyType, ObjectType> (RDSCDataSourceIndexPathChanges)

typedef NSInteger (^NSDictionary_RDSCDataSourceIndexPathChanges__indexPathSectionForSectionKeyBlock)(SectionKeyType _Nonnull sectionKey,
                                                                                                   NSDictionary<SectionKeyType,NSOrderedSet<ObjectType>*>* _Nonnull dataSectionMapping);

typedef NSInteger (^NSDictionary_RDSCDataSourceIndexPathChanges__indexPathRowForObjectBlock)(ObjectType _Nonnull object,
                                                                                           NSOrderedSet<ObjectType>* _Nonnull sectionObjects,
                                                                                           SectionKeyType _Nonnull sectionKey,
                                                                                           NSDictionary<SectionKeyType,NSOrderedSet<ObjectType>*>* _Nonnull dataSectionMapping);

+(nullable RDSCDataSourceIndexPathChanges*)dataChangesFromOldDataSectionMapping:(nullable NSDictionary<SectionKeyType,NSOrderedSet<ObjectType>*>*)dataSectionMapping_old
newDataSectionMapping:(nullable NSDictionary<SectionKeyType,NSOrderedSet<ObjectType>*>*)dataSectionMapping_new
indexPathSectionForSectionKeyBlock:(nonnull NSDictionary_RDSCDataSourceIndexPathChanges__indexPathSectionForSectionKeyBlock)indexPathSectionForSectionKeyBlock
indexPathRowForObjectBlock:(nonnull NSDictionary_RDSCDataSourceIndexPathChanges__indexPathRowForObjectBlock)indexPathRowForObjectBlock;

@end
