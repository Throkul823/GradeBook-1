//
//  TAssignmentViewController.m
//  GradeBook
//
//  Created by Nissa Nishiyama on 5/19/13.
//
//

#import "TAssignmentViewController.h"

@interface TAssignmentViewController ()

@end

@implementation TAssignmentViewController
@synthesize dataArray, scoreTable;
NSIndexPath *deleteIndexPath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popToViewController:self.parentViewController.parentViewController animated:YES];
}
- (IBAction)reportsButton:(id)sender {
}


# pragma mark Table Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [dataArray[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [dataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 6, 300, 30);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    //label.shadowColor = [UIColor whiteColor];
    //label.shadowOffset = CGSizeMake(0.0, 1.0);
    label.font = [UIFont boldSystemFontOfSize:19];
    label.text = sectionTitle;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    float rd = 42.00/255.00;
    float gr = 205.00/255.00;
    float bl = 192.00/255.00;
    [headerView setBackgroundColor:[UIColor colorWithRed:rd green:gr blue:bl alpha:1.0]];
    [headerView addSubview:label];
    return headerView;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    
    
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"Current", @"Current");
            break;
        case 1:
            sectionName = NSLocalizedString(@"Previous", @"Previous");
            break;
        case 2:
            sectionName = NSLocalizedString(@"Upcoming", @"Upcoming");
            break;
            // ...
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSMutableArray *array1 = [dataArray objectAtIndex:indexPath.section];
    NSString *cellValue = [array1 objectAtIndex:indexPath.row];
    cell.textLabel.text = cellValue;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        deleteIndexPath = indexPath;
        NSString *rowValue = dataArray[deleteIndexPath.section][deleteIndexPath.row];
        
        NSString *message = [[NSString alloc] initWithFormat:@"Delete %@?", rowValue];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message
                              //delegate:self
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Delete",nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)//OK button pressed
    {NSLog(@"button 1");
        
        [dataArray[deleteIndexPath.section] removeObjectAtIndex:deleteIndexPath.row];
        [scoreTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:deleteIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"delete Item");
    }
    if(buttonIndex == 0)
    {NSLog(@"button 0");
        
    }
    
}


- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
}


@end
