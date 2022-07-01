//
//  ColorSelectionHandler.m
//  CT
//
//  Created by Development on 01.07.2022.
//

#import "ColorSelectionHandler.h"

@interface ColorSelectionHandler ()
@property (strong, nonatomic) NSArray *colorButtons;
@property (nonatomic, copy) void (^colorWasChanged)(UIColor *color);

@property (strong, nonatomic) UIColor *selectedColor;
@end

@implementation ColorSelectionHandler

// Override Setters:
- (void)setSelectedColor:(UIColor *)color {
    _selectedColor = color;
    self.colorWasChanged(color);
}

- (id)initWithColorButtons:(NSArray *) colorButtons
withColorWasChangedHandler:(void (^)(UIColor *color)) colorWasChangedHandler {
    self = [super init];
    if (self) {
        self.colorButtons = colorButtons;
        self.colorWasChanged = colorWasChangedHandler;
    }
    return self;
}

- (void)colorWasChanged:(UIButton *)sender {
    if (sender.isSelected) {
        // Deselect button that previously was selected
        sender.selected = !sender.selected;
    } else {
        // Deselect all buttons
        for (id color in self.colorButtons) {
            [color setSelected:false];
        }
        // Select the button that was tapped
        sender.selected = !sender.selected;
    }
    
    self.selectedColor = sender.isSelected ? sender.backgroundColor : nil;
}

@end

