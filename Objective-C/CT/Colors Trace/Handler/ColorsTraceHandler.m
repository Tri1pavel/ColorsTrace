//
//  ColorsTraceHandler.m
//  CT
//
//  Created by Development on 24.06.2022.
//

#import "ColorsTraceHandler.h"
#import "Stack.h"

@interface ColorsTraceHandler ()
@property (strong, nonatomic) UIView *canvas;
@property (strong, nonatomic) NSArray *colorButtons;
@property (nonatomic, copy) void (^colorWasChanged)(UIColor *color);
@property (nonatomic, copy) void (^undoStackWasChanged)(BOOL isEnabled);

@property (strong, nonatomic) UIColor *selectedColor;
@property (strong, nonatomic) NSMutableDictionary *hashColorDictionary;
@property (strong, nonatomic) Stack *undoStack;
@end

@implementation ColorsTraceHandler

// Override the setter for selectedColor property
// and execute the closure block colorWasChanged(UIColor *color)
- (void)setSelectedColor:(UIColor *)color {
    _selectedColor = color;
    self.colorWasChanged(color);
}

- (id)initWithCanvas:(UIView *) canvas
    withColorButtons:(NSArray *) colorButtons
    withColorWasChangedHandler:(void (^)(UIColor *color)) colorWasChangedHandler
    withUndoStackWasChangedHandler:(void (^)(BOOL isEnabled)) undoStackWasChangedHandler {
    self = [super init];
    if (self) {
        self.canvas = canvas;
        self.colorButtons = colorButtons;
        self.colorWasChanged = colorWasChangedHandler;
        self.undoStackWasChanged = undoStackWasChangedHandler;
        
        // Init dictionary for hash colors
        self.hashColorDictionary = [[NSMutableDictionary alloc] init];
        // Init undo stack
        self.undoStack = [[Stack alloc] init];
        
        [self addTapGestureRecognizerToCanvas];
    }
    return self;
}

- (void)addTapGestureRecognizerToCanvas {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(addView:)];
    [self.canvas addGestureRecognizer:tapGesture];
}

- (void)addView:(UITapGestureRecognizer *) gesture {
    if (self.selectedColor) {
        // Get location on canvas
        CGPoint location = [gesture locationInView:self.canvas];
        UIColor *color = self.selectedColor;
        // Add view at location on canvas with specific color
        [self addViewAt:location withColor:color];
    }
}

- (void)addViewAt:(CGPoint) location withColor:(UIColor *) color {
    CGFloat size = 50.0;
    UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(location.x - size * 0.5, location.y - size * 0.5, size, size)];
    view.backgroundColor = color;
    // Add rounded corners
    view.layer.cornerRadius = size * 0.5;
    view.clipsToBounds = true;
    // Set font
    [view setFont:[UIFont systemFontOfSize:20]];
    // Set text attributes
    [view setTextColor:[UIColor whiteColor]];
    [view setTextAlignment:NSTextAlignmentCenter];
    // Update hash for added color
    int current = [self updateHashWithColor:color withAscending:TRUE];
    [view setText:[NSString stringWithFormat:@"%i",current]];
    // Add to canvas
    [self.canvas addSubview:view];
    // Add view to "undo" stack
    [self.undoStack push:view];
    // Undo completion handler
    BOOL isEnabled = [self.undoStack.items count] == 0 ? FALSE : TRUE;
    self.undoStackWasChanged(isEnabled);
}

- (int)updateHashWithColor:(UIColor *) color withAscending:(BOOL) isAscending {
    int current = [[self.hashColorDictionary objectForKey:color] intValue];
    current = isAscending ? current + 1 : MAX(0, current - 1);
    [self.hashColorDictionary setObject:[NSNumber numberWithInt:current] forKey:color];
    return current;
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

- (void)undo {
    UIView *view = [self.undoStack pop];
    // Undo completion handler
    BOOL isUndoEnabled = [self.undoStack.items count] == 0 ? FALSE : TRUE;
    self.undoStackWasChanged(isUndoEnabled);
    // Update hash for removed color
    [self updateHashWithColor: view.backgroundColor withAscending: FALSE];
    // Remove view from canvas
    [view removeFromSuperview];
}

@end
