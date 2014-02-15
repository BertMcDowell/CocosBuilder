//
//  CustomPropSettings.m
//  CocosBuilder
//
//  Created by Robert McDowell on 24/01/2014.
//
//

#import "CustomPropSettings.h"
#import "CustomPropSetting.h"

@implementation CustomPropSettings
{
    NSMutableArray * _internal;
    id _selection;
}

+ (id) settings
{
    return [[[CustomPropSettings alloc] init] autorelease];
}

+ (id) settingsWithCapacity:(NSUInteger)numItems
{
   return [[[CustomPropSettings alloc] initWithCapacity:numItems] autorelease];
}

- (id) init
{
    self = [super init];
    if (!self) return NULL;
    
    _internal = [[NSMutableArray alloc] init];
    return self;
}

- (id)initWithCapacity: (NSUInteger)numItems
{
    self = [super init];
    if (!self) return NULL;
    
    _internal = [[NSMutableArray alloc] initWithCapacity:numItems];
    return self;
}

- (void)dealloc
{
    [_internal removeAllObjects];
    [_internal release];
    
    [_selection release];
    [super dealloc];
}

- (NSUInteger)count
{
    return [_internal count];
}

- (id)objectAtIndex: (NSUInteger)index
{
    return [_internal objectAtIndex:index];
}
- (void)addObject:(id)anObject
{
    if ([anObject isKindOfClass:[CustomPropSetting class]])
    {
        [(CustomPropSetting*)anObject setName:[NSString stringWithFormat:@"CustomItem%lu", (unsigned long)[_internal count]]];
    }
    
    [_internal addObject:anObject];
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if ([anObject isKindOfClass:[CustomPropSetting class]])
    {
        [(CustomPropSetting*)anObject setName:[NSString stringWithFormat:@"CustomItem%lu", (unsigned long)[_internal count]]];
    }
    
    if (_selection)
    {
        if ([_selection isKindOfClass:[CustomPropSetting class]])
        {
            CustomPropSetting * obj = (CustomPropSetting*)_selection;
            if (obj.type == kCCBCustomPropTypeArray)
            {
                [(CustomPropSetting*)obj addObject:anObject];
                
                [(CustomPropSetting*)anObject setParent:obj];
            }
            else if (obj.parent)
            {
                [(CustomPropSetting*)obj.parent addObject:anObject];
                
                [(CustomPropSetting*)anObject setParent:obj.parent];
            }
            else
            {
                NSInteger index = [_internal indexOfObject:_selection];
                if (index >= 0)
                {
                    [_internal insertObject:anObject atIndex:index];
                }
                else
                {
                    [_internal addObject:anObject];
                }
            }
        }
        else
        {
            [_internal addObject:anObject];
        }
    }
    else
    {
        [_internal addObject:anObject];
    }
}

- (void)removeLastObject
{
    [_internal removeLastObject];
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    [_internal removeObjectAtIndex:index];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    [_internal replaceObjectAtIndex:index withObject:anObject];
}

- (void)setSelected:(id)anObject
{
    [_selection release];
    _selection = [anObject retain];
}

@end
