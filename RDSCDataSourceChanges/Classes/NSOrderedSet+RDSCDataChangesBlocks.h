//
//  NSOrderedSet+RDSCDataChangesBlocks.h
//  Pods
//
//  Created by Reitzfeld, Richard on 7/6/16.
//
//

#ifndef NSOrderedSet_RDSCDataChangesBlocks_h
#define NSOrderedSet_RDSCDataChangesBlocks_h





@interface NSOrderedSet<ObjectType> (RDSCDataChangesBlocks)

typedef  NSIndexPath* _Nonnull (^NSOrderedSet_RDSCDataChanges__indexPathForObjectBlock)(ObjectType _Nonnull object); //This needs to be in the @interface, so it recognizes `ObjectType`
typedef  NSInteger (^NSOrderedSet_RDSCDataChanges__indexPathSectionForOrderedSetBlock)(NSOrderedSet<ObjectType>* _Nonnull orderedSet); //This needs to be in the @interface, so it recognizes `ObjectType`

@end





#endif /* NSOrderedSet_RDSCDataChangesBlocks_h */
