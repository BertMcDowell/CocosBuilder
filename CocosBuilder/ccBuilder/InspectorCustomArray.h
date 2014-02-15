//
//  InspectorCustomArray.h
//  CocosBuilder
//
//  Created by Robert McDowell on 15/02/2014.
//
//

#import "InspectorValue.h"

@interface InspectorCustomArray : InspectorValue
{
    IBOutlet NSTextField* textField;
    IBOutlet NSScrollView* scrollView;
}

@property (nonatomic,readonly) NSArray* contents;

@end
