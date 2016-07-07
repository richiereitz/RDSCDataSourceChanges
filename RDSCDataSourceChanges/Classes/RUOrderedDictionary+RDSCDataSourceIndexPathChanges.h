//
//  RUOrderedDictionary+RDSCDataSourceIndexPathChanges.h
//  Pods
//
//  Created by Reitzfeld, Richard on 7/6/16.
//
//

#import <ResplendentUtilities/RUOrderedDictionary.h>





@class RDSCDataSourceIndexPathChanges;





@interface RUOrderedDictionary<SectionKeyType, ObjectType> (RDSCDataSourceIndexPathChanges)

typedef NSInteger (^RUOrderedDictionary_RDSCDataSourceIndexPathChanges__indexPathSectionForSectionKeyIndexBlock)(NSUInteger sectionKeyIndex,
                                                                                                               RUOrderedDictionary<SectionKeyType,NSOrderedSet<ObjectType>*>* _Nonnull dataSectionMapping);

typedef NSInteger (^RUOrderedDictionary_RDSCDataSourceIndexPathChanges__indexPathRowForObjectIndexBlock)(NSUInteger objectIndex,
                                                                                                       NSUInteger sectionKeyIndex,
                                                                                                       RUOrderedDictionary<SectionKeyType,NSOrderedSet<ObjectType>*>* _Nonnull dataSectionMapping);

+(nullable RDSCDataSourceIndexPathChanges*)dataChangesFromOldOrderedDataSectionMapping:(nullable RUOrderedDictionary<SectionKeyType,NSOrderedSet<ObjectType>*>*)dataSectionMapping_old
newOrderedDataSectionMapping:(nullable RUOrderedDictionary<SectionKeyType,NSOrderedSet<ObjectType>*>*)dataSectionMapping_new
indexPathSectionForSectionKeyIndexBlock:(nonnull RUOrderedDictionary_RDSCDataSourceIndexPathChanges__indexPathSectionForSectionKeyIndexBlock)indexPathSectionForSectionKeyIndexBlock
indexPathRowForObjectIndexBlock:(nonnull RUOrderedDictionary_RDSCDataSourceIndexPathChanges__indexPathRowForObjectIndexBlock)indexPathRowForObjectIndexBlock;

@end
