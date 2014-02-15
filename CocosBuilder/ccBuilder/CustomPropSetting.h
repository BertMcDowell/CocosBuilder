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

#import <Foundation/Foundation.h>

enum
{
    kCCBCustomPropTypeInt = 0,
    kCCBCustomPropTypeFloat,
    kCCBCustomPropTypeBool,
    kCCBCustomPropTypeString,
    kCCBCustomPropTypeArray,
};

@interface CustomPropSetting : NSObject
{
    NSString* name;
    int type;
    BOOL optimized;
    
    NSObject* parent;
    NSObject* object;
}

@property (nonatomic,retain) NSObject* parent;
@property (nonatomic,retain) NSObject* object;

@property (nonatomic,readonly) NSMutableArray* children;
@property (nonatomic,readonly) int childrenCount;
@property (nonatomic,readonly) BOOL isLeaf;

@property (nonatomic,readonly) BOOL nameEditable;
@property (nonatomic,readonly) BOOL valueEditable;

@property (nonatomic,copy) NSString* name;
@property (nonatomic,assign) int type;
@property (nonatomic,assign) BOOL optimized;

@property (nonatomic,copy) NSString* value;

- (id) initWithSerialization:(id)ser;
- (id) serialization;

- (void) addObject:(NSObject *)object;

@end
