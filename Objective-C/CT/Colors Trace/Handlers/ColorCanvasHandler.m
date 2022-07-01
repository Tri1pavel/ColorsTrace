//
//  ColorCanvasHandler.m
//  CT
//
//  Created by Development on 01.07.2022.
//

#import "ColorCanvasHandler.h"
#import "Stack.h"

@interface ColorCanvasHandler ()
@property (strong, nonatomic) UIView *canvas;
@property (nonatomic, copy) void (^wasChanged)(BOOL isUndoEnabled, BOOL isRedoEnabled);

@property (strong, nonatomic) UIColor *selectedColor;
@property (strong, nonatomic) NSMutableDictionary *hashColorDictionary;
@property (strong, nonatomic) Stack *undoStack;
@property (strong, nonatomic) Stack *redoStack;
@end

@implementation ColorCanvasHandler

// Override Setters:
- (void)setCanvas:(UIView *)canvas {
    // A Boolean indicating whether sublayers are clipped to the layer’s bounds
    [canvas.layer setMasksToBounds:true];
    // Set the canvas
    _canvas = canvas;
    [self addTapGestureRecognizerToCanvas];
}

- (id)initWithCanvas:(UIView *) canvas
withWasChangedHandler:(void (^)(BOOL isUndoEnabled, BOOL isRedoEnabled)) wasChangedHandler {
    self = [super init];
    if (self) {
        self.canvas = canvas;
        self.wasChanged = wasChangedHandler;
        
        // Init dictionary for hash colors
        self.hashColorDictionary = [[NSMutableDictionary alloc] init];
        // Init undo stack
        self.undoStack = [[Stack alloc] init];
        // Init undo stack
        self.redoStack = [[Stack alloc] init];
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
    int current = [self updateHashWithColor:color withAscending:true];
    [view setText:[NSString stringWithFormat:@"%i",current]];
    // Add to canvas
    [self.canvas addSubview:view];
    // Add view to "undo" stack
    [self.undoStack push:view];
    // Completion handler
    BOOL isUndoEnabled = [self.undoStack.items count] == 0 ? false : true;
    BOOL isRedoEnabled = [self.redoStack.items count] == 0 ? false : true;
    self.wasChanged(isUndoEnabled, isRedoEnabled);
}

- (int)updateHashWithColor:(UIColor *) color withAscending:(BOOL) isAscending {
    int current = [[self.hashColorDictionary objectForKey:color] intValue];
    current = isAscending ? current + 1 : MAX(0, current - 1);
    [self.hashColorDictionary setObject:[NSNumber numberWithInt:current] forKey:color];
    return current;
}

- (void)colorWasChangedWith:(UIColor *)color {
    self.selectedColor = color;
}

- (void)undo {
    UIView *view = [self.undoStack pop];
    // Update hash for removed color
    [self updateHashWithColor: view.backgroundColor withAscending: false];
    // Remove view from canvas
    [view removeFromSuperview];
    // Add view to "redo" stack
    [self.redoStack push:view];
    // Completion handler
    BOOL isUndoEnabled = [self.undoStack.items count] == 0 ? false : true;
    BOOL isRedoEnabled = [self.redoStack.items count] == 0 ? false : true;
    self.wasChanged(isUndoEnabled, isRedoEnabled);
}

- (void)redo {
    UIView *view = [self.redoStack pop];
    // Get location from restored view
    CGPoint location = CGPointMake(view.frame.origin.x + view.frame.size.width * 0.5, view.frame.origin.y + view.frame.size.height * 0.5);
    // Get color from restored view
    UIColor *color = view.backgroundColor;
    // Add restored view at location on canvas with specific color
    [self addViewAt:location withColor:color];
}

@end

