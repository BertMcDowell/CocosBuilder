//
//  InspectorCustomArray.m
//  CocosBuilder
//
//  Created by Robert McDowell on 15/02/2014.
//
//

#import "InspectorCustomArray.h"
#import "CCNode+NodeInfo.h"
#import "CocosBuilderAppDelegate.h"
#import "CustomPropSetting.h"

@implementation InspectorCustomArray

- (void) awakeFromNib
{
    [super awakeFromNib];

    [textField setStringValue:[selection customPropertyNamed:propertyName]];
    
    CustomPropSetting * settings = [selection customPropertyWithName:propertyName];
    NSRect viewBounds = [self.view frame];
    NSRect scrollBounds = [scrollView frame];
    float height = scrollBounds.size.height;
    if ([settings childrenCount])
    {
        height = height *([settings childrenCount]-1);
    }
    else
    {
        height *= -1;
    }
    viewBounds.size.height += height;
    [self.view setFrame:viewBounds];    
}

- (NSArray*) contents
{
    return [[selection customPropertyWithName:propertyName] children];
}

@end
