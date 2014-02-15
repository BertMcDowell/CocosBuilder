//
//  CustomPropSettings.h
//  CocosBuilder
//
//  Created by Robert McDowell on 24/01/2014.
//
//

#import <Foundation/Foundation.h>

@interface CustomPropSettings : NSMutableArray

+ (id) settings;
+ (id) settingsWithCapacity:(NSUInteger)numItems;

- (id) init;
- (id) initWithCapacity:(NSUInteger)numItems;

- (void)addObject:(id)anObject;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)removeLastObject;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

- (void)setSelected:(id)anObject;


@end
