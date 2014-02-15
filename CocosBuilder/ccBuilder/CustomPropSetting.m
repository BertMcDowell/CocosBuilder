/*
 * CocosBuilder: http://www.cocosbuilder.com
 *
 * Copyright (c) 2012 Zynga Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "CustomPropSetting.h"

@implementation CustomPropSetting

@synthesize name;
@synthesize type;
@synthesize optimized;
@synthesize parent = parent;

- (id) init
{
    self = [super init];
    if (!self) return NULL;
    
    self.name = @"myCustomProperty";
    self.type = kCCBCustomPropTypeInt;
    self.optimized = NO;
    self.object = [NSNumber numberWithInt:0];
    
    return self;
}

- (id) initWithSerialization:(id)ser
{
    self = [super init];
    if (!self) return NULL;
    
    self.name = [ser objectForKey:@"name"];
    self.type = [[ser objectForKey:@"type"] intValue];
    self.optimized = [[ser objectForKey:@"optimized"] boolValue];
    //self.value = [ser objectForKey:@"value"];
    
    return self;
}

- (id) serialization
{
    NSMutableDictionary* ser = [NSMutableDictionary dictionary];
    
    [ser setObject:name forKey:@"name"];
    [ser setObject:[NSNumber numberWithInt:type] forKey:@"type"];
    [ser setObject:[NSNumber numberWithBool:optimized] forKey:@"optimized"];
    //[ser setObject:value forKey:@"value"];
    
    return ser;
}

- (void) dealloc
{
    self.name = NULL;
    self.parent = NULL;
    self.object = NULL;
    [super dealloc];
}

- (NSObject*) formatValue:(NSString*) val
{
    if (type == kCCBCustomPropTypeInt)
    {
        return [NSNumber numberWithInt:[val intValue]];
    }
    else if (type == kCCBCustomPropTypeFloat)
    {
        return [NSNumber numberWithFloat:[val floatValue]];
    }
    else if (type == kCCBCustomPropTypeBool)
    {
        return [NSNumber numberWithBool:[val boolValue]];
    }
    else if (type == kCCBCustomPropTypeString)
    {
        return val;
    }
    else if (type == kCCBCustomPropTypeArray)
    {
        return [NSMutableArray array];
    }
    else
    {
        NSAssert(NO, @"Undefined value type");
        return NULL;
    }
}

- (NSObject*) object
{
    return object;
}

- (void) setObject:(NSObject *)obj
{
    [object release];
    object = [obj retain];
}

- (NSMutableArray*) children
{
    return Obj_Cast(object, NSMutableArray);
}

- (int) childrenCount
{
    return [[self children] count];
}

- (BOOL) isLeaf
{
    return [self children] == NULL;
}

- (BOOL) nameEditable
{
    return parent == NULL;
}

- (BOOL) valueEditable
{
    return [self children] == NULL;
}

- (void) setType:(int)t
{
    if (t == type) return;
    
    NSString * val = self.value;
    BOOL wasLeaf = self.isLeaf;
    
    type = t;
    
    self.value = val;
    
    // Post an event to reload the data when we change leaf state
    // as the outline view does not seem to check this all the time :(
    if (wasLeaf != self.isLeaf)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CustomPropSettingsTypeChanged" object:self];
    }
}

- (void) setValue:(NSString *)val
{
    self.object = [self formatValue:val];
}

- (NSString*) value
{
    if (object)
    {
        switch (type) {
            case kCCBCustomPropTypeArray:
            {
                NSMutableArray* obj = Obj_Cast(object, NSMutableArray);
                assert(obj);
                return [NSString stringWithFormat:@"(%lu items)", (unsigned long)[obj count]];
                break;
            }
            default:
                return [NSString stringWithFormat:@"%@", object];
                break;
        }
    }
    return @"";
}

- (id) copyWithZone:(NSZone*)zone
{
    CustomPropSetting* copy = [[CustomPropSetting alloc] init];
    
    copy.name = name;
    copy.type = type;
    copy.optimized = optimized;
    
    copy.object = object;
    copy.parent = parent;
    
    return copy;
}

- (void) addObject:(NSObject *)obj
{
    NSMutableArray * array = [self children];
    if (array)
    {
        if ([obj isKindOfClass:[CustomPropSetting class]])
        {
            [(CustomPropSetting*)obj setName:[NSString stringWithFormat:@"item %d", [self childrenCount]]];
        }
        [array addObject:obj];
    }
}

@end
