//
//  NSTextFieldCellVertical.m
//  CocosBuilder
//
//  Created by Robert McDowell on 15/02/2014.
//
//

#import "NSTextFieldCellVertical.h"

@implementation NSTextFieldCellVertical

- (NSRect) titleRectForBounds:(NSRect)frame
{
    CGFloat stringHeight       = self.attributedStringValue.size.height;
    NSRect titleRect          = [super titleRectForBounds:frame];
    titleRect.origin.y = frame.origin.y +
    (frame.size.height - stringHeight) / 2.0;
    return titleRect;
}

- (void) drawInteriorWithFrame:(NSRect)cFrame inView:(NSView*)cView
{
    if (![self isBezeled])
    {
        [super drawInteriorWithFrame:[self titleRectForBounds:cFrame] inView:cView];
    }
    else
    {
        [super drawInteriorWithFrame:cFrame inView:cView];
    }
}

@end
