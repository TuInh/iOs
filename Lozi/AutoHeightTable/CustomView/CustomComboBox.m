//
//  CustomComboBox.m
//  AutoHeightTable
//
//  Created by AnhLTV on 6/18/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "CustomComboBox.h"


@implementation CustomDropDownList

float ItemHeight = 50.0f;
float TableMargin = 20.0f;
-(instancetype) initWithDictionary:(NSMutableDictionary*) dictionay
{
    self = [super init];
    
    if (self)
    {
        [self setModalPresentationStyle:UIModalPresentationOverCurrentContext];
        [self.view setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
        self.itemDictionary = dictionay;
        
        float tableWidth = self.view.frame.size.width - TableMargin * 2.0f;
        float tableHeight = ItemHeight * self.itemDictionary.count;
        float tableTop = (self.view.frame.size.height - tableHeight) / 2.0f;
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(TableMargin, tableTop, tableWidth, tableHeight) style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate =self;
        self.tableView.scrollEnabled = false;
        [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"HistoryCell"];
        [self.view addSubview:self.tableView];
        
    }
    
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.itemDictionary count];
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"HistoryCell";
    
    // Similar to UITableViewCell, but
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    [cell.textLabel setText: [self.itemDictionary allKeys][indexPath.row]];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ItemHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dropDownDelegate)
    {
        [self.dropDownDelegate onSelectedItem: self.itemDictionary.allKeys[indexPath.row]];
    }
}
@end

@implementation CustomComboBox

-(instancetype) initWithFrame:(CGRect) frame andParentViewController:(UIViewController*) parentController andItemSelectedHandler:(id<UITableViewDelegate>) itemSelectedHandler
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.uiTextField = [[UITextField alloc] initWithFrame:frame];
        [self.uiTextField setFont:[UIFont preferredFontForTextStyle:@"UIFontTextStyleFootnote"]];
        [self.uiTextField setRightView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"triangleGrey"]]];
        [self.uiTextField setLeftViewMode:UITextFieldViewModeAlways];
        self.parentController = parentController;


        
    }
    
    return self;
}


-(void) InitView
{
    
}

@end




