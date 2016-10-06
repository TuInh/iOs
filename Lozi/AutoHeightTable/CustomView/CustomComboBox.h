//
//  CustomComboBox.h
//  AutoHeightTable
//
//  Created by AnhLTV on 6/18/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomDropDownListDelegate<NSObject>
-(void) onSelectedItem: (NSString*) item;
@end


@interface CustomDropDownList: UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic) id<CustomDropDownListDelegate> dropDownDelegate;
@property(strong, nonatomic) NSMutableDictionary* itemDictionary;
@property(strong, nonatomic) UITableView* tableView;
-(instancetype) initWithDictionary:(NSMutableDictionary*) dictionay;
@end

@interface CustomComboBox : UIView
@property(nonatomic, strong) UITextField* uiTextField;
@property(nonatomic, strong) UIViewController* parentController;
@property(nonatomic, strong) CustomDropDownList* dropDownList;

-(instancetype) initWithFrame:(CGRect) frame andParentViewController:(UIViewController*) parentController andItemSelectedHandler:(id<UITableViewDelegate>) itemSelectedHandler;
@end




